defmodule Flightex.Users.AgentTest do
  use ExUnit.Case, async: false
  import Flightex.Factory

  alias Flightex.Users.Agent, as: UserAgent

  describe "start_link/1" do
    test "sucess when inicial state" do
      assert {:ok, _pid} = UserAgent.start_link(%{})
    end

    test "fail when inicial state" do
      assert {:error, "A map must be passed as parameters"} = UserAgent.start_link()
    end
  end

  describe "save/1" do
    setup do
      UserAgent.start_link(%{})

      id = UUID.uuid4()
      cpf = "12345678900"

      {:ok, id: id, cpf: cpf}
    end

    test "when the user is saves, returns an tuple", %{id: id, cpf: cpf} do
      :users
      |> build(id: id, cpf: cpf)
      |> UserAgent.save()

      response = UserAgent.get(cpf)

      expected_response =
        {:ok, %Flightex.Users.User{cpf: cpf, email: "jp@banana.com", id: id, name: "Jp"}}

      assert response == expected_response
    end

    test "fails when map does not match map User" do
      params = %{
        name: "Jp",
        email: "jp@banana.com",
        cpf: "12345678900"
      }

      UserAgent.save(params)

      assert {:error, "Save error"} == UserAgent.save(params)
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      id = UUID.uuid4()
      cpf = "12345678900"

      {:ok, id: id, cpf: cpf}
    end

    test "when the user is found, returns the user", %{id: id, cpf: cpf} do
      :users
      |> build(id: id, cpf: cpf)
      |> UserAgent.save()

      response = UserAgent.get(cpf)

      expected_response =
        {:ok, %Flightex.Users.User{cpf: cpf, email: "jp@banana.com", id: id, name: "Jp"}}

      assert response == expected_response
    end

    test "when the user is't founded, returns an error", %{id: id, cpf: cpf} do
      :users
      |> build(id: id, cpf: cpf)
      |> UserAgent.save()

      response = UserAgent.get("banana")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end

  describe "list_all/1" do
    setup do
      Flightex.start_agents()

      Enum.map(1..2, fn x ->
        params = build(:users, cpf: "123123123#{x}")
        Flightex.create_or_update_user(params)
      end)

      :ok
    end

    test "Return list" do
      response = UserAgent.list_all()

      assert %{
               "1231231231" => %Flightex.Users.User{
                 cpf: "1231231231",
                 email: "jp@banana.com",
                 name: "Jp",
                 id: _
               },
               "1231231232" => %Flightex.Users.User{
                 cpf: "1231231232",
                 email: "jp@banana.com",
                 name: "Jp",
                 id: _
               }
             } = response
    end
  end
end
