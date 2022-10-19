defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Report
  alias Flightex.Users.Agent, as: UserAgent

  describe "generate/2" do
    setup do
      BookingAgent.start_link()
      UserAgent.start_link()

      user1 = build(:user)
      user2 = build(:user, name: "Ruan", email: "Ruan@ruan.com", cpf: "00987654321")
      user3 = build(:user, name: "Pablo", email: "Pablo@Pablo.com", cpf: "12365478900")

      booking1990 = build(:booking, data_completa: ~N[1990-01-01 00:00:00], user_id: user2.id)
      booking2021 = build(:booking, user_id: user1.id)
      booking2050 = build(:booking, data_completa: ~N[2050-01-01 00:00:00], user_id: user3.id)

      UserAgent.save(user1)
      UserAgent.save(user2)
      UserAgent.save(user3)

      BookingAgent.save(booking1990)
      BookingAgent.save(booking2021)
      BookingAgent.save(booking2050)

      {:ok, booking1990: booking1990, booking2021: booking2021, booking2050: booking2050}
    end

    test "when all params are valid, saves the report" do
      from_date = "1990-01-01T00:00:00Z"
      to_date = "2099-01-01T00:00:00Z"

      response = Report.generate(from_date, to_date)

      expected_response = {:ok, "Report generated successfully"}

      assert response == expected_response
    end

    test "when there are no bookings in range, saves an empty report" do
      from_date = "2098-01-01T00:00:00Z"
      to_date = "2099-01-01T00:00:00Z"

      Report.generate(from_date, to_date)

      {:ok, response} = File.read("reports/report.csv")

      expected_response = ""

      assert response == expected_response
    end

    test "when there are bookings in range, saves the bookings info on the report", %{
      booking2021: booking2021,
      booking2050: booking2050
    } do
      from_date = "2000-01-01T00:00:00Z"
      to_date = "2099-01-01T00:00:00Z"

      Report.generate(from_date, to_date)

      {:ok, response} = File.read("reports/report.csv")

      expected_response =
        "#{booking2021.user_id},Sorocaba,São Paulo,2021-01-02 15:30:45\n" <>
          "#{booking2050.user_id},Sorocaba,São Paulo,2050-01-01 00:00:00\n"

      assert response == expected_response
    end

    test "when any param is invalid, returns an error" do
      invalid_from_date = 19_910_101
      valid_to_date = "1991-01-01T00:00:00Z"

      response = Report.generate(invalid_from_date, valid_to_date)

      expected_response = {:error, "Please provide both dates as ISO8601 datetime strings"}

      assert response == expected_response
    end

    test "when any date is invalid, returns an error" do
      valid_from_date = "2001-01-01T00:30:00Z"
      invalid_to_date = "2099-01-01"

      response = Report.generate(valid_from_date, invalid_to_date)

      expected_response = {:error, "Date must be an ISO8601 datetime string"}

      assert response == expected_response
    end
  end
end
