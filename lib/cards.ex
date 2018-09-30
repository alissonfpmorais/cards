defmodule Cards do
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six",
      "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    { hand, _rest_of_deck } = Enum.split(deck, hand_size)
    hand
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)

    case File.write(filename, binary) do
      :ok -> { :ok, filename }
      { :error, _reason } -> { :error, "Something went wrong" }
    end
  end

  def load(filename) do
    case File.read(filename) do
      { :ok, binary } -> { :ok, :erlang.binary_to_term(binary) }
      { :error, _reason } -> { :error, "Something went wrong" }
    end
  end
end
