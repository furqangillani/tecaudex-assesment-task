class Order < ApplicationRecord
    has_many :line_items, dependent: :destroy
    before_create :create_order_number
    after_destroy :clear_the_current_order

    enum state: { 'completed': 1, 'paid': 2, 'cart': 0}


    def generate_order_number
     prefix = "R"
     timestamp = Time.now.strftime("%Y%m%d%H%M%S")
     random_component = rand(1_000_000).to_s.rjust(6, '0')
     order_number = "#{prefix}#{timestamp}#{random_component}"
    end


    def create_order_number
        order_number = generate_order_number
        self.order_number = order_number
    end

    def products_in_cart_count
        self.line_items.count
    end


    def re_calculate_order
        self.total = self.line_items.map(&:get_line_item_price)&.sum
        self.tax = self.total/16 * 100
        self.delivery_charges = rand(1000)
        self.save!
    end

    def self.current_order
        @current_order ||= new 
    end


    def order_completed
        self.state = 'completed'
        self.save!
        self.class.instance_variable_set(:@current_order, self.class.new)
        return nil
    end

    def cart_items
        line_items_list = []
        _line_item =  self.line_items
        _line_item.each do |line_item|
            line_items_list << { 
                id: line_item.id,
                quantity: line_item.quantity,
                product_id: line_item.product.id,
                price: line_item.product.price,
                description: line_item.product.description,
                title: line_item.product.title,
                categories: line_item.product.categories
            }
        end
        line_items_list
    end


    def remove_all_cart_items
        self.line_items.destroy_all
    end


    def remove_single_item(id)
        line_item = self.line_items.find_by(id: id)
        line_item.destroy if line_item.present?
    end


    def add_product(product, quantity)
        return false if self.state == 'completed'
        self.line_items.create!(product: product, quantity: quantity)
        return true
    end

    def clear_the_current_order
      self.class.instance_variable_set(:@current_order, self.class.new)
    end

end
