defmodule TestPayfy.Fixtures do
  def fixture(a, attrs \\ %{})

  def fixture(:user, attrs) do
    {:ok, user} =
      attrs
      |> Enum.into(%{name: unique_name("user_name")})
      |> Enum.into(%{email: unique_name("user_email@")})
      |> TestPayfy.Users.create_user()

    user
  end

  def fixture(:sweepstake, attrs) do
    {:ok, sweepstake} =
      attrs
      |> Enum.into(%{name: unique_name("sweepstake_name")})
      |> TestPayfy.Sweepstakes.create_sweepstake()

    sweepstake
  end

  def fixture(:register_sweepstake, attrs) do
    {:ok, register_sweepstake} =
      attrs
      |> Map.put_new_lazy(:user_id, fn -> fixture(:user).id end)
      |> Map.put_new_lazy(:sweepstake_id, fn -> fixture(:sweepstake).id end)
      |> TestPayfy.RegistersSweepstake.create_register_sweepstake()

    register_sweepstake
  end

  defp unique_name(preffix) do
    "#{preffix}-#{System.unique_integer([:positive])}"
  end
end
