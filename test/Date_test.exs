defmodule EmudaTest.Date do
  import Emuda.Date
  use ExUnit.Case

  # age_from_birthdate/1 ----------------------------

  test "Emuda.Date.age_from_birthdate/1: returns correct age" do
    assert age_from_birthdate(~D[2024-01-14]) == 1
  end

  # first_day_of_month/1 ----------------------------

  test "Emuda.Date.first_day_of_month/1: returns correct day" do
    assert first_day_of_month(~D[1974-01-14]) == 2
  end

  # last_day_of_month/1 ----------------------------

  test "Emuda.Date.last_day_of_month/1: returns correct day" do
    assert last_day_of_month(~D[1974-01-14]) == 4
  end

  # last_day_of_month/1 ----------------------------

  test "Emuda.Date.day_name/1: returns correct day name" do
    assert day_name(1) == :monday
  end

  test "Emuda.Date.day_name/1: returns correct day name with offset" do
    assert day_name(1, :sunday) == :sunday
  end

  test "Emuda.Date.day_name/1: returns correct other day name with offset" do
    assert day_name(7, :sunday) == :saturday
  end
end
