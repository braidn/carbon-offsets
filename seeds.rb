projects = [
  { "name": "biomass" },
  { "name": "forestry" },
  { "name": "dac" }
]
offsets = [
  { "project_id": 1, "mass_g": 100000000, "price_cents_usd": 5000000.0, "retired": false },
  { "project_id": 1, "mass_g": 50000000, "price_cents_usd": 2500000.0, "retired": false },
  { "project_id": 2, "mass_g": 200000000, "price_cents_usd": 2000000.0, "retired": false },
  { "project_id": 3, "mass_g": 10000000, "price_cents_usd": 300000.0, "retired": false },
  { "project_id": 3, "mass_g": 10000000, "price_cents_usd": 300000.0, "retired": false }
]
orders = [
  { "offset_id": 4, "mass_g": 2000000, captured: false },
  { "offset_id": 4, "mass_g": 4000000, captured: false },
  { "offset_id": 4, "mass_g": 4000000, captured: false },
  { "offset_id": 1, "mass_g": 1000000, captured: false },
  { "offset_id": 1, "mass_g": 10000000, captured: false },
  { "offset_id": 1, "mass_g": 20000000, captured: false },
  { "offset_id": 3, "mass_g": 10000000, captured: false },
  { "offset_id": 2, "mass_g": 25000000, captured: false },
  { "offset_id": 2, "mass_g": 25000000, captured: false },
  { "offset_id": 5, "mass_g": 5000000, captured: false }
]

projects.each { |project| Project.create(project) }
offsets.each { |offset| Offset.create(offset) }
orders.each { |order| Order.create(order) }
