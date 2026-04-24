# The Effects of Labour Force Participation on Real GDP per Capita (Canada)

## Overview
This project analyzes the relationship between labour force participation and real GDP per capita in Canada using quarterly time series data from 1995 to 2024.

Using applied econometrics techniques, the analysis finds that increases in labour force participation are strongly associated with higher economic growth.

**Key Result:**  
A 1 percentage point increase in labour force participation is associated with an increase of approximately **$1,806.88 in quarterly real GDP per capita growth**.

---

## What This Demonstrates
- Time series econometrics (real-world macroeconomic data)
- Data cleaning and merging from multiple sources
- Stationarity testing (ADF tests)
- Model selection with mixed I(0)/I(1) variables
- Regression analysis with Newey-West HAC standard errors
- Clear interpretation of empirical results

---

## Methodology
- Quarterly data (1995–2024, 120 observations)
- Augmented Dickey-Fuller tests for stationarity
- Model specification based on integration properties
- Final regression model:

```
Δrgdppc = β0 + β1Δlfpr + β2inv + β3Δprd + ut
```

- HAC (Newey-West) standard errors used for robustness

---

## Repository Structure
```
.
├── Impact_of_LFPR_on_RGGDPPC_Canada.pdf   # Final research paper
├── ECO475_term_paper.do                   # Stata code
└── README.md                              # Project description
```

---

## How to Run
1. Open Stata  
2. Run:
```
do ECO475_term_paper.do (Change the wroking directory)
```
3. Results will appear in the log file

---

## Data Sources
- Statistics Canada  
- Federal Reserve Economic Data (FRED)  
- OECD  

---

## Key Variables
- `rgdppc`: Real GDP per capita (2017 chained dollars)  
- `lfpr`: Labour force participation rate  
- `inv`: Investment in inventories  
- `prd`: Labour productivity index (2017 = 100)  

---

## Limitations
- Results are correlational, not causal  
- Potential endogeneity between GDP and labour participation  

---

## Authors
Nipun Jaiswal  
Ana Elisa Lopez-Miranda  https://github.com/AnaElisaLopezMiranda

University of Toronto — Applied Econometrics II  

---

## Why This Project Matters
This project demonstrates the ability to work with real economic data, apply econometric methods, and generate actionable insights—skills relevant for data analysis, finance, and economic research roles.
