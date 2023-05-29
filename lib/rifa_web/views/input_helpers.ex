defmodule RifaWeb.InputHelpers do
  @moduledoc """
  Conveniences for creating input fields
  """

  use Phoenix.HTML

  def datetime_select_this_year(form, field, attr \\ []) do
    datetime = DateTime.utc_now()

    date = DateTime.to_date(datetime)

    default_attr = [
      year: [options: date.year..(date.year + 10)],
    ]

    merged_attr = attr ++ default_attr

    datetime_select form, field, merged_attr
  end


end
