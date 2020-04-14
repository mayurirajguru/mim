# Mim

Mim is a vim inspired editor-like command line program written in Ruby.
The program depends on [Curses](https://github.com/ruby/curses) gem which in turn has a dependancy on ncurses. The program makes following assumptions:

* ncurses is setup correctly. See directions [here](https://gist.github.com/cnruby/960344)
* ruby is installed locally.
* The program supports commands: 0, $, e, t[char], v$, ve, vt[char]
* Before each command is passed in, return key needs to be pressed for more readable output
* keywords used for exiting the porgram are: exit, q

## How to run the program

### For the first time:
From the root of the project, run following commands in the given sequence

```
gem install bundler
bundle install
ruby lib/mim.rb
```

### For consecutive runs:
```
ruby lib/mim.rb
```

## How to run the tests
From the root of the project, run following:
```
ruby test/lib/mim/executor_test.rb
```
