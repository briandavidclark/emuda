defmodule Emuda.Tuple do
  @doc """
  Gets item in tuple at index or default value if not found.
  """
  @spec tuple_get(tuple(), integer(), any()) :: any()
  def tuple_get(tup, idx, or_else \\ nil) when is_tuple(tup) do
    try do
      elem(tup, idx)
    rescue
      _ -> or_else
    end
  end
end
