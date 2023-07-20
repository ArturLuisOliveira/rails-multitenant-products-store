# Rails Multi-Tenancy Products Store (WIP)

RESTful API to list and categorize products by store. It was design to be consumed by a simple website and a Admin page. One interesting architecture aspect of this project is that the system is designed to serve multiple stores and their users using the same instance, like a marketplace. The main purpose of this project is to practice Ruby on Rails concepts and share with recruiters.
</br>
</br>

### ERD

Simplified entity relation diagram of the project database.
https://whimsical.com/erd-7wCVtxvayhgy3PxbeUnuYP

### Endpoints

Endpoints that the API provides.
https://whimsical.com/endpoints-Vh6H1SxjfoLADLZRidvfVi

### UML

Unified model language to describe the functionalities of the system.
https://whimsical.com/uml-AJURGu9JU396heFEstEYn

### Sugested Wireframe

Sugested wireframe of a webpage on which this API should be consumed.
https://whimsical.com/wireframe-A1CNjnGvYR5VHY17GLiQFc
</br>

#

## Running the project

The easiest way to run this project locally is using docker-compose.

### Build App & Run App

```
docker-compose build
docker-compose run
```

### Configure Database

Command to create db, run migrations and create seed files.

```
docker-compose run api rails db:create db:migrate db:seed
```

### Run Tests

To run the tests locally run the following command.

```
docker-compose run api rspec
```

### Run linter

```
docker-compose run api rubocop
```

## Next Steps

- Properly configure environment variables.

- Allow users to have multiple stores by creating a bridge table (UserStore).

- Implement image upload using Active Storage and S3.

- Implement seed data.

- Add Redis for cache.

- Create Open API documentation.
