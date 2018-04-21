import csv

f = open('../wes_classified.csv', 'r')
reader = csv.reader(f, delimiter=',')
D = []
for row in reader:
    D.append(row)
f.close()

genres = [
    "electronic",
    "hiphop",
    "rock",
    "other"
]

for i in range(len(D)):
    D[i][1] = int(D[i][1] == "Yes")
    D[i][2] = genres.index(D[i][2])

f = open('../wes_classified_fixed.csv', 'w')
writer = csv.writer(f, dialect="excel", delimiter=",")
for row in D:
    writer.writerow(row)
f.close()
