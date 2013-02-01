%%%-------------------------------------------------------------------
%%% @author Tristan Sloughter <tristan@zinn>
%%% @copyright (C) 2012, Tristan Sloughter
%%% @doc
%%%
%%% @end
%%% Created : 31 Aug 2012 by Tristan Sloughter <tristan@zinn>
%%%-------------------------------------------------------------------
-module(jqheroku_app).

-behaviour(application).

%% Application callbacks
-export([start/0
         ,start/2
         ,stop/1]).

-define(APP, jqheroku).

%%%===================================================================
%%% Application callbacks
%%%===================================================================

%%--------------------------------------------------------------------
start() ->
    application:set_env(lager, handlers, {handlers, [
                                                    {lager_console_backend, [info]}
                                                    ]}),    
    start_deps(?APP, permanent).

start_deps(App, Type) ->
    case application:start(App, Type) of
        ok ->
            ok;
        {error, {not_started, Dep}} ->
            start_deps(Dep, Type),
            start_deps(App, Type)
    end.

start(_StartType, _StartArgs) ->    
    jqheroku_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%%===================================================================
%%% Internal functions
%%%===================================================================

