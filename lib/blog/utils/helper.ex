defmodule Blog.Utils.Helper do

  def is_empty(val) when is_nil(val) do
    true
  end

  def is_empty(val) when is_binary(val) do
    val = String.trim(val)
    byte_size(val) == 0
  end

  def is_empty(val) when is_list(val) do
    length(val) == 0
  end

  def is_empty(val) when is_map(val) do
    map_size(val) == 0
  end

  def is_empty(val) when is_tuple(val) do
    tuple_size(val) == 0
  end

  def is_empty(_val) do
    false
  end
  
  def generate_password_hash(password) do
    :crypto.hash(:sha256, password) |> Base.encode64  
  end
  
end