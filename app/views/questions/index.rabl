collection @questions

node(:notification) do
  @notification
end

node(:total) do 
  @total
end

extends('questions/show')