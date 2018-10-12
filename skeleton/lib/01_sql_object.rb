require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  # columns essentially are reset every single time we run this.
  # so if columns exist, return columns.
  # SQL will return interpolated self.table_name. the method must be called on self.
  def self.columns
    return @columns if @columns
    col = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    result = []
    col.first.each do |string|
      result << string.to_sym

    end
    result


    @columns = result
    # col.map!(&:to_sym)
    # @column = col
  end

  def self.finalize!
    self.columns.each do |symbol|
    # returns a column and a hash
    # using attributes
      define_method(symbol) do
        self.attributes[symbol]
      end

      define_method("#{symbol}=") do |arg|
        self.attributes[symbol] = arg
      end
    end

  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    # if table exists, return it.
    # if not, create based off self into a string then tableize it.
    @table_name ||= self.to_s.tableize
  end

  def self.all
    # ...
    # col = DBConnection.execute2(<<-SQL)
    #   SELECT
    #     *
    #   FROM
    #     #{self.table_name}
    # SQL
    #
    # col
    self
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # we need to call ::columns on a class object,
    # not the instance. For example, we can call Dog::columns but not dog.columns.
    # we use the Object#class method to access the
    # ::columns class method from inside the #initialize instance method
    raise "unknown attribute #{params}" unless params.is_a?(Hash)
    self.class.columns.each do |symbol|

    end

    # params.each do |k, val|

    # end



  end

  def attributes
    # ...
    #sets the hash we want to store for later gettters and setters
    @attributes ||= {}

  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
    # DBConnection.instance.execute(<<-SQL, name, id, owner_id)
    #   UPDATE
    #     #{table_name}
    #   SET
    #     #{name} = ?, #{id} = ?, #{owner_id} = ?
    #
    #   SQL
    #
    #
    # end
  end

  def save
    # ...
    # DBConnection.instance.execute(<<-SQL, name, id, owner_id)
    #   INSERT INTO
    #     #{table_name}
    #   VALUES
    #     (?, ?, ?)
    #
    #   SQL
    #
    #
    # end
  end
end
