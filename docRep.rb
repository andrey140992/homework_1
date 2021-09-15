require "./allReports"


report = AllReports.new("./csv/vms.csv", "./csv/prices.csv", "./csv/volumes.csv", "10")


report.highest_price
report.lowest_price
report.largest_VM_by_type
report.VM_with_maximum_number_of_dop_disks
report.VM_with_maximum_vol_of_dop_disks