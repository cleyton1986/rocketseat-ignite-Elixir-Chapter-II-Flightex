defmodule Flightex.Factory do
  use ExMachina

  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  def user_factory do
    %User{
      id: UUID.uuid4(),
      name: "Hessel",
      email: "hessel@hessel.com",
      cpf: "12345678900"
    }
  end

  def booking_factory do
    user = build(:user)

    %Booking{
      id: UUID.uuid4(),
      data_completa: ~N[2021-01-02 15:30:45],
      cidade_origem: "Sorocaba",
      cidade_destino: "São Paulo",
      user_id: user.id
    }
  end
end
