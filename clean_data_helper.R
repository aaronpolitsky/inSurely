#require('stringr')
require('plyr')
source('parameters.R')

# brute force method
copay.lookup <- list(  
  "No Charge" =
    list("before" = 
           list("pct" = 0,
                "fee" = 0),
         "after" = 
           list("pct" = 0,
                "fee" = 0)),
  "No Charge after Deductible" = 
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 0,
                "fee" = 0)),
  "$20 Copay after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 0,
                "fee" = 20)),
  "$25 Copay after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 0,
                "fee" = 25)),
  "$250 Copay after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 0,
                "fee" = 250)),
  "$30 Copay after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 0,
                "fee" = 30)),
  "$30 Copay before deductible" =
    list("before" = 
           list("pct" = 0,
                "fee" = 30),
         "after" = 
           list("pct" = 0,
                "fee" = 0)),
  "$300 Copay after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 0,
                "fee" = 300)),
  "$35 Copay before deductible" =
    list("before" = 
           list("pct" = 0,
                "fee" = 35),
         "after" = 
           list("pct" = 0,
                "fee" = 0)),
  "$40 Copay after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 0,
                "fee" = 40)),
  "$400 Copay and 20% Coinsurance after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 20,
                "fee" = 400)),
  "$45 Copay after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 0,
                "fee" = 45)),
  "$50 Copay after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 0,
                "fee" = 50)),
  "$50 Copay before deductible and 20% Coinsurance after deductible" =
    list("before" = 
           list("pct" = 0,
                "fee" = 50),
         "after" = 
           list("pct" = 20,
                "fee" = 0)),
  "$500 Copay and 20% Coinsurance after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 20,
                "fee" = 500)),
  "$500 Copay before deductible" =
    list("before" = 
           list("pct" = 0,
                "fee" = 500),
         "after" = 
           list("pct" = 0,
                "fee" = 0)),
  "$60 Copay after deductible"  =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 0,
                "fee" = 60)),
  "$600 Copay and 30% Coinsurance after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 30,
                "fee" = 600)),
  "$100 Copay per Stay" = 
    list("before" = 
           list("pct" = 0,
                "fee" = 100),
         "after" = 
           list("pct" = 0,
                "fee" = 100)), 
  "$200 Copay per Stay" = 
    list("before" = 
           list("pct" = 0,
                "fee" = 200),
         "after" = 
           list("pct" = 0,
                "fee" = 200)),
  "$250 Copay per Stay" = 
    list("before" = 
           list("pct" = 0,
                "fee" = 250),
         "after" = 
           list("pct" = 0,
                "fee" = 250)),
  "$200 Copay per Stay and 20% Coinsurance after deductible" = 
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 20,
                "fee" = 200)),
  "$250 Copay per Stay and 20% Coinsurance after deductible"= 
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 20,
                "fee" = 250)),
  "$300 Copay per Stay and 30% Coinsurance after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 30,
                "fee" = 300)),
  "$500 Copay per Stay and 30% Coinsurance after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 30,
                "fee" = 500)),
  "$650 Copay per Day" =
    list("before" = 
           list("pct" = 0,
                "fee" = 650),
         "after" = 
           list("pct" = 0,
                "fee" = 650)),
  "$70 Copay after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 0,
                "fee" = 70)),
  "$75 Copay after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 0,
                "fee" = 75)),
  "$75 Copay before deductible" =
    list("before" = 
           list("pct" = 0,
                "fee" = 75),
         "after" = 
           list("pct" = 0,
                "fee" = 0)),
  "$75 Copay before deductible and 20% Coinsurance after deductible" =
    list("before" = 
           list("pct" = 0,
                "fee" = 75),
         "after" = 
           list("pct" = 20,
                "fee" = 0)),
  "$750 Copay per Day" =
    list("before" = 
           list("pct" = 0,
                "fee" = 750),
         "after" = 
           list("pct" = 0,
                "fee" = 750)),
  "10% Coinsurance after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 10,
                "fee" = 0)),
  "20% Coinsurance after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 20,
                "fee" = 0)),                                
  "25% Coinsurance after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 25,
                "fee" = 0)),                                
  "30% Coinsurance after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 30,
                "fee" = 0)),                          
  "32% Coinsurance after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 32,
                "fee" = 0)),                                
  "40% Coinsurance after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 40,
                "fee" = 0)),                                
  "50% Coinsurance after deductible" =
    list("before" = 
           list("pct" = 100,
                "fee" = 0),
         "after" = 
           list("pct" = 50,
                "fee" = 0)) 
)

dollar.to.numeric <- function(dollar.string) {
  as.numeric(gsub("\\$", "", gsub(",","", dollar.string)))
}

numeric.row.list <- function(row) {
  list("before" = 
         list("pct" = 0,
              "fee" = dollar.to.numeric(row)),
       "after"  = 
         list("pct" = 0,
              "fee" = dollar.to.numeric(row))
  )
}

create.uship.plan <- function() {
  # set up the uship plan for comparison to marketplace plans.
  uship.plan <- list()
  uship.plan$plan_marketing_name <- "U-SHIP"
  uship.plan$plan_id_standard_component <- "U-SHIP"
  uship.plan$my.premium <- 3432/12
  uship.plan$medical_deductible_individual_standard <- 500
  uship.plan$medical_maximum_out_of_pocket_individual_standard <- 1500
  uship.plan$drug_deductible_individual_standard <- 500 # same as medical
  uship.plan$drug_maximum_out_of_pocket_individual_standard <- 1500 # same as medical
  uship.plan$drug.ded.included <- T
  
  uship.plan$copays <- 
    list(
      "inpatient_facility_standard"        = 
        list("before" = 
               list("pct" = 90,
                    "fee" = 0),
             "after" = 
               list("pct" = 25,
                    "fee" = 0)), 
      "primary_care_physician_standard"    = 
        list("before" = 
               list("pct" = 0,
                    "fee" = 20),
             "after" = 
               list("pct" = 0,
                    "fee" = 20)),
      "emergency_room_standard"            = 
        list("before" = 
               list("pct" = 0,
                    "fee" = 100),
             "after" = 
               list("pct" = 0,
                    "fee" = 100)), 
      "generic_drugs_standard"             = 
        list("before" = 
               list("pct" = 0,
                    "fee" = 10),
             "after" = 
               list("pct" = 0,
                    "fee" = 10)), 
      "preferred_brand_drugs_standard"     = 
        list("before" = 
               list("pct" = 0,
                    "fee" = 25),
             "after" = 
               list("pct" = 0,
                    "fee" = 25)), 
      "non_preferred_brand_drugs_standard" = 
        list("before" = 
               list("pct" = 0,
                    "fee" = 40),
             "after" = 
               list("pct" = 0,
                    "fee" = 40)), 
      "specialty_drugs_standard"           = 
        list("before" = 
               list("pct" = 0,
                    "fee" = 0),
             "after" = 
               list("pct" = 0,
                    "fee" = 0)), 
      "inpatient_physician_standard"       = 
        list("before" = 
               list("pct" = 70,
                    "fee" = 0),
             "after" = 
               list("pct" = 70,
                    "fee" = 0)),
      "specialist_standard"                = 
        list("before" = 
               list("pct" = 70,
                    "fee" = 0),
             "after" = 
               list("pct" = 70,
                    "fee" = 0))       
    )
  
  uship.plan$metal_level <- "Platinum"

  return(uship.plan)
}

service.event.classes <- 
  c("primary_care_physician_standard",
    "specialist_standard", 
    "emergency_room_standard",
    "inpatient_facility_standard",
    "inpatient_physician_standard"                   
  )

drug.event.classes <-
  c("generic_drugs_standard",
    "preferred_brand_drugs_standard",
    "non_preferred_brand_drugs_standard",
    "specialty_drugs_standard"
  )

create.plan.list <- function(plan) {
  plan.list <- list()
  
  # name, id, attributes
  plan.list$plan_marketing_name <- plan$plan_marketing_name
  plan.list$plan_id_standard_component <- plan$plan_id_standard_component
  

  
  # my.premium
  if(age.tens.digit < 3) { # in your 20's
    plan.list$my.premium <- 
      as.numeric(plan$premium_adult_individual_age_20)*(10-age.ones.digit)/10 + 
      as.numeric(plan$premium_adult_individual_age_30)*age.ones.digit/10  
    
  } else { # in your 30's
    plan.list$my.premium <- 
      as.numeric(plan$premium_adult_individual_age_30)*(10-age.ones.digit)/10 + 
      as.numeric(plan$premium_adult_individual_age_40)*age.ones.digit/10        
  }
  
  # medical deductible
  plan.list$medical_deductible_individual_standard <- 
    dollar.to.numeric(plan$medical_deductible_individual_standard)
  
  # out of pocket maximum
  plan.list$medical_maximum_out_of_pocket_individual_standard <- 
    dollar.to.numeric(plan$medical_maximum_out_of_pocket_individual_standard)
    
  plan.list$drug_deductible_individual_standard <- 
    dollar.to.numeric(plan$drug_deductible_individual_standard)
  
  plan.list$drug_maximum_out_of_pocket_individual_standard <- 
    ifelse(plan$drug_maximum_out_of_pocket_individual_standard == "Included in Medical",
           plan.list$medical_maximum_out_of_pocket_individual_standard,
           dollar.to.numeric(plan$drug_maximum_out_of_pocket_individual_standard))
  
  # is drug deductible included in medical?
  plan.list$drug.ded.included <- plan$drug_deductible_individual_standard=="Included in Medical"
  
  # create copays per event
  copays <- 
    lapply(c(service.event.classes, drug.event.classes), 
           function(event.class) {
             if(plan[event.class] %in% names(copay.lookup)) {
               return(copay.lookup[unlist(plan[event.class])][[1]])
             } else {
               return(numeric.row.list(unlist(plan[event.class])) )
             }
           }
    )
  names(copays) <- c(service.event.classes, drug.event.classes)
  plan.list$copays <- copays
  
  plan.list$metal_level <- plan$metal_level
  
  return(plan.list)
}



