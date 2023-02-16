# Rails Multi-Tenancy Products Store (WIP)

RESTful API to list and categorize products by store. The purpose of this project is to practice Ruby on Rails concepts.
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

## TODO
- Allow users to have multiple stores by creating a UserStore bridge table.

- Implement image upload using Active Storage and S3.

- Implement seed data.