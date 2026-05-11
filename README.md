# Customer Revenue & Retention Analysis — Olist E-Commerce
 
Cohort analysis on the Olist Brazilian e-commerce dataset. The dataset covers 96,469 delivered orders from 93,349 unique customers between 2016 and 2018. The focus is on customer retention, when repeat buyers come back, and how revenue splits between first-time and returning customers.
 
**The short version:** 97% of customers never placed a second order. Growth here depends almost entirely on acquiring new customers, not keeping existing ones.
 
---
 
## The Question
 
How many customers come back after their first purchase? When do they return? And what share of total revenue actually comes from repeat buyers?
 
---
 
## Findings
 
**Retention rates are low no matter how you measure them**
 
1.25% of customers placed a second order within 30 days of their first. Extend that to 60 days and it climbs to 1.57%, and to 90 days it reaches 1.79%. Put another way: roughly 98 out of every 100 customers who bought something never came back within three months.
 
**The customers who do return tend to do so fast**
 
Of everyone who placed a second order, 1,170 did it within the first 30 days. After that the numbers fall off sharply — 300 returned in the 31–60 day window, 197 in the 61–90 day window. There's a rebound at 91–180 days and 180+ days, which could mean some buyers have longer natural purchase cycles or came back for a specific reason.
 
**First-time buyers account for nearly all revenue**
 
New customers brought in R$15.1M. Returning customers brought in R$0.3M. That's a 97.8% / 2.2% split — retention is not a meaningful revenue channel for this business at this point in time.
 
**Spend per order is almost identical across both groups**
 
New customers averaged R$161.58 per order; returning customers averaged R$167.43. The gap is negligible. The problem is frequency, not order size.
 
---
 
## Approach
 
The data comes from the [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) on Kaggle — 9 CSV files covering orders, customers, payments, products, sellers, and geolocation from 2016 to 2018.
 
The analysis filters to delivered orders only, then joins payment data to get order-level revenue. Each order gets classified as new or returning by checking whether it matches the customer's earliest order date. Retention rates come from looking at each customer's first purchase and checking for any follow-up order within 30, 60, or 90 days. The timing buckets break down when returning customers actually came back.
 
**Tools:** Python (Pandas, DuckDB, Matplotlib). Power BI dashboard in progress — star schema and DAX measures for retention rates, revenue by segment, cohort churn, and monthly trends.
 
---
 
## Results
 
**Retention Rates**
 
| Window | Customers Who Returned | Retention Rate |
|---|---|---|
| 30 days | 1,170 | 1.25% |
| 60 days | 1,470 | 1.57% |
| 90 days | 1,667 | 1.79% |
| Never returned | 90,784 | 97.2% |
 
Total unique customers: **93,349**
 
**Revenue by Customer Segment**
 
| Segment | Customers | Orders | Total Revenue | Avg Order | Revenue / Customer |
|---|---|---|---|---|---|
| New Customer | 93,349 | 94,209 | R$15,083,719 | R$160.11 | R$161.58 |
| Returning Customer | 2,015 | 2,260 | R$337,364 | R$149.28 | R$167.43 |
 
**Return Timing (among customers who came back)**
 
| Window | Count |
|---|---|
| 0–30 days | 1,170 |
| 31–60 days | 300 |
| 61–90 days | 197 |
| 91–180 days | 415 |
| 180+ days | 483 |
 
---
 
## Charts
 
![retention_analysis](retention_analysis.png)
 
Power BI dashboard coming soon.
 
---
 
## Repo Structure
 
```
olist-retention-analysis/
│
├── olist_retention_analysis.py    # full analysis script, paste into Colab and run
├── retention_analysis.png         # four-panel chart output
├── README.md
│
└── outputs/
    ├── fact_orders.csv            # 96,469 row fact table
    ├── dim_customer.csv           # one row per unique customer with lifetime stats
    ├── dim_monthly_revenue.csv    # monthly revenue aggregated
    ├── dim_state_revenue.csv      # revenue by Brazilian state
    ├── cohort_analysis.csv        # order-level cohort classification
    ├── churn_buckets.csv          # return timing distribution
    ├── retention_rates.csv        # 30/60/90 day retention numbers
    └── segment_revenue.csv        # new vs returning revenue summary
```
 
---
 
## How to Run
 
Download the dataset from Kaggle (search "Brazilian E-Commerce Public Dataset by Olist"), open Google Colab, and upload all 9 CSV files. Paste the script and run — the last cell downloads all output files automatically.
 
```python
!pip install duckdb  # only needed in Colab
```
 
---
 
## Future Directions
 
- **Category-level retention** — some product categories probably have much higher return rates than others. Consumables vs one-time purchases like furniture would likely look completely different.
- **Geographic patterns** — do customers in certain Brazilian states come back more often? Delivery speed, income distribution, and local competition could all play a role.
- **Modeling repeat buyers** — order characteristics like category, price, delivery time, and review score might predict whether a customer returns. Worth testing a simple classifier.
- **Delivery time and repeat purchase rate** — the dataset has both estimated and actual delivery dates. A direct test of whether faster delivery correlates with higher return rates is possible with this data.
- **Cohort revenue over time** — tracking how much each monthly acquisition cohort generates in its first 6 and 12 months would give a clearer picture of which cohorts retained best.
