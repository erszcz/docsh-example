-module('docsh-example').

%% API exports
-export([hello/1]).

-export_type([name/0]).

-type name() :: string().

%% TODO: Somehow, rebar3 can't find this include file...
%-include_lib("docsh/include/docsh.hrl").

%%====================================================================
%% API functions
%%====================================================================

%% @doc Greet the person whose Name is passed in.
-spec hello(name()) -> ok.
hello(Name) ->
    print("Hello, ~s!\n", [Name]).

%%====================================================================
%% Internal functions
%%====================================================================

-spec print(io:format(), [term()]) -> ok.
print(Fmt, Args) ->
    print(standard_io, Fmt, Args).

-spec print(io:device(), io:format(), [term()]) -> ok.
print(Handle, Fmt, Args) ->
    io:format(Handle, Fmt, Args).
