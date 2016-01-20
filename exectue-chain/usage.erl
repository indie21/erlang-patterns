-module(usage).
-compile([export_all]).

-define(BUILDING_NAME_ARRAY, ["b1", "b2"]).

check_building_name_valid(BuildingName) ->
  case lists:member(BuildingName, ?BUILDING_NAME_ARRAY) of
    false ->  {error, building_not_exist};
    true -> {ok, BuildingName}
  end.

check_building_max_level(BuildingName) ->
  case demo:beyand_max_level(BuildingName) of
    true -> {error, build_beyond_max_level};
    false -> 
      {ok, BuildingName}
  end.

building_upgrade_1(BuildingName) ->
  %% do real job -> upgrade the build.
  NewLevel = demo:update_return_new_level(BuildingName),
  {ok, NewLevel}.


%% upgrade building by name.
building_upgrade(BuildingName) ->
  ValidExecChain = [
                    fun check_building_name_valid/1,
                    fun check_building_max_level/1,
                    %% very easy to add or delete check function
                    fun building_upgrade_1/1
                   ],
  ec:foldr(ValidExecChain, BuildingName).
