# ---------------------------------------------------------------------------- #
# Create Democracy Motion Chart
# Christopher Gandrud
# MIT LICENSE
# ---------------------------------------------------------------------------- #

# Load packages
library(rio)
library(dplyr)
library(googleVis)

# Load data
main <- import('~/Desktop/qog_bas_ts_jan15.csv')

# Keep variables of interest
sub <- main %>% select(cname, year, ht_region, cam_contest, cam_inclusive, chga_demo, 
              h_polcon3, iaep_evp, iaep_lvp, p_polity2, uds_median,
              ti_cpi, wbgi_gee, wbgi_rle, gle_rgdpc)

names(sub) <- c('Country', 'Year', 'Region', 'Contestation', 'Inclusiveness', 
                'Binary Democracy', 'Constraints', 'Executive Veto Power',
                'Legislative Veto Power', 'Polity Democracy Score', 
                'Unified Democracy Score', 
                'Corruption Perceptions Index', 'Government Input Effectiveness',
                'Rule of Law', 'Real GDP per capita')

sub$Region <- factor(sub$Region, levels = 1:10, 
                     labels = c('Eastern Europe/Soviet Union',
                                'Latin America',
                                'North Africa/Middle East',
                                'Sub-Saharan Africa',
                                'Western Europe/North America',
                                'East Asia',
                                'South-East Asia',
                                'South Asia',
                                'The Pacific',
                                'Caribbean'))

# Create motion chart
motion <- gvisMotionChart(sub, idvar = 'Country', timevar = 'Year', 
                          colorvar = 'Region', sizevar = 'Real GDP per capita',
                          xvar = 'Unified Democracy Score', 
                          yvar = 'Contestation')
plot(motion)
