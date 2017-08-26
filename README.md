## purescript-project

A PureScript project starter template using Gulp and browser LiveReload.

## Usage

First install the project requirements:

```
npm install -g purescript gulp bower
```

Then create a new project:

```
git clone https://github.com/johnmendonca/purescript-project.git my-project-name
cd my-project-name/

npm install
bower install
gulp
```

The default gulp task will watch your source files then recompile and reload your browser whenever you make a change.

## Notes

I use CoffeeScript to write my gulpfile to be more concise.  If you do not want to use coffeescript in this way, you can compile the file once:

```
coffee -p gulpfile.coffee
```

and replace the `gulpfile.js` with the output of that command.

