#!/bin/bash

# wrapper script for the policy cost calculation
# instead of calling Rscript output.R -> comparison -> policyCosts and selecting the scenarios manually, 
# you specify the scenarios below
# Note: currently works only for coupled runs (for standalone runs the timestamp needs to be taken up)
# Bjoern Soergel, Oliver Richters, 2023

# definition of (scenario - reference) run pairs as expected by policy cost calculation
# select the appropriate definition set below, or add for your project

# SHAPE (mandatory & optional runs)
#this now includes the new default with CO2 price increase post-peak for SDP_EI/SSP2/SSP1-PkBudg650 scenarios (including CCimp)
# comment the taxIncX & uncomment the original if this is applied in a re-run with new settings AND new name
# it also includes NPi w.r.t. to NPi to add zeros in policy costs for the reference scenarios
scenarioAndReference=(
"SDP_EI-PkBudg650-taxInc3" "SDP_EI-NPi" \
# "SDP_EI-PkBudg650" "SDP_EI-NPi" \ 
"SDP_EI-PkBudg500" "SDP_EI-NPi" \
"SDP_EI-PkBudg650-taxInc3-CCimp" "SDP_EI-NPi" \
# "SDP_EI-PkBudg650-CCimp" "SDP_EI-NPi" \ 
"SDP_EI-NDC" "SDP_EI-NPi" \
"SDP_EI-NPi" "SDP_EI-NPi" \
# ----------------------------------------------------
"SDP_MC-PkBudg650" "SDP_MC-NPi" \
"SDP_MC-PkBudg500" "SDP_MC-NPi" \
"SDP_MC-PkBudg650-CCimp" "SDP_MC-NPi" \
"SDP_MC-NDC" "SDP_MC-NPi" \
"SDP_MC-NPi" "SDP_MC-NPi" \
# ----------------------------------------------------
"SDP_RC-PkBudg650" "SDP_RC-NPi" \
"SDP_RC-PkBudg500" "SDP_RC-NPi" \
"SDP_RC-PkBudg650-CCimp" "SDP_RC-NPi" \
"SDP_RC-NDC" "SDP_RC-NPi" \
"SDP_RC-NPi" "SDP_RC-NPi" \
# ----------------------------------------------------
"SSP2EU-PkBudg650-taxInc6" "SSP2EU-NPi" \
# "SSP2EU-PkBudg650" "SSP2EU-NPi" \
"SSP2EU-PkBudg500" "SSP2EU-NPi" \
"SSP2EU-PkBudg650-taxInc6-CCimp" "SSP2EU-NPi" \
# "SSP2EU-PkBudg650-CCimp" "SSP2EU-NPi" \
"SSP2EU-NPi-CCimp" "SSP2EU-NPi" \
"SSP2EU-NDC" "SSP2EU-NPi" \
"SSP2EU-NPi" "SSP2EU-NPi" \
# ----------------------------------------------------
"SSP1-PkBudg650-taxInc3" "SSP1-NPi" \
# "SSP1-PkBudg650" "SSP1-NPi" \
"SSP1-PkBudg500" "SSP1-NPi" \
"SSP1-NDC" "SSP1-NPi" \
"SSP1-NPi" "SSP1-NPi" \
)

# generate scenario selection string as expected by policyCosts
remnr=5
scenarioAndReference=( "${scenarioAndReference[@]/#/output/C_}" )
scenarioAndReference=( "${scenarioAndReference[@]/%/-rem-$remnr}" )
scenarioAndReference=( $( IFS="," ; echo "${scenarioAndReference[*]}") )

Rscript output.R comp=T output=policyCosts outputdir=$scenarioAndReference
