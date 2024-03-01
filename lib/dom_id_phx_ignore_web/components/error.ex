defmodule DomIdPhxIgnoreWeb.Example do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <div id="test?param=1" phx-update="ignore"></div>
    """
  end
end
