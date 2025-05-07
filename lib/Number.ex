defmodule Emuda.Number do
  @doc """
  Constrains a number to a range.
  """
  def clamp(num, min, max), do: max(min(num, max(min, max)), min(min, max))

  @doc """
  Returns the greatest common divisor of two numbers.
  """
  def gcd(a, 0), do: a

  def gcd(a, b), do: gcd(b, rem(a, b))

  @doc """
  Test if a number is between two other numbers.
  """
  @spec is_between?(number(), number(), number()) :: boolean()
  def is_between?(n, min, max), do: n >= min and n <= max

  @doc """
  Returns the lowest common denominator of two numbers.
  """
  def lcd(a, b), do: div(a * b, gcd(a, b))

  @doc """
  Returns the mean for the given list of numbers.
  """
  @spec mean([number()]) :: number()
  def mean([]), do: nil
  def mean(nums), do: Enum.sum(nums) / length(nums)

  @doc """
  Returns the mean for the given list of numbers.
  """
  @spec median([number()]) :: number()
  def median([]), do: nil

  def median(nums) do
    sorted = Enum.sort(nums)
    len = length(sorted)

    case rem(len, 2) do
      1 ->
        Enum.at(sorted, div(len, 2))

      0 ->
        mid1 = Enum.at(sorted, div(len, 2) - 1)
        mid2 = Enum.at(sorted, div(len, 2))
        (mid1 + mid2) / 2
    end
  end

  @doc """
  Returns the percentage of difference between `a` and `b`.
  """
  def percent_of_change(a, b, whole_number? \\ true), do: 100 - percent_of(a, b, whole_number?)

  @doc """
  Returns the percentage of `a` that `b` is.
  """
  def percent_of(a, b, whole_number? \\ true) do
    percent = b / a * 100
    if whole_number?, do: round(percent), else: percent
  end

  @doc """
  Returns a random number between, and including, two numbers.
  """
  def rand_between(min, max) when is_float(min) or is_float(max),
    do: (:rand.uniform() * (max - min) + min) |> min(max)

  def rand_between(min, max) when is_integer(min) and is_integer(max),
    do: min..max |> Enum.random()

  @doc """
  Returns number rounded to nearest multiple of an integer.
  """
  @spec round_to_multiple(integer(), integer(), :round | :floor | :ceil) :: integer()
  def round_to_multiple(n, mult, rounding_type \\ :round)

  def round_to_multiple(n, mult, :round), do: round(n / mult) * mult

  def round_to_multiple(n, mult, :floor), do: floor(n / mult) * mult

  def round_to_multiple(n, mult, :ceil), do: ceil(n / mult) * mult

  @doc """
  Performs a linear conversion between 2 ranges.
  """
  def rescale(val, old_min, old_max, new_min, new_max),
    do: new_min + (val - old_min) * ((new_max - new_min) / (old_max - old_min))

  @doc """
  Tests whether a string can be coerced into a number.
  Note: float strings with no leading zero (ie ".123")
  are not coercible to floats and return `false`
  """
  def str_is_numeric?(str), do: String.match?(str, ~r/\-?\d+(\.\d+)?/)
end
