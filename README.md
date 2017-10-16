# DEFUNCT: docsh doesn't provide a rebar3 plugin anymore!

# [docsh][gh:docsh] in action


## Try it

Clone this repo and check out `local-plugin`:

```
git clone https://github.com/erszcz/docsh-example
cd docsh-example
git checkout local-plugin
```

See how it works:

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

You now see it works. Switch back to `master`:

```
git checkout master
```

The `local-plugin` branch is completely self contained - no changes
which might affect other projects are made to your system.
However, the minimal config (and less overhead due to fewer dependencies)
is achieved with the setup described in the next section.


## Rebar3 setup

This project relies on [rebar3 global plugin support][rebar3:plugins].
These plugins are downloaded and installed automatically.
Make sure `rebar3_docsh` plugin is in your `~/.config/rebar3/rebar.config`
as shown below:

```erlang
{plugins,
 [
  {rebar3_docsh, {git, "https://github.com/erszcz/docsh", {tag, "0.2.0"}}}
 ]}.
```

With the plugin in place, the configuration of this project is minimal:

```erlang
{erl_opts, [debug_info, {core_transform, ct_docsh}]}.

{provider_hooks,
 [
  {post, [{compile, {docsh, compile}}]}
 ]}.
```

The `{core_transform, ct_docsh}` option enables documentation for all
modules in the project.
If you want to be more specific about which modules should provide
embedded docs and which should not don't use the option.
Instead, include the header file in your module:

```erlang
-include_lib("docsh/include/docsh.hrl").
```

Each approach of enabling the core transformation will embed helper code
needed for accessing the documentation into your modules.
The documentation itself is embedded straight into the `.beam` file by the
post-compile `{docsh, compile}` hook.
The support code makes your documentation accessible wherever you ship your code.
No separate doc package - when you deploy your code,
you automagically deploy your docs.

[gh:docsh]: https://github.com/erszcz/docsh
[rebar3:plugins]: http://www.rebar3.org/docs/using-available-plugins
