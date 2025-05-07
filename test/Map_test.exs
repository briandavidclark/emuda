defmodule EmudaTest.Map do
  import Emuda.Map
  use ExUnit.Case

  # evolve/2 ----------------------------

  test "Emuda.Map.evolve/2: adds `item` if it isn't already in the `list`" do
    tomato = %{firstName: "  Tomato ", data: %{elapsed: 100, remaining: 1400}, id: 123}

    transformations = %{
      firstName: &String.trim/1,
      lastName: &String.trim/1,
      data: %{elapsed: &(&1 + 1), remaining: &(&1 - 1), total: &(&1 + 1)}
    }

    assert evolve(tomato, transformations) == %{
             data: %{elapsed: 101, remaining: 1399},
             id: 123,
             firstName: "Tomato"
           }
  end

  # rename_keys/2 ----------------------------

  test "Emuda.Map.rename_keys/2: adds `item` if it isn't already in the `list`" do
    map = %{a: 1, b: 2, c: 3}
    remap = %{b: :bee, c: :cee}
    assert rename_keys(map, remap) == %{a: 1, bee: 2, cee: 3}
  end

  # where/2 ----------------------------

  test "Emuda.Map.where/2: returns `true` if the test satisfies the spec" do
    test = %{a: 111, b: "12345", c: %{d: :dee, e: ["f"]}}

    spec = %{
      a: &(&1 >= 100),
      b: &(String.length(&1) > 3),
      c: %{
        d: &is_atom(&1),
        e: &(length(&1) > 0)
      }
    }

    assert where(test, spec) == true
  end

  test "Emuda.Map.where/2: returns `false` if the test does not satisfy the spec" do
    test = %{a: 111, b: "12345", c: %{d: :dee, e: []}}

    spec = %{
      a: &(&1 >= 100),
      b: &(String.length(&1) > 3),
      c: %{
        d: &is_atom(&1),
        e: &(length(&1) > 0)
      }
    }

    assert where(test, spec) == false
  end
end
