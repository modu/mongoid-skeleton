class ApplicationController < ActionController::Base
  protect_from_forgery
end

class ParseFunction
   def parse
      raise "parse must be overridden"
   end
end

class StringParseFunction < ParseFunction
   attr_accessor :hashkey
   def initialize(hashkey)
      @hashkey = hashkey
   end
   def parse(hash)
      value = hash.fetch(@hashkey)
      raise "#{hashkey} is empty" if value.empty?
      return value
   end
end

class NumberParseFunction < ParseFunction
   attr_accessor :hashkey
   def initialize(hashkey)
      @hashkey = hashkey
   end
   def parse(hash)
      value = Integer(hash.fetch(@hashkey))
      return value
   end
end

class ArrayParseFunction < ParseFunction
   attr_accessor :hashkey
   def initialize(hashkey)
      @hashkey = hashkey
   end
   def parse(hash)
      return nil unless hash.has_key? @hashkey
      value = hash.fetch(@hashkey).split(',')
      return nil if value.empty?
      return value
   end
end

class MultipleParseFunction < ParseFunction
   attr_accessor :key_start
   def initialize(key_start)
      @key_start = key_start
   end
   def parse(hash)
      #raise key_start
      return nil unless (hash.has_key?(key_start+'1') and (not hash.fetch(key_start+'1').empty?))
      ans = [hash.fetch(key_start+'1')]
      i = 2
      while hash.has_key?(key_start+i.to_s) do
         val = hash.fetch(key_start+i.to_s)
         ans << val unless val.empty? or val.nil?
         i = i + 1
      end
      return ans
   end
end

class ArrayMultipleParseFunction < ParseFunction
  attr_accessor :key_start
  def initialize(key_start)
    @key_start = key_start
  end
  def parse(hash)
    res = MultipleParseFunction.new(@key_start).parse(hash)
    ans = []
    res.each do |one|
      putin = one.split(',')
      ans << putin unless putin.nil? 
    end
    return ans
  end  
end  

class CollationParseFunction < ParseFunction
  attr_accessor :keys
  def initialize(parse_functions)
    @parse_functions = parse_functions
  end
  def parse(hash)
    result = {}
    @parse_functions.each do |key, parse_function|
      v = parse_function.parse(hash)
      result[key] = v if not v.nil?
    end
    return result if not result.empty?
    return nil
  end  
end

class CollationMultipleParseFunction < ParseFunction
  attr_accessor :keys
  def initialize(keys)
    @keys = keys
  end
  def parse(hash)
    result1 = {}
    @keys.each do |key|
      m = MultipleParseFunction.new(key)
      result1[key] = m.parse(hash) 
    end
    result2 = []
    return nil if result1[keys[0]].nil?
    l = result1[keys[0]].size
    (0...l).each do |num|
      one_hash = {}
      keys.each do |key|
        one_hash[key] = result1[key][num]
      end
      result2 << one_hash  
    end
    return result2
  end  
end

$level_spec = [
     [:game, CollationParseFunction.new([
       [:levelName, StringParseFunction.new('levelName')],
       [:sequence, StringParseFunction.new('sequence')],
       [:items, CollationParseFunction.new([
         [:item, CollationMultipleParseFunction.new(['question','answer'])]
       ])],
       [:kcs, CollationParseFunction.new([
         [:kc, CollationMultipleParseFunction.new(['kcname', 'L', 'G', 'T', 'S', 'itemnumbers'])]

=begin
         [:kc,  CollationParseFunction.new([
           [:kcname, MultipleParseFunction.new('kcname')],
           [:L, MultipleParseFunction.new('L')],
           [:G, MultipleParseFunction.new('G')],
           [:T, MultipleParseFunction.new('T')],
           [:S, MultipleParseFunction.new('S')],
           [:itemnumbers, ArrayMultipleParseFunction.new('itemnumbers')]
         ])]
=end

       ])],
       [:binsizes, ArrayParseFunction.new('binsizes')]
       ])]     
  ]

$sequence_spec = [
       [:levelSequence, CollationParseFunction.new([
            [:creatorName, StringParseFunction.new('CreatorName')],
            [:sequenceName, StringParseFunction.new('sequenceName')],
            [:levels, CollationParseFunction.new([
              [:level, StringParseFunction.new('level')]
            ])]
         ])]
    ]


def parse(input_hash, parse_spec)
   ans = Hash.new
   parse_spec.each do |field, parse_ob|
    unless parse_ob.nil?
      doc = parse_ob.parse(input_hash)
      ans[field] = doc unless doc.nil?
    end
   end
   return ans
end

