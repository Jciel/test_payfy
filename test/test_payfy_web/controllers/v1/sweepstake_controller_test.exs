defmodule TestPayfyWeb.V1.SweepstakeControllerTest do
  use TestPayfyWeb.ConnCase, async: true

  describe "Create Sweepstake" do
    test ":create with valid attrs creates a Sweepstake without winner", %{conn: conn} do
      conn =
        conn
        |> post(Routes.v1_sweepstake_path(conn, :create), %{
          name: "namesweepstake",
          draw_date: ~U[2023-12-01 00:00:00Z] |> DateTime.to_unix(:millisecond),
          user_id: nil
        })

      data = json_response(conn, :ok)["data"]

      assert json_response(conn, :ok)["data"] == %{"id" => conn.assigns.sweepstake.id}

      assert {:ok,
              %TestPayfy.Sweepstakes.Sweepstake{
                name: "namesweepstake",
                draw_date: ~U[2023-12-01 00:00:00Z],
                user_id: nil
              }} = TestPayfy.Sweepstakes.get_sweepstake(data["id"])
    end

    test ":create with valid attrs creates a Sweepstake with winner", %{conn: conn} do
      %TestPayfy.Users.User{id: user_id} =
        user =
        fixture(:user, %{
          name: "nameuser",
          email: "test_email@gmail.com"
        })

      conn =
        conn
        |> post(Routes.v1_sweepstake_path(conn, :create), %{
          name: "namesweepstake",
          draw_date: ~U[2023-12-01 00:00:00Z] |> DateTime.to_unix(:millisecond),
          user_id: user.id
        })

      data = json_response(conn, :ok)["data"]

      assert json_response(conn, :ok)["data"] == %{"id" => conn.assigns.sweepstake.id}

      assert {:ok,
              %TestPayfy.Sweepstakes.Sweepstake{
                name: "namesweepstake",
                draw_date: ~U[2023-12-01 00:00:00Z],
                user_id: ^user_id
              }} = TestPayfy.Sweepstakes.get_sweepstake(data["id"])
    end

    test ":update name and draw_date of an existent Sweepstake", %{conn: conn} do
      sweepstake =
        fixture(:sweepstake, %{
          name: "namesweepstake",
          draw_date: ~U[2023-12-01 00:00:00Z]
        })

      conn =
        conn
        |> patch(Routes.v1_sweepstake_path(conn, :update, sweepstake), %{
          attrs: %{
            name: "newnamesweepstake",
            draw_date: ~U[2023-05-07 00:00:00Z] |> DateTime.to_unix(:millisecond)
          }
        })

      assert json_response(conn, :ok)["data"] == %{"id" => sweepstake.id}

      assert {:ok,
              %TestPayfy.Sweepstakes.Sweepstake{
                name: "newnamesweepstake",
                draw_date: ~U[2023-05-07 00:00:00Z]
              }} = TestPayfy.Sweepstakes.get_sweepstake(sweepstake.id)
    end

    test ":update determines a Sweepstake winner with a existent user", %{conn: conn} do
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

      conn =
        conn
        |> patch(Routes.v1_sweepstake_path(conn, :update, sweepstake), %{
          attrs: %{
            user_id: user.id
          }
        })

      assert json_response(conn, :ok)["data"] == %{"id" => sweepstake.id}

      assert {:ok,
              %TestPayfy.Sweepstakes.Sweepstake{
                name: "namesweepstake",
                draw_date: ~U[2023-12-01 00:00:00Z],
                user_id: ^user_id
              }} = TestPayfy.Sweepstakes.get_sweepstake(sweepstake.id)
    end

    test ":update determines a Sweepstake winner without a existent user retun a error", %{
      conn: conn
    } do
      sweepstake =
        fixture(:sweepstake, %{
          name: "namesweepstake",
          draw_date: ~U[2023-12-01 00:00:00Z]
        })

      conn =
        conn
        |> patch(Routes.v1_sweepstake_path(conn, :update, sweepstake), %{
          attrs: %{
            user_id: Ecto.UUID.generate()
          }
        })

      assert json_response(conn, :unprocessable_entity) == %{
               "errors" => %{
                 "user_id" => [
                   "does not exist"
                 ]
               }
             }

      assert {:ok,
              %TestPayfy.Sweepstakes.Sweepstake{
                name: "namesweepstake",
                draw_date: ~U[2023-12-01 00:00:00Z],
                user_id: nil
              }} = TestPayfy.Sweepstakes.get_sweepstake(sweepstake.id)
    end
  end
end
