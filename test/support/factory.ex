defmodule Flightex.Factory do
  use ExMachina

  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  def user_factory do
    %User{
      id: UUID.uuid4(),
      name: "Cleyton",
      email: "cleyton@admin.com",
      cpf: "12345678900"
    }
  end

  def booking_factory do
    user = build(:user)

    %Booking{
      id: UUID.uuid4(),
      data_completa: ~N[2022-10-19 19:05:01],
      cidade_origem: "Recife",
      cidade_destino: "Pernambuco",
      user_id: user.id
    }
  end
end
