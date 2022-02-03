class Mikawa
  attr_accessor :name, :sex, :constellation, :sing_comfortably_status

  CONSTELLATION_ARRAY = ["牡羊座", "牡牛座", "双子座", "蟹座", "獅子座", "乙女座", "天秤座", "蠍座", "射手座", "山羊座", "水瓶座", "魚座"]
  SEX_ARRAY = ["男", "女"]

  def initialize
    @name = "美川"
    @sex = "女"
    @constellation = "蠍座"
    @sing_comfortably_status = false
  end

  def random_search
    response = false

    while !response
      constellation = CONSTELLATION_ARRAY[rand(0...12)]
      sex = SEX_ARRAY[rand(0...2)]

      puts "#{constellation}の#{sex}ですか？"
      response = is_asked?(constellation, sex)
    end
  end

  def exhaustive_seach
    CONSTELLATION_ARRAY.each do |constellation|
      SEX_ARRAY.each do |sex|
        puts "#{constellation}の#{sex}ですか？"
        return if is_asked?(constellation, sex)
      end
    end
  end

  def sequential_search
    constellation = nil
    sex = nil
    CONSTELLATION_ARRAY.each do |_constellation|
      puts "#{_constellation}ですか？"
      if is_constellation?(_constellation)
        constellation = _constellation
        break
      end
    end
    SEX_ARRAY.each do |_sex|
      puts "#{_sex}ですか？"
      if is_sex?(_sex)
        sex = _sex
        break
      end
    end
    puts "ってことは#{constellation}の#{sex}ですね？"
    is_asked?(constellation, sex)
  end

  def binary_search
    constellation = binary_search_constellation
    sex = binary_search_sex

    puts "ってことは#{constellation}の#{sex}ですね？"
    is_asked?(constellation, sex)
  end

  def start_singing
    puts sing_comfortably? ? "そうよ！私は#{constellation}の#{sex}〜♪" : "いいえ私は#{constellation}の#{sex}〜♪"
  end

  def start_intro
    puts "〜♪"
  end

  def exec(search)
    search_method = method(search.to_sym)
    start_intro
    puts "わー！#{name}さんだー！#{name}さん！#{name}さん！"
    sleep(0.5)
    search_method.call
    start_singing
  end

  private

  def sing_comfortably?
    sing_comfortably_status
  end

  def is_asked?(constellation, sex)
    sleep(0.5)
    boolean = constellation.eql?(self.constellation) && sex.eql?(self.sex)
    self.sing_comfortably_status = boolean ? response_true : response_false
  end

  def is_sex?(sex)
    sleep(0.5)
    sex.eql?(self.sex) ? response_true : response_false
  end

  def is_constellation?(constellation)
    sleep(0.5)
    constellation.eql?(self.constellation) ? response_true : response_false
  end

  def is_greater_constellation?(mid_constellation)
    sleep(0.5)
    self.constellation > mid_constellation ? response_true : response_false
  end

  def is_greater_sex?(mid_sex)
    sleep(0.5)
    self.sex > mid_sex ? response_true : response_false
  end

  def response_true
    puts "(頷く)"
    sleep(0.5)
    true
  end

  def response_false
    puts "(首を振る)"
    sleep(0.5)
    false
  end

  def binary_search_constellation
    sorted_constellation_array = CONSTELLATION_ARRAY.sort
    min_num = 0
    max_num = sorted_constellation_array.length - 1
    mid_num = (min_num + max_num) / 2
    mid_constellation = sorted_constellation_array[mid_num + 1]

    while (min_num < max_num)
      puts "#{mid_constellation}以降の星座ですか？"
      if is_greater_constellation?(mid_constellation)
        min_num = mid_num + 1
      else
        max_num = mid_num
      end
      mid_num = (min_num + max_num) / 2
      mid_constellation = sorted_constellation_array[mid_num]
    end
  end

  def binary_search_sex
    sorted_sex_array = SEX_ARRAY.sort
    min_num = 0
    max_num = sorted_sex_array.length - 1
    mid_num = (min_num + max_num) / 2
    mid_sex = sorted_sex_array[mid_num + 1]
    while (min_num < max_num)
      puts "性別を名前の順にしたとき#{mid_sex}以降ですか？"
      if is_greater_sex?(mid_sex)
        min_num = mid_num + 1
      else
        max_num = mid_num
      end
      mid_num = (min_num + max_num) / 2
      mid_sex = sorted_sex_array[mid_num]
    end
  end
end

Mikawa.new.exec("random_search")
Mikawa.new.exec("exhaustive_seach")
Mikawa.new.exec("sequential_search")
Mikawa.new.exec("binary_search")
