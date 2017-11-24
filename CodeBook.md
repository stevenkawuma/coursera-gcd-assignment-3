## Transformations
1. Merged test and training datasets
2. Renamed columns to more descriptive labels given in features.txt
3. Extracted mean and standard deviation measurements into a new dataset
4. Generated a tidy dataset from the dataset in 4. above whose variables are described and summarized below

## Variables
1.  subject
---
Matched from the subject_test.txt and subject_train.txt for the two datasets before merging

   * Storage mode: integer

2. activity
---
Derived by replacing activity names from the activity_labels.txt file with their corresponding IDs

   * Storage mode: integer
   * Factor with 6 levels

        Values and labels    N    Percent 
                                          
   1 'LAYING'             2580   16.7     
   2 'SITTING'            2580   16.7     
   3 'STANDING'           2580   16.7     
   4 'WALKING'            2580   16.7     
   5 'WALKING_DOWNSTAIRS' 2580   16.7     
   6 'WALKING_UPSTAIRS'   2580   16.7     

3.  measure
---
Extrated from column names of original datatase that match "mean" or "std" for standard deviations

   * Storage mode: character

       Length:      15480
        Class:  character
         Mode:  character

4.  mean
---
   *  Storage mode: double

