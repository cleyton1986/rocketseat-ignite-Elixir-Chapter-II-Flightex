defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def generate(from_date_str, to_date_str)
      when is_bitstring(from_date_str) and is_bitstring(to_date_str) do
    with {:ok, from_date} <- from_iso8601(from_date_str),
         {:ok, to_date} <- from_iso8601(to_date_str) do
      BookingAgent.get_all()
      |> Stream.map(&get_booking/1)
      |> Stream.filter(&booking_in_range(&1, from_date, to_date))
      |> Enum.reduce("", &booking_string/2)
      |> save_report()
    end
  end

  def generate(_from_date, _to_date) do
    {:error, "Please provide both dates as ISO8601 datetime strings"}
  end

  defp get_booking({_id, %Booking{} = booking}), do: booking

  defp from_iso8601(date_string) do
    case NaiveDateTime.from_iso8601(date_string) do
      {:error, _reason} -> {:error, "Date must be an ISO8601 datetime string"}
      {:ok, date} -> {:ok, date}
    end
  end

  defp booking_in_range(%Booking{data_completa: data_completa}, from_date, to_date) do
    NaiveDateTime.compare(data_completa, from_date) in [:eq, :gt] and
      NaiveDateTime.compare(data_completa, to_date) in [:eq, :lt]
  end

  defp booking_string(
         %Booking{
           user_id: user_id,
           cidade_origem: cidade_origem,
           cidade_destino: cidade_destino,
           data_completa: data_completa
         },
         acc
       ) do
    acc <> "#{user_id},#{cidade_origem},#{cidade_destino},#{data_completa}\n"
  end

  defp save_report(content) do
    case File.write("reports/report.csv", content) do
      :ok -> {:ok, "Report generated successfully"}
      {:error, _reason} = error -> error
    end
  end
end
