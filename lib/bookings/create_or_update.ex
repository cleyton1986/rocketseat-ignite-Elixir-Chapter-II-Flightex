defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent

  def call(user_id, %{
        data_completa: data_completa_string,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino
      })
      when is_bitstring(user_id) do
    booking_id = UUID.uuid4()

    with {:ok, _user} <- UserAgent.get(user_id),
         {:ok, data_completa} <- from_iso8601(data_completa_string),
         {:ok, booking} <-
           Booking.build(booking_id, data_completa, cidade_origem, cidade_destino, user_id) do
      BookingAgent.save(booking)

      {:ok, booking.id}
    end
  end

  def call(_user_id, _booking_params), do: {:error, "Invalid parameters"}

  defp from_iso8601(date_string) do
    case NaiveDateTime.from_iso8601(date_string) do
      {:error, _reason} -> {:error, "Date must be an ISO8601 datetime string"}
      {:ok, date} -> {:ok, date}
    end
  end
end
