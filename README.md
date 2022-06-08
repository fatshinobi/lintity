# Lintity
Training gem (Engine) that shows list of entities

## Installation
Add this line to your application's Gemfile:

```ruby
gem "lintity"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install lintity
```
## System Requirements
  * Ruby >= 3.0
  * Ruby On Rails >= 7.0
  * gem 'importmap-rails'
  * gem 'stimulus-rails'
  * bootstrap 5
  * gem 'font-awesome-rails'
  * ActiveRecord

## Usage
Create your controller
```ruby
class CustomersController < Lintity::EntityListController #inherit
  layout 'application'  #use own main layout
  before_action :set_customer, only: [:edit]

  def index
    @search_path = customers_path
    
    @records = 
      if @filter_field
        Customer.where("#{@filter_field} #{@filter_sign} ?", @filter_value.to_i)  #implementing filter result
      else
        Customer.all
      end
  end

  def edit; end

  private

  def init_fields  #your fields from model
    @fields_settings = [
      { field: 'name', name: 'Name', type: 'edit', path: Proc.new { |customer_id| edit_customer_path(id: customer_id) } },  #Add path for edit of a record
      { field: 'phone', name: 'Phone', type: 'info' },
      { field: 'address', name: 'Address', type: 'info' },
      { field: 'ordered', name: 'Ordered', type: 'numeric_filter' },
      { field: 'no_of_orders', name: 'No Of Orders', type: 'numeric_filter' },
      { field: 'total_amount', name: 'Total Amount', type: 'numeric_filter' },
    ]
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
```

## Results
  * Entity List View:
![list](https://user-images.githubusercontent.com/14085661/172581037-c439c2f5-8c6b-4eb0-a5f0-21db755f427c.jpg)

  * Filter
![filter](https://user-images.githubusercontent.com/14085661/172581112-c98d9c0a-3c8c-4ee7-a651-9827435377cb.jpg)

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
