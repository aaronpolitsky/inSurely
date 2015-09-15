source('clean_data_helper.R')
source('parameters.R')

is.drug.event <- function(event.class) {
  event.class %in% drug.event.classes
}

create.event <- function(event.class, probabilities) {
  retlist <- list("event.class"=event.class)
  if(event.class=="inpatient_facility_standard") {
    retlist$duration <- rpois(1,probabilities$inpatient_facility_duration)
  }
  retlist
}

# given a scenario's probabilities, generate a year's worth of medical/drug events
generate.events <- function(scenario.name) {
  events.per.class <-
    lapply(c(service.event.classes, drug.event.classes), function(event.class) {   
      count <- rpois(1, scenario.probabilities[[scenario.name]][[event.class]])
      if(count)
        events <- replicate(count, create.event(event.class, scenario.probabilities[[scenario.name]]), simplify=F)
      else
        events <- NULL
      events
    })
  names(events.per.class) <- c(service.event.classes, drug.event.classes)
  
  # need to first shuffle the class, then its events
  sample(unlist(events.per.class, recursive=F, use.names=F))
}

simulate.year <- function(plan, event.list) {
  costs <- NULL
  for(event in event.list) { # need for loop because it must be sequential
    costs <- update.costs(costs, plan, event)
  }
  costs$events.total <- sum(unlist(costs))
  costs$premium.total <- 12* plan$my.premium
  costs$total <- costs$events.total + costs$premium.total 
  costs
}

calculate.event.cost  <- function(plan, event, before.or.after) {
  if(event$event.class=="inpatient_facility_standard") {
    sum(plan$copays[[event$event.class]][[before.or.after]]$fee, 
        plan$copays[[event$event.class]][[before.or.after]]$pct/100 *
          (prices[[event$event.class]]$per.stay + 
             event$duration * prices[[event$event.class]]$per.day),
        na.rm=T)
  }
  else {
    sum(plan$copays[[event$event.class]][[before.or.after]]$fee, 
        plan$copays[[event$event.class]][[before.or.after]]$pct/100 * 
          prices[[event$event.class]], 
        na.rm = T)
  }  
}

update.costs <- function(costs=NULL, plan, event) {
  # initialize cost list if does not exist.
  if(is.null(costs)) {
    costs <- as.list(sapply(c(service.event.classes, drug.event.classes), function(x) {0}))
  }
  
  # if drug deductible is included in medical, treat all events same
  if(plan$drug.ded.included) {
    total.cost <- sum(unlist(costs))
     
    # have we met our deductible?
    before.or.after <- ifelse(total.cost < plan$medical_deductible_individual_standard, 
                              "before",
                              "after")
    
    event.cost <- calculate.event.cost(plan, event, before.or.after)
    
    # would this put us over our out of pocket max?
    if((total.cost + event.cost) >= plan$medical_maximum_out_of_pocket_individual_standard) {
     
      event.cost <- plan$medical_maximum_out_of_pocket_individual_standard - total.cost
    
    } 
    
    costs[[event$event.class]] <- costs[[event$event.class]] + event.cost
    
  } else {
    
    if(event$event.class %in% drug.event.classes) {
      total.cost <- sum(unlist(costs)[names(costs) %in% drug.event.classes])
      
      before.or.after <- 
        ifelse(total.cost < plan$drug_deductible_individual_standard, 
               "before",
               "after")
      
      event.cost <- calculate.event.cost(plan, event, before.or.after)
  
      if((total.cost + event.cost) >= plan$drug_maximum_out_of_pocket_individual_standard) {
        
        event.cost <- plan$drug_maximum_out_of_pocket_individual_standard - total.cost

      }
      
      costs[[event$event.class]] <- costs[[event$event.class]] + event.cost
      
    } else {
      total.cost <- sum(unlist(costs)[names(costs) %in% service.event.classes])
      
      before.or.after <- 
        ifelse(total.cost < plan$medical_deductible_individual_standard, 
               "before",
               "after")
      
      event.cost <- calculate.event.cost(plan, event, before.or.after)
      
      if((total.cost + event.cost) >= plan$medical_maximum_out_of_pocket_individual_standard) {
        
        event.cost <- plan$medical_maximum_out_of_pocket_individual_standard - total.cost
    
      }
      
      costs[[event$event.class]] <- costs[[event$event.class]] + event.cost
      
    }
  }
  
  costs
}
