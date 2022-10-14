defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent, as: UsersAgent
  alias Flightex.Users.User

  def call(%{name: name, email: email, cpf: cpf}) do
    name
    |> User.build(email, cpf)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UsersAgent.save(user)
    {:ok, "User created or updated"}
  end

  defp save_user({:error, _} = error), do: error
end
