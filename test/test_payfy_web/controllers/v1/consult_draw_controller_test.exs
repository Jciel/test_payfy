defmodule TestPayfyWeb.V1.ConsultDrawControllerTest do
  use TestPayfyWeb.ConnCase, async: true

  describe "Consult Draw" do
    test ":show with valid attrs get User winner from a Sweepstake", %{conn: conn} do
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

      conn =
        conn
        |> get(Routes.v1_consult_draw_path(conn, :show, sweepstake))

      assert json_response(conn, :ok)["data"] == %{
               "email" => user.email,
               "id" => user.id,
               "name" => user.name
             }
    end

    test ":show Try get User winner from a Sweepstake with a fake id", %{conn: conn} do
      conn =
        conn
        |> get(Routes.v1_consult_draw_path(conn, :show, Ecto.UUID.generate()))

      assert json_response(conn, :not_found) == %{
               "errors" => %{
                 "sweepstake_id" => [
                   "does not exist"
                 ]
               }
             }
    end

    test ":show with valid attrs get User winner from a Sweepstake without winner", %{conn: conn} do
      sweepstake =
        fixture(:sweepstake, %{
          name: "namesweepstake",
          draw_date: ~U[2023-12-01 00:00:00Z]
        })

      conn =
        conn
        |> get(Routes.v1_consult_draw_path(conn, :show, sweepstake))

      assert json_response(conn, :not_found) == %{
               "errors" => %{
                 "user_id" => [
                   "does not exist"
                 ]
               }
             }
    end
  end
end
