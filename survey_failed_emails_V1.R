#This piece of code gathers all failed emails from a csv file and updates status of the participants (for instance: not contactable) in Redcap
#Prerequisites
# - A PC with R or Rstudio
# - In Redcap, the variables "email" and "treatment" must exist in one of the forms.
# - A csv file with all failed emails (this is easy to do by setting a rule in Outlook that moves the incoming failed mails to a folder and then export the contents of the
# folder to a csv file instead of a .pst)
update_participant <-function(){
  library(stringr)
  library(data.table)
  x <- readline("What is the path to the csv file that contains the emails?")
  x <- gsub("\\", "/",x, fixed=TRUE)
  setwd(x)
  y <- readline("And the failed email csv file name? don't write the extension:")

  fmail<-fread(paste0(x,"/",y,".csv"),select=c(1:3,6,8),skip=1L)

  names(fmail) <- c("object","body","sender","receiver","type")

  #Non valid emails have "treatment" variable set to 1
  fmail[,treatment:=1]
  fmail2<-fmail[,c("receiver","treatment")]
  names(fmail2) <- c("email","treatment")

  #Read redcap list of participants (export it with a report). Report should be in the same folder as the csv with the failed emails
  z <- readline("And Redcap's report containing participant names?should have record_id, event and participant email:")
  particlist<-fread(paste0(x,"/",z,".csv"))
  toredcap <- merge(particlist,fmail2, on="email")
  setcolorder(toredcap, c("record_id", "redcap_event_name", "email", "treatment"))

  fwrite(toredcap,paste0(y,"_toredcap.csv"))
}


