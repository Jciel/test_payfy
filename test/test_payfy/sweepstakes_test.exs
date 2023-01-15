defmodule TestPayfy.SweepstakesTest do
  use TestPayfy.DataCase, async: true

  describe "Sweepstake context" do
    test "get_sweepstake/1 Get a Sweepstake by id" do
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

      assert {:ok, ^sweepstake} = TestPayfy.Sweepstakes.get_sweepstake(sweepstake.id)

      assert {:error, :not_found} = TestPayfy.Sweepstakes.get_sweepstake(Ecto.UUID.generate())
    end

    test "create_sweepstake/1 Create a Sweepstake by attributes with a user winner" do
      %TestPayfy.Users.User{id: id} =
        user =
        fixture(:user, %{
          name: "nameuser",
          email: "test_email@gmail.com"
        })

      assert {:ok,
              %TestPayfy.Sweepstakes.Sweepstake{
                name: "namesweepstake",
                draw_date: ~U[2023-12-01 00:00:00Z],
                user_id: ^id
              }} =
               TestPayfy.Sweepstakes.create_sweepstake(%{
                 name: "namesweepstake",
                 draw_date: ~U[2023-12-01 00:00:00Z],
                 user_id: user.id
               })

      assert {:error, %Ecto.Changeset{}} =
               TestPayfy.Sweepstakes.create_sweepstake(%{
                 name: "namesweepstake",
                 draw_date: ~U[2023-12-01 00:00:00Z],
                 user_id: Ecto.UUID.generate()
               })
    end

    test "create_sweepstake/1 Create a Sweepstake by attributes without user winner" do
      assert {:ok,
              %TestPayfy.Sweepstakes.Sweepstake{
                name: "namesweepstake",
                draw_date: ~U[2023-12-01 00:00:00Z]
              }} =
               TestPayfy.Sweepstakes.create_sweepstake(%{
                 name: "namesweepstake",
                 draw_date: ~U[2023-12-01 00:00:00Z]
               })

      assert {:error, %Ecto.Changeset{}} =
               TestPayfy.Sweepstakes.create_sweepstake(%{
                 name: "namesweepstake",
                 draw_date: ~U[2023-12-01 00:00:00Z],
                 user_id: Ecto.UUID.generate()
               })
    end

    test "update_sweepstake/2 update an existent Sweepstake" do
      %TestPayfy.Users.User{id: user_id} =
        user =
        fixture(:user, %{
          name: "nameuser",
          email: "test_email@gmail.com"
        })

      sweepstake =
        fixture(:sweepstake, %{
          name: "namesweepstake",
          draw_date: ~U[2023-12-01 00:00:00Z]
        })

      assert {:ok,
              %TestPayfy.Sweepstakes.Sweepstake{
                name: "newnamesweepstake"
              }} =
               TestPayfy.Sweepstakes.update_sweepstake(sweepstake, %{
                 name: "newnamesweepstake"
               })

      assert {:ok,
              %TestPayfy.Sweepstakes.Sweepstake{
                draw_date: ~U[2023-04-07 00:00:00Z]
              }} =
               TestPayfy.Sweepstakes.update_sweepstake(sweepstake, %{
                 draw_date: ~U[2023-04-07 00:00:00Z]
               })

      assert {:ok,
              %TestPayfy.Sweepstakes.Sweepstake{
                user_id: ^user_id
              }} =
               TestPayfy.Sweepstakes.update_sweepstake(sweepstake, %{
                 user_id: user.id
               })

      assert {:error, %Ecto.Changeset{}} =
               TestPayfy.Sweepstakes.update_sweepstake(sweepstake, %{
                 user_id: Ecto.UUID.generate()
               })
    end

    test "consult_draw/1 Try get a User winner from Sweepstake by Sweepstake id" do
      %TestPayfy.Users.User{id: user_id} =
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

      assert {:ok,
              %TestPayfy.Users.User{
                id: ^user_id
              }} = TestPayfy.Sweepstakes.consult_draw(sweepstake.id)
    end

    test "consult_draw/1 Try get a User winner from Sweepstake by Sweepstake id witout winner" do
      sweepstake =
        fixture(:sweepstake, %{
          name: "namesweepstake",
          draw_date: ~U[2023-12-01 00:00:00Z]
        })

      assert TestPayfy.Sweepstakes.consult_draw(sweepstake.id) ==
               {:error, %{user_id: ["does not exist"]}}
    end
  end
end
