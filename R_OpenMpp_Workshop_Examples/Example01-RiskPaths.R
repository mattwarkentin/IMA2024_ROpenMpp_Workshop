## Load Packages ----

library(tidyverse)
library(oncosimx)

## Inspect available models, worksets, and model runs ----

get_models()

get_scenarios('RiskPaths')

get_model_runs('RiskPaths')

## Load and inspect RiskPaths Model ----

riskpaths <- load_model('RiskPaths')

riskpaths

riskpaths$ParamInfo

riskpaths$TableInfo

riskpaths$ModelDigest

riskpaths$ModelScenarios

riskpaths$ModelRuns

## Load and inspect Default RiskPaths workset ----

rp_default_ws <- load_scenario('RiskPaths', 'Default')

rp_default_ws$Parameters

## Load and inspect Default RiskPaths run ----

rp_default_run <- load_model_run('RiskPaths', 'RiskPaths_Default')

rp_default_run$Parameters

rp_default_run$Tables

## Create and run new RiskPaths workset ----

create_scenario('RiskPaths', 'MyNewScenario')

myscenario <- load_scenario('RiskPaths', 'MyNewScenario')

old_param <- myscenario$Parameters$AgeBaselinePreg1

new_param <-
  old_param |>
  mutate(
    # Reduce fertility by 10% for all ages
    across(-sub_id, \(x) x * 0.9)
  )

myscenario$Parameters$AgeBaselinePreg1 <- new_param

myscenario$ReadOnly <- TRUE

myscenario$run(
  name = 'MyRun',
  wait = TRUE,
  progress = TRUE,
  opts = opts_run(SimulationCases = 50000)
)

## Load run and inspect results ----

myrun <- load_run('RiskPaths', 'MyRun')

myrun$Tables$T04_FertilityRatesByAgeGroup

## Load multiple runs and compare results ----

rp_runs <- load_runs('RiskPaths', riskpaths$RunDigests)

rp_runs$Tables$T04_FertilityRatesByAgeGroup
