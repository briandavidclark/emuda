defmodule EmudaTest.Tuple do
  import Emuda.Tuple
  use ExUnit.Case

  # tuple_get/3 ----------------------------

  test "Emuda.Collection.tuple_get/3: wrong type provided" do
    assert_raise FunctionClauseError, fn -> tuple_get(%{}, 0) end
  end

  test "Emuda.Collection.tuple_get/3: returns correct value at index" do
    assert tuple_get({:a}, 0) == :a
  end

  test "Emuda.Collection.tuple_get/3: returns `or_else` if no matching index" do
    assert tuple_get({:a}, 1) == nil
  end
end
