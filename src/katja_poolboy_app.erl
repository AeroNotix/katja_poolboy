-module(katja_poolboy_app).

-behaviour(application).

-export([start/2, stop/1]).


start(_StartType, _StartArgs) ->
    katja_poolboy_sup:start_link().

stop(_State) ->
    ok.
