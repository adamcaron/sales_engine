require 'date'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository,
              :revenue

  def initialize(line, repository)
    @id         = line[:id].to_i
    @name       = line[:name]
    @created_at = Date.parse(line[:created_at])
    @updated_at = Date.parse(line[:updated_at])
    @repository = repository
  end

  def items
    repository.find_items(id)
  end

  def invoices
    repository.find_invoices_by_id(id)
  end


  def revenue
    @revenue ||= calculate_revenue(self.invoices)
    @revenue
  end

  # def revenue(date)
  #   invoices_for_date = self.invoices.find_all { |invoice| invoice.created_at.eql?(date)}
  #   calculate_revenue(invoices_for_date)
  # end

  private

  def calculate_revenue(invoices)
    total(get_invoice_items(find_successful_transactions(invoices)))
  end

  def total(invoice_items)
    invoice_items.inject(0) { |total, invoice_item| total + (invoice_item.unit_price * invoice_item.quantity) }
  end

  def get_invoice_items(transactions)
    transactions.map { |invoice| invoice.invoice_items }.flatten
  end

  def find_successful_transactions(invoices)
    invoices.find_all { |invoice| has_successful_transactions?(invoice) }
  end

  def has_successful_transactions?(invoice)
    invoice.transactions.any? { |transaction| transaction.result.eql?('success') }
  end

end


