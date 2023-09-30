# branching-rails-example

From this repo, you can learn:

- How to connect to TiDB Serverless in ruby on rails.
- How to use branching GitHub integration.

## About this repo

This repo is a rails blog example. it includes:

- Articles CRUD based on [MVC](https://guides.rubyonrails.org/getting_started.html#mvc-and-you)
- Migration and seed bases on [Active Record Migrations](https://guides.rubyonrails.org/active_record_migrations.html)

> The repo is based on the [blog tutorial](https://guides.rubyonrails.org/getting_started.html).

## Connect to TiDB Serverless in ruby on rails

> Make sure you have installed the ruby and rails environment.

1. clone the code

```
git clone git@github.com:tidbcloud/branching-rails-example.git
cd branching-rails-example
```

2. Install the dependencies

```
bundle install
```

3. Fill in the following environment variable defined in `config/database.yml`. You can find the information in the TiDB Serverless console.

```
export TIDB_DATABASE=
export TIDB_USER=
export TIDB_HOST=
export TIDB_PASSWORD=
export TIDB_CERT_PATH=
```

4. Migrate and seed

```
rake db:migrate
rake db:seed
```

5. Run the server

```
rails server
```

## Use branching GitHub integration

Assume that you have run the rails project on a TiDB Serverless. Next, you can use the [Branching GitHub integration](https://docs.pingcap.com/tidbcloud/branch-github-integration) to connect the TiDB Serverless to this repo. Then a database branch will be created for every pull request to test the changes before merging the code to the master branch.

This repo has already connected to a TiDB Serverless. Check this [pull request](https://github.com/tidbcloud/branching-rails-example/pull/1) to see how we check the migration changes!


