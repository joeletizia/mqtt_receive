defmodule ProducerConsumer.Producer do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def publish_message_on_topic(topic, message) do
    GenServer.cast(__MODULE__, {:publish, {topic, message}})
  end

  def init(_) do
    :emqttc.start_link([host: 'localhost', client_id: "producer"])
  end

  def handle_cast({:publish, {topic, message}}, client) do
    spawn(fn -> publish_repeatedly(client, topic, message) end)
    {:noreply, client}
  end

  def handle_info(data, state) do
    # IO.puts "### RECEIVING INFO"
    # IO.inspect(data)
    # IO.puts "####"
    {:noreply, state}
  end

  defp publish_repeatedly(client, topic, message) do
    :timer.sleep(1000)
    :emqttc.publish(client, topic, message)
    IO.puts "Published message"
    publish_repeatedly(client, topic, message)
  end
end
