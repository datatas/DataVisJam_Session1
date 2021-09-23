#Datatas: Data Visualisation Jam
#Date: 2021-09-23
#Author: Denisse Fierro Arcos
#Using Tidy Tuesday data to create simple plots.
#This week we have data from the Emmy Awards.

# Libraries ---------------------------------------------------------------
library(tidyverse)

# Loading data ------------------------------------------------------------
nominees <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-21/nominees.csv')

#Checking our data
nominees %>% 
  glimpse()


# Plotting ----------------------------------------------------------------
#We can count first and then create a bar plot
nominees %>%
  count(year, type) %>%
  ggplot(aes(x = year, y = n, fill = type))+
  #Note that we use 'stat = "identity"', this means that we are forcing
  #geom_bar to use the data as it is, no transformation is required
  geom_bar(stat = "identity")

#A more personalised plot
#Note that we do not count first, this is because geom_bar automatically
#counts the number of rows for each group (year in this case)
fig1 <- nominees %>% 
  ggplot(aes(x = year, fill = type))+
  #The position option tells geom_bar to put each group next to each other 
  #instead of on top of each other
  geom_bar(position = "dodge2")+
  #Changing color palette
  scale_fill_brewer(type = "qual", palette = "Dark2")+
  #Changing labels
  labs(x = "Year", y = "", title = "Emmy winners and nominees",
       caption = "Created by Denisse from Datatas", fill = "")+
  theme_bw()+
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(), 
        plot.title = element_text(hjust = 0.5, face = "italic",
                                  size = 16),
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14),
        legend.position = "top")

#Checking resulting plot
fig1

#Saving our plot
ggsave(plot = fig1, filename = "Figures/Figure1.png", device = "png")


#BONUS
#We can use facets and show the data in two boxes
#All axes are the same
nominees %>% 
  ggplot(aes(x = year, fill = type))+
  geom_bar()+
  #Two boxes with the same axes
  facet_grid(~type)+
  #Changing color palette
  scale_fill_brewer(type = "qual", palette = "Dark2")+
  #Changing labels
  labs(x = "Year", y = "", title = "Emmy winners and nominees",
       caption = "Created by Denisse from Datatas", fill = "")+
  theme_bw()+
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        plot.title = element_text(hjust = 0.5, face = "italic",
                                  size = 16),
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14),
        legend.position = "top")

#Y axis varies for each plot
nominees %>% 
  ggplot(aes(x = year, fill = type))+
  geom_bar()+
  #Two boxes with different y axis
  facet_wrap(~type, scales = "free_y")+
  #Changing color palette
  scale_fill_brewer(type = "qual", palette = "Dark2")+
  #Changing labels
  labs(x = "Year", y = "", title = "Emmy winners and nominees",
       caption = "Created by Denisse from Datatas", fill = "")+
  theme_bw()+
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        plot.title = element_text(hjust = 0.5, face = "italic",
                                  size = 16),
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14),
        legend.position = "top")
