#loopie the scrapie
#libraries
library(rvest)
library(tidyverse)

#game earnings
games_Earnings <- data.frame()

for (i in seq(from = 1998, to = 2025, by = 1)) {
  
  urlloop <- paste0("https://www.esportsearnings.com/history/", i, "/games")
  
  webpageloop <- read_html(urlloop)
  
  years <- i
  
  games <- webpageloop %>%
    html_element(xpath = "/html/body/div[1]/div/main/div[2]/div/div[2]/table/tbody") %>%
    html_table()
  
  page_data <- data.frame(years, games)
  
  games_Earnings <- bind_rows(games_Earnings, page_data)
 
 Sys.sleep(5)
}

games_Earnings <- games_Earnings %>%
  mutate(X5 = str_remove(X5,"Tournaments | Tournament")) %>%
  mutate(X4 = str_remove(X4, "Players | Player | s"))

#country earnings
country_Earnings <- data.frame()

for (i in seq(from = 1998, to = 2025, by = 1)) {
  urlloop <- paste0("https://www.esportsearnings.com/history/", i, "/countries")
  
  webpageloop <- read_html(urlloop)
  
  years <- i
  
  country <- webpageloop %>%
    html_elements(xpath = "/html/body/div/div/main/div[2]/div/table/tbody") %>%
    html_table()
  
  page_data <- data.frame(years, country)
  
  country_Earnings <- bind_rows(country_Earnings, page_data)
  
  Sys.sleep(5)
}

view(country_Earnings)


#team earnings
team_Earnings <- data.frame()

for (i in seq(from = 1999, to = 2025, by = 1)) {
  urlloop <- paste0("https://www.esportsearnings.com/history/", i, "/teams")
  
  webpageloop <- read_html(urlloop)
  
  years <- i
  
  team <- webpageloop %>%
    html_elements(xpath = "/html/body/div/div/main/div[2]/div/div[2]/table/tbody") %>%
    html_table()
  
  page_data <- data.frame(years, team)
  
  team_Earnings <- bind_rows(team_Earnings, page_data)
  
  Sys.sleep(5)
}

#writing to csv and saving to desktop
write.csv(team_Earnings, "C:/Users/gokog/Desktop/team_Earnings.csv")
write.csv(games_Earnings, "C:/Users/gokog/Desktop/games_Earnings.csv")
write.csv(country_Earnings, "C:/Users/gokog/Desktop/country_Earnings.csv")