require './Gene.rb'
require "csv"

a = []


CSV.foreach("gene_information.tsv", col_sep: "\t") do |line| # I have taken this code line from https://linuxtut.com/how-to-handle-tsv-files-and-csv-files-in-ruby-b8798/ to transform each line of the file to an arra
  gene = Gene.new(:Gene_ID => line[0], :Gene_name => line[1], :mutant_phenotype => line[2])
  a.append(gene)
    
end
a.shift #I have taken this code line from https://programmingresources.fandom.com/wiki/Ruby-_Remove_Elements_From_An_Array to remove the first element of the array where the header of the file has been stored 

require './SeedStock.rb'
require "csv"

b = []

CSV.foreach("seed_stock_data.tsv", col_sep: "\t") do |line| 
  seed = SeedStock.new(:Seed_Stock => line[0], :Mutant_Gene_ID => line[1], :Last_Planted => line[2], :Storage => line[3], :Grams_Remaining => line[4].to_i)
  b.append(seed)
end 
b.shift

require './HybridCross.rb'
require "csv"


c = []

CSV.foreach("cross_data.tsv", col_sep: "\t") do |line|
  cross = HybridCross.new(:Parent1 => line[0], :Parent2 => line[1], :F2_Wild => line[2].to_i, :F2_P1 => line[3].to_i, :F2_P2 => line[4].to_i, :F2_P1P2 => line[5].to_i)
  c.append(cross)
end 
c.shift

def plant7_grams (x,y)
  x.each do |record|
    record.Grams_Remaining = record.Grams_Remaining - y
    if record.Grams_Remaining <= 0
      puts "CAREFUL! we have run out of #{record.Seed_Stock}"
      record.Grams_Remaining = 0
    end 
  end 
end

plant7_grams(b, 7)

require "csv"
CSV.open("new_stock_file.tsv", "w+", col_sep: "\t") do |seed|
  seed << ["Seed_Stock", "Mutant_Gene_ID", "Last_Planted", "Storage", "Grams_Remaining"]
b.each do |record|
  seed << [record.Seed_Stock, record.Mutant_Gene_ID, record.Last_Planted, record.Storage, record.Grams_Remaining]
  end 
end 

stock = File.open("new_stock_file.tsv", "r")
puts stock.read
stock.close

def chi_square (x)
  genetsv = CSV.read("gene_information.tsv", "r", col_sep: "\t") 
  i = 0
  j = 1
  x.each do |record|
    total = record.F2_Wild + record.F2_P1 + record.F2_P2 + record.F2_P1P2
    expected1 = total*(9.to_f/16)
    expected2 = total*(3.to_f/16)
    expected3 = total*(3.to_f/16)
    expected4 = total*(1.to_f/16)
    chi1 = (record.F2_Wild - expected1)**2/expected1
    chi2 = (record.F2_P1 - expected2)**2/expected2
    chi3 = (record.F2_P2 - expected3)**2/expected3
    chi4 = (record.F2_P1P2 - expected4)**2/expected4
    chi = chi1 + chi2 + chi3 + chi4
    #puts "Chi square = #{chi}"
    #to calculate the chi value and evaluate our hypothesis we need to know the degree of freedom for this case which is 3 (phenotypes - 1 = 3)
    #hence with a degree of freedom of 3 and an alpha of 0.05, the p value is 7.815
    chi_value = 7.815
    i += 1
    j += 1
      if i == 6
       j = 1
      end 
        if chi > chi_value
        puts "#{genetsv[i][1]} is genetically linked to #{genetsv[j][1]} with chi square score #{chi}"
        puts
        puts "Final Report"
        puts
        puts "#{genetsv[i][1]} is linked to #{genetsv[j][1]}"
        puts "#{genetsv[j][1]} is linked to #{genetsv[i][1]}"
        end
  end

end 

chi_square(c)