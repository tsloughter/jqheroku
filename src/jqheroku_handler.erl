-module(jqheroku_handler).

-export([init/3, 
         handle/2, 
         terminate/3]).

-record(state, {}).

init({tcp, http}, Req, []) ->
    {ok, Req, #state{}}.

handle(Req, State) ->
    try
        {Url, Req1} = cowboy_req:qs_val(<<"url">>, Req),
        {JsonPath, Req2} = cowboy_req:qs_val(<<"expression">>, Req1),
        lager:info("at=handle url=~p expression=~p", [Url, JsonPath]),
        Json = get_json(Url),
        Result = jsonpath:search(JsonPath, Json),        
        {ok, Req3} = cowboy_req:reply(200, [], jiffy:encode(Result), Req2),
        {ok, Req3, State}
    catch
        T:E ->
            lager:info("at=handle type=~p exception=~p ~p", [T, E, erlang:get_stacktrace()]),
            {ok, Req4} = cowboy_req:reply(401, Req),
            {ok, Req4, State}
    end.            
            

terminate(_Reason, _Req, _State) ->
    ok.

%%
%% Internal functions
%%

get_json(Url) ->
    Method = get,
    Headers = [],
    Payload = <<>>,
    Options = [],
    {ok, 200, _RespHeaders, Client} = hackney:request(Method, Url,
                                                     Headers, Payload,
                                                     Options),
    {ok, Body, _Client1} = hackney:body(Client),
    
    Body.
