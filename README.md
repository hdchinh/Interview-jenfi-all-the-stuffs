# README

# 1. Demo

```
https://youtu.be/-5DR7Ea8TIg
```

# 2. Dependencies

1. Ruby 2.7.5
2. Rails 6
3. Postgres
4. Rspec, Factory-bot, shoulda-matchers

**Need to seed the lines by calling `rails db:seed`**

# 3. Use cases

1. As a train operator

- I can register the account (with name only)
- I get api_key (simple 6 digits key)
- I use api_key to submit a train
- I use api_key to withdraw a train
- I use api_key to check status of a train
- I cannot withdraw a train that is running

2. As a customer

- I can register the account (with name only)
- I get api_key (simple 6 digits key)
- I use api_key to submit a package
- I use api_key to check status of a package
- I use api_key to withdraw a package
- I cannot withdraw a package that is delivering

3. As a post master

- I no need to register an account
- I only have 1 API, and when I call this API I need to submit the line name as a params, then I will process to fill packages and let the Train running on the selected line.

4. The approach to pick a train

- if all packages need shipping when post master call API can ship on more than 1 trains => pick the cheapest train.
- if all packages need shipping when post master call API cannot ship on a train => pick the biggest train.
- When a train runs on a line, both the train and that line go unavailable status

# 4. Run programs

**can use postman with attached json file**

1. Get list of Lines

```
curl -H "Accept: application/json" "http://localhost:8080/api/lines"
```

2. Get list of active Lines

In case a line has a issue, the status of that line changes to `blocked`, and the system will not allow trains to run on that line anymore.

```
curl  -H "Accept: application/json" "http://localhost:8080/api/lines/active"
```

3. Create train operators

Each train operator will have 1 api_key and 1 name, api_key will be generated automatically, we just need to submit the name, but the name needs to be unique in the system.

```
curl -d '{"name": "kaka"}' -X POST -H "Content-Type: application/json" "http://localhost:8080/api/train_operators"
```

4. Show all train operators in the system

It is not a good idea to have an API that returns information of all train operators along with api_key, this API is made for testing purpose.

```
curl -X GET -H "Content-Type: application/json" "http://localhost:8080/api/train_operators"
```

5. Train operators submit a train

TO-7539 is the api_key

```
curl -d '{"max_weight": 100, "max_volume": 1, "cost": 100 ,"lines": ["A", "B"]}' -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: TO-7539" \
  "http://localhost:8080/api/trains"
```

6. Get all trains of a train operator

```
curl -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: TO-7539" \
  "http://localhost:8080/api/trains"
```

7. Train operator withdraw a train

```
 curl -X PUT \
  -H "Content-Type: application/json" \
  -H "Authorization: TO-7539" \
  "http://localhost:8080/api/trains/1/withdraw"
```

7. Train operator check status of their trains

```
 curl -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: TO-7539" \
  "http://localhost:8080/api/trains/1/status"
```

8. Customer create a basic account

Only require name, after creating will receive 1 api_key, use this api_key to send packages or check package status.

```
curl -d '{"name": "ronaldo"}' -X POST \
  -H "Content-Type: application/json" \
  "http://localhost:8080/api/customers"
```

9. Customer submit a package

```
curl -d '{"weight": 100, "volume": 100000, "line": "C"}' -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: U-6492" \
  "http://localhost:8080/api/packages"
```

10. Customer check status of a package

```
curl -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: U-6492" \
  "http://localhost:8080/api/packages/13/status"
```

11. Customer withdraw a package

```
curl -X PUT \
  -H "Content-Type: application/json" \
  -H "Authorization: U-6492" \
  "http://localhost:8080/api/packages/13/withdraw"
```

12. Post master process packages

```
curl -d '{"line": "A"}' -X POST \
  -H "Content-Type: application/json" \
  "http://localhost:8080/api/post_masters/process_packages"
```
