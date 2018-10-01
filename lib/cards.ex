defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six",
      "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Returns a shuffled deck of cards
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Returns if a given deck contains or not a card.
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` parameter indicates how many cards should be in the hand

  ## Example

      iex> deck = Cards.create_deck
      iex> {hand, _rest_of_deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Save a deck to a file
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)

    case File.write(filename, binary) do
      :ok -> {:ok, filename}
      {:error, _reason} -> {:error, "Something went wrong" }
    end
  end

  @doc """
    Load a deck from a file
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> {:ok, :erlang.binary_to_term(binary)}
      {:error, _reason} -> {:error, "Something went wrong"}
    end
  end

  @doc """
    Return a new hand from a new shuffled deck.
    The `hand_size` parameter indicates how many cards should be in the hand

    This methods is an alias for:
    `Cards.create_deck |> Cards.shuffle |> Cards.deal(hand_size)`

  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
