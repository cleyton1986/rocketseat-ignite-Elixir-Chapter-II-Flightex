defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.CreateOrUpdate
  alias Flightex.Users.Agent, as: UserAgent

  describe "call/2" do
    setup do
      BookingAgent.start_link()
      UserAgent.start_link()

      user = build(:user)

      UserAgent.save(user)

      {:ok, user_id: user.id}
    end

    test "whe all params are valid, creates a booking", %{user_id: user_id} do
      booking_params = %{
        data_completa: "2021-01-01T00:00:00Z",
        cidade_origem: "Sorocaba",
        cidade_destino: "São Paulo"
      }

      response = CreateOrUpdate.call(user_id, booking_params)

      assert {:ok, _booking_id} = response
    end

    test "when the user_id is invalid, returns an error" do
      user_id = true

      booking_params = %{
        data_completa: "2021-01-01T00:00:00Z",
        cidade_origem: "Sorocaba",
        cidade_destino: "São Paulo"
      }

      response = CreateOrUpdate.call(user_id, booking_params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "when the user_id is don't exists, returns an error" do
      user_id = UUID.uuid4()

      booking_params = %{
        data_completa: "2021-01-01T00:00:00Z",
        cidade_origem: "Sorocaba",
        cidade_destino: "São Paulo"
      }

      response = CreateOrUpdate.call(user_id, booking_params)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end

    test "when the 'data_completa' is invalid, returns an error", %{user_id: user_id} do
      booking_params = %{
        data_completa: "01/01/2021",
        cidade_origem: "Sorocaba",
        cidade_destino: "São Paulo"
      }

      response = CreateOrUpdate.call(user_id, booking_params)

      expected_response = {:error, "Date must be an ISO8601 datetime string"}

      assert response == expected_response
    end

    test "when the booking_params are invalid, returns an error", %{user_id: user_id} do
      booking_params = %{
        data_completa: "2021-01-01T00:00:00Z",
        cidade_origem: true,
        cidade_destino: 20.5
      }

      response = CreateOrUpdate.call(user_id, booking_params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
