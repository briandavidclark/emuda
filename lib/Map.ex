defmodule Emuda.Map do
  @doc """
  Creates a new map by recursively evolving a map, according to the transformation functions.
  A transformation function will not be invoked if its corresponding key does not exist in the evolved object.
  """
  @spec evolve(map(), map()) :: map()
  def evolve(map, transformations) do
    Map.new(map, fn {key, val} ->
      case transformations do
        %{^key => fun} when is_function(fun, 1) ->
          {key, fun.(val)}

        %{^key => nested_transforms} when is_map(nested_transforms) and is_map(val) ->
          {key, evolve(val, nested_transforms)}

        _ ->
          {key, val}
      end
    end)
  end

  @doc """
  Returns a copy of the original map with the keys renamed to the values of the corresponding key in `remap`. If there is no corresponding key in `remap`, the key is copied without alteration.
  """
  @spec rename_keys(map(), map()) :: map()
  def rename_keys(map, remap) do
    Map.new(map, fn {k, v} ->
      if Map.has_key?(remap, k), do: {Map.get(remap, k), v}, else: {k, v}
    end)
  end

  @doc """
  Takes a spec map and a test map; returns `true` if the test satisfies the spec. Each of the spec's properties must be a predicate function. Each predicate is applied to the value of the corresponding property in the test map. Returns `true` if all the predicates return `true`, `false` otherwise.
  """
  @spec where(map(), map()) :: boolean()
  def where(test, spec) do
    ref = make_ref()

    spec
    |> Enum.reduce(true, fn x, acc ->
      {spec_key, spec_val} = x
      test_val = Map.get(test, spec_key, ref)
      valid? = test_val != ref

      cond do
        acc == false -> false
        is_map(spec_val) and is_map(test_val) -> where(test_val, spec_val)
        is_function(spec_val) and valid? -> spec_val.(Map.get(test, spec_key))
        true -> true
      end
    end)
  end
end
