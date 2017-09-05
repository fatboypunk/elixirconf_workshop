defmodule ProblemE do
  @moduledoc """
  ProblemE.
  """

  @doc """
  Start a Supervisor for Agents.
  """
  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, opts, opts)
  end

  @doc """
  Initialize the Supervisor
  """
  def init(opts) do
    {shutdown, opts} = Keyword.pop(opts, :shutdown, 5000)
    {restart,opts} = Keyword.pop(opts, :restart, :temporary)
    agent = %{id: Agent,
      start: {Agent, :start_link, []},
      shutdown: shutdown,
      restart: restart}
      Supervisor.init([agent], [strategy: :simple_one_for_one] ++ opts)
  end

  @doc """
  Start an Agent with a fun.
  """
  def start_child(sup, fun, opts \\ []) do
    Supervisor.start_child(sup, [fun, opts])
  end

  @doc """
  Start an Agent with module, function and arguments.
  """
  def start_child(sup, mod, fun, args, opts \\ []) do
    Supervisor.start_child(sup, [mod, fun, args, opts])
  end
end
