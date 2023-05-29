defmodule RifaWeb.RifaPartyView do
  use RifaWeb, :view

  def date_later(date) do
    now = DateTime.to_naive(DateTime.utc_now())
    NaiveDateTime.compare(now, date) == :gt
  end
  
  def date_early(date) do
    now = DateTime.to_naive(DateTime.utc_now())
    NaiveDateTime.compare(date, now) == :gt
  end
end
