require 'optparse'
require 'date'

#初期値を設定
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

#-mと-yが指定された場合はその通りに出力されるよう設定
if year && month
    puts "#{month}月 #{year}".center(20)

#-mだけ指定された場合は今年が入るように設定
elsif month
    year = Date.today.year
    puts "#{month}月 #{year}".center(20)

#何も指定されていない場合は今日が出力されるよう設定
else
    year = Date.today.year
    month = Date.today.month
    puts "#{month}月 #{year}".center(20)
end

puts " 日" + " 月" + " 火" + " 水" + " 木" + " 金" + " 土"

first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)
today = Date.today

#初週を右に寄せる
day_righter = (first_day.wday * 3) - 1
day_righter.times do 
    print " "
end

(first_day..last_day).each do |d|
    #曜日の出力位置と合わせるため、日付が1桁の場合に半角スペースを2つ入れ、2桁の場合は半角スペースを1桁入れる
    if d.day.to_i < 10    
        print "  #{d.day}"
     #今日の日付の場合は背景色を黒、文字色を白で出力する
    elsif d.day.to_i == today.day.to_i
        print " \e[97;40m#{d.day}\e[0m"
    else 
        print " #{d.day}"
    end
    #土曜日の場合は改行する
    if d.saturday?
        puts " "
    end
end

#最後に表示される%を削除する
puts " "