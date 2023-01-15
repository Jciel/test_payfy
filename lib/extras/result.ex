defmodule Extras.Result do
  @type result(a, error) :: {:ok, a} | {:error, error}
  @type t(a, error) :: {:ok, a} | {:error, error}

  @spec fail(a) :: {:error, a} when a: var

  def fail(a), do: {:error, a}

  @spec from_maybe(Maybe.maybe(a), e) :: result(a, e) when a: var, e: var

  def from_maybe(nil, error), do: {:error, error}
  def from_maybe(a, _), do: {:ok, a}
end
