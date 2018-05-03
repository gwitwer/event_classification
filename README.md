### Machine Learning Project
# Event Classification using MATLAB, Python

These files have been organized into 3 folders, with the root directory holding our data CSVs.
The final paper coming out of this project can be found in the PDF "EventClassificationReport"

### Data files
The original data can be found in ORIGINAL_DATA.csv
The final data can be found in either of the two CSVs beginning "wes_classified"

### MATLAB scripts
The MATLAB scripts folder contains all of our real classification and preprocessing work.

### Python scripts
Python scripts contains files primarily used for splitting the data sets and writing them to CSV files.
They are essentially "helper scripts".

### images
The images folder contains all of the images we generated for our presentation and report, as well as some extras we didn't use.

### Other notes
The genre categories (electronic, rock, hiphop, other), taken together, represent the entire data set.

The day of week categories (weekday, weekend), taken together, also represent the entire data set.

That is, there are two ways to combine files to get the entire data set.
The split weekday / weekend CSV files can be found in MATLAB scripts.
The CSVs split by genre can be found in the root directory (although they only have a select number of features)
