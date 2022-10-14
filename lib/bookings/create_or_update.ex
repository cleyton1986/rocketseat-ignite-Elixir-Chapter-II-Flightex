defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def call(%{
        complete_date: date,
        local_origin: origin,
        local_destination: destiny,
        user_id: user_id
      }) do
    date
    |> Booking.build(origin, destiny, user_id)
    |> save_booking()
  end

  defp save_booking({:ok, %Booking{id: id} = booking}) do
    BookingAgent.save(booking)
    {:ok, id}
  end

  defp save_booking({:error, _} = error), do: error
end
