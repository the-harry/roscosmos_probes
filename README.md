# dc.saas.food

## Stack

- `Ruby 3.0.2`
- `Rails 6.1.3`
- `Postgres 13.1-alpine`

## Production URLs

- [roscosmos.ru](roscosmos.ru)

## About

This project is created to manage Roscosmos probes.

## Getting started

```bash
# Before building the containers copy the .env.sample file to .env. Change any value if needed.
cp .env.sample .env

# Build and run the containers:
docker-compose build
docker-compose up

# To access the web container:
docker-compose exec web bash

# To setup the project just run bin/setup` inside the container.
bin/setup

# To stop the project:
docker-compose down
```

The application is loaded by default on port 80.

## Quality

We have rspec specs, rubocop and brakeman in this project, we also check zeitwerk loader. Please keep it tidy by running:

```bash
# Security
brakeman -A --color

# Loaders integrity
yarn install --check-files
bin/rails zeitwerk:check

# Autofix ofenses
rubocop -A

# run all specs
rspec
```

PS: If possible run rubocop first, so if any autofix breaks the code, rspec will tell you(probably).

We also use SimpleCov with the min coverage of 95%, so if the coverage drops, the pipeline will break.
Coverage report can be found at `coverage/index.html`.


## ENDPOINTS

### CREATE PROBE

To create a new probe you must send a post request containing this structure. e.g:

* `verb` - `POST`
* `endpoint` - `/api/v1/probe`
* `body` - [spec/fixtures/probe.json](spec/fixtures/probe.json)

```bash
curl -H 'Content-Type: application/json' \
     -d @spec/fixtures/probe.json \
     http://localhost/api/v1/probe
```

* Possible responses:

  - 201 - Successfully created
  - 422 - Can't create probe, please check your params


### TELEPORT BACK TO HOME

When you are too far way from home and just need a teleport you may send a post to this endpoint with the id of the probe. e.g:

* `verb` - `POST`
* `endpoint` - `/api/v1/probe/travel_home`

```bash
curl -H 'Content-Type: application/json' \
     -d '{"id": "9ad4dc1b-ae78-43a9-8a91-9ae2d019ebac"}' \
     http://localhost/api/v1/probe/travel_home
```

* Possible responses:

  - 200 - Successfully teleported
  - 404 - Can't find probe
