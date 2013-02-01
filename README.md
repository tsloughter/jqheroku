### jqHeroku

#### Install

```shell
λ heroku create --buildpack https://github.com/tsloughter/heroku-buildpack-erlang.git
λ git push heroku master
```

#### Use

```shell
λ curl "http://<domain>?url=https://gist.github.com/raw/0f6d146cdfb814ab23d9/test.json&expression=$[name=foo]"
{"name":"foo","age":40}
```
