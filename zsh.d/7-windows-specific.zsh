function blogtest() {
  blog --test $1 && pushd _build && python -mSimpleHTTPServer; popd
}

function blogdeploy() {
  blog --deploy && pushd _deploy && git push; popd
}
