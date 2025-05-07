defmodule EmudaTest.Collection do
  import Emuda.Collection
  use ExUnit.Case

  @test_data [
    %{
      0 => 1.23,
      "key1" => %{
        mapval1: 1,
        mapval2: 2
      },
      key2: "str1",
      key3: {
        111,
        222,
        333,
        [
          key1: 100,
          key2: 200
        ]
      }
    }
  ]

  # collect_by/2 ----------------------------

  test "Emuda.Collection.collect_by/2: gets the correct grouping" do
    data = [
      %{type: "breakfast", item: "coffee"},
      %{type: "lunch", item: "burrito"},
      %{type: "breakfast", item: "roll"},
      %{type: "dinner", item: "steak"}
    ]

    assert collect_by(data, &Emuda.Collection.prop(&1, :type)) == [
             [%{type: "dinner", item: "steak"}],
             [%{type: "lunch", item: "burrito"}],
             [%{type: "breakfast", item: "coffee"}, %{type: "breakfast", item: "roll"}]
           ]
  end

  # compact/1 ----------------------------

  test "Emuda.Collection.compact/1: removes falsy values" do
    assert compact([0, "a", false, "b", nil, "", [], {}, "c", %{}, "0"]) == ["a", "b", "c"]
  end

  # path/3 ----------------------------

  test "Emuda.Collection.path/3: wrong `path` type provided" do
    assert_raise FunctionClauseError, fn -> path(%{}, 0) end
  end

  test "Emuda.Collection.path/3: non-traversable `data` type provided" do
    assert_raise FunctionClauseError, fn -> path(999, [0]) end
  end

  test "Emuda.Collection.path/3: returns `or_else` if no matching index" do
    assert path({:a}, [1]) == nil
  end

  test "Emuda.Collection.path/3: returns `or_else` if empty `data`" do
    assert path([], [0]) == nil
  end

  test "Emuda.Collection.path/3: returns `data` if empty path" do
    assert path({:a}, []) == {:a}
  end

  test "Emuda.Collection.path/3: correctly traverses down through all supported data types" do
    assert path(@test_data, [0, :key3, 3, :key2]) == 200
  end

  # paths/3 ----------------------------
  test "Emuda.Collection.paths/3: wrong path type provided" do
    assert_raise FunctionClauseError, fn -> paths(%{}, 0) end
  end

  test "Emuda.Collection.paths/3: non-traversable `data` type provided" do
    assert_raise FunctionClauseError, fn -> paths(999, [[0], [1]]) end
  end

  test "Emuda.Collection.paths/3: returns `or_else` for paths with no matching index" do
    assert paths({:a}, [[0], [1]]) == [:a, nil]
  end

  test "Emuda.Collection.paths/3: returns `or_else` if empty data for each path" do
    assert paths([], [[0], [1]]) == [nil, nil]
  end

  test "Emuda.Collection.paths/3: returns `data` if empty path" do
    assert paths({:a}, []) == {:a}
  end

  test "Emuda.Collection.paths/3: returns `data` for all empty paths" do
    assert paths({:a}, [[], [0]]) == [{:a}, :a]
  end

  test "Emuda.Collection.paths/3: correctly traverses down through all supported data types for each path" do
    assert paths(@test_data, [[0, :key3, 3, :key2], [0, "key1", :mapval2]]) == [200, 2]
  end

  # prop/3 ----------------------------

  test "Emuda.Collection.prop/3: invalid key provided" do
    assert prop({:a}, 1) == nil
  end

  test "Emuda.Collection.prop/3: valid key provided" do
    assert prop({:a}, 0) == :a
  end

  # props/3 ----------------------------

  test "Emuda.Collection.props/3: invalid key provided" do
    assert props([:a, :b, :c], [1, 2, 3]) == [:b, :c, nil]
  end

  test "Emuda.Collection.props/3: with a map" do
    assert props(%{a: 1, b: 2, c: 3}, [:a, :c]) == [1, 3]
  end

  # pluck/3 ----------------------------

  test "Emuda.Collection.pluck/3: returns a new list by plucking the property off of all items in the map supplied" do
    assert pluck([%{c: 1}, %{c: 2}, %{a: 3}], :c, :not_found) == [1, 2, :not_found]
  end

  test "Emuda.Collection.pluck/3: with a map" do
    assert pluck(%{a: [1, 2, 3], b: [4, 5, 6], c: [6, 7, 8]}, 1, :not_found) -- [2, 5, 7] == []
  end
end
