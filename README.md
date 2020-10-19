# Data_analysis_4
This file takes the samsung watch dataset and process it as described

1. Take the features names from file
2. Rename the features to R-compatible names
3. Read the test file
4. Give the test column names (from features vector)
5. Append activity labels column
6. Change labels from code numbers to names
7. Append subject vector
8. Read train file
9. Give the train column names (from features vector)
10. Append activity labels column
11. Change labels from code numbers to names
12. Append subject vector
13. Merge train and test datasets
14. Get indeces of features with only mean or std
15. Select columns with previous indeces and store it to new dataset
16. Make a third new dataset with mean for each activity and subject
