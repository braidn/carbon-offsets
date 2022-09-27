## API Examples.

The Following are a few examples of how to 'exercise the API'.

### Creating an Offset

```
curl -H "Content-Type: application/json" --data "{\"mass\":10000,\"price_in_cents\":100000,\"currency\":\"USD\"}" "http://localhost:9292/api/projects/1/offsets"
```

### List Offsets per Project

```
curl 'http://localhost:9292/api/projects/2/offsets'
```

### List Future Payments for all Projects

```
curl 'http://localhost:9292/api/payments?type=new'
```

### List All Captured Payments for all Projects

```
curl 'http://localhost:9292/api/payments'
```
