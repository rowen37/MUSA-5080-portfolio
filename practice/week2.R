# 1
library(tidyverse)
library(tidycensus)

# 2
pa_income <- get_acs(
  geography = "county",
  variables = "B19013_001",
  state = 'PA',
  year = 2023,
  survey = "acs5"
)

dim(pa_income)
glimpse(pa_income)
head(pa_income, 10)    # Pennsylvania has 67 counties because 'Rows: 67'

# 3
pa_income$GEOID

as.numeric("01001").   # leading 0 is missing

# 4
filter(pa_income, estimate > 60000)
# Counties where the margin of error is bigger than 3000
filter(pa_income, moe > 3000)
# Counties where the estimate is under 50000
filter(pa_income, estimate < 50000)

# 5
select(pa_income, NAME, estimate, moe)

# 6
mutate(pa_income, moe_pct = moe / estimate * 100)

pa_income <- mutate(pa_income, moe_pct = moe / estimate * 100).   # Relative Margin of Error
pa_income

# 7
arrange(pa_income, moe_pct)
arrange(pa_income, desc(moe_pct))

# 8
step1 <- filter(pa_income, moe_pct > 5)
step2 <- arrange(step1, desc(moe_pct))
step3 <- select(step2, NAME, estimate, moe, moe_pct)
step3

pa_income %>%
  filter(moe_pct > 5 ) %>%
  arrange(desc(moe_pct)) %>%
  select(NAME, estimate, moe, moe_pct)

# Keep counties with moe_pct over 8, sort by estimate, show NAME and moe_pct
pa_income %>%
  filter(moe_pct > 8) %>%
  arrange(desc(estimate)) %>%
  select(NAME, moe_pct)
# Change that pipeline so the result lands in an object called worst
worst <- pa_income %>%
  filter(moe_pct > 8) %>%
  arrange(desc(estimate)) %>%
  select(NAME, moe_pct)

# 9
pa_income <- mutate(pa_income, reliable = moe_pct < 5)
pa_income %>%
  group_by(reliable) %>%
  summarize(n = n(),
            avg_income = mean(estimate))

# 10
pa_income <- pa_income %>%
  mutate(reliability = case_when(
    moe_pct < 3 ~ "High confidence",
    moe_pct < 6 ~ "Moderate",
    TRUE ~ "Low condifence"
  ))
count(pa_income, reliability)

# 11
pa_two <- get_acs(
  geography = "county",
  variables = c("B19013_001", "B01003_001"),
  state = "PA", year = 2023, survey = "acs5"
)
pa_two

pa_wide <- get_acs(
  geography = "county",
  variables = c(income = "B19013_001",
                pop = "B01003_001"),
  state = "PA", year = 2023, survey = "acs5",
  output = "wide"
)
pa_wide

pa_wide %>%
  mutate(moe_pct = incomeM / incomeE * 100) %>%
  arrange(desc(moe_pct)) %>%
  select(NAME, popE, incomeE, moe_pct) %>%
  head(10)
