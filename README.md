# LibreRead

This is Web App for Import Kindle Highlights. 

## License

Code released under MIT license. 
See [LICENSE](LICENSE) for details.

## System dependencies
- ruby-3.1.2
- node 18.12.0
- yarn 3.2.4
- redis 7.0.5
- postgres 14.5

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ gem install bundler -v 2.3.22
$ bundle _2.3.22_ config set --local without 'production'
$ bundle _2.3.22_ install
$ yarn install
```

Create the file config/database.yml like config/database.example.yml.

Create the database:

```
$ rails db:create
```

Next, migrate and seed a database:

```
$ rails db:migrate
$ rails db:seed
```

Run the app in a local server:

```
$ ./bin/dev
```
