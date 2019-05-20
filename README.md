# README

This Rails app implements a solution to the coding challenge with specification listed here: https://gist.github.com/francesc/33239117e4986459a9ff9f6ea64b4e80

It's a standard Rails (v5.2.2) app developed using Ruby 2.5.3.

It uses Rspec for tests, PostgreSQL for the DB, Sidekiq for the background job and 'money-rails' for dealing with money. Redis is a system dependency for running Sidekiq.

The core of the solution is the `CalculateDisbursements` service class that, as the name says, calculate the disbursements for all the merchants with orders on a given week.

`CalculateDisbursementsJob` is the job that uses the service class to calculate the disbursements. If you'd want to run it on monday, I'd have a cron job that calls a rake task to call this job, this solution doesn't include the rake task due to time constraints.

The API endpoint that lists the disbursements is at `/api/v1/disbursements`, it takes `year`, `week` and `merchant` (as the merchant ID) as parameters and returns an array that's either empty or contains one or more pairs of `merchant_id` and `amount`, for each disbursement found that matches the criteria.

The `CalculateDisbursements` service class has it's own tests and the API is tested with request tests. If I had more time, I'd refactor the API controller moving the logic to its own object with separate tests, but I considered it to be less prioritary right now.