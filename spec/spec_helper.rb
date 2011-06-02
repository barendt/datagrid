require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require "active_record"
require "will_paginate"
require 'datagrid'
require "datagrid/rspec"
require 'ruby-debug'

require "rspec/rails/adapters"
require "rspec/rails/fixture_support"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Base.configurations = true

File.open('spec.log', "w").close
ActiveRecord::Base.logger = Logger.new('spec.log')



WillPaginate.enable

ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define(:version => 1) do

  create_table :entries do |t|
    t.integer :group_id
    t.string :name
  end

  create_table :groups do |t|
    t.string :name
  end

  class ::Entry < ActiveRecord::Base
    belongs_to :group
  end
  class ::Group < ActiveRecord::Base
  end
end



# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}