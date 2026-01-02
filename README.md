# Gino's Pizzeria Analytics Project

## Overview

This project models and analyzes pizza sales data using a modern analytics engineering approach with **dbt** and **Snowflake**.
The goal is to transform raw POS data into a clean, well-structured dimensional model that supports business questions related to **revenue, customer behavior, product performance, and time-based analysis**.

The project follows **analytics engineering best practices**, separating concerns into **staging, intermediate, and report layers**, with appropriate testing and documentation at each level.

---

## Data Architecture

The project is structured using a layered approach:


### Layers

#### 1. **Staging (`stg_`)**
- Light transformations
- Type casting
- Standardized column names
- Basic data quality tests (not null, accepted values, ranges)

#### 2. **Intermediate (`int_`)**
- Business logic
- Deduplication
- Enrichment (age, age groups, date attributes)
- Surrogate key generation
- Bridge tables for many-to-many relationships

#### 3. **Dimensions (`dim_`)**
- Clean, analytics-ready entities
- One row per business grain
- No heavy transformations
- Mostly documentation-only (tests already enforced upstream)

#### 4. **Facts (`fact_`)**
- Transactional metrics
- Proper foreign keys to dimensions
- Grain clearly defined


## Testing Strategy

Tests are applied based on the responsibility of each layer:

### Staging
- `not_null`
- `unique`
- `accepted_values`
- Date range validations
- Warnings used where data is known to be imperfect

### Intermediate
- Business logic validations
- Grain enforcement
- Referential integrity checks where relevant

### Dimensions
- Mostly documentation-only
- Trust upstream constraints

### Facts
- Grain validation
- Revenue sanity checks using **singular tests**
- Referential integrity with dimensions

---

## Key Business Questions Answered

This model supports answering questions such as:

- **Which pizza brings in the most revenue?**
- **What is the average ticket size?**
- **How long does it usually take for repeat customers to come back?**
- **Which pizza categories are most popular with young people?**
- **What is the most popular ingredient?**
- **When is our busiest time of day?**
- **How often do people place orders on their birthday?**
- 📈 **How does revenue evolve over time for top products?**


## Tools Used

- **Snowflake** – Cloud data warehouse, dashboard
- **dbt** – Transformation, testing, and documentation
- **SQL** – Business logic and analytics

---

## Final Notes

This project is designed to be:
- Easy to extend
- Safe to refactor
- Clear for both technical and non-technical stakeholders

It reflects real-world analytics engineering patterns and trade-offs rather than toy examples.

---
