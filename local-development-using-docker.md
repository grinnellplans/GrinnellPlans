## Local development using Docker

### First run:

1. [Install Docker](https://www.docker.com/products/docker)
2. Build the image:
    ```bash
    docker-compose build
    ```
    This will build the docker image defined in the Dockerfile. It can take a while to pull images and run the installation steps, but you shouldn't have to repeat this step unless you delete the image.

2. Create and seed the database:
    ```bash
    docker-compose run plans rake db:setup
    ```
    At this point, you're ready to run the development server, tests, or the console as described below.

### Subsequent runs:

- Run the development server:
    ```bash
    docker-compose up
    ```
- Run tests:
    ```bash
    docker-compose run plans ./bin/rspec spec
    ```
- Run a Rails console:
    ```bash
    docker-compose run plans ./bin/rails console
    ```
