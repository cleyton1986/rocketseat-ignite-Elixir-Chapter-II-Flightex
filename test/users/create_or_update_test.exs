defmodule Flightex.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate

  describe "call/1" do
    test "when all params are valid, saves the user" do
      UserAgent.start_link()

      user_params = %{name: "Hessel", email: "hessel@hessel.com", cpf: "12345678900"}

      response = CreateOrUpdate.call(user_params)

      assert {:ok, _user_id} = response
    end

    test "when there are missing params, returns an error" do
      user_params = %{name: "Hessel", email: "hessel@hessel.com"}

      response = CreateOrUpdate.call(user_params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      user_params = %{name: "Hessel", email: "hessel@hessel.com", cpf: 1}

      response = CreateOrUpdate.call(user_params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
