defmodule Flightex.Bookings.Agent do
  use Agent

  alias Flightex.Bookings.Booking

  def start_link, do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def save(%Booking{} = booking), do: Agent.update(__MODULE__, &update_state(&1, booking))

  def get(id), do: Agent.get(__MODULE__, &get_booking(&1, id))

  def get_all do
    __MODULE__
    |> Agent.get(& &1)
    |> sort_by_date()
  end

  defp update_state(state, %Booking{id: id} = booking), do: Map.put(state, id, booking)

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Flight Booking not found"}
      booking -> {:ok, booking}
    end
  end

  defp sort_by_date(bookings), do: Enum.sort_by(bookings, &get_date/1, Date)

  defp get_date({_id, %Booking{data_completa: data_completa}}), do: data_completa
end
