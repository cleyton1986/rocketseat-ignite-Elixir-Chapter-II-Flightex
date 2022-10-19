defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent

  describe "save/1" do
    test "when receive a booking, saves it in the agent" do
      BookingAgent.start_link()

      booking = build(:booking)

      response = BookingAgent.save(booking)

      expected_response = :ok

      assert response == expected_response
    end
  end

  describe "get/1" do
    setup do
      BookingAgent.start_link()

      booking = build(:booking)

      BookingAgent.save(booking)

      {:ok, booking: booking}
    end

    test "when the informed id belongs to a booking, returns the booking", %{booking: booking} do
      response = BookingAgent.get(booking.id)

      expected_response = {:ok, booking}

      assert response == expected_response
    end

    test "when the informed don't belong to any booking, returns an error" do
      id = "id that don't exists"

      response = BookingAgent.get(id)

      expected_response = {:error, "Flight Booking not found"}

      assert response == expected_response
    end
  end

  describe "get_all/0" do
    test "when there are bookings in the agent, returns all of them ordered by 'data_completa'" do
      BookingAgent.start_link()

      first_booking = build(:booking, data_completa: ~N[1976-01-01 00:00:00])
      last_booking = build(:booking, data_completa: ~N[2099-01-01 00:00:00])

      BookingAgent.save(first_booking)
      BookingAgent.save(last_booking)

      response = BookingAgent.get_all()

      expected_response = [
        {first_booking.id, first_booking},
        {last_booking.id, last_booking}
      ]

      assert response == expected_response
    end

    test "when there are no booking in the agent, returns an empty list" do
      BookingAgent.start_link()

      response = BookingAgent.get_all()

      expected_response = []

      assert response == expected_response
    end
  end
end
