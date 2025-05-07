defmodule Emuda.String do
  @doc """
  Replaces `mask_char` string in `fmt_str` with the digits in `num_str`.

  ## Examples

    iex> Emuda.String.number_str_format("123-456-7890", "+1(###)###-####")
    "+1(123)456-7890"
  """
  def number_str_format(num_str, fmt_str, mask_char \\ "#") do
    num_str
    |> String.replace(~r/\D+/, "")
    |> String.graphemes()
    |> Enum.reduce(fmt_str, &String.replace(&2, mask_char, &1, global: false))
  end

  @doc """
  Removes all non-numeric characters from string.
  """
  def remove_alpha_chars(str), do: Regex.replace(~r/[^0-9]/u, str, "")

  @doc """
  Removes all numeric characters from string.
  """
  def remove_number_chars(str), do: Regex.replace(~r/[0-9]/, str, "")

  @doc """
  Splits a string into slices of the specified length.
  """
  @spec split_every(String.t(), non_neg_integer()) :: [String.t()]
  def split_every(str, count) do
    str
    |> String.graphemes()
    |> Enum.chunk_every(count)
    |> Enum.map(&Enum.join/1)
  end

  @doc """
  Takes a list of values and replaces numbered tokens in `str` with list items
  that correspond to list index.

  ## Examples

    iex> Emuda.String.token_format("Name: {2}, {0} {1}", ["John", "Doe", "Smith"])
    "Name: Smith, John Doe"
  """
  def token_format(str, vals) do
    0..(length(vals) - 1)
    |> Enum.reduce(str, &String.replace(&2, "{#{&1}}", Enum.at(vals, &1)))
  end
end
