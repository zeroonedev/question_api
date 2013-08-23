
collection @questions

extends('questions/show')

node(:errors) do
  @notification
end

node(:total) do
  @total
end
