function blogtest() {
  racket C:/Users/JP/Projects/blog-generator/blog.rkt --test "$@" && pushd _build && python -mSimpleHTTPServer; popd
}

function blogdeploy() {
  racket C:/Users/JP/Projects/blog-generator/blog.rkt --deploy && pushd _deploy && git push; popd
}
