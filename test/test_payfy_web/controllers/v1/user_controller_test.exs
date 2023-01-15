defmodule TestPayfyWeb.V1.UserControllerTest do
  use TestPayfyWeb.ConnCase, async: true

  describe "Create User" do
    test ":create with valid attrs creates a User", %{conn: conn} do
      conn =
        conn
        |> post(Routes.v1_user_path(conn, :create), %{
          name: "nameuser",
          email: "test_email@gmail.com"
        })

      data = json_response(conn, :ok)["data"]

      assert json_response(conn, :ok)["data"] == %{"id" => conn.assigns.user.id}

      assert {:ok,
              %TestPayfy.Users.User{
                name: "nameuser",
                email: "test_email@gmail.com"
              }} = TestPayfy.Users.get_user(data["id"])
    end

    test ":create with invalid email", %{conn: conn} do
      conn =
        conn
        |> post(Routes.v1_user_path(conn, :create), %{
          name: "nameuser",
          email: "error_email"
        })

      assert json_response(conn, :unprocessable_entity) == %{
               "errors" => %{
                 "email" => [
                   "has invalid format"
                 ]
               }
             }
    end
  end
end
