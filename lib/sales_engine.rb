require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'

class SalesEngine
  attr_accessor :merchant_repository,
                :item_repository,
                :invoice_repository,
                :invoice_item_repository,
                :customer_repository,
                :transaction_repository

  attr_reader :filepath

  def initialize(filepath)
    @filepath = filepath
    @merchant_repository ||= MerchantRepository.new(self)
    @item_repository ||= ItemRepository.new(self)
    @invoice_repository ||= InvoiceRepository.new(self)
    @customer_repository ||= CustomerRepository.new(self)
    @transaction_repository ||= TransactionRepository.new(self)
    @invoice_item_repository ||= InvoiceItemRepository.new(self)
  end

  def startup
    @merchant_repository.load_data("#{filepath}/merchants.csv")
    @item_repository.load_data("#{filepath}/items.csv")
    @invoice_repository.load_data("#{@filepath}/invoices.csv")
    @customer_repository.load_data("#{@filepath}/customers.csv")
    @transaction_repository.load_data("#{@filepath}/transactions.csv")
    @invoice_item_repository.load_data("#{@filepath}/invoice_items.csv")
  end

  def find_item_by_id(id)
    item_repository.find_by_id(id)
  end

  def find_items_by_merchant_id(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_merchant_by_id(id)
    merchant_repository.find_by_id(id)
  end

  def find_invoice_by_id(id)
    invoice_repository.find_by_id(id)
  end

  def find_invoices_by_merchant_id(id)
    invoice_repository.find_all_by_merchant_id(id)
  end

  def find_invoices_by_customer_id(customer_id)
    invoice_repository.find_all_by_customer_id(customer_id)
  end

  def find_invoice_items_by_item_id(id)
    invoice_item_repository.find_all_by_item_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    invoice_item_repository.find_all_by_invoice_id(id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    transaction_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_customer_by_id(id)
    customer_repository.find_by_id(id)
  end

  def find_invoice_by_id(id)
    invoice_repository.find_by_id(id)
  end

  def create_invoice_items(items, invoice_id)
    invoice_item_repository.create(items, invoice_id)
  end

  def create_transaction_with_invoice_id(information, invoice_id)
    transaction_repository.create(information, invoice_id)
  end
end
