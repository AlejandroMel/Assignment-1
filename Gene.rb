class Gene
  attr_accessor :Gene_ID
  attr_accessor :Gene_name
  attr_accessor :mutant_phenotype
    
  def initialize (params = {})
    
    @Gene_ID = params.fetch(:Gene_ID, 'null')
    @Gene_name = params.fetch(:Gene_name, 'No gene')
    @mutant_phenotype = params.fetch(:mutant_phenotype, 'No mutation')
  
  end

end