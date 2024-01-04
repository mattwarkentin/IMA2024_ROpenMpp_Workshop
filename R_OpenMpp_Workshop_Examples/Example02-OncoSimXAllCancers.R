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

allcancers$ParamInfo

allcancers$TableInfo

allcancers$ModelDigest

allcancers$ModelScenarios

allcancers$ModelRuns

## Load and inspect Default OncoSimX workset ----

ac_default_ws <- load_scenario('OncoSimX-allcancers', 'Default')

ac_default_ws$Parameters

## Load and inspect Default OncoSimX run ----

ac_default_run <- load_model_run('OncoSimX-allcancers', 'Default')

ac_default_run$Parameters

ac_default_run$Tables
