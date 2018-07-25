defmodule ProducerConsumer.Consumer do
  use GenServer

  def start_link(_) do 
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    {:ok, client} = :emqttc.start_link([host: 'localhost', client_id: "consumer"])
    :emqttc.subscribe(client, "topic", :qos1)
    {:ok, nil}
  end

  def handle_info(data, state) do
    IO.puts "### RECEIVING INFO"
    IO.inspect(data)
    IO.puts "####"
    {:noreply, state}
  end
end
