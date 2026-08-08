ActiveAdmin.register_page "Customer Order Summaries" do

  content title: "Customer Order Summaries" do

    customers = Customer
      .joins(:orders)
      .includes(orders: { order_items: :product })
      .distinct
      .order(:name)

    if customers.empty?
      panel "Customer Order Summary" do
        para "No customers with orders were found."
      end
    else
      customers.each do |customer|
        grand_total = 0
        panel customer.name do

          attributes_table_for customer do
            row("Email") { customer.email }
            row("Phone") { customer.phone }
            row("Number of Orders") { customer.orders.size }
          end

          table_for customer.orders.order(order_date: :desc) do

            column("Order ID") do |order|
              order.id
            end

            column("Order Date") do |order|
              order.order_date
            end

            column("Products") do |order|
              ul do
                order.order_items.each do |item|
                  li do
                    "#{item.product.name} × #{item.quantity}"
                  end
                end
              end
            end

            column("Taxes") do |order|
              order.order_items.each do |order_item|
                grand_total += order_item.product.price
              end
              number_to_currency(customer.province.tax * grand_total)
            end

            grand_total = 0

            column("Grand Total") do |order|
                order.order_items.each do |order_item|
                    grand_total += order_item.product.price +  order_item.product.price * customer.province.tax
                end
              number_to_currency(grand_total)
            end

          end

        end

      end

    end
  end
end