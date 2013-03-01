# Ppjson

Pretty print your JSON on the command-line the easy way.

## Installation

Add this line to your application's Gemfile:

    gem 'ppjson'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ppjson

## Usage

Pretty printing your JSON on the command line has never been easier:

```
ppjson '{"a":"b"}'
```

If another command returns some JSON for you:

```
curl http://mydomain.com/blah.json | ppjson
```

Do you have some JSON in a file? See a pretty printed version of it:

```
ppjson -f my_file.json
```

Or maybe you want to pretty print the contents of the file and then update the file with the pretty printed version:

```
ppjson -f -i my_file.json
```

Perhaps you already have some pretty printed JSON in a file, but you want to pass it as an argument to some other command, so you need to un-pretty print it:

```
ppjson -f -u my_file.json
```

You can even store your un-pretty printed version back into the file for later:

```
ppjson -f -u -i my_file.json
```

Get some help with:

```
ppjson -h
```

It's easier to remember than `python -mjson.tool` and it won't annoyingly reorder your keys for you.

If you're using RVM just dump it into your global gemset to have it available everywhere.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
