previous = "~/Downloads/国家车辆列表-2020-02-28.xls"
after = "~/Downloads/国家车辆列表-2020-03-06.xls"

import xlrd
book = xlrd.open_workbook(previous)
sh = book.sheet_by_index(0)
previous_vin = list()
for rx in range(sh.nrows):
    value = sh.row(rx)[0].value
    if len(value) == 17:
        previous_vin.append(value)
print("pervious truck count: {}".format(len(previous_vin)))

book = xlrd.open_workbook(after)
sh = book.sheet_by_index(0)
after_vin = list()
for rx in range(sh.nrows):
    value = sh.row(rx)[0].value
    if len(value) == 17:
        after_vin.append(value)
print("after truck count: {}".format(len(after_vin)))

diff = [i for i in previous_vin if i not in after_vin]
print("diff trucks: {}".format(len(diff)))

import xlwt
wb = xlwt.Workbook()
ws = wb.add_sheet('Sheet 1')
for i in range(len(diff)):
    ws.write(i, 0, diff[i])

wb.save('missing_trucks.xls')