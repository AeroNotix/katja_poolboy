-module(katja_poolboy_sup).

-behaviour(supervisor).


-export([start_link/0]).

-export([stop_pool/1]).
-export([start_pool/3]).
-export([init/1]).


start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

start_pool(Name, SizeArgs, WorkerArgs) when is_atom(Name) ->
    supervisor:start_child(?MODULE, [Name, SizeArgs, WorkerArgs]).

-spec stop_pool(atom()) -> ok.
stop_pool(Name) ->
    katja_pool_sup:stop_child(Name).

init([]) ->
    {ok, {{simple_one_for_one, 1, 1},
          [{undefined,
            {katja_pool_sup, start_link, []},
            transient, 5000, worker, [katja_pool_sup]}]}}.
