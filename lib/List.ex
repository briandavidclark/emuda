defmodule Emuda.List do
  import Emuda.Collection

  @doc """
  Adds item if it isn't already in the list.
  """
  @spec add_uniq(list(), any()) :: list()
  def add_uniq(list, item), do: if(item in list, do: list, else: [item | list])

  @doc """
  Returns `false` if at least one item of the list is repeated.
  """
  @spec all_uniq?(list()) :: boolean()
  def all_uniq?(list), do: Enum.uniq(list) |> length() == length(list)

  @doc """
  Returns a new list, composed of n-tuples of consecutive elements. If `size` is greater than the length of the list, an empty list is returned.

  ## Examples

    iex> Emuda.List.aperture(3, [1, 2, 3, 4, 5])
    [[1, 2, 3], [2, 3, 4], [3, 4, 5]]
  """
  @spec aperture(non_neg_integer(), list()) :: [list()]
  def aperture(0, _list), do: []

  def aperture(size, list) when size > length(list), do: []

  def aperture(size, list) do
    0..(length(list) - size)
    |> Enum.map(&Enum.slice(list, &1..(&1 + size - 1)))
  end

  @doc """
  Resolves to `true` if all elements in the first list are found within the second list.
  """
  @spec contains_all(list(), list()) :: boolean()
  def contains_all(list_1, list_2), do: list_1 -- list_2 == []

  @doc """
  Returns `true` if any of the items from the first list are in the second list.
  """
  @spec contains_any(list(), list()) :: boolean()
  def contains_any(list_1, list_2), do: intersection(list_1, list_2) |> length() > 0

  @doc """
  Returns `true` if none of the items from the first list are in the second list.
  """
  @spec contains_none(list(), list()) :: boolean()
  def contains_none(list_1, list_2), do: intersection(list_1, list_2) |> length() == 0

  @doc """
  Returns the number of items in a given list matching the predicate `pred`.
  """
  @spec count(list(), function()) :: non_neg_integer()
  def count(list, pred), do: list |> Enum.reduce(0, &if(pred.(&1), do: &2 + 1, else: &2))

  @doc """
  Returns all elements from `list_1` not found in `list_2`.
  """
  @spec diff(list(), list()) :: list()
  def diff(list_1, list_2), do: list_1 -- list_2

  @doc """
  Returns a new list excluding all the tailing elements of a given list which satisfy the supplied predicate function.
  """
  @spec drop_last_while(list(), function()) :: list()
  def drop_last_while(list, f), do: list |> Enum.reverse() |> Enum.drop_while(f) |> Enum.reverse()

  @doc """
  Returns a new list without any consecutively repeating elements.
  """
  @spec drop_repeats(list()) :: list()
  def drop_repeats(list) do
    list
    |> Enum.reduce([], &if(&1 !== List.last(&2), do: &2 ++ [&1], else: &2))
  end

  @doc """
  Returns a new list without any consecutively repeating elements. Equality is determined by applying the supplied two-argument predicate to each pair of consecutive elements. The first element in a series of equal elements will be preserved.
  """
  @spec drop_repeats_with(list(), function()) :: list()
  def drop_repeats_with(list, pred) do
    list
    |> Enum.reduce([], fn x, acc ->
      if acc == [] or !pred.(x, List.last(acc)) do
        acc ++ [x]
      else
        acc
      end
    end)
  end

  @doc """
  Checks whether a list ends with `item`.
  """
  @spec ends_with?(list(), any()) :: boolean()
  def ends_with?(list, item), do: List.last(list) == item

  @doc """
  Returns list of items found at provided indexes. If the index doesn't exist, `default` is returned.
  """
  @spec find_at_indexes(list(), [non_neg_integer()], any()) :: [any()]
  def find_at_indexes(list, indexes, default \\ nil),
    do: indexes |> Enum.map(&Enum.at(list, &1, default))

  @doc """
  Returns the last element of the list which matches the predicate, or `default` if no element matches.
  """
  @spec find_last(list(), function(), any()) :: any()
  def find_last(list, pred, default \\ nil) do
    ref = make_ref()

    res =
      Range.new(length(list) - 1, 0, -1)
      |> Enum.reduce(ref, fn x, acc ->
        item = Enum.at(list, x)
        if acc == ref and pred.(item), do: item, else: acc
      end)

    if res == ref, do: default, else: res
  end

  @doc """
  Returns the index of the last element in the list which matches the predicate, or `default` if no element matches.
  """
  @spec find_last_index(list(), function(), any()) :: any()
  def find_last_index(list, pred, default \\ nil) do
    ref = make_ref()

    res =
      Range.new(length(list) - 1, 0, -1)
      |> Enum.reduce(ref, fn x, acc ->
        item = Enum.at(list, x)
        if acc == ref and pred.(item), do: x, else: acc
      end)

    if res == ref, do: default, else: res
  end

  @doc """
  Splits a list into sub-lists stored in a map, based on the result of calling a key-returning function on each element, and grouping the results according to values returned.
  """
  @spec group_by(list(), function()) :: map()
  def group_by(list, f) do
    ref = make_ref()

    Enum.reduce(list, %{}, fn x, acc ->
      key = f.(x)

      if prop(acc, key, ref) == ref do
        Map.put(acc, key, [x])
      else
        Map.put(acc, key, [x | Map.get(acc, key)])
      end
    end)
  end

  @doc """
  Checks whether an index exists in a list.
  """
  @spec index_exists?(list(), non_neg_integer()) :: boolean()
  def index_exists?(list, idx), do: idx >= 0 and idx < length(list)

  @doc """
  Returns all elements common to both provided lists.
  """
  @spec intersection(list(), list()) :: list()
  def intersection(list_1, list_2), do: list_1 |> Enum.filter(&(&1 in list_2))

  @doc """
  Offset an existing list item to a new index in the list.
  """
  def offset_index(list, _idx, 0), do: list

  def offset_index(list, idx, offset) do
    new_idx = idx + offset

    if index_exists?(list, new_idx),
      do: list |> List.delete_at(idx) |> List.insert_at(new_idx, Enum.at(list, idx)),
      else: list
  end

  @doc """
  Takes a predicate and a list and returns a pair of lists of the same type of elements which do and do not satisfy the predicate, respectively.
  """
  @spec partition(list(), function()) :: any()
  def partition(list, pred), do: [Enum.filter(list, pred), Enum.reject(list, pred)]

  @doc """
  Rotates the list items right (positively) or left (negatively) depending on the `places` argument.
  """
  @spec rotate_list(list(), integer()) :: list()
  def rotate_list([], _places), do: []
  def rotate_list(list, 0), do: list

  def rotate_list(list, places) do
    cond do
      places < 0 -> do_rotate_list_left(list, places)
      places > 0 -> do_rotate_list_right(Enum.reverse(list), places)
    end
  end

  defp do_rotate_list_right(list, 0), do: Enum.reverse(list)
  defp do_rotate_list_right([h | t], places), do: do_rotate_list_right(t ++ [h], places - 1)

  defp do_rotate_list_left(list, 0), do: list
  defp do_rotate_list_left([h | t], places), do: do_rotate_list_left(t ++ [h], places + 1)

  @doc """
  Returns an list of numbers from an list of numeric strings. Casts each item to a number.
  """
  @spec string_list_to_number_list(list()) :: list()
  def string_list_to_number_list(list) do
    Enum.map(list, fn x ->
      result =
        cond do
          !is_bitstring(x) -> nil
          String.contains?(x, ".") -> Float.parse(x)
          true -> Integer.parse(x)
        end

      case result do
        {x, _} -> x
        _ -> nil
      end
    end)
  end

  @doc """
  Returns all elements of `list_1` that are not in `list_2` and vice-versa.
  """
  @spec symmetric_diff(list(), list()) :: list()
  def symmetric_diff(list_1, list_2),
    do: (diff(list_1, list_2) ++ diff(list_2, list_1)) |> Enum.uniq()
end
