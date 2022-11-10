# Instruction to students: You may clear the code in this file and replace it
# with your own.

library(tidyverse)
library(ggforce)
theme_set(theme_void())

# Draw a random chord in a unit circle centred at origin -----------------------

# Coordinates of equilateral triangle
eqtri_df <- tibble(
  x    = c(0, sqrt(3) / 2, -sqrt(3) / 2),
  y    = c(1, -0.5, -0.5),
  xend = c(sqrt(3) / 2, -sqrt(3) / 2, 0),
  yend = c(-0.5, -0.5, 1)
)

# Coordinates of random chord
rdmchr_df <- tibble(
  x    = 0.93636368,
  y    = 0.35103142,
  xend = -0.9999991,
  yend = -0.001326758
)

# Plot
p <- ggplot() +
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray50") +
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_segment(data = rdmchr_df, aes(x = x, y = y, xend = xend, yend = yend),
               col = "red3") +
  coord_equal()

ggsave(p, file = "plot.png", height = 5, width = 7)

# Plot a circle
library(ggplot2)
library(ggforce)

data_circle <- data.frame(x0 = 0,
                          y0 = 0,
                          r = 1)

ggplot(data = data_circle, aes(x = x0, y = y0)) + 
  geom_circle(data = data_circle, aes(x0 = x0, y0 = y0, r=r))

# METHOD A (Random Endpoints) --------------------------------------------------
library(tidyverse)
library(ggforce)
library(ggplot2)
library(dplyr)

n <- 200 # number of chords - can change this

theta_1 <- runif(n, 0, 2*pi)
theta_2 <- runif(n, 0, 2*pi)
endpoint <- tibble(
  x1 = cos(theta_1),
  y1 = sin(theta_1),
  x2 = cos(theta_2),
  y2 = sin(theta_2))

eqtri_df <- tibble(
  x    = c(0, sqrt(3) / 2, -sqrt(3) / 2),
  y    = c(1, -0.5, -0.5),
  xend = c(sqrt(3) / 2, -sqrt(3) / 2, 0),
  yend = c(-0.5, -0.5, 1))

circle <- mutate(.data = endpoint, l = sqrt((x2 - x1)^2 + (y2 - y1)^2)) # add new column l

eqtri_df_new <- mutate(.data = eqtri_df, s = sqrt((xend - x)^2 + (yend - y)^2)) # add new column s

final_eqtri_df_new <- slice(.data = eqtri_df_new, 1) # only need 1 row as reference

s <- final_eqtri_df_new$s

final_table <- bind_cols(circle, s)
colnames(final_table)[6]  <- "s"

compare <- select(.data = final_table, l, s)
longer <- filter(.data = final_table, l > s)
shorter <- filter(.data = final_table, l < s)
print(longer)
chords_longer <- print(nrow(longer))

ggplot(data = endpoint, aes(x = x1, y = y1)) +
  #ggplot(data = data_circle, aes(x = x0, y = y0)) +
  #geom_circle(data = data_circle, aes(x0 = x0, y0 = y0, r=r)) +
  geom_point() + 
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend), col = "red", lwd = 1.5) +
  geom_segment(data = longer , aes(x = x1, y = y1, xend = x2, yend = y2), col = "darkcyan") + 
  geom_segment(data = shorter , aes(x = x1, y = y1, xend = x2, yend = y2), col = "darkorange1") 
#+
 #  + 
 # geom_circle(data = data_circle, aes(x0 = x0, y0 = y0, r=r))

# Using Principle of Indifference
prob = chords_longer/n
print(prob)

# METHOD B (Random Radial Points) ----------------------------------------------
library(tidyverse)
library(ggforce)
library(ggplot2)
library(dplyr)

data_circle <- data.frame(x0 = 0,
                          y0 = 0,
                          r = 1)

ggplot(data = data_circle, aes(x = x0, y = y0)) + 
  geom_circle(data = data_circle, aes(x0 = x0, y0 = y0, r=r))

# how to randomise radius
n <- 200 # number of chords - can change this
theta_3 <- runif(n, 0, 2*pi)
endpoint <- tibble(
  x = cos(theta_3),
  x0 = 0 ,
  y = sin(theta_3),
  y0 = 0 )

eqtri_df <- tibble(
  x    = c(0, sqrt(3) / 2, -sqrt(3) / 2),
  y    = c(1, -0.5, -0.5),
  xend = c(sqrt(3) / 2, -sqrt(3) / 2, 0),
  yend = c(-0.5, -0.5, 1))

ggplot(data = endpoint, aes(x = x, y = y)) +
  # ggplot(data = data_circle, aes(x = x0, y = y0)) +
  # geom_circle(data = data_circle, aes(x0 = x0, y0 = y0, r=r)) +
  geom_point() + 
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend), col = "red", lwd = 1.5) 

radius <- mutate(.data = endpoint, r = sqrt((x- x0)^2 + (y - y0)^2))

# METHOD C (Random Midpoints) --------------------------------------------------
