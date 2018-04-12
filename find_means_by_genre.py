import csv
import numpy

f = open('Venue_IQ_data_4-1.csv', 'r')
reader = csv.reader(f, delimiter=',')
lines = []
for row in reader:
    lines.append(row)
f.close()

# index 8 = Genre
# index 9 = Attending
# index 10 = Interested

sums_by_genre = {
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
        attending = int(line[9])
        # interested = int(line[10])
        try:
            sums_by_genre[genre].append(attending)
            # sums_by_genre[genre].append(interested)
        except KeyError:
            pass
    except ValueError:
        pass

print sums_by_genre
for k in sums_by_genre.keys():
    numpy_arr = numpy.array(sums_by_genre[k])
    print(k, numpy.mean(sums_by_genre[k]), numpy.std(sums_by_genre[k]))
