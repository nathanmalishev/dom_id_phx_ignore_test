defmodule DomIdPhxIgnore.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DomIdPhxIgnore.Content` context.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        content: "some content",
        title: "some title"
      })
      |> DomIdPhxIgnore.Content.create_article()

    article
  end
end
