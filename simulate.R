require('ggplot2')

source('simulator_helper.R')
source("get_data.R")
source('clean_data_helper.R')


# for each row, generate a plan data structure in a list.  save this as a list.
plans.list <- alply(unclean.data, .margins = 1, create.plan.list)
plans.list[[length(plans.list)+1]] <- create.uship.plan()

# number of simulated years of medical events
nsims <- 1000

years <- unlist(lapply(names(scenario.weights), function(name) {
  lapply(seq(1, nsims*scenario.weights[[name]]), function(x) {generate.events(name)})
}), recursive = F, use.names = F)

plans.list.sims <- lapply(plans.list, function(plan) {
  # for each plan, simulate each year. 
  plan.sims <- lapply(years, function(year) simulate.year(plan, year))
  totals <- sapply(plan.sims, function(sim) sim$total)
  summary <- summary(totals)
  list(name=plan$plan_marketing_name,
       id=plan$plan_id_standard_component,
       metal_level=plan$metal_level,
       totals=totals,
       summary=as.list(summary))
})

# throw everything into a data frame, with nsims rows per plan (representing a simulation each)
sims.data.frames <- ldply(plans.list.sims, data.frame)

# order by median
ordered.by.median <- sims.data.frames[order(sims.data.frames$summary.Median),]


top.10 <- ordered.by.median[1:(10*nsims-1),]

unique(top.10[,c("name",  "summary.Min.", "summary.Median", "summary.3rd.Qu.", "summary.Max.")])

ggplot(top.10, aes(x=totals)) + 
  facet_wrap(~summary.Median, ncol=1) + 
  #facet_grid(name~metal_level) +
  geom_density() + 
  geom_histogram(aes(y=..density..), binwidth=50, alpha=0.5)

d_ply(top.10, .(name), function(plan) {
  plt <- 
    ggplot(plan, aes(x=totals)) + 
    geom_density() + 
    geom_histogram(aes(y=..density..), binwidth=50, alpha=0.5) + 
    ggtitle(plan$name) + 
    expand_limits(x=c(0,10000))
  print(plt)
})

