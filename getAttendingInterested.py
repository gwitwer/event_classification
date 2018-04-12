import csv

f = open('Venue_IQ_data_4-1.csv', 'r')
reader = csv.reader(f, delimiter=',')
lines = []
for row in reader:
    lines.append(row)
f.close()

ai_by_genre = {
    "hiphop": [],
    "rock": [],
    "other": [],
    "electronic": []
}

for line in lines:
    genre = line[8]
    if genre == 'latin':
        genre = 'hiphop'
    try:
        dow = int(line[2])
        attending = int(line[9])
        interested = int(line[10])
        try:
            ai_by_genre[genre].append([attending, interested, dow])
        except KeyError:
            pass
    except ValueError:
        pass

for g in ai_by_genre.keys():
    # int_att = map(lambda l : l[9:11], ai_by_genre[g])
    f = open('attending_interested_' + g + '.csv', 'w')
    writer = csv.writer(f, dialect="excel", delimiter=",")
    for row in ai_by_genre[g]:
        writer.writerow(row)
    f.close()
