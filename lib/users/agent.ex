defmodule Flightex.Users.Agent do
  use Agent

  alias Flightex.Users.User

  def start_link(_inicial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def start_link, do: {:error, "A map must be passed as parameters"}

  def save(%User{} = user) do
    Agent.update(__MODULE__, &update_state(&1, user))
  end

  def save(_), do: {:error, "Save error"}

  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  defp update_state(atual_state, %User{cpf: cpf} = user) do
    Map.put(atual_state, cpf, user)
  end

  defp get_user(atual_state, cpf) do
    case Map.get(atual_state, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  def list_all, do: Agent.get(__MODULE__, & &1)
end
