class ::String
	### Small hack, didnt know if theres another option hehe
	def append_line &block
		(self + "\r\n").concat(yield(block))
	end
end