defmodule Flightex.Bookings.Booking do
  @keys [:id, :data_completa, :cidade_origem, :cidade_destino, :user_id]

  @enforce_keys @keys

  defstruct @keys

  def build(id, data_completa, cidade_origem, cidade_destino, user_id)
      when is_bitstring(cidade_origem) and is_bitstring(cidade_destino) do
    {:ok,
     %__MODULE__{
       id: id,
       data_completa: data_completa,
       cidade_origem: cidade_origem,
       cidade_destino: cidade_destino,
       user_id: user_id
     }}
  end

  def build(_id, _data_completa, _cidade_origem, _cidade_destino, _user_id) do
    {:error, "Invalid parameters"}
  end
end
