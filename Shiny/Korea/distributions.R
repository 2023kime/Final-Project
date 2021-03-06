EARFEI
density(totalsum)
totalsum
Total
ggplot(Total, aes(sum)) +
  geom_density()
hist(totalsum, probability = TRUE)

EARFEIwithGDP <- full_join(join, kgrowth, by = "Year") %>%
  rename(GDP_growth = 'GDP Growth') %>%
  mutate(GDP_growth = (GDP_growth)) %>%
  drop_na()

kgrowth$Entertainment <- 0
kgrowth$Entertainment <- Entertainment$sum
kgrowth$Employment <- Employment$sum
kgrowth$Academic <- Academic$sum
kgrowth$Religion <- Religion$sum
kgrowth$Family <- Family$sum
kgrowth$Investment <- Investment$sum
kgrowth$Sum <- totalsum
finaldata <- kgrowth

# stan_glm(formula = Sum ~ Year + `GDP Growth` + Entertainment,
#          data = kgrowth,
#          refresh = 0) %>%
#   print(digits = 10, detail = FALSE)
# 
# model <- lm(formula = `GDP Growth` ~ Year + log(Sum),
#          data = kgrowth)
# summary(model)






# Looking at Temporary and Permanent Visas
# This has Job Seeking by M/F/T and GDP values from 2000 to 2020
temp_perm <- full_join(temp_v_perm, korea_GDP, by = "Year") %>%
  rename(GDP = value) %>%
  select(-Indicator)
setwd("~/Desktop/Projects/Final-Project/Shiny/Korea")
write.csv(temp_perm, "data/temp_perm.csv")

fit <- lm(formula = Temp_sum ~ GDP *Year,
         data = joined)
tbl_regression(fit, intercept = TRUE) %>%
  as_gt() %>%
  tab_header(title = md("**Regression of Temporary Visas**"),
             subtitle = "The Effect of GDP on Temporary Visas Sought")

fit2 <- lm(formula = Perm_sum ~ GDP *Year,
                 data = joined)
tbl_regression(fit2, intercept = TRUE) %>%
  as_gt() %>%
  tab_header(title = md("**Regression of Permanent Visas**"),
             subtitle = "The Effect of GDP on Permanent Visas Sought")

fit3 <- stan_glm(formula = `GDP Growth` ~ Entertainment + Employment + Academic + 
                   Religion + Family + Investment - 1,
                 data = finaldata,
                 refresh = 0) %>%
  print(digits = 4, deatil = FALSE)

plot(fit3, "hist", pars = c("Entertainment", "Employment", "Academic", "Religion",
                            "Family", "Investment"), binwidth = .0001)
m3 <- lm(`GDP Growth` ~ Entertainment + Employment + Academic + 
           Religion + Family + Investment,
         data = finaldata)
summary(m3) 
# make this model into table

m4 <- lm(Entertainment ~ 'GDP Growth',
         data = finaldata)


m1 <- lm(Perm_sum ~ GDP + Year,
         data = joined)
summary(m1)
m1$coefficients[1] + m1$coefficients[2] * 28605.73 + m1$coefficients[3] * 2030
#prediction distribution: make year/gdp growth rates selectable variables
#missing edited_korea3 so...#
# joined <- full_join(edited_korea3, korea_GDP, by = "Year")
# stan_glm(formula = Total ~ value,
#         data = joined,
#         refresh = 0) %>%
#  print(digits = 10, deatil = FALSE)
