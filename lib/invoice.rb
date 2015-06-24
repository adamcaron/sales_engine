class Invoice
  attr_reader   :id,
                :customer_id,
                :merchant_id,
                :status,
                :created_at,
                :updated_at

  attr_accessor :repository

  def initialize(line, repository)
    @id         = line[:id].to_i
    @customer_id = line[:customer_id].to_i
    @merchant_id = line[:merchant_id].to_i
    @status = line[:status]
    @created_at = line[:created_at]
    @updated_at = line[:updated_at]
    @repository = repository
  end

  def transactions
    repository.find_transactions_by_id(id)
  end

  def customer
    repository.find_customer_by_customer_id(customer_id)
  end

  def invoice_items
    repository.find_invoice_items_by_id(id)
  end

  def items
    repository.find_items(id)
  end
end
