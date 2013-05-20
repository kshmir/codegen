# Codegen

Tired of writing the code twice? Write simple code to generate the sources you need based on your current ruby project.
For example, if you want to make an android app, you will be able to generate the java entities based on your ruby ones.

## Installation

Add this line to your application's Gemfile:

    gem 'codegen'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install codegen

## Usage

Right now, just watch how the specs are... no cli commands yet :(

## Roadmap

They don't need to be in this order:

- Write full and comprehensive tests.
- Split clearly the tests for sources and generators.
- Implement "codegen.yml" and make it able to support all kinds of sources and generators. 
- Make something like Rails does for code generation, showing pretty colors and prompting users.
- Support code merging, with declared sections for free user input.
- Add other languages other than Java for generating entities.
- Add REST API building using grape (!).
- Add REST API comsumption for Java.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
