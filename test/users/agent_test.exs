defmodule Flightex.Users.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Users.Agent, as: UserAgent

  describe "save/1" do
    test "when receive an user, saves it in the agent" do
      UserAgent.start_link()

      user = build(:user)

      response = UserAgent.save(user)

      expected_response = :ok

      assert response == expected_response
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link()

      user = build(:user)

      UserAgent.save(user)

      {:ok, user: user}
    end

    test "when the informed id belongs to an user, returns the user", %{user: user} do
      response = UserAgent.get(user.id)

      expected_response = {:ok, user}

      assert response == expected_response
    end

    test "when the informed id don't belong to any user, returns an error" do
      id = "id that don't exists"

      response = UserAgent.get(id)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
