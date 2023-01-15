defmodule TestPayfy.RegisterSweepstakeTest do
  use TestPayfy.DataCase, async: true

  describe "RegisterSweepstake context" do
    test "get_register_sweepstake/1 Get a Register Sweepstake by id" do
      user =
        fixture(:user, %{
          name: "nameuser",
          email: "test_email@gmail.com"
        })

      sweepstake =
        fixture(:sweepstake, %{
          name: "namesweepstake",
          draw_date: ~U[2023-12-01 00:00:00Z],
          user_id: user.id
        })

      register_sweepstake =
        fixture(:register_sweepstake, %{
          user_id: user.id,
          sweepstake_id: sweepstake.id
        })

      assert {:ok, ^register_sweepstake} =
               TestPayfy.RegistersSweepstake.get_register_sweepstake(register_sweepstake.id)

      assert {:error, :not_found} =
               TestPayfy.RegistersSweepstake.get_register_sweepstake(Ecto.UUID.generate())
    end

    test "create_register_sweepstake/1 Create a Register Sweepstake by attributes" do
      %TestPayfy.Users.User{id: user_id} =
        user =
        fixture(:user, %{
          name: "nameuser",
          email: "test_email@gmail.com"
        })

      %TestPayfy.Sweepstakes.Sweepstake{id: sweepstake_id} =
        sweepstake =
        fixture(:sweepstake, %{
          name: "namesweepstake",
          draw_date: ~U[2023-12-01 00:00:00Z],
          user_id: user.id
        })

      assert {:ok,
              %TestPayfy.RegistersSweepstake.RegisterSweepstake{
                user_id: ^user_id,
                sweepstake_id: ^sweepstake_id
              }} =
               TestPayfy.RegistersSweepstake.create_register_sweepstake(%{
                 user_id: user.id,
                 sweepstake_id: sweepstake.id
               })

      assert {:error, :not_found} =
               TestPayfy.RegistersSweepstake.create_register_sweepstake(%{
                 user_id: user.id,
                 sweepstake_id: Ecto.UUID.generate()
               })

      assert {:error, %Ecto.Changeset{}} =
               TestPayfy.RegistersSweepstake.create_register_sweepstake(%{
                 user_id: Ecto.UUID.generate(),
                 sweepstake_id: sweepstake.id
               })

      assert {:error, :not_found} =
               TestPayfy.RegistersSweepstake.create_register_sweepstake(%{
                 user_id: Ecto.UUID.generate(),
                 sweepstake_id: Ecto.UUID.generate()
               })
    end
  end
end
