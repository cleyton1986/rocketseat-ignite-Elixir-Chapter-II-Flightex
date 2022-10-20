defmodule Flightex.Users.UserTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Users.User

  describe "build/4" do
    test "when all parameters are valid, returns an user struct" do
      user_id = UUID.uuid4()

      response = User.build(user_id, "Cleyton", "cleyton@admin.com", "12345678900")

      expected_response = {:ok, build(:user, id: user_id)}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      response = User.build("123456789", "Cleyton", "cleyton@admin.com", 12_345_678_900)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
