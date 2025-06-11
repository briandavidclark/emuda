defmodule Emuda.Collection do
  import Emuda.Tuple

  @typep path_item() :: String.t() | atom() | integer()
  @typep path() :: [path_item()]
  @typep traversable() :: map() | keyword() | list() | tuple()

  @doc """
  Splits `data` into lists, based on the result of calling a key-returning function on each element, and grouping the results according to values returned.

  ## Examples

    iex> data = [%{type: "breakfast", item: "coffee"}, %{type: "lunch", item: "burrito"}, %{type: "breakfast", item: "roll"}]
    iex> Emuda.Collection.collect_by(data, & Emuda.Collection.prop(&1, "type"))
    [[%{type: "breakfast", item: "coffee"}, %{type: "breakfast", item: "roll"}], [%{type: "lunch", item: "burrito"}]]
  """
  @spec collect_by(traversable(), function()) :: any()
  def collect_by(data, f) do
    data
    |> Enum.map(&f.(&1))
    |> Enum.uniq()
    |> Enum.reduce([], &[Enum.filter(data, fn x -> f.(x) == &1 end) | &2])
  end

  @doc """
  Creates a list with all falsy values removed. The values `false`, `nil`, `0`, `""`, `[]`, `%{}`, `{}`, and `"0"` are falsy.
  """
  @spec compact(traversable()) :: traversable()
  def compact(data) do
    data
    |> Enum.reject(fn x ->
      x == 0 or
        x == false or
        x == nil or
        x == "" or
        x == [] or
        x == %{} or
        x == {} or
        x == "0"
    end)
  end

  @doc """
  TODO
  """
  @spec prop(traversable(), path_item(), any()) :: any()
  def prop(data, key, or_else \\ nil), do: path(data, [key], or_else)

  @doc """
  TODO
  """
  @spec props(traversable(), [path_item()], any()) :: any()
  def props(data, keys, or_else \\ nil), do: Enum.map(keys, &path(data, [&1], or_else))

  @doc """
  Returns a new list by plucking the same keyed item off of all items in the data supplied.
  """
  @spec pluck(traversable(), path_item(), any()) :: any()
  def pluck(data, key, or_else \\ nil) do
    Enum.map(data, fn x ->
      if is_map(data) do
        {_, val} = x
        path(val, [key], or_else)
      else
        path(x, [key], or_else)
      end
    end)
  end

  @doc """
  TODO
  """
  @spec path(traversable(), path(), any()) :: any()
  def path(data, path, or_else \\ nil)

  def path(data, [], _or_else), do: data

  def path(data, path, or_else)
      when (is_map(data) or is_list(data) or is_tuple(data)) and is_list(path) do
    ref = make_ref()

    result =
      Enum.reduce(path, data, fn x, acc ->
        cond do
          acc === ref -> acc
          is_map(acc) -> Map.get(acc, x, ref)
          Keyword.keyword?(acc) and is_atom(x) -> Keyword.get(acc, x, ref)
          is_list(acc) -> Enum.at(acc, x, ref)
          is_tuple(acc) -> tuple_get(acc, x, ref)
          true -> ref
        end
      end)

    if result === ref, do: or_else, else: result
  end

  @doc """
  TODO
  """
  @spec paths(traversable(), [path()], any()) :: [any()]
  def paths(data, paths, or_else \\ nil)

  def paths(data, [], _or_else), do: data

  def paths(data, [h | _t] = paths, or_else) when is_list(h),
    do: Enum.map(paths, &path(data, &1, or_else))
end
