defmodule Extras.Map do
  @spec map_field(map, any, (any -> any)) :: map

  def map_field(%{} = map, field, function) do
    case Map.fetch(map, field) do
      {:ok, value} when not is_nil(value) ->
        Map.put(map, field, function.(value))

      _ ->
        map
    end
  end
end
