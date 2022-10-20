defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Booking

  describe "build/5" do
    test "when all params are valid, returns a booking struct" do
      booking_id = UUID.uuid4()
      user_id = UUID.uuid4()
      response =
        Booking.build(
          booking_id,
          ~N[2022-10-19 19:05:01],
          "Recife",
          "Pernambuco",
          user_id
        )

      expected_response = {:ok, build(:booking, id: booking_id, user_id: user_id)}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      booking_id = UUID.uuid4()
      user_id = UUID.uuid4()
      response =
        Booking.build(
          booking_id,
          ~N[2022-10-19 16:35:10],
          321,
          123,
          user_id
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
