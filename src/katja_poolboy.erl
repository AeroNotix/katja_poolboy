-module(katja_poolboy).


-export([start_pool/3]).
-export([stop_pool/1]).
-export([send_event/2]).


-spec
start_pool(atom(), list(term()), list(term())) ->
    supervisor:startlink_ret().
start_pool(Name, SizeArgs, WorkerArgs) ->
    katja_poolboy_sup:start_pool(Name, SizeArgs, WorkerArgs).

-spec
stop_pool(atom()) ->
    ok | {error, running | restarting | not_found | simple_one_for_one}.
stop_pool(Name) ->
    katja_poolboy_sup:stop_pool(Name).

send_event(PoolName, Data) ->
    Worker = poolboy:checkout(PoolName),
    Res = katja_writer:send_event(Worker, Data),
    poolboy:checkin(PoolName, Worker),
    Res.
