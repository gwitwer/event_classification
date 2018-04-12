import csv
from functools import reduce

f = open('../combined_new_master_list.csv', 'r')
reader = csv.reader(f, delimiter=',')
CURR = []
for row in reader:
    CURR.append(row)
f.close()

pred_values = {
    "hiphop": [],
    "rock": [],
    "electronic": [],
    "other": []
}

for k in pred_values.keys():
    f = open("../predicted_attending_interested_" + k + ".csv", "r")
    reader = csv.reader(f, delimiter=',')
    for row in reader:
        pred_values[k].append(row)
    f.close()

limit = reduce(lambda x,y: max(x, len(pred_values[y])), pred_values.keys(), 0)

for i in range(limit):
    for k in pred_values.keys():
        if i < len(pred_values[k]):
            CURR.append([
                "",                     # name
                pred_values[k][i][2],   # day of week
                "",                     # unique
                k,                      # genre
                pred_values[k][i][0],   # attending
                pred_values[k][i][1]    # interested
            ])


f = open('combined_with_predictions_master_list.csv', 'w')
writer = csv.writer(f, dialect="excel", delimiter=",")
for row in CURR:
    writer.writerow(row)
f.close()
