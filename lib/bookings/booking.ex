defmodule Flightex.Bookings.Booking do
  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(date, origin, destiny, user_id) when is_bitstring(user_id) do
    {:ok,
     %__MODULE__{
       id: UUID.uuid4(),
       complete_date: date,
       local_origin: origin,
       local_destination: destiny,
       user_id: user_id
     }}
  end

  def build(_date, _origin, _destiny, _user_id), do: {:error, "Invalid Params"}
end
