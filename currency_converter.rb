class UnknownCurrencyCodeError < StandardError
end

class CurrencyConverter

   require_relative 'currency'

   attr_reader :conversion_rates

   # conversion_rates must be a dictionary of conversion rates i.e. {'USD': 1.0, 'EUR': 0.74}
   # conversion_rates ideally should be a nested hash with seperate libraries for each individual currency
   # i.e. {'USD': {'USD': 1.0, 'EUR': 0.74, 'JPY': 120.0}, .....} etc.
   def initialize(conversion_rates)
      if conversion_rates.length >= 3
         @conversion_rates = conversion_rates
      else
         puts "Argument passed must be a dictionary of at least 3 converstion rates."
      end
   end

   def convert(currency_object, desired_code)
      if currency_object.code != desired_code
         if conversion_rates[currency_object.code][desired_code] >= 1.0
            new_amount = currency_object.amount * conversion_rates[currency_object.code][desired_code]
            new_amount = new_amount.round(2)
            return Currency.new(desired_code, new_amount)
         elsif conversion_rates[currency_object.code][desired_code] < 1.0
            new_amount = conversion_rates[currency_object.code][desired_code] / currency_object.amount
            new_amount = new_amount.round(2)
            return Currency.new(desired_code, new_amount)
         end
      elsif currency_object.code == desired_code
         return Currency.new(currency_object.code, currency_object.amount)
      else
         raise UnknownCurrencyCodeError
      end
   end



end
