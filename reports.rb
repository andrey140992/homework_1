require "./allReports"

report = AllReports.new("./csv/vms.csv", "./csv/prices.csv", "./csv/volumes.csv")



puts "Выберете отчет:
1.Самая дорогая ВМ 
2.Самая дешевая ВМ
3.Самая объемная ВМ по параметру type
4.ВМ у которой подключено больше всего дополнительных дисков (по количеству штук)
5.ВМ у которой подключено больше всего дополнительных дисков (по объему)"

choice = gets.chomp

if choice == "1"
    report.highest_price 
elsif choice == "2"
    report.lowest_price  
elsif choice == "3"
    report.largest_VM_by_type 
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
     
else
    puts"Такого отчета нет!"
end

#report.highest_price
#report.lowest_price
#report.largest_VM_by_type
#report.VM_with_maximum_number_of_dop_disks
#report.VM_with_maximum_vol_of_dop_disks
