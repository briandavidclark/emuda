defmodule EmudaTest.Number do
  import Emuda.Number
  use ExUnit.Case

  # clamp/3 ----------------------------
  test "Emuda.Number.clamp/3: returns `min` if `num` is lower" do
    assert clamp(-99, 0, 100) == 0
  end

  test "Emuda.Number.clamp/3: returns `max` if `num` is higher" do
    assert clamp(999, 0, 100) == 100
  end

  test "Emuda.Number.clamp/3: returns `num` if within range" do
    assert clamp(50, 0, 100) == 50
  end

  # gcd/2 ----------------------------
  test "Emuda.Number.gcd/2: returns the greatest common divisor of two numbers" do
    assert gcd(8, 12) == 4
  end

  # lcd/2 ----------------------------
  test "Emuda.Number.lcd/2: returns the lowest common denominator of two numbers" do
    assert lcd(8, 12) == 24
  end

  # percent_of_change/2 ----------------------------
  test "Emuda.Number.percent_of_change/2: returns the percentage of difference between `a` and `b`" do
    assert percent_of_change(200, 10) == 95
  end

  # percent_of/2 ----------------------------
  test "Emuda.Number.percent_of/2: returns the percentage of `a` that `b` is" do
    assert percent_of(200, 10) == 5
  end

  # rand_between/2 ----------------------------
  test "Emuda.Number.rand_between/2: returns float between two floats" do
    assert rand_between(2.0, 2.5) >= 2.0 and rand_between(2.0, 2.5) <= 2.5
  end

  test "Emuda.Number.rand_between/2: returns init between two ints" do
    assert rand_between(10, 11) >= 10 and rand_between(10, 11) <= 11
  end

  test "Emuda.Number.rand_between/2: returns float between an int and a float" do
    assert rand_between(10, 11.0) >= 10.0 and rand_between(10, 11.0) <= 11.0
  end

  # rescale/5 ----------------------------
  test "Emuda.Number.rescale/5: returns the lowest common denominator of two numbers" do
    assert rescale(50, 0, 100, 0, 150) == 75
  end

  # round_to_multiple/2 ----------------------------
  test "Emuda.Number.round_to_multiple/2: rounds to nearest multiple of `mult`" do
    assert round_to_multiple(73, 5) == 75
  end

  test "Emuda.Number.round_to_multiple/2: rounds up to nearest multiple of `mult`" do
    assert round_to_multiple(71, 5, :ceil) == 75
  end

  test "Emuda.Number.round_to_multiple/2: rounds down to nearest multiple of `mult`" do
    assert round_to_multiple(74, 5, :floor) == 70
  end

  # str_is_numeric?/1 ----------------------------
  test "Emuda.Number.str_is_numeric?/1: returns false when given non-numeric string" do
    assert str_is_numeric?("hello") == false
  end

  test "Emuda.Number.str_is_numeric?/1: returns true when given float string" do
    assert str_is_numeric?("0.1") == true
  end

  test "Emuda.Number.str_is_numeric?/1: returns true when given int string" do
    assert str_is_numeric?("99") == true
  end
end
