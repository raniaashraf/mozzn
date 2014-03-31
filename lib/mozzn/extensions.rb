class Object
  # Copied from: https://github.com/rails/rails/blob/f4e180578c673194f58d4ff5a4a656cc51b2249e/activesupport/lib/active_support/core_ext/object/blank.rb
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end

	def present?
    !blank?
	end
end