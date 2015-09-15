age.tens.digit <- 3
age.ones.digit <- 7

prices <- 
  list("primary_care_physician_standard"    = 160,
       "specialist_standard"                = 300, 
       "emergency_room_standard"            = 1000,
       "inpatient_facility_standard"        = list("per.stay" = 500,
                                                   "per.day"  = 1000),
       "inpatient_physician_standard"       = 160,                       
       "generic_drugs_standard"             = 31,
       "preferred_brand_drugs_standard"     = 85,
       "non_preferred_brand_drugs_standard" = 85,
       "specialty_drugs_standard"           = 170
  )

# probabilities for different scenarios
scenario.probabilities <- 
  list(
    "typical" =
      list("primary_care_physician_standard"    = 2,
           "specialist_standard"                = 1, 
           "emergency_room_standard"            = .01,
           # probability of a stay
           "inpatient_facility_standard"        = .05,
           # duration
           "inpatient_facility_duration"        = 3,
           "inpatient_physician_standard"       = .05,                       
           "generic_drugs_standard"             = 2,
           "preferred_brand_drugs_standard"     = .25,
           "non_preferred_brand_drugs_standard" = .1,
           "specialty_drugs_standard"           = .01
      ),
    "bad" =
      list("primary_care_physician_standard"    = 6,
           "specialist_standard"                = 3, 
           "emergency_room_standard"            = .1,
           # probability of a stay
           "inpatient_facility_standard"        = 1,
           # duration
           "inpatient_facility_duration"        = 5,
           "inpatient_physician_standard"       = 1,                       
           "generic_drugs_standard"             = 5,
           "preferred_brand_drugs_standard"     = 3,
           "non_preferred_brand_drugs_standard" = 1,
           "specialty_drugs_standard"           = 1
      ),
    "really.bad" =
      list("primary_care_physician_standard"    = 15,
           "specialist_standard"                = 5, 
           "emergency_room_standard"            = .5,
           # probability of a stay
           "inpatient_facility_standard"        = 2,
           # duration
           "inpatient_facility_duration"        = 10,
           "inpatient_physician_standard"       = 3,                       
           "generic_drugs_standard"             = 10,
           "preferred_brand_drugs_standard"     = 5,
           "non_preferred_brand_drugs_standard" = 3,
           "specialty_drugs_standard"           = 3
      )  
  )

# weights indicating the likelihood of each scenario
scenario.weights <- list("typical"= .9,
                         "bad"    = .09,
                         "really.bad" = .01)

