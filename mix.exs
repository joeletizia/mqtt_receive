defmodule ProducerConsumer.MixProject do
  use Mix.Project

  def project do
    [
      app: :producer_consumer,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ProducerConsumer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:exmqttc, "~> 0.5"}, 
      {:emqttc, github: "emqtt/emqttc"}
    ]
  end
end
