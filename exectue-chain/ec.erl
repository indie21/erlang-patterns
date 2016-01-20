-module(ec).
-compile([export_all]).


%%% -------------------------------------------------------------------
%%% execute chain pattern.
%%%
%%% if the function return {error, Reason} then exectue list will terminate
%%% and return {error, Reason}.
%%% if the function return {ok, X}. then The X will be the param of the
%%% next function
%%%
%%% -------------------------------------------------------------------

do_foldr([Last], Param) ->
  Last(Param);
do_foldr([Fun | T], Param) ->
  case Fun(Param) of
    {ok, NewParam} -> do_foldr(T, NewParam);
    {error, Reason} -> {error, Reason}
  end.

foldr(FunctionList, Param) ->
  do_foldr(FunctionList, Param).

foldr(FunctionList) ->
  do_foldr(FunctionList, {}).


%%% foreach does not return params, just check and exec.
do_each([Last], Param) ->
  Last(Param);
do_each([ValidFun | T], Param) ->
  case ValidFun(Param) of
    {ok, _} -> do_each(T, Param);
    {error, Reason} -> {error, Reason}
  end.

each(FunctionList, Param) ->
  do_each(FunctionList, Param).

each(FunctionList) ->
  do_each(FunctionList, {}).

