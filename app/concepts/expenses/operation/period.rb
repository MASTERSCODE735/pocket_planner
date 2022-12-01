require 'date'
module Expenses::Operation
  class Period < Base::Operation::BaseApiOperation
    step :check_equal_periods
    step :check_range_intersection
    step :fetch_data
    fail :error!

    def check_equal_periods(ctx, params:, **)
      unless DateTime.parse(params[:end_date1]) - DateTime.parse(params[:start_date1]) == DateTime.parse(params[:end_date2]) - DateTime.parse(params[:start_date2])
        ctx[:error_message] = "Both periods do not have same number of days"
        return false
      end
      true
    end

    def check_range_intersection(ctx, params:, **)
      range = DateTime.parse(params[:start_date1])..DateTime.parse(params[:end_date1])
      if (range === DateTime.parse(params[:start_date2])) || range === DateTime.parse(params[:end_date2])
        ctx[:error_message] = "Both periods may be intersecting"
        return false
      end
      true
    end

    def fetch_data(ctx, params:, **)
      ctx[:model] = { period1: {
        start_date: params[:start_date1],
        end_date: params[:end_date1],
        category_exepense_amounts:
        Transaction.joins(:transaction_type,:category)
          .where(transaction_types: {name: "expense"}, transactions: {:date => DateTime.parse(params[:start_date1])..DateTime.parse(params[:end_date1])})
          .group('categories.name').sum(:amount)
      },
       period2: {
        start_date: params[:start_date2],
        end_date: params[:end_date2],
        category_exepense_amounts:
        Transaction.joins(:transaction_type,:category)
          .where(transaction_types: {name: "expense"}, transactions: {:date => DateTime.parse(params[:start_date2])..DateTime.parse(params[:end_date2])})
          .group('categories.name').sum(:amount)
       }
      }
      ctx
    end

    def error!(ctx, params:,error_message:, **)
      ctx[:http_status_code] = 400
      add_errors ctx, error_message
    end

  end
end
