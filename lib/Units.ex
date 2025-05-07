defmodule Emuda.Units do
  def cm_to_in(cm), do: cm / 2.54

  def deg_to_rad(deg), do: deg * (:math.pi() / 180)

  def in_to_ft_and_in(inches) do
    ft = floor(inches / 12)
    {ft, inches - ft * 12}
  end

  def in_to_cm(inches), do: inches * 2.54

  def kg_to_lb(kg), do: kg / 0.45359237

  def lb_to_kg(lb), do: lb * 0.45359237
end
