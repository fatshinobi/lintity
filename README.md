# Lintity
Training gem (Engine) that shows list of entities

## Installation
Add this line to your application's Gemfile:

```ruby
gem "lintity", "~> 0.2.0"
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
  * Ruby >= 3.4
  * Ruby On Rails >= 8.0
  * gem 'importmap-rails'
  * gem 'stimulus-rails'
  * gem 'pagy'
  * bootstrap 5
  * ActiveRecord

## Entity List Usage
Create your controller
```ruby
class CustomersController < Lintity::EntityListController #inherit
  layout 'application'  #use own main layout
  before_action :set_customer, only: [:edit]

  def index
    @search_path = customers_path
    
    @records = 
      if @filter_field && valid_filter_field?
        Customer.where(Customer.arel_table[@filter_field].public_send(valid_filter_sign, @filter_value))  #implementing filter result
      else
        Customer.all
      end

    @pagy, @records = pagy(:offset, @records)

    @entity_list_header_caption, @entity_list_new_path = "Customers List", new_customer_path
  end

  def edit; end

  private

  def init_fields  #your fields from model
    @fields_settings = [
      { field: 'name', name: 'Name', type: 'edit', path: Proc.new { |customer_id| edit_customer_path(id: customer_id) } },  # Add path for edit a record
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

Or implement the pagination by default
```ruby
class CustomersController < Lintity::EntityListController 
...
  def index
    @search_path = items_path

    @entity_list_header_caption, @entity_list_new_path = "Items List", new_item_path
  end

...
  private
...
  # Pagination is automatically handled by the controller
  # @records will be paginated using pagy if it responds to paginate
  def init_records
    @records =
      if @filter_field && valid_filter_field?
        Customer.where(Customer.arel_table[@filter_field].public_send(valid_filter_sign, @filter_value))
      else
        Customer.all
      end
  end
```

Couple useful methods implementation
```ruby
  def valid_filter_field?
    @fields_settings.map { |f| f[:field] }.include?(@filter_field) && %(= <= >=).include?(@filter_sign)
  end

  def valid_filter_sign
    case @filter_sign
    when "="
      "eq"
    when "<="
      "lteq"
    when ">="
      "gteq"
    else
      nil
    end
  end
```

## Results
  * Entity List View:
![list](https://user-images.githubusercontent.com/14085661/172581037-c439c2f5-8c6b-4eb0-a5f0-21db755f427c.jpg)

  * Filter
![filter](https://user-images.githubusercontent.com/14085661/172581112-c98d9c0a-3c8c-4ee7-a651-9827435377cb.jpg)

## Entity Report Usage
Create your controller
```ruby
class StockBalanceReportsController < Lintity::EntityReportController
  layout "application"
  before_action :set_entity_filter_header, only: [ :index ]

  def index
    storage_id = params[:storage_id]
    item_id = params[:item_id]
    balance_time = params[:balance_time] || Time.current
    @records = InventoryTransaction.stock_balance_by_batches_calculation(
      storage_id: storage_id,
      item_id: item_id,
      to_time: balance_time,
      fields_info: {
        items: { include: :item, field: :name },
        storages: { include: :storage, field: :name }
      }
    )

    @entity_report_header_caption, @entity_report_pdf_path = "Stock Balance Report", stock_balance_reports_path(format: :pdf, storage_id: storage_id, item_id: item_id, balance_time: balance_time)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "stock_balance_report_#{Time.current.to_i}", # The name of the downloaded file
                template: "lintity/entity_report/index",
                layout: "layouts/pdf", # Optional: Use a specific layout
                disposition: "attachment" # Optional: Force download instead of inline view
      end
    end
  end

  # Show a form to select an Item and a Storage before displaying the report
  def new
    @items = Item.all
    @storages = Storage.all
  end

  private

  def set_entity_filter_header
    filter_parts = []
    if params[:storage_id].present?
      storage_name = Storage.find_by(id: params[:storage_id])&.name
      filter_parts << "Storage: #{storage_name}" if storage_name.present?
    end
    if params[:item_id].present?
      item_name = Item.find_by(id: params[:item_id])&.name
      filter_parts << "Item: #{item_name}" if item_name.present?
    end
    if params[:balance_time].present?
      filter_parts << "Balance time: #{params[:balance_time]}"
    end
    @entity_filter_header_caption = "Filters: #{filter_parts.join(', ')}" if filter_parts.present?
  end

  def init_fields
    @fields_settings = [
      { field: "item", caption: "Storage/Item/Batch", type: "info" },
      { field: "qty",  type: "number" },
      { field: "cost",  type: "number" }
    ]
  end
end
```
## Results
  * Entity Report View:
![list](https://private-user-images.githubusercontent.com/14085661/603609128-ef008aec-bf2e-4f8a-a556-0ce984168d34.jpg?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3ODA2ODE2MjcsIm5iZiI6MTc4MDY4MTMyNywicGF0aCI6Ii8xNDA4NTY2MS82MDM2MDkxMjgtZWYwMDhhZWMtYmYyZS00ZjhhLWE1NTYtMGNlOTg0MTY4ZDM0LmpwZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA2MDUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNjA1VDE3NDIwN1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWExOGM5YzcxZDNmNjc3ZGU1YzRjZDM3NGUxMWEzNDRhODY1ZDRhMjZjMTI2ZjBjNzU1ZDJhOGQzOGRhYzA4YTcmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JnJlc3BvbnNlLWNvbnRlbnQtdHlwZT1pbWFnZSUyRmpwZWcifQ.6HDnjvjp574YyL-H1RJOgtpP6sGAhU2_1pOD8UOjP-E)

  * Entity Report PDF:
![list](https://private-user-images.githubusercontent.com/14085661/603609363-f1f98bfe-bea5-4625-b11a-f2d07ad2b3ae.jpg?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3ODA2ODE2MjcsIm5iZiI6MTc4MDY4MTMyNywicGF0aCI6Ii8xNDA4NTY2MS82MDM2MDkzNjMtZjFmOThiZmUtYmVhNS00NjI1LWIxMWEtZjJkMDdhZDJiM2FlLmpwZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA2MDUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNjA1VDE3NDIwN1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWI5YWQ4N2JjZWJhZmM3ZDlmZTY4OGRhMzRiNjM4YmEyMDRlYWQ3OGFlOGQ3NGY2NDQxZGM4ZTJjNDAzYjM4ZDImWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JnJlc3BvbnNlLWNvbnRlbnQtdHlwZT1pbWFnZSUyRmpwZWcifQ.b-9mPsd6p0EJYDTJ_EWre0seuoCRtzO7C7v2MyLXuJ0)

## Demo application:
[FIFO LIFO Warehouse](https://github.com/fatshinobi/fifo_lifo_warehouse)

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
