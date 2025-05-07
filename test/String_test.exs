defmodule EmudaTest.String do
  import Emuda.String
  use ExUnit.Case

  # number_format/3 ----------------------------
  test "Emuda.String.number_format/3: replaces `mask_char` strings in `fmt_str` with the digits in `num_str`" do
    assert number_str_format("123-456-7890", "+1(###)###-####") == "+1(123)456-7890"
  end

  # remove_alpha_chars/1 ----------------------------
  test "Emuda.String.remove_alpha_chars/1: removes letter characters from string" do
    assert remove_alpha_chars("abc 1 Γεια σου 2 κόσμε! 3") == "123"
  end

  # remove_number_chars/1 ----------------------------
  test "Emuda.String.remove_number_chars/1: removes numeric characters from string" do
    assert remove_number_chars("a1b2c3") == "abc"
  end

  # split_every/2 ----------------------------
  test "Emuda.String.split_every/2: replaces numbered tokens in `str` with list items" do
    assert split_every("aaabbbccc", 3) == ["aaa", "bbb", "ccc"]
  end

  # token_format/2 ----------------------------
  test "Emuda.String.token_format/2: replaces numbered tokens in `str` with list items" do
    assert token_format("Name: {2}, {0} {1}", ["John", "Doe", "Smith"]) == "Name: Smith, John Doe"
  end
end
