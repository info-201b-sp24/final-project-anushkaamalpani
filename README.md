# Global Unemployment Trends 
## INFO 201 "Foundational Skills for Data Science"

Authors: ALexia Jacobs, Anushka Malpani, Leisha Bajaj


For the Final Project -- Data Wrangling, add the following to this code repository:

* An R script file containing the code you used to create your unified dataset 
* Your unified and cleaned CSV dataset file
* Data Nutrition Label (pdf) 


**Link: https://anushkaamalpani.shinyapps.io/final-project-anushkaamalpani/**

Please create the necessary files for your multi-page Shiny app in this GitHub repository. Consult the Canvas assignment for more details. Be sure to publish your app on Shinyapps.io.

When you are finished, please add the text from your introductory and concluding pages below. You might want to use this GitHub repository as part of your digital portfolio, so you want this README.md to offer a brief description of the project and key takeaways.

Feel free to delete these instructions for your final README.md file and to make your GitHub repository public if you would like others to be able to see it. 

# Introduction

Unemployment is a situation wherein a person, who is actively looking for a job, is unable to find work. Unemployment rate is defined as the number of people without work, represented as a percentage of the labor force. It serves as an indicator of the health of the economy. Analyzing unemployment rates throughout the years in different countries is crucial for understanding the economic fluctuations during different periods over the years as well as how the unemployment rates fluctuate between sex and between different ages.    
![img](https://laboriq.co/hs-fs/hubfs/Shutterstock_336372527.png?width=600&height=397&name=Shutterstock_336372527.png)

Some questions that we are aiming to answer through this analysis are,  

- To what extent was the employment rate between sexes affected by Covid-19 in multiple countries?  
- Is there a relationship between tropic zones and unemployment rates? 
How does the unemployment rate of different age groups differ between 2014 to 2024 in the United States?   
- By examining these factors, we aim to identify disparities and trends in workforce participation across various regions and periods. This understanding is essential for creating more equitable employment opportunities and addressing broader social issues.
  
  
##Dataset Information  

This data is sourced from Kaggle – Global Unemployment dataset and was tabulated from the data collected by the ILO. It is updated and posted on Kaggle by Sazidul Islam to measure changes in employment across 189 countries/regions over 11 years.     

**Observations (rows)**: 1,135
   
   
**Features (columns)**: 16

##Limitations/Problems  

There are a few limitations that we should consider when working with this data set. For example, it does not provide a holistic view of unemployment rates, as all data is numeric with no description given of how exactly this data was collected or what factors were taken into consideration during data collection.In addition, the data collected is the mean calculated over the course of a year rather than collecting exact data per month. This can cause problems with exact data values and reliability. Fluctuations within unemployment rates over a shorter period of time are not visible in this data set. Relying entirely on yearly averages can hide important trends and variations that occur throughout the year. For example, jobs with seasonal fluctuations, weather cycles, and economic cycles can affect employment rates on a monthly basis. With this data these fluctuations are not shown and are ignored. This makes the data provided less specific. The process of copying data from the ILO LFS database and then sourcing it to present on Kaggle can lead to loss of detail or granularity in the dataset. For example, there may have been reformatting of the data by the author of the dataset which may have unintentionally led to loss of important data.


# Conclusion / Summary Takeaways

After analyzing this data set, we have 3 major takeaways. From our first chart, we were able to see that the unemployment rate for both male and females went through similar fluctuations overtime even though the male unemployment rate was always higher than the female. The biggest spike in the unemployment rate across each country analyzed, (Canada, United States, Brazil and India) is over the years of 2019-2021 during the COVID-19 pandemic. These findings have important implications for our economy. The significant rise in unemployment during the COVID-19 pandemic highlights the labor market to global disruptions. This chunk of high unemployment may have long-term effects on economic stability and growth. Additionally, being able to understand the impacts on male and female employment can guide more equitable economic recovery strategies in the future. 
  
  
From our second chart, we chose to analyze the unemployment rates across all countries and divide up the countries by tropic zones. We chose to display this information on a map as that would better visualise how the unemployment rate differs by tropic. The two horizontal lines depict the tropic of Cancer and Capricorn. A darker colour indicates a lower unemployment rate while a lighter colour indicates a higher unemployment rate, and a green or grey colour indicates that there’s no data.
In our analysis we can see that the highest unemployment rates are located in South Africa, North Africa, and Eastern Europe. More specifically, some of the highest unemployment rates are located close to where the tropic lines are, at 23.43612° North and South but only in the continents of Africa and Europe. These findings suggest that while geographic and climatic factors might influence unemployment rates, it is not a strong relationship as otherwise the trend would be visible in the Americas and Asia. Regardless, regions near the tropic lines may face challenges that contribute to higher unemployment, such as economic instability, or limited access to resources. Understanding these disparities is crucial for developing targeted economic policies. 
  
  
Lastly for our third chart we compared the average unemployment rate among the age categories of Children (less than 15 years), Youth (15 years to 24 years), and Adults (25+ years). Through our analysis, It is evident that the youth face the highest unemployment, followed by 'Children' and 'Adults,' it suggests that young people entering the job market out of college or even high school face the most challenges, whereas older adults have relatively stable employment. The impact of COVID-19 is also evident through this analysis where we see the unemployment rates across all age categories are highest in 2020. This can help policymakers identify and design economic strategies favoring their employment. Over here in the US, they can introduce policies that focus on job training programs or educational initiatives for young people. This graph also gives us insight that children under the age of 15 facing unemployment may not be in school studying. This could indicate issues such as child labor or lack of access to education, which brings out the issue of children not receiving proper education and being part of the labor force.
