collection @questions

node(:errors) do
  @notification
end

node(:total) do 
  @total
end

extends('questions/show')