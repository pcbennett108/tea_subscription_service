# Tea Subscription Service

## Table of Contents
- [Project Links](#project-links)
- [System Dependencies](#system-dependencies)
- [Testing Dependencies](#testing-dependencies)
- [Installation Instructions](#installation-instructions)
- [Summary of Work & Endpoints](#endpoints)
- [Contributors](#contributors)</br>

<h3 align="center">Project Description</h3>
<p align="center">
Tea Subscription is a Back-End application meant to run with a front-end service. This application delivers four seperate endpoints to create, update and retrive subscriptions and statuses.
</p></br>

## Project Links
- GitHub Repositories
    - [Backend](https://github.com/pcbennett108/Tea_Subscription_Service)

## System Dependencies
- Ruby (3.2.2) 
- Rails (7.1.1)

## Testing Dependencies
  - Pry
  - Rspec
  - Simplecov
  - shoulda-matchers
  - Postman

## Installation Instructions
 - Fork Repository
 - `git clone <repo_name>`
 - `cd <repo_name>`
 - `bundle install`   
 - `rails db:{drop,create,migrate,seed}`
 - `rails s`
 - Postman also used for live testing

## Endpoints

<u>GET /api/v1/customers</u>
  - Simple customer creation

<u>POST /api/v1/subscriptions</u>
  - Create a new subscriptions based on chosen tea
    - Enpoint created to use after customer picks a tea and fills form out on front-end, form routes to creation of a new subscription
    - This endpoint is for customers that have already created a customer account and have a customer id

<u>PUT /api/v1/subscriptions/1</u>
  - Updates a subscription's status to 'subscribed' or 'cancelled'
    - Endpoint created to update/cancel a subscription from a subscription show page

<u>GET /api/v1/subscriptions</u>
  - Retrieves a customer's list of active and cancelled subscriptions

## Contributors
- Paul Bennett [GitHub](https://github.com/pcbennett108)

