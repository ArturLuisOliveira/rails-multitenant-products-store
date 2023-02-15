# Rails Products Store

RESTful API to list and categorize products. The purpose of this project is to practice Ruby on Rails.
</br>
</br>

## Running the project

The easiest way to run this project locally is using docker-compose.

### Build App & Run App

```
docker-compose build
docker-compose run
```

### Configure Database

```
docker-compose run api rails db:create db:migrate db:seed
```

### Run Tests

To run the tests locally run the following command.

```
docker-compose run api rspec
```
