require(tidyverse)
require(ggplot2)
require(ggthemr)

d <- read.csv('ggp.dat', header = TRUE)

d$ipsi = d$hemisphere == d$lesionside


ggthemr('light')
d %>% ggplot(aes(x=ses, y=GGP, group=interaction(sub,ipsi), color=ipsi))+
  geom_line(alpha=.25) +
  stat_summary(aes(group = ipsi), geom = "point", fun.y = mean, shape = 21, size = .75, color='grey')+
  stat_summary(aes(group = ipsi, width=.75), size=.5, fun.data = mean_se, geom = "errorbar")+
  facet_wrap(~lab, scales = 'free')

ggsave('GGP.png', width = 10, height = 4)
