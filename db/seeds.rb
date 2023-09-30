# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Article.create([{ title: 'Hello Rails', body: 'Rails is a web application development framework written in the Ruby programming language. It is designed to make programming web applications easier by making assumptions about what every developer needs to get started. It allows you to write less code while accomplishing more than many other languages and frameworks. Experienced Rails developers also report that it makes web application development more fun.' },
                { title: 'Hello TiDB Serverless', body: 'TiDB Serverless is a fully managed, auto-scaling TiDB service provided by TiDB Cloud. It allows users to create a TiDB cluster quickly without worrying about the underlying infrastructure. TiDB Serverless can automatically scale up or down based on the workload, ensuring high availability and performance.' },
                { title: 'Hello TiDB Serverless', body: 'TiDB Serverless is a fully managed, auto-scaling TiDB service provided by TiDB Cloud. It allows users to create a TiDB cluster quickly without worrying about the underlying infrastructure. TiDB Serverless can automatically scale up or down based on the workload, ensuring high availability and performance.' }])
