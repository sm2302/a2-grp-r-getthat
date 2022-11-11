# Instruction to students: You may clear the code in this file and replace it
# with your own.

library(tidyverse)
library(ggforce)
library(ggplot2)
library(dplyr)
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
n <- 200 # number of chords - can be changed

theta_A1 <- runif(n, 0, 2*pi)
theta_A2 <- runif(n, 0, 2*pi)
endpoint <- tibble(
  x1 = cos(theta_A1),
  y1 = sin(theta_A1),
  x2 = cos(theta_A2),
  y2 = sin(theta_A2))

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
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray17") +
  geom_point() + 
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend), col = "khaki3", lwd = 1.5) +
  geom_segment(data = longer , aes(x = x1, y = y1, xend = x2, yend = y2), col = "darkcyan") + 
  geom_segment(data = shorter , aes(x = x1, y = y1, xend = x2, yend = y2), col = "darkorange1") 

# Using Principle of Indifference
prob = chords_longer/n
print(prob)


# METHOD B (Random Radial Points) ----------------------------------------------
n <- 150 # number of chords - can be changed
r <- 1

theta_B <- runif(n, 0, 2*pi) # runif to randomise angles
P <- runif(n,0,r) # runif to randomise radius
Q <- sqrt(r^2-P^2) 

# coordinates of random radial points
endpoint <- tibble(
  x1 = P*cos(theta_B)+ Q*sin(theta_B),
  y1 = P*sin(theta_B)- Q*cos(theta_B),
  x2 = P*cos(theta_B)- Q*sin(theta_B),
  y2 = P*sin(theta_B)+ Q*cos(theta_B))

# coordinates of equilateral triangle
eqtri_df <- tibble(
  x    = c(0, sqrt(3) / 2, -sqrt(3) / 2),
  y    = c(1, -0.5, -0.5),
  xend = c(sqrt(3) / 2, -sqrt(3) / 2, 0),
  yend = c(-0.5, -0.5, 1))

# new data for any random chord l and size s of triangle's lengths
endpoint_new <- mutate(.data = endpoint, l = sqrt((x2-x1)^2+(y2-y1)^2))
eqtri_df_new <- mutate(.data = eqtri_df, s = sqrt((xend-x)^2+(yend-y)^2))


final_eqtri_df_new <- slice(.data = eqtri_df_new, 1) # only need 1 row as reference

s <- final_eqtri_df_new$s # rename as s

final_table <- bind_cols(endpoint_new, s)
colnames(final_table)[6]  <- "s"

# Comparing lengths l and s
compare <- select(.data = final_table, l, s)
longer <- filter(.data = final_table, l > s)
shorter <- filter(.data = final_table, l < s)
print(longer) # only printing chords longer than side s of equilateral triangle
chords_longer <- print(nrow(longer))

# Plot triangle and chords
ggplot() +
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray17") +
  geom_segment(data = endpoint, aes(x = x1, y = y1,xend = x2, yend = y2)) + 
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend), col = "khaki3", lwd = 1.5) +
  geom_segment(data = longer , aes(x = x1, y = y1, xend = x2, yend = y2), col = "darkcyan") + 
  geom_segment(data = shorter , aes(x = x1, y = y1, xend = x2, yend = y2), col = "darkorange1") 

# Using Principle of Indifference to calculate probability
prob = chords_longer/n
print(prob)

# METHOD C (Random Midpoints) --------------------------------------------------
n <- 300 # number of chords - can be changed
r <- 1

theta_C <- runif(n, 0, 2*pi) # randomise angles
V <- runif(n, 0, 1) 
V1 <- sqrt(V)
U <- sqrt(r^2 - V1^2)

end_point <- tibble(
  x1 = V1*cos(theta_C) + U*sin(theta_C),
  y1 = V1*sin(theta_C) - U*cos(theta_C),
  x2 = V1*cos(theta_C) - U*sin(theta_C),
  y2 = V1*sin(theta_C) + U*cos(theta_C))

eqtri_df <- tibble(
  x    = c(0, sqrt(3) / 2, -sqrt(3) / 2),
  y    = c(1, -0.5, -0.5),
  xend = c(sqrt(3) / 2, -sqrt(3) / 2, 0),
  yend = c(-0.5, -0.5, 1))

end_point_new <- mutate(.data = end_point, l = sqrt((x2 - x1)^2 + (y2 - y1)^2))
eqtri_df_new <- mutate(.data = eqtri_df, s = sqrt((xend - x)^2 + (yend - y)^2))

final_eqtri_df_new <- slice(.data = eqtri_df_new, 1) # only need 1 row as reference

s <- final_eqtri_df_new$s

final_table <- bind_cols(end_point_new, s)
colnames(final_table)[6]  <- "s"

compare <- select(.data = final_table, l, s)
longer <- filter(.data = final_table, l > s)
shorter <- filter(.data = final_table, l < s)
print(longer)
chords_longer <- print(nrow(longer))

# Plot 
ggplot() +
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray17") +
  geom_segment(data = end_point, aes(x = x1, y = y1, xend = x2, yend = y2)) +
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend), col = "grey10", lwd = 1.5) +
  geom_segment(data = longer , aes(x = x1, y = y1, xend = x2, yend = y2), col = "steelblue3") + 
  geom_segment(data = shorter , aes(x = x1, y = y1, xend = x2, yend = y2), col = "lightgoldenrod") 

# Calculate probability 
prob = chords_longer/n
print(prob)





