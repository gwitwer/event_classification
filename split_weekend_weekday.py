import csv

f = open('Venue_IQ_data_4-1.csv', 'r')
reader = csv.reader(f, delimiter=',')
lines = []
for row in reader:
    lines.append(row)
f.close()

dow_split = [[], []]

for line in lines:
    try:
        dow = int(line[2])
        attending = int(line[9])
        interested = int(line[10])
        try:
            dow_split[dow].append([attending, interested, dow])
        except KeyError:
            pass
    except ValueError:
        pass

for d in range(len(dow_split)):
    k = "weekend" if d else "weekday"

    f = open('attending_interested_' + k + '.csv', 'w')
    writer = csv.writer(f, dialect="excel", delimiter=",")
    for row in dow_split[d]:
        writer.writerow(row)
    f.close()
