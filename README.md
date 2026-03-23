# 🎬 Movie Analytics Pipeline on GCP

This project implements an **end-to-end data analytics pipeline** using a movie dataset. The solution was built on **Google Cloud Platform (GCP)** and follows a modern data architecture to transform raw data into meaningful insights for business intelligence.

## Technologies Used

- **Google Cloud Storage (GCS)** – data lake for raw CSV files  
- **BigQuery** – data warehouse for processing and analytics  
- **Metabase** – BI tool for dashboards and data visualization  
- **Docker** – containerization of Metabase  
- **GCP Service Account** – secure access control  

## Architecture Overview

The pipeline follows a **Medallion Architecture (Bronze, Silver, Gold)**:

### 🥉 Bronze Layer (Raw Data)
- CSV files are uploaded to Google Cloud Storage  
- Data is accessed in BigQuery using External Tables  
- No transformations are applied at this stage  

### 🥈 Silver Layer (Cleaned & Modeled Data)
- Data is cleaned and transformed  
- A Star Schema is created to improve analytical performance  
- Fact and dimension tables are structured for efficient querying  

### 🥇 Gold Layer (Business Layer)
- Analytical views are created  
- These views are optimized for BI tools and reporting  
- Data is ready for consumption  

## Analytics & KPIs

Using the Gold layer views, several insights and KPIs were developed:

- Overall business KPIs  
- Evolution of movie ratings over time  
- Top 10 movies  
- Top 10 genres  
- Movie popularity segmentation  
- Other exploratory analyses  

## Security & Access Control

A Service Account was created to ensure secure and limited access.  
The following roles were assigned:

- BigQuery Data Viewer – allows reading data  
- BigQuery Job User – allows running queries  
- BigQuery Metadata Viewer – allows viewing dataset structure  
- Object Storage Viewer – allows access to files in GCS  

This ensures the principle of **least privilege** is respected.

## Metabase Deployment

- Metabase was deployed using Docker  
- It connects to BigQuery using the service account credentials  
- Enables interactive dashboards and data exploration  

## Workflow Summary

1. Upload CSV files to Google Cloud Storage  
2. Create External Tables in BigQuery (Bronze)  
3. Clean and transform data into Star Schema (Silver)  
4. Create analytical views (Gold)  
5. Connect Metabase to BigQuery  
6. Build dashboards and analyze KPIs  
