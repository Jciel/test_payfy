defmodule TestPayfy.UsersTest do
  use TestPayfy.DataCase, async: true

  describe "Users context" do
    test "get_user/1 Get a User by id" do
      user =
        fixture(:user, %{
          name: "nameuser",
          email: "test_email@gmail.com"
        })

      assert {:ok, ^user} = TestPayfy.Users.get_user(user.id)

      assert {:error, %{user_id: ["does not exist"]}} =
               TestPayfy.Users.get_user(Ecto.UUID.generate())
    end

    test "create_user/1 Create a User by attributes" do
      assert {:ok,
              %TestPayfy.Users.User{
                name: "nameuser",
                email: "test_email@gmail.com"
              }} = TestPayfy.Users.create_user(%{name: "nameuser", email: "test_email@gmail.com"})

      assert {:error, %Ecto.Changeset{}} =
               TestPayfy.Users.create_user(%{name: "nameuser", email: "error_email"})
    end
  end
end
