class SeedStock
  attr_accessor :Seed_Stock
  attr_accessor :Mutant_Gene_ID
  attr_accessor :Last_Planted
  attr_accessor :Storage
  attr_accessor :Grams_Remaining
  
  def initialize (params = {})
    @Seed_Stock = params.fetch(:Seed_Stock, 'No seed')
    @Mutant_Gene_ID = params.fetch(:Mutant_Gene_ID, 'No mutant')
    @Last_Planted = params.fetch(:Last_Planted, 'Not planted')
    @Storage = params.fetch(:Storage, 'Not stored')
    @Grams_Remaining = params.fetch(:Grams_Remaining, 'Empty')
  
  end
    
    #code
end