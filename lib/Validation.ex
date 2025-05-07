defmodule Emuda.Validation do
  def is_length?(str, length), do: String.length(str) == length

  def is_min_length?(str, min), do: String.length(str) >= min

  def is_max_length?(str, max), do: String.length(str) <= max

  def is_postal_code?(str, country_code), do: String.match?(str, postal_code_regex(country_code))

  def postal_code_regex(country_code) do
    case country_code do
      "US" -> ~r/^([0-9]{5})(?:[-\s]*([0-9]{4}))?$/i
      "CA" -> ~r/^([A-Z][0-9][A-Z])\s*([0-9][A-Z][0-9])$/i
      _ -> nil
    end
  end

  def simple_email?(str), do: String.match?(str, ~r/^.+@.+\..+$/)
end
