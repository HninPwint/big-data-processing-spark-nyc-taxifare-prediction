## Big Data Engineering - Data processing on a big dataset with Spark

### Project Background
* Individual University Academic Project 
* Subject - Big Data Engineering 
* Course -  Master of Data Science and Innovaion (MDSI) , University of Technology Sydney, Autumn 2021.
* Time Taken - 3 weeks (9 April 2021 - 25 April 2021)
* Author / Owner - Hnin Pwint Tin
* Assignment Title - Data processing on a big dataset with Spark


### Project Oveview
 * Project Objective -  Analyse a large dataset using Spark. Load the available data, perform data transformation and analysis on it and 
 finally train a Machine Learning algorithm for predicting a continuous outcome. 
 * Answer business questions with evidence built from the dataset to support the claims.
 * Data Source - [NYC Taxi & Limousine Comission (TLC)](https://www1.nyc.gov/site/tlc/about/tlc-trip-record-data.page)
 * Business Use Case - TLC is the agency responsible for licensing and regulating New York City’s taxi cabs since 1971.
              TLC has publicly published millions of trip records from both yellow and green taxi cabs.
              Each record includes fields capturing pick-up and drop-off dates/times, locations, trip distances,
              itemized fares, rate types, payment types, and driver-reported passenger counts.<br>
              This Big Data Analytic is to help TLC in establising the regulations and find some insights useful to the companies.
 * Machine Leanrning Model - Predict the total taxi fare
 * Recommendation and Insights to Regulators include <br>
 In each month and year, <br>
    - which day of the months has most number of taxi trips <br>
    - Which hour of the day had the most trips<br>
    - the average amount paid per trip <br>
    - total number of trips<br>
    - average amount paid per passenger<br>
    - Max/Min/Avg/Median trip distance and duration
    
 
 
 
 ### Project Structure Overview
 ```bash
├── data                  # /data folder is kept in Local, not commited to Git
│   ├── raw               # Original Raw Data downloaded locally from the Source is saved
│   ├── processed         # Integrated, Cleansed, Transformed, Pipelined data is saved in Parquet format        
├── notebooks
│   ├── data_processing.ipnyb 
│   ├── modelling.ipnyb 
├── docker-compose.yml
├── Dockerfile

```
### Running Experiment Guide in Local
1) In the project directory in CLI, build the docker image and run
 ```docker-compose up -d```
2) ```docker logs --tail 50 jupyter_docker_nyc_tlc```
3) To load the Jupyter Lab, <br/> Copy and paste the url from the console  for example: http://127.0.0.1:8888/?token=979a5xxxxx in the browser 

### Extra Notes
* Data Processing performed in local system
* Processed Data is Transferred to Google Drive
* Due to hardware limitation in the local system, the Model Training is done in Google Cloud environment
* The Model training performed in Google Colab can be found [here](https://colab.research.google.com/drive/1yUF_U2ko3OcHR-u04eE851Ilhc7vecYv#scrollTo=kU67gaHVHOMj)
