class Todo
  include Mongoid::Document

  field :title
  field :completed, type: Boolean, default: false
end
