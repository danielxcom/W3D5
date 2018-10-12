class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |arg|
      define_method(arg) do
        instance_variable_get("@#{arg}")
      end

      define_method("#{arg}=") do |someblock|
        instance_variable_set("@#{arg}", someblock)
      end
    end
  end
end

#   #   instance_variable_get("@#{arg}")
# def send_with_args(method, *args)
#   self.send(method, *args)
# end
#
# # ...
# # define_method(names) do |name|
# #   self.instance_variable_get(:name)
# # end
# #
# # define_method(names) do |name|
# #   self.instance_variable_set(:name)
# # end
#
# # names.each do |name|
# #   define_method(name) do |n|
# #     puts "#{n}"
# #   end
# # end
#
# #
# # names.each do |name|
# #   self.send(:define_method, name) do |*name|
# #     instance_variable_set(:@name)
# #   end
# # end
#
# # names.each do |name|
# #   self.instance_variable_set(:@name, name)
# # end
#
# # names.each do |name|
# #   define_method(name) do |n|
# #     send(:initialize, "#{n}")
# #   end
# # end
#
# # names.each do |name|
# #   catched = "@#{name}"
# #   self.instance_variable_set(define_method(catched), catched)
# # end
#
#
#
# names.each do
#   define_method(name) do # what I'm seperating
#     instance_variable_get("@#{name}") # what I'm getting, don't need do |n|
#   end
#
#   # define_method("#{name}=") do |value| # what
#   #   instance_variable_set("@#{name}", value)
#   # end
#
#
# # names.each do |name|
# #   define_method(:name) {|other| "#{other}"}
# # end
# def send_without_args(*methods)
#   methods.each {|method| self.send(method) }
# end
