require 'optparse'
require 'date'

month = nil
year = nil

opt = OptionParser.new

opt.on('-m MONTH') do |m|
  month = m.to_i
end

opt.on('-y YEAR') do |y|
  year = y.to_i
end

opt.parse!(ARGV)

unless month
  month ||= Date.today.month
end

year ||= Date.today.year
puts "#{month}月 #{year}".center(20)

puts " 日 月 火 水 木 金 土"

first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)
today = Date.today

# 初週を右に寄せる
prefix_blank_length = (first_day.wday * 3)
print " " * prefix_blank_length

(first_day..last_day).each do |d|
  if d.day.to_i < 10
      print "#{d.day}".rjust(3)
  elsif d.day.to_i == today.day.to_i
    print "\e[7m#{d.day}\e[0m".rjust(11)
  else 
    print "#{d.day}".rjust(3)
  end
  if d.saturday?
    puts " "
  end
end

puts " " # 最後に出力される%を削除する
