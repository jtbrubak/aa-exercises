class Array

  def my_each(&blk)
    self.length.times do |i|
      blk.call(self[i])
    end
    self
  end

  def my_select(&blk)
    selects = []
    self.length.times do |i|
      selects.push(self[i]) if blk.call(self[i])
    end
    selects
  end

  def my_reject(&blk)
    selects = []
    self.length.times do |i|
      selects.push(self[i]) unless blk.call(self[i])
    end
    selects
  end

  def my_any?(&blk)
    self.length.times { |i| return true if blk.call(self[i]) }
    false
  end

  def my_all?(&blk)
    self.length.times { |i| return false unless blk.call(self[i]) }
    true
  end

  def my_flatten
    flattened = []
    self.length.times do |i|
      if self[i].is_a?(Array)
        flattened.concat(self[i].my_flatten)
      else
        flattened.push(self[i])
      end
    end
    flattened
  end

  def my_zip(*arrs)
    zipped = []
    self.length.times do |i|
      zipped[i] = [self[i]]
      arrs.each do |arr|
        zipped[i].push(arr[i])
      end
    end
    zipped
  end

  def my_rotate(num = 1)
    rotated = self.dup
    if num >= 0
      num.times do
        el = rotated.shift
        rotated.push(el)
      end
    else
      num.abs.times do
        el = rotated.pop
        rotated.unshift(el)
      end
    end
    rotated
  end

  def my_join(str = "")
    joined = ""
    (self.length - 1).times do |i|
      joined += self[i] + str
    end
    joined += self.last
  end

  def my_reverse
    reversed = []
    (self.length - 1).downto(0) do |i|
      reversed.push(self[i])
    end
    reversed
  end

  def bubble_sort!
    finished = false
    while !finished
      finished = true
      0.upto(self.length - 2) do |i|
        if self[i] > self[i+1]
          finished = false
          self[i], self[i+1] = self[i+1], self[i]
        end
      end
    end
    self
  end

  def bubble_sort
    sorted = self.dup
    sorted.bubble_sort!
  end

end

def factors(num)
  factors = [1]
  2.upto(num / 2) do |i|
    factors.push(i) if num % i == 0
  end
  factors.push(num)
  factors
end

def substrings(str)
  substrings = []
  used = {}
  str.length.times do |i|
    1.upto(str.length - 1) do |j|
      substrings.push(str[i..j]) unless used[str[i..j]]
    end
  end
  substrings
end

def subwords(word, dictionary)
  subwords = []
  used = {}
  word.length.times do |i|
    1.upto(word.length - 1) do |j|
      subwords.push(word[i..j]) unless used[word[i..j]]
      used[word[i..j]] = true
    end
  end
  subwords.select { |sub| dictionary.include?(sub) }
end
