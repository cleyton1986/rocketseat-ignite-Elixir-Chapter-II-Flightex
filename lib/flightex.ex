defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookingsAgent
  alias Flightex.Bookings.CreateOrUpdate, as: BookingCreateOrUpdate
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate, as: UserCreateOrUpdate

  def start_agents do
    BookingsAgent.start_link(%{})
    UserAgent.start_link(%{})
  end

  defdelegate create_or_update_booking(params), to: BookingCreateOrUpdate, as: :call
  defdelegate create_or_update_user(params), to: UserCreateOrUpdate, as: :call
end
