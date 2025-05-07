defmodule EmudaTest.Units do
  import Emuda.Units
  use ExUnit.Case

  # cm_to_in/1 ----------------------------

  test "Emuda.Units.cm_to_in/1: returns correct age" do
    assert cm_to_in(100) == 39.37007874015748
  end

  # deg_to_rad/1 ----------------------------

  test "Emuda.Units.deg_to_rad/1: returns correct age" do
    assert deg_to_rad(100) == 1.7453292519943295
  end

  # in_to_ft_and_in/1 ----------------------------

  test "Emuda.Units.in_to_ft_and_in/1: returns correct age" do
    assert in_to_ft_and_in(73) == {6, 1}
  end

  # in_to_cm/1 ----------------------------

  test "Emuda.Units.in_to_cm/1: returns correct age" do
    assert in_to_cm(100) == 254.0
  end

  # kg_to_lb/1 ----------------------------

  test "Emuda.Units.kg_to_lb/1: returns correct age" do
    assert kg_to_lb(100) == 220.46226218487757
  end

  # lb_to_kg/1 ----------------------------

  test "Emuda.Units.lb_to_kg/1: returns correct age" do
    assert lb_to_kg(100) == 45.359237
  end
end
