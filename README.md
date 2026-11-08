## Architecture Overview

The pipeline leverages a modern, serverless data lakehouse design pattern (Medallion Architecture) on AWS to handle data ingestion, transformation, and business intelligence.

```text
[Mihomo API / HoYoLAB]
        │
        ▼ (Triggered via EventBridge Schedule)
  [AWS Lambda]  ───► (Fetches JSON Data with PyPi Package)
        │
        ▼
   [Amazon S3]  ───► (Raw JSON Landing Zone / "Bronze Layer")
        │
        ▼ (Orchestrated by Lambda or Glue Workflow)
  [AWS Glue ETL] ───► (Normalizes & Flattens JSON into Parquet)
        │
        ▼
   [Amazon S3]  ───► (Processed Columnar Data / "Silver Layer")
        │
        ▼
 [Amazon Athena] ───► [Amazon QuickSight / BI Dashboards]
