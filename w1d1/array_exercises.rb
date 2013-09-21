
class Array
	def my_uniq
		uniques = []
		self.each do |element|
			uniques << element unless uniques.include?(element)
		end

		uniques
	end

	def two_sum
		pairs =[]
		self.each_with_index do |num1, ind1|
#			ind2 = ind1 + 1
#
#			while ind2 < self.length
#				pairs << [ind1, ind2] if (num + self[ind2] == 0)
#				ind2 +=1
#			end

			self[ind1+1..-1].each_with_index do |num2, ind2|

				real_ind2 = ind2 + ind1 + 1
				pairs << [ind1, real_ind2] if (num1 + num2 == 0)

			end

		end
		pairs
	end

end


def my_transpose(matrix)
	new_matrix = []

	(0...matrix.length).each do |row_index|
		new_row = []
		matrix.each do |row|
			new_row << row[row_index]
		end
		new_matrix << new_row
	end

	new_matrix
end


#p [1, 2, 1, 3, 3].my_uniq

#p [-1, 0, 2, -2, 1].two_sum
# rows = [
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ]
# 	p my_transpose(rows)


def stock_picker stock_prices
	buy_ind = 0
	sell_ind = 1

	highest_price = 0

	stock_prices.each_with_index do |price, buy_day|
		sell_day = buy_day +1

		while sell_day < stock_prices.length
			if stock_prices[sell_day] - price > highest_price
				buy_ind = buy_day
				sell_ind = sell_day
				highest_price = stock_prices[sell_day] - price
			end
			sell_day +=1
		end
	end
	[buy_ind, sell_ind]

end

# p stock_picker stock_prices
