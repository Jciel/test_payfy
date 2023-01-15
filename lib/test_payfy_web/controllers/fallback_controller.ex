defmodule TestPayfyWeb.FallbackController do
  use TestPayfyWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(TestPayfyWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause handles errors returned by custom validation with fields
  def call(conn, {:error, {key, error}}) when is_atom(key) and is_binary(error) do
    conn
    |> put_status(:unprocessable_entity)
    |> json(%{errors: Map.put(%{}, key, [error])})
  end

  # This clause handles errors returned by custom validation
  def call(conn, {:error, error}) when is_binary(error) do
    conn
    |> put_status(:unprocessable_entity)
    |> json(%{errors: error})
  end

  # This clause handles generic unprocessable entity errors
  def call(conn, {:error, :unprocessable_entity}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(TestPayfyWeb.ErrorView)
    |> render(:"422")
  end

  # This clause is an example of how to handle resources that cannot be found with generic message.
  def call(conn, {:error, error}) do
    conn
    |> put_status(:not_found)
    |> json(%{errors: error})
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(TestPayfyWeb.ErrorView)
    |> render(:"404")
  end

  # This clause handles unauthorized error returned by role plug
  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(TestPayfyWeb.ErrorView)
    |> render(:"401")
  end

  def call(conn, _) do
    conn
    |> put_status(:not_found)
    |> put_view(TestPayfyWeb.ErrorView)
    |> render(:"404")
  end
end
