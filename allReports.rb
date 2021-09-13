require 'csv'

class AllReports

    attr_reader :vms_csv, :prices_csv, :volumes_csv

    def initialize(vms_csv, prices_csv, volumes_csv)

       @@vms_table = CSV.parse(File.read(vms_csv), headers: %i[id cpu ram hdd_type hdd_capacity])
       @@vms_prices =  CSV.parse(File.read(prices_csv), headers: %i[type price])
       @@volumes_table = CSV.parse(File.read(volumes_csv), headers: %i[id hdd_type hdd_capacity])

    end


    def prices_vm

        vms_sums = {}

        @@vms_table.each do |id, cpu, ram, hdd_type, hdd_capacity|

            vm_sum = cpu[1].to_i * @@vms_prices[:price][0].to_i + ram[1].to_i * @@vms_prices[:price][1].to_i
        
                if hdd_type[1] == @@vms_prices[:type][2]
                    vm_sum +=  @@vms_prices[:price][2].to_i
                elsif hdd_type[1] == @@vms_prices[:type][3]
                    vm_sum += @@vms_prices[:price][3].to_i 
                elsif hdd_type[1] == @@vms_prices[:type][4] 
                    vm_sum += @@vms_prices[:price][4].to_i
                end
        
             vms_sums[id[1]] = vm_sum
        
        end

        @@volumes_table.each do |id, hdd_type, hdd_capacity|
            dop = 0
         
                if hdd_type[1] == @@vms_prices[:type][2]
                    dop += @@vms_prices[:price][2].to_i 
                elsif hdd_type[1] == @@vms_prices[:type][3]
                    dop += @@vms_prices[:price][3].to_i
                elsif hdd_type[1] == @@vms_prices[:type][4]
                    dop += @@vms_prices[:price][4].to_i
                end
         
            vms_sums[id[1]] += dop
            
        end

        @@prices_vm = vms_sums.to_a.sort_by(&:last)

    end

   
    def highest_price

        prices_vm()

        puts " Самая дорогая ВМ #{@@prices_vm[-1]}"

    end


    def lowest_price

        prices_vm()
      
        puts " Самая дешевая ВМ #{@@prices_vm[0]}"

    end


    def largest_VM_by_type

        vms_all_types = {}
        vms_types = {}
        vms_types_length ={}

        @@vms_table.each do |id, cpu, ram, hdd_type, hdd_capacity|
  
            vms_all_types[id[1]] = cpu[1].to_i + ram[1].to_i
             
        end

        @@volumes_table.each do |id, hdd_type, hdd_capacity|

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


    def largest_VM_by_type_cpu

        vms_cpu = {}
       
        @@vms_table.each do |id, cpu, ram, hdd_type, hdd_capacity|
  
            vms_cpu[id[1]] = cpu[1].to_i 
             
        end

        vms_cpu_sort = vms_cpu.to_a.sort_by(&:last)

        puts " Самая объемная ВМ по параметру cpu id: #{vms_cpu_sort[-1][0].to_s + ", количество подключенных типов: " + vms_cpu_sort[-1][1].to_s}"

    end


    def largest_VM_by_type_ram

        vms_ram = {}
       
        @@vms_table.each do |id, cpu, ram, hdd_type, hdd_capacity|
  
            vms_ram[id[1]] = ram[1].to_i 
             
        end

        vms_ram_sort = vms_ram.to_a.sort_by(&:last)

        puts " Самая объемная ВМ по параметру ram id: #{vms_ram_sort[-1][0].to_s + ", количество подключенных типов: " + vms_ram_sort[-1][1].to_s}"

    end


    def largest_VM_by_type_ssd

        vms_types_ssd = {}
        vms_types_ssd_length = {}
       

           @@vms_table.each do |id, cpu, ram, hdd_type, hdd_capacity|

            vms_types_ssd[id[1]] = vms_types_ssd[id[1]] || []

            if hdd_type[1] == "ssd"
                vms_types_ssd[id[1]] << hdd_type[1]
            end
          
            
        end

        @@volumes_table.each do |id, hdd_type, hdd_capacity|
            
            vms_types_ssd[id[1]] = vms_types_ssd[id[1]] || []

            if hdd_type[1] == "ssd"
                vms_types_ssd[id[1]] << hdd_type[1]
            end
          
           
        end

        vms_types_ssd.each do |id, types|
  
            vms_types_ssd_length[id] = vms_types_ssd[id].length
        
        end

        vms_types_ssd_length_sort = vms_types_ssd_length.to_a.sort_by(&:last)

        puts " Самая объемная ВМ по параметру ssd id: #{vms_types_ssd_length_sort[-1][0].to_s + ", количество подключенных типов: " + vms_types_ssd_length_sort[-1][1].to_s}"

    end


    def largest_VM_by_type_sas

        vms_types_sas = {}
        vms_types_sas_length = {}
       

           @@vms_table.each do |id, cpu, ram, hdd_type, hdd_capacity|

            vms_types_sas[id[1]] = vms_types_sas[id[1]] || []

            if hdd_type[1] == "sas"
                vms_types_sas[id[1]] << hdd_type[1]
            end
          
            
        end

        @@volumes_table.each do |id, hdd_type, hdd_capacity|
            
            vms_types_sas[id[1]] = vms_types_sas[id[1]] || []

            if hdd_type[1] == "sas"
                vms_types_sas[id[1]] << hdd_type[1]
            end
          
           
        end

        vms_types_sas.each do |id, types|
  
            vms_types_sas_length[id] = vms_types_sas[id].length
        
        end

        vms_types_sas_length_sort = vms_types_sas_length.to_a.sort_by(&:last)

        puts " Самая объемная ВМ по параметру sas id: #{vms_types_sas_length_sort[-1][0].to_s + ", количество подключенных типов: " + vms_types_sas_length_sort[-1][1].to_s}"

    end


    def largest_VM_by_type_sata

        vms_types_sata = {}
        vms_types_sata_length = {}
       

           @@vms_table.each do |id, cpu, ram, hdd_type, hdd_capacity|

            vms_types_sata[id[1]] = vms_types_sata[id[1]] || []

            if hdd_type[1] == "sata"
                vms_types_sata[id[1]] << hdd_type[1]
            end
          
            
        end

        @@volumes_table.each do |id, hdd_type, hdd_capacity|
            
            vms_types_sata[id[1]] = vms_types_sata[id[1]] || []

            if hdd_type[1] == "sata"
                vms_types_sata[id[1]] << hdd_type[1]
            end
          
           
        end

        vms_types_sata.each do |id, types|
  
            vms_types_sata_length[id] = vms_types_sata[id].length
        
        end

        vms_types_sata_length_sort = vms_types_sata_length.to_a.sort_by(&:last)

        puts " Самая объемная ВМ по параметру sata id: #{vms_types_sata_length_sort[-1][0].to_s + ", количество подключенных типов: " + vms_types_sata_length_sort[-1][1].to_s}"

    end


    def VM_with_maximum_number_of_dop_disks

        vms_types = {}
        vms_types_length ={}

        @@volumes_table.each do |id, hdd_type, hdd_capacity|

            vms_types[id[1]] = vms_types[id[1]] || []
          
            vms_types[id[1]] ? vms_types[id[1]] << hdd_type[1] : vms_types[id[1]] = 0
            
        end
       
        vms_types.each do |id, types|
  
            vms_types_length[id] = vms_types[id].length
        
        end

        vms_types_length_sort = vms_types_length.to_a.sort_by(&:last)
        puts " ВМ у которой подключено больше всего дополнительных дисков (по количеству штук) id: #{vms_types_length_sort[-1][0].to_s  + ", количество подключенных дополнительных дисков: " + vms_types_length_sort[-1][1].to_s}"

    end


    def VM_with_maximum_number_of_dop_disks_ssd

        vms_ssd ={}
        vms_ssd_length = {}

        @@volumes_table.each do |id, hdd_type, hdd_capacity|
            
            vms_ssd[id[1]] = vms_ssd[id[1]] || []

            if hdd_type[1] == "ssd"
                vms_ssd[id[1]] << hdd_type[1]
            end
          
           
        end

        vms_ssd.each do |id, types|
  
            vms_ssd_length[id] = vms_ssd[id].length
        
        end

        vms_ssd_length_sort = vms_ssd_length.to_a.sort_by(&:last)
        puts " ВМ у которой подключено больше всего дополнительных дисков по типу ssd (по количеству штук) id: #{vms_ssd_length_sort[-1][0].to_s  + ", количество подключенных дополнительных дисков ssd: " + vms_ssd_length_sort[-1][1].to_s}"

    end


    def VM_with_maximum_number_of_dop_disks_sas

        vms_sas ={}
        vms_sas_length = {}

        @@volumes_table.each do |id, hdd_type, hdd_capacity|
            
            vms_sas[id[1]] = vms_sas[id[1]] || []

            if hdd_type[1] == "sas"
                vms_sas[id[1]] << hdd_type[1]
            end
          
           
        end

        vms_sas.each do |id, types|
  
            vms_sas_length[id] = vms_sas[id].length
        
        end

        vms_sas_length_sort = vms_sas_length.to_a.sort_by(&:last)
        puts " ВМ у которой подключено больше всего дополнительных дисков по типу sas (по количеству штук) id: #{vms_sas_length_sort[-1][0].to_s  + ", количество подключенных дополнительных дисков sas: " + vms_sas_length_sort[-1][1].to_s}"

    end


    def VM_with_maximum_number_of_dop_disks_sata

        vms_sata ={}
        vms_sata_length = {}

        @@volumes_table.each do |id, hdd_type, hdd_capacity|
            
            vms_sata[id[1]] = vms_sata[id[1]] || []

            if hdd_type[1] == "sata"
                vms_sata[id[1]] << hdd_type[1]
            end
          
           
        end

        vms_sata.each do |id, types|
  
            vms_sata_length[id] = vms_sata[id].length
        
        end

        vms_sata_length_sort = vms_sata_length.to_a.sort_by(&:last)
        puts " ВМ у которой подключено больше всего дополнительных дисков по типу sata (по количеству штук) id: #{vms_sata_length_sort[-1][0].to_s  + ", количество подключенных дополнительных дисков sata: " + vms_sata_length_sort[-1][1].to_s}"

    end

    
    def VM_with_maximum_vol_of_dop_disks

        vms_types_vol = {}

        @@volumes_table.each do |id, hdd_type, hdd_capacity|

            vms_types_vol[id[1]] = vms_types_vol[id[1]] || 0
          
            vms_types_vol[id[1]] ? vms_types_vol[id[1]] += hdd_capacity[1].to_i : vms_types_vol[id[1]] = 0
            
        end



        vms_types_vol_sort = vms_types_vol.to_a.sort_by(&:last)
        puts " ВМ у которой подключено больше всего дополнительных дисков (по объему) id: #{vms_types_vol_sort[-1][0].to_s  + ", объем памяти: " + vms_types_vol_sort[-1][1].to_s}"

    end


    def VM_with_maximum_vol_of_dop_disks_ssd

        vms_ssd_vol = {}

        @@volumes_table.each do |id, hdd_type, hdd_capacity|
            
            vms_ssd_vol[id[1]] = vms_ssd_vol[id[1]] || 0

            if hdd_type[1] == "ssd"
                vms_ssd_vol[id[1]] += hdd_capacity[1].to_i
            end
          
           
        end

        
        vms_ssd_vol_sort = vms_ssd_vol.to_a.sort_by(&:last)
        puts " ВМ у которой подключено больше всего дополнительных дисков ssd (по объему) id: #{vms_ssd_vol_sort[-1][0].to_s  + ", объем памяти: " + vms_ssd_vol_sort[-1][1].to_s}"

    end


    def VM_with_maximum_vol_of_dop_disks_sas

        vms_sas_vol = {}

        @@volumes_table.each do |id, hdd_type, hdd_capacity|
            
            vms_sas_vol[id[1]] = vms_sas_vol[id[1]] || 0

            if hdd_type[1] == "sas"
                vms_sas_vol[id[1]] += hdd_capacity[1].to_i
            end
          
           
        end

        
        vms_sas_vol_sort = vms_sas_vol.to_a.sort_by(&:last)
        puts " ВМ у которой подключено больше всего дополнительных дисков sas (по объему) id: #{vms_sas_vol_sort[-1][0].to_s  + ", объем памяти: " + vms_sas_vol_sort[-1][1].to_s}"

    end

    
    def VM_with_maximum_vol_of_dop_disks_sata

        vms_sata_vol = {}

        @@volumes_table.each do |id, hdd_type, hdd_capacity|
            
            vms_sata_vol[id[1]] = vms_sata_vol[id[1]] || 0

            if hdd_type[1] == "sata"
                vms_sata_vol[id[1]] += hdd_capacity[1].to_i
            end
          
           
        end

        
        vms_sata_vol_sort = vms_sata_vol.to_a.sort_by(&:last)
        puts " ВМ у которой подключено больше всего дополнительных дисков sata (по объему) id: #{vms_sata_vol_sort[-1][0].to_s  + ", объем памяти: " + vms_sata_vol_sort[-1][1].to_s}"

    end

    
end