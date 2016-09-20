class DifferentCurrencyCodeError < StandardError
end

class Currency

   attr_accessor :code :amount

   def initialize(code, amount)
      @code = code
      @amount = amount
   end

   def ==(other_currency)
      other_currency.is_a?(Currency) && other_currency.code == @code && other_currency.amount == @amount
   end

   def !=(other_currency)
      other_currency.is_a?(Currency) && other_currency.code != @code && other_currency.amount != @amount
   end

   def +(other_currency)
      @amount = @amount + other_currency.amount if other_currency.code == @code
      raise DifferentCurrencyCodeError if other_currency.code != @code
      puts "Invalid action. Not the same type(s) of currency." if other_currency.code != @code
   end

   def -(other_currency)
      @amount = @amount - other_currency.amount if other_currency.code == @code
      raise DifferentCurrencyCodeError if other_currency.code != @code
      puts "Invalid action. Not the same type(s) of currency." if other_currency.code != @code
   end

   def *(a_fixnum)
      if a_fixnum.is_a?(Fixnum)
         @amount = @amount * a_fixnum
         @amount = @amount.round(2)
      else
         puts "#{a_fixnum} is not a Fixnum and cannot be multiplied."
      end
   end

   def get_code(string_of_currency)
      return "USD" if string_of_currency[0] == '$'
      return "EUR" if string_of_currency[0] == '€'
      return "JPY" if string_of_currency[0] == '¥'
   end

end
