defmodule EmudaTest.List do
  import Emuda.List
  use ExUnit.Case

  # add_uniq/2 ----------------------------
  test "Emuda.List.add_uniq/2: adds `item` if it isn't already in the `list`" do
    assert add_uniq([1, 2, 3], 0) == [0, 1, 2, 3]
  end

  test "Emuda.List.add_uniq/2: does not add `item` if it is already in the `list`" do
    assert add_uniq([1, 2, 3], 1) == [1, 2, 3]
  end

  # all_uniq?/1 ----------------------------
  test "Emuda.List.all_uniq?/1: returns `true` if at no items of the list is repeated" do
    assert all_uniq?([1, 2, 3]) == true
  end

  test "Emuda.List.all_uniq?/1: returns `false` if at least one item of the list is repeated" do
    assert all_uniq?([1, 2, 1]) == false
  end

  # aperture/2 ----------------------------
  test "Emuda.List.aperture/2: returns a new list, composed of n-tuples of consecutive elements" do
    assert aperture(3, [1, 2, 3, 4, 5]) == [[1, 2, 3], [2, 3, 4], [3, 4, 5]]
  end

  test "Emuda.List.aperture/2: test when `size` is equal to `list` length" do
    assert aperture(5, [1, 2, 3, 4, 5]) == [[1, 2, 3, 4, 5]]
  end

  # contains_all/2 ----------------------------
  test "Emuda.List.contains_all/2: returns `false` if lists do not contain the same elements" do
    assert contains_all([1, 2, 3], [1, 2]) == false
  end

  test "Emuda.List.contains_all/2: returns `true` if lists contain the same elements" do
    assert contains_all([1, 2, 3], [3, 2, 1]) == true
  end

  # contains_any/2 ----------------------------
  test "Emuda.List.contains_any/2: returns `false` if lists do not contain any of the same elements" do
    assert contains_any([1, 2, 3], [4, 5, 6]) == false
  end

  test "Emuda.List.contains_any/2: returns `true` if lists contain any of the same elements" do
    assert contains_any([1, 2, 3], [3, 4, 5]) == true
  end

  # contains_none/2 ----------------------------
  test "Emuda.List.contains_none/2: returns `true` if lists do not contain any of the same elements" do
    assert contains_none([1, 2, 3], [4, 5, 6]) == true
  end

  test "Emuda.List.contains_none/2: returns `false` if lists do contain any of the same elements" do
    assert contains_none([1, 2, 3], [3, 4, 5]) == false
  end

  # count/2 ----------------------------
  test "Emuda.List.count/2: returns the number of items in a given list matching the predicate `pred`" do
    assert count([1, 2.0, "3", 4], &is_integer/1) == 2
  end

  # diff/2 ----------------------------
  test "Emuda.List.diff/2: returns all elements from `list_1` not found in `list_2`" do
    assert diff([1, 2, 3], [1, 2]) == [3]
  end

  # drop_last_while/2 ----------------------------
  test "Emuda.List.drop_last_while/2: returns a new list excluding all the tailing elements of a given list which satisfy the supplied predicate function" do
    assert drop_last_while([1, 2, 3, 4, 3, 2, 1], &(&1 <= 3)) == [1, 2, 3, 4]
  end

  # drop_repeats/1 ----------------------------
  test "Emuda.List.drop_repeats/1: returns a new list without any consecutively repeating elements" do
    assert drop_repeats([1, 1, 2, 1, 3, 3]) == [1, 2, 1, 3]
  end

  # drop_repeats_with/2 ----------------------------
  test "Emuda.List.drop_repeats_with/2: returns a new list without any consecutively repeating elements" do
    assert drop_repeats_with([1, -1, 2, 1, -3, 3], &(abs(&1) == abs(&2))) == [1, 2, 1, -3]
  end

  # ends_with?/2 ----------------------------
  test "Emuda.List.ends_with?/2: checks whether a list ends with `item`" do
    assert ends_with?([1, 2, 3], 3) == true
  end

  # find_at_indexes/3 ----------------------------
  test "Emuda.List.find_at_indexes/3: checks whether a list ends with `item`" do
    assert find_at_indexes([1, 2, 3, 4, 5], [4, 2, 0, 99], :not_found) == [5, 3, 1, :not_found]
  end

  # find_last/3 ----------------------------
  test "Emuda.List.find_last/3: returns the last element of the list which matches the predicate, or `default` if no element matches" do
    assert find_last([1, 2, 3, 4, 5], &(&1 <= 4), :not_found) == 4
  end

  test "Emuda.List.find_last/3: returns `default` if no element matches" do
    assert find_last([5], &(&1 <= 4), :not_found) == :not_found
  end

  # find_last_index/3 ----------------------------
  test "Emuda.List.find_last_index/3: returns the last index of the list which matches the predicate, or `default` if no element matches" do
    assert find_last_index([1, 2, 3, 4, 5], &(&1 <= 4), :not_found) == 3
  end

  test "Emuda.List.find_last_index/3: returns `default` if no element matches" do
    assert find_last_index([5], &(&1 <= 4), :not_found) == :not_found
  end

  # group_by/2 ----------------------------
  test "Emuda.List.group_by/2: groups the results correctly" do
    f = fn x ->
      score = Map.get(x, :score)

      cond do
        score < 65 -> "F"
        score < 70 -> "D"
        score < 80 -> "C"
        score < 90 -> "B"
        true -> "A"
      end
    end

    data = [
      %{name: "Abby", score: 84},
      %{name: "Eddy", score: 58},
      %{name: "Jack", score: 69},
      %{name: "Bob", score: 69}
    ]

    assert group_by(data, f) == %{
             "B" => [%{name: "Abby", score: 84}],
             "D" => [%{name: "Bob", score: 69}, %{name: "Jack", score: 69}],
             "F" => [%{name: "Eddy", score: 58}]
           }
  end

  # index_exists?/2 ----------------------------
  test "Emuda.List.index_exists?/2: returns true if index exists" do
    assert index_exists?(["0", "1", "2", "3"], 2) == true
  end

  test "Emuda.List.index_exists?/2: returns false if index doesn't exist" do
    assert index_exists?([0, 1, 2, 3], 99) == false
  end

  # intersection/2 ----------------------------
  test "Emuda.List.intersection/2: returns all elements common to both provided lists" do
    assert intersection([0, 1, 2, 3], [1, 2, 3, 4]) == [1, 2, 3]
  end

  # offset_index/2 ----------------------------
  test "Emuda.List.offset_index/2: moves third item left by one place" do
    assert offset_index([1, 2, 3, 4], 2, -1) == [1, 3, 2, 4]
  end

  test "Emuda.List.offset_index/2: moves second item right by two places" do
    assert offset_index([1, 2, 3, 4], 1, 2) == [1, 3, 4, 2]
  end

  test "Emuda.List.offset_index/2: returns original list if indexes don't exist" do
    assert offset_index([1, 2, 3, 4], 2, -100) == [1, 2, 3, 4]
  end

  # partition/2 ----------------------------

  test "Emuda.List.partition/2: returns lists that do and do not satisfy the predicate" do
    assert partition([1, 2, 3, 4, 5, 6], &(&1 > 3)) == [[4, 5, 6], [1, 2, 3]]
  end

  # rotate_list/2 ----------------------------

  test "Emuda.List.rotate_list/2: returns list when list is empty" do
    assert rotate_list([], 2) == []
  end

  test "Emuda.List.rotate_list/2: returns list when `places` == 0" do
    assert rotate_list([1, 2, 3, 4, 5], 0) == [1, 2, 3, 4, 5]
  end

  test "Emuda.List.rotate_list/2: returns correct left-shifted list" do
    assert rotate_list([1, 2, 3, 4, 5], -7) == [3, 4, 5, 1, 2]
  end

  test "Emuda.List.rotate_list/2: returns correct right-shifted list" do
    assert rotate_list([1, 2, 3, 4, 5], 2) == [4, 5, 1, 2, 3]
  end

  # string_list_to_number_list/1 ----------------------------
  test "Emuda.List.string_list_to_number_list/1: returns all elements of `list_1` that are not in `list_2` and vice-versa" do
    assert string_list_to_number_list(["1", "3.14", [], %{}, {}]) == [1, 3.14, nil, nil, nil]
  end

  # symmetric_diff/2 ----------------------------
  test "Emuda.List.symmetric_diff/2: returns all elements of `list_1` that are not in `list_2` and vice-versa" do
    assert symmetric_diff([0, 1, 2, 3], [1, 2, 3, 4]) == [0, 4]
  end
end
