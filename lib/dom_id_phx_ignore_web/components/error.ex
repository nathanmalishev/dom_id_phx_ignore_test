defmodule DomIdPhxIgnoreWeb.Example do
  use Phoenix.Component

  attr :dom_id, :string, required: true

  def render(assigns) do
    ~H"""
    <div id={@dom_id} phx-update="ignore"></div>
    """
  end
end
