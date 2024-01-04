## Load Packages ----

library(tidyverse)
library(oncosimx)

## Inspect available models, worksets, and model runs ----

get_models()

get_worksets('RiskPaths')

get_model_runs('RiskPaths')$RunDigest

## Load and inspect RiskPaths Model ----

riskpaths <- load_model('RiskPaths')

riskpaths

riskpaths$ParamsInfo

riskpaths$TablesInfo

riskpaths$ModelDigest

riskpaths$ModelScenarios

riskpaths$ModelRuns

## Load and inspect Default RiskPaths workset ----

rp_default_ws <- load_scenario('RiskPaths', 'Default')

rp_default_ws

rp_default_ws$ReadOnly

rp_default_ws$Parameters$AgeBaselineForm1

rp_default_ws$Parameters$AgeBaselinePreg1

## Load and inspect Default RiskPaths run ----

rp_default_run <- load_model_run('RiskPaths', 'RiskPaths_Default')

rp_default_run$Parameters$AgeBaselinePreg1

rp_default_run$Tables$T03_FertilityByAge

rp_default_run$Tables$T03_FertilityByAge |>
  ggplot(aes(Dim0, expr_value)) +
  geom_col()

rp_default_run$Tables$T06_BirthsByUnion |>
  filter(Dim0 != 'all') |>
  ggplot(aes(Dim0, expr_value)) +
  geom_col()

## Create and run new RiskPaths workset ----

create_scenario('RiskPaths', 'MyWorkset', '9a6bf761db1a7f27b91fc1d56c0e6d0e')

myworkset <- load_scenario('RiskPaths', 'MyWorkset')

myworkset

myworkset$copy_params('AgeBaselinePreg1')

old_param <- myworkset$Parameters$AgeBaselinePreg1

new_param <-
  old_param |>
  mutate(
    # Reduce fertility by 10% for all ages
    across(-sub_id, \(x) x * 0.9)
  )

myworkset$Parameters$AgeBaselinePreg1 <- new_param

myworkset$ReadOnly <- TRUE

myworkset$run(
  name = 'MyRun',
  wait = TRUE,
  progress = FALSE,
  opts = opts_run(SimulationCases = 10000)
)

## Load run and inspect results ----

myrun <- load_run('RiskPaths', 'MyRun')

myrun$Tables$T03_FertilityByAge

## Load multiple runs and compare results ----

rp_runs <- load_runs('RiskPaths', riskpaths$ModelRuns$RunDigest)

rp_runs

rp_runs$Tables$T03_FertilityByAge

rp_runs$Tables$T03_FertilityByAge |>
  ggplot(aes(Dim0, expr_value, fill = RunName)) +
  geom_col(position = position_dodge())

rp_runs$Tables$T04_FertilityRatesByAgeGroup |>
  ggplot(aes(Dim0, expr_value, fill = RunName)) +
  geom_col(position = position_dodge()) +
  facet_wrap(~ Dim1, scales = 'free_y')

## Clean up workset and run ----

myworkset$ReadOnly <- FALSE
delete_workset('RiskPaths', 'MyWorkset')

delete_run('RiskPaths', 'MyRun')
