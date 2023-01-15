defmodule TestPayfyWeb.V1.RegisterSweepstakeControllerTest do
  use TestPayfyWeb.ConnCase, async: true

  describe "Create Register Sweepstake" do
    test ":create with valid attrs creates a Register Sweepstake", %{conn: conn} do
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

      conn =
        conn
        |> post(Routes.v1_register_sweepstake_path(conn, :create), %{
          user_id: user.id,
          sweepstake_id: sweepstake.id
        })

      assert "Ok" == json_response(conn, :ok)["data"]
    end

    test ":create with invalid user_id try creates a Register Sweepstake", %{conn: conn} do
      _user =
        fixture(:user, %{
          name: "nameuser",
          email: "test_email@gmail.com"
        })

      sweepstake =
        fixture(:sweepstake, %{
          name: "namesweepstake",
          draw_date: ~U[2023-12-01 00:00:00Z]
        })

      conn =
        conn
        |> post(Routes.v1_register_sweepstake_path(conn, :create), %{
          user_id: Ecto.UUID.generate(),
          sweepstake_id: sweepstake.id
        })

      assert json_response(conn, :unprocessable_entity) == %{
               "errors" => %{
                 "user_id" => [
                   "does not exist"
                 ]
               }
             }
    end

    test ":create with invalid sweepstake_id try creates a Register Sweepstake", %{conn: conn} do
      user =
        fixture(:user, %{
          name: "nameuser",
          email: "test_email@gmail.com"
        })

      _sweepstake =
        fixture(:sweepstake, %{
          name: "namesweepstake",
          draw_date: ~U[2023-12-01 00:00:00Z]
        })

      conn =
        conn
        |> post(Routes.v1_register_sweepstake_path(conn, :create), %{
          user_id: user.id,
          sweepstake_id: Ecto.UUID.generate()
        })

      assert json_response(conn, :not_found) == %{
               "errors" => %{
                 "sweepstake_id" => [
                   "does not exist"
                 ]
               }
             }
    end

    test ":create with valid attrs try creates a Register Sweepstake outside the draw deadline",
         %{
           conn: conn
         } do
      user =
        fixture(:user, %{
          name: "nameuser",
          email: "test_email@gmail.com"
        })

      sweepstake =
        fixture(:sweepstake, %{
          name: "namesweepstake",
          draw_date: ~U[2022-12-01 00:00:00Z]
        })

      conn =
        conn
        |> post(Routes.v1_register_sweepstake_path(conn, :create), %{
          user_id: user.id,
          sweepstake_id: sweepstake.id
        })

      assert json_response(conn, :not_found) == %{
               "errors" => %{
                 "sweepstake_id" => [
                   "Registration outside the draw deadline"
                 ]
               }
             }
    end

    test ":create with valid attrs try creates a Register Sweepstake with same user twice", %{
      conn: conn
    } do
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

      conn =
        conn
        |> post(Routes.v1_register_sweepstake_path(conn, :create), %{
          user_id: user.id,
          sweepstake_id: sweepstake.id
        })

      assert "Ok" == json_response(conn, :ok)["data"]

      conn =
        conn
        |> post(Routes.v1_register_sweepstake_path(conn, :create), %{
          user_id: user.id,
          sweepstake_id: sweepstake.id
        })

      assert json_response(conn, :unprocessable_entity) == %{
               "errors" => %{
                 "sweepstake_id" => [
                   "User already registered in this draw"
                 ]
               }
             }
    end
  end
end
