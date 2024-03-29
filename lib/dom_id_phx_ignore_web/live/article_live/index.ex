defmodule DomIdPhxIgnoreWeb.ArticleLive.Index do
  use DomIdPhxIgnoreWeb, :live_view

  alias DomIdPhxIgnore.Content
  alias DomIdPhxIgnore.Content.Article

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :articles, Content.list_articles())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Article")
    |> assign(:article, Content.get_article!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Article")
    |> assign(:article, %Article{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Articles")
    |> assign(:article, nil)
  end

  @impl true
  def handle_info({DomIdPhxIgnoreWeb.ArticleLive.FormComponent, {:saved, article}}, socket) do
    {:noreply, stream_insert(socket, :articles, article)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    article = Content.get_article!(id)
    {:ok, _} = Content.delete_article(article)

    {:noreply, stream_delete(socket, :articles, article)}
  end
end
