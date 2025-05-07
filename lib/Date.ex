defmodule Emuda.Date do
  @spec age_from_birthdate(Calendar.date()) :: pos_integer()
  def age_from_birthdate(birthdate = %Date{}) do
    today = Date.utc_today()
    {_, bd_this_year} = Date.new(today.year, birthdate.month, birthdate.day)
    comp = Date.compare(today, bd_this_year)

    if comp == :gt or comp == :eq do
      today.year - birthdate.year
    else
      today.year - birthdate.year - 1
    end
  end

  @spec first_day_of_month(Calendar.date(), atom()) :: pos_integer()
  def first_day_of_month(date = %Date{}, start_of_week \\ :monday),
    do: Date.beginning_of_month(date) |> Date.day_of_week(start_of_week)

  @spec last_day_of_month(Calendar.date(), atom()) :: pos_integer()
  def last_day_of_month(date = %Date{}, start_of_week \\ :monday) do
    days = Date.days_in_month(date)
    {_, d} = Date.new(date.year, date.month, days)
    Date.day_of_week(d, start_of_week)
  end

  @spec day_name(1..7, atom()) :: pos_integer()
  def day_name(day, start_of_week \\ :monday) do
    offsets = %{
      monday: 0,
      tuesday: 1,
      wednesday: 2,
      thursday: 3,
      friday: 4,
      saturday: 5,
      sunday: 6
    }

    [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
    |> Enum.at(rem(day + offsets[start_of_week], 7) - 1)
  end
end
