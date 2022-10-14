defmodule Flightex.Bookings.Agent do
  use Agent
  alias Flightex.Bookings.Booking

  def start_link(_inicial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{id: id} = booking) do
    Agent.update(__MODULE__, &update_state(&1, booking))
    {:ok, id}
  end

  def get(id), do: Agent.get(__MODULE__, &get_booking(&1, id))

  defp update_state(atual_state, %Booking{id: id} = booking) do
    Map.put(atual_state, id, booking)
  end

  defp get_booking(atual_state, id) do
    case Map.get(atual_state, id) do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end

  def list_all, do: Agent.get(__MODULE__, & &1)
end
