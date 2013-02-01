-module(jqheroku_handler).

-export([init/3, 
         handle/2, 
         terminate/3]).

-record(state, {}).

init({tcp, http}, Req, []) ->
    {ok, Req, #state{}}.

handle(Req, State) ->
    {ok, Req2} = cowboy_req:reply(200, [], <<"">>, Req),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.

%%
%% Internal functions
%%
