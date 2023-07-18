# Documentation 

## CLI doc

See [Usage](pages/usage.md?id=cli).

### Serve locally

```
$ npm i docsify-cli gulp-cli -g
$ cd docs-tools
$ npm i
$ gulp
$ docsify serve ../docs
```

## Library doc

The output directory of the library documentation will be `docs/yard`.

You can consult it online [here](https://acceis.github.io/unisec/yard/).

### Build & serve locally

```
$ bundle exec yard doc && bundle exec yard server
```
