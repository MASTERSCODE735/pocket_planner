class TransactionType < ApplicationRecord

  VALUES = {
      expense: 1,
      income: 2,
      tranfer_in: 3,
      tranfer_out: 4
  }

  def self.id_for(key)
    VALUES[key]
  end
    
end
