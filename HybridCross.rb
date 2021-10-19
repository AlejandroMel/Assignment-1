class HybridCross
  attr_accessor :Parent1
  attr_accessor :Parent2
  attr_accessor :F2_Wild
  attr_accessor :F2_P1
  attr_accessor :F2_P2
  attr_accessor :F2_P1P2
  
  
  def initialize (params = {})
  @Parent1 = params.fetch(:Parent1, 'No parent')
  @Parent2 = params.fetch(:Parent2, 'No parent')
  @F2_Wild = params.fetch(:F2_Wild, 'No F2')
  @F2_P1 = params.fetch(:F2_P1, 'No F2')
  @F2_P2 = params.fetch(:F2_P2, 'No F2')
  @F2_P1P2 = params.fetch(:F2_P1P2, 'No F2')
  
  
  end
  
    #code
end