defmodule EmudaTest.Validation do
  import Emuda.Validation
  use ExUnit.Case

  # simple_email?/1 ----------------------------

  test "Emuda.Validation.simple_email?/1: returns true if valid email" do
    assert simple_email?("abc@abc.abc") == true
  end

  test "Emuda.Validation.simple_email?/1: returns false if invalid email" do
    assert simple_email?("abc@abc") == false
  end
end
