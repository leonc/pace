defmodule Pace do

  def sec_to_min_sec(sec_left,min,sec) when sec_left == 0 do
    "#{min}:#{sec}"
  end

  def sec_to_min_sec(sec_left,min,_) when sec_left < 60 do
    sec_to_min_sec(0,min,sec_left)
  end

  def sec_to_min_sec(sec_left,min,sec) do
    sec_to_min_sec(sec_left - 60, min+1, sec)
  end

  def sec_to_min_sec(sec_left) do
    sec_to_min_sec(sec_left,0,0)
  end

  def mile_to_400(pace) do
    # get a pace as a m:ss format for a mile
    # and convert it to a m:ss for a 400 at 
    # that pace

    [_,min_mile_pace,sec_mile_pace]=
        Regex.run(~r/(\d+):([\d\.]+)/,pace)
    # should be ["6:40","6","40.1"]

    {min_num, _} = Float.parse(min_mile_pace)
    {sec_num, _} = Float.parse(sec_mile_pace)

    total_sec = (min_num * 60.0) + sec_num

    # there are 1609.34m in a mile
    sec_for_1600 = total_sec * 0.99419637864
    sec_for_400 = sec_for_1600 / 4

    # back to min:sec format
    sec_to_min_sec(sec_for_400)

  end

  def convert(pace) do
    IO.puts "A mile in #{pace} is 400m in #{mile_to_400(pace)}"
  end

end

# i'll admit i don't know why i had to declare this function this way.
# TODO: WTF was this about?
foo = fn s -> IO.puts "A mile @ #{s} is a 400 in #{Pace.mile_to_400(s)}" end
Enum.each(System.argv, foo)

