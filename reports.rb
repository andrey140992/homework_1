require "./allReports"

report = AllReports.new("./csv/vms.csv", "./csv/prices.csv", "./csv/volumes.csv")


puts "Выберете отчет:
1.Самая дорогая ВМ 
2.Самая дешевая ВМ
3.Самая объемная ВМ по параметру type
4.ВМ у которой подключено больше всего дополнительных дисков с учетом типа диска(по количеству штук)
5.ВМ у которой подключено больше всего дополнительных дисков с учетом типа диска (по объему)
6.ВМ у которой подключено больше всего дополнительных дисков без учета типа диска (по количеству штук)
7.ВМ у которой подключено больше всего дополнительных дисков без учета типа диска (по объему)"

choice = gets.chomp

if choice == "1"
    report.highest_price

elsif choice == "2"
    report.lowest_price  

elsif choice == "3"
    puts " 
    Выберете type :
    1)  cpu
    2)  ram
    3)  ssd
    4)  sas
    5)  sata"

    choice = gets.chomp

    if choice == "1"
        report.largest_VM_by_type_cpu
    elsif choice == "2"
        report.largest_VM_by_type_ram
    elsif choice == "3"
        report.largest_VM_by_type_ssd
    elsif choice == "4"
        report.largest_VM_by_type_sas
    elsif choice == "5"
        report.largest_VM_by_type_sata
    else 
        puts "Такого отчета нет!"
    end 


elsif choice == "4"
    puts " 
    Выберете тип жесткого диска:
    1)  ssd
    2)  sas
    3)  sata"

    choice = gets.chomp
    
    if choice == "1"
        report.VM_with_maximum_number_of_dop_disks_ssd
    elsif choice == "2"
        report.VM_with_maximum_number_of_dop_disks_sas
    elsif choice == "3"
        report.VM_with_maximum_number_of_dop_disks_sata
    else 
        puts "Такого отчета нет!"
    end 

elsif choice == "5"
    puts " 
    Выберете тип жесткого диска:
    1)  ssd
    2)  sas
    3)  sata"

    choice = gets.chomp

    if choice == "1"
        report.VM_with_maximum_vol_of_dop_disks_ssd
    elsif choice == "2"
        report.VM_with_maximum_vol_of_dop_disks_sas
    elsif choice == "3"
        report.VM_with_maximum_vol_of_dop_disks_sata
    else 
        puts "Такого отчета нет!"
    end 

elsif choice == "6"
    report.VM_with_maximum_number_of_dop_disks

elsif choice == "7"
    report.VM_with_maximum_vol_of_dop_disks
     
else
    puts"Такого отчета нет!"
end


