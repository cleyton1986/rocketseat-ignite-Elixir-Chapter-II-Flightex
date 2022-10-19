defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.CreateOrUpdate, as: CreateOrUpdateBooking
  alias Flightex.Bookings.Report, as: BookingReport
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate, as: CreateOrUpdateUser

  def start_links do
    BookingAgent.start_link()
    UserAgent.start_link()
  end

  defdelegate create_or_update_user(params), to: CreateOrUpdateUser, as: :call

  defdelegate get_user(id), to: UserAgent, as: :get

  defdelegate create_or_update_booking(user_id, params), to: CreateOrUpdateBooking, as: :call

  defdelegate get_booking(id), to: BookingAgent, as: :get

  defdelegate generate_report(from_date, to_date), to: BookingReport, as: :generate
end
