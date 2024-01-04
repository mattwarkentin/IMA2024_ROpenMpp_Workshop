## Load Packages ----

library(tidyverse)
library(oncosimx)

## Inspect available models, worksets, and model runs ----

get_models()

get_scenarios('OncoSimX-allcancers')

get_model_runs('OncoSimX-allcancers')

## Load and inspect OncoSimX Model ----

allcancers <- load_model('OncoSimX-allcancers')

allcancers

allcancers$ParamsInfo

allcancers$TablesInfo

allcancers$ModelDigest

allcancers$ModelScenarios

allcancers$ModelRuns

## Load and inspect Default OncoSimX workset ----

ac_default_ws <- load_scenario('OncoSimX-allcancers', 'Default')

ac_default_ws

ac_default_ws$Parameters

## Load and inspect Default OncoSimX run ----

ac_default_run <- load_model_run('OncoSimX-allcancers', 'Default_first_run_32M_cases_12_subs')

ac_default_run

ac_default_run$Parameters

ac_default_run$Tables$All_Cancer_Age_Standardized_Rates_Table

ac_default_run$Tables$All_Cancer_Active_Cost_Table |>
  filter(Cancers == 'Lung', Sex != 'all') %>%
  ggplot(aes(Year, expr_value, fill = Sex)) +
  geom_col()
