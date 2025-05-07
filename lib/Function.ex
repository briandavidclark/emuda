defmodule Emuda.Function do
  def juxt(xs, fs), do: Enum.map(fs, & &1.(xs))

  def toggle(x, a, b) do
    case x do
      ^a -> b
      ^b -> a
      _ -> nil
    end
  end
end
