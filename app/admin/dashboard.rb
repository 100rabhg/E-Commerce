# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Order in a week: #{Order.where(created_at: (Time.now-7.days..)).count}" do
          ul do
            Order.joins(product: :category).group("categories.title").count.map do |title,count|
              li ("#{title} : #{count}")
            end
          end
        end
      end

      column do
        panel "Total Store: #{Store.count}" do
          ul do
            Store.limit(100).map do |store|
              li ("#{store.name} : #{store.product.count}")
            end
          end
        end
      end

      # column do
      #   panel "Info" do
      #     para "Welcome to ActiveAdmin."
      #   end
      # end
    end
  end # content
end
