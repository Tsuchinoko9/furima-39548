FactoryBot.define do
  factory :purchase_record_shipping_address do
    token {"tok_abcdefghijk00000000000000000"}
    postal_code {'123-4567'}
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city {'A市'}
    addresses {'B区8-9'} 
    building {'Cビル10号室'}
    phone_number {'12345678901'} 
    # ターミナルにおいてFactoryBot.createで出力テストすると`save!'メソッドがないエラーが出る
    # ターミナルにおいてFactoryBot.buildで出力テストすると問題なく出力される
  end
  
end
