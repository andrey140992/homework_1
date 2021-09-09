require 'csv'

class ReportPrice
    attr_reader :vms_csv, :prices_csv, :volumes_csv

    def initialize(vms_csv, prices_csv, volumes_csv)
        @vms_csv = vms_csv
        @prices_csv = prices_csv
        @volumes_csv = volumes_csv
    end

    def highest_price

        vms_table = CSV.parse(File.read(@vms_csv), headers: %i[id cpu ram hdd_type hdd_capacity])
        vms_prices =  CSV.parse(File.read(@prices_csv), headers: %i[type price])
        volumes_table = CSV.parse(File.read(@volumes_csv), headers: %i[id hdd_type hdd_capacity])

        vms_sums = {}

        vms_table.each do |id, cpu, ram, hdd_type, hdd_capacity|

            vm_sum = cpu[1].to_i * vms_prices[:price][0].to_i + ram[1].to_i * vms_prices[:price][1].to_i
        
                if hdd_type[1] == vms_prices[:type][2]
                    vm_sum +=  vms_prices[:price][2].to_i
                elsif hdd_type[1] == vms_prices[:type][3]
                    vm_sum += vms_prices[:price][3].to_i 
                elsif hdd_type[1] == vms_prices[:type][4] 
                    vm_sum += vms_prices[:price][4].to_i
                end
        
             vms_sums[id[1]] = vm_sum
        
        end

        volumes_table.each do |id, hdd_type, hdd_capacity|
            dop = 0
         
                if hdd_type[1] == vms_prices[:type][2]
                    dop += vms_prices[:price][2].to_i 
                elsif hdd_type[1] == vms_prices[:type][3]
                    dop += vms_prices[:price][3].to_i
                elsif hdd_type[1] == vms_prices[:type][4]
                    dop += vms_prices[:price][4].to_i
                end
         
            vms_sums[id[1]] += dop
            
        end

        expensivest_vm = vms_sums.to_a.sort_by(&:last)

        puts " Самая дорогая ВМ #{expensivest_vm[-1]}"


    end

    def lowest_price

        vms_table = CSV.parse(File.read(@vms_csv), headers: %i[id cpu ram hdd_type hdd_capacity])
        vms_prices =  CSV.parse(File.read(@prices_csv), headers: %i[type price])
        volumes_table = CSV.parse(File.read(@volumes_csv), headers: %i[id hdd_type hdd_capacity])

        vms_sums = {}

        vms_table.each do |id, cpu, ram, hdd_type, hdd_capacity|

            vm_sum = cpu[1].to_i * vms_prices[:price][0].to_i + ram[1].to_i * vms_prices[:price][1].to_i
        
                if hdd_type[1] == vms_prices[:type][2]
                    vm_sum +=  vms_prices[:price][2].to_i
                elsif hdd_type[1] == vms_prices[:type][3]
                    vm_sum += vms_prices[:price][3].to_i 
                elsif hdd_type[1] == vms_prices[:type][4] 
                    vm_sum += vms_prices[:price][4].to_i
                end
        
             vms_sums[id[1]] = vm_sum
        
        end

        volumes_table.each do |id, hdd_type, hdd_capacity|
            dop = 0
         
                if hdd_type[1] == vms_prices[:type][2]
                    dop += vms_prices[:price][2].to_i 
                elsif hdd_type[1] == vms_prices[:type][3]
                    dop += vms_prices[:price][3].to_i
                elsif hdd_type[1] == vms_prices[:type][4]
                    dop += vms_prices[:price][4].to_i
                end
         
            vms_sums[id[1]] += dop
            
        end

        expensivest_vm = vms_sums.to_a.sort_by(&:last)

        puts " Самая дешевая ВМ #{expensivest_vm[0]}"
    end

    def largest_VM_by_type

        vms_table = CSV.parse(File.read(@vms_csv), headers: %i[id cpu ram hdd_type hdd_capacity])
        volumes_table = CSV.parse(File.read(@volumes_csv), headers: %i[id hdd_type hdd_capacity])

        vms_all_types = {}
        vms_types = {}
        vms_types_length ={}

        vms_table.each do |id, cpu, ram, hdd_type, hdd_capacity|
  
            vms_all_types[id[1]] = cpu[1].to_i + ram[1].to_i
             
        end

        volumes_table.each do |id, hdd_type, hdd_capacity|

            vms_types[id[1]] = vms_types[id[1]] || []
          
            vms_types[id[1]] ? vms_types[id[1]] << hdd_type[1] : vms_types[id[1]] = 0
            
        end

        vms_types.each do |id, types|
  
            vms_types_length[id] = vms_types[id].length
        
        end
        
        vms_types_length.each do |id, length|
        
            vms_all_types[id] += length
            
        end

        vms_all_types_sort = vms_all_types.to_a.sort_by(&:last)

        puts " Самая объемная ВМ по параметру type id: #{vms_all_types_sort[-1][0].to_s + ", количество подключенных типов: " + vms_all_types_sort[-1][1].to_s}"


    end

    def VM_with_maximum_number_of_dop_disks

        volumes_table = CSV.parse(File.read(@volumes_csv), headers: %i[id hdd_type hdd_capacity])

        
        vms_types = {}
        vms_types_length ={}

        volumes_table.each do |id, hdd_type, hdd_capacity|

            vms_types[id[1]] = vms_types[id[1]] || []
          
            vms_types[id[1]] ? vms_types[id[1]] << hdd_type[1] : vms_types[id[1]] = 0
            
        end

        vms_types.each do |id, types|
  
            vms_types_length[id] = vms_types[id].length
        
        end

        vms_types_length_sort = vms_types_length.to_a.sort_by(&:last)
        puts " ВМ у которой подключено больше всего дополнительных дисков (по количеству штук) id: #{vms_types_length_sort[-1][0].to_s  + ", количество подключенных дополнительных дисков: " + vms_types_length_sort[-1][1].to_s}"

    end

    def VM_with_maximum_vol_of_dop_disks

        volumes_table = CSV.parse(File.read(@volumes_csv), headers: %i[id hdd_type hdd_capacity])

        vms_types = {}
        vms_types_vol = {}

        volumes_table.each do |id, hdd_type, hdd_capacity|

            vms_types_vol[id[1]] = vms_types_vol[id[1]] || 0
          
            vms_types_vol[id[1]] ? vms_types_vol[id[1]] += hdd_capacity[1].to_i : vms_types_vol[id[1]] = 0
            
        end

        

        vms_types_vol_sort = vms_types_vol.to_a.sort_by(&:last)
        puts " ВМ у которой подключено больше всего дополнительных дисков (по объему) id: #{vms_types_vol_sort[-1][0].to_s  + ", объем памяти: " + vms_types_vol_sort[-1][1].to_s}"

    end

    
end
