# Kubernetes Hackathon

## Components

Taken straight from [RealWorld](https://github.com/gothinkster/realworld) project.

### Frontend

Based on [React/Redux](https://github.com/gothinkster/react-redux-realworld-example-app) example app. Authentication uses Keycloak. Frontend connects to Content API and Users API. 

### Content API

Based on [NestJS + TypeORM/Prisma](https://github.com/lujakob/nestjs-realworld-example-app) example app. NodeJS API that stores data in PostgreSQL database.

### User API 

Simple Nest.js API that contains one endpoint for registration which creates users both in Keycloak and Content API.

## Running locally

Simply run `docker-compose up` to spin up the whole project and visit http://localhost:4100/
