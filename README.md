# [docsh](https://github.com/erszcz/docsh) in action

Just clone this repo and:

```erlang
$ ./rebar3 shell 
===> Verifying dependencies...
===> Compiling docsh-example
Erlang/OTP 18 [erts-7.1] [source] [64-bit] [smp:8:8] [async-threads:0] [hipe] [kernel-poll:false]

Eshell V7.1  (abort with ^G)
1> 'docsh-example':h(hello, 1). 
-spec hello(name()) -> ok.

Greet the person whose Name is passed in.

ok
2> 'docsh-example':hello("Joe").
Hello, Joe!
ok
3> 
```

(Watch out for `Uncaught error in rebar_core. Run with DEBUG=1 to see stacktrace`.
Running `shell` again helps.)
