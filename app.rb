require_relative 'models'
require 'roda'

class PatchApp < Roda
  opts[:check_dynamic_arity] = false
  opts[:check_arity] = :warn

  plugin :default_headers,
    'Content-Type'=>'application/json',
    'X-Frame-Options'=>'deny',
    'X-Content-Type-Options'=>'nosniff',
    'X-XSS-Protection'=>'1; mode=block'

  plugin :content_security_policy do |csp|
    csp.default_src :none
    csp.form_action :self
    csp.script_src :self
    csp.connect_src :self
    csp.base_uri :none
    csp.frame_ancestors :none
  end

  plugin :route_csrf, check_request_methods: [ 'DELETE', 'PATCH', 'PUT' ]

  plugin :public
  plugin :hash_branch_view_subdir

  logger = if ENV['RACK_ENV'] == 'test'
    Class.new{def write(_) end}.new
  else
    $stderr
  end
  plugin :common_logger, logger

  if ENV['RACK_ENV'] == 'development'
    plugin :exception_page
    class RodaRequest
      def assets
        exception_page_assets
        super
      end
    end
  else
    def self.freeze
      Sequel::Model.freeze_descendents
      DB.freeze
      super
    end
  end

  plugin :error_handler do |e|
    case e
    when Roda::RodaPlugins::RouteCsrf::InvalidToken
      response.status = 400
      { _errors: [e.message] }
    else
      $stderr.print "#{e.class}: #{e.message}\n"
      $stderr.puts e.backtrace
      next exception_page(e, :assets=>true) if ENV['RACK_ENV'] == 'development'
      { _errors: [e.message] }
    end
  end

  plugin :json
  plugin :json_parser
  plugin :typecast_params

  Unreloader.require('routes', :delete_hook=>proc{|f| hash_branch(File.basename(f).delete_suffix('.rb'))}){}

  route do |r|
    r.hash_branches('')
    r.root do
      { data: {} }
    end
  end
end
