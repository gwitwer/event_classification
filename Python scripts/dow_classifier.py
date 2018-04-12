import csv
from datetime import datetime

weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
]

f = open('viq_data.csv', 'r')
reader = csv.reader(f, delimiter=',')
lines = []
for row in reader:
    lines.append(row)
f.close()

for line in lines:
    date = line[1]
    date = date.split('/')
    is_weekend = ' '
    if len(date) > 1:
        if len(date[0]) < 2:
            date[0] = '0' + date[0]
        if len(date[1]) < 2:
            date[1] = '0' + date[1]
        date = '/'.join(date)
        date = date.split(', ')
        date[1] = date[1].split(':')
        if len(date[1][0]) < 2:
            date[1][0] = '0' + date[1][0]
        date[1] = ':'.join(date[1])
        date = ', '.join(date)
        
        
        wd = datetime.strptime(date, '%m/%d/%Y, %I:%M:%S %p').weekday()
        print(weekdays[wd]),
        is_weekend = (wd > 3 and wd < 6) * 1
        print(is_weekend)
        
    line.insert(2, is_weekend)

f = open('viq_data_o.csv', 'w')
writer = csv.writer(f, dialect="excel", delimiter=",")
for row in lines:
    writer.writerow(row)
f.close()
        
            
        
    