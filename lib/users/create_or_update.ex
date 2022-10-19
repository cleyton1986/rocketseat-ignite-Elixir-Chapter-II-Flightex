defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def call(%{name: name, email: email, cpf: cpf}) do
    user_id = UUID.uuid4()

    user_id
    |> User.build(name, email, cpf)
    |> save_user()
  end

  def call(_params), do: {:error, "Invalid parameters"}

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)

    {:ok, user.id}
  end

  defp save_user({:error, _reason} = error), do: error
end
