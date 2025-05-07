defmodule EmudaTest.Function do
  import Emuda.Function
  use ExUnit.Case

  # juxt/2 ----------------------------
  test "Emuda.Function.juxt/2: applies a list of functions to a list of values" do
    assert juxt([3, 4, 9, -3], [&Enum.min/1, &Enum.max/1]) == [-3, 9]
  end

  # toggle/3 ----------------------------
  test "Emuda.Function.toggle/2: returns the opposite value comparing against a given set of two values" do
    assert toggle("off", "off", "on") == "on"
  end
end
