library(tidyverse)
library(ggforce)
library(ggplot2)
library(dplyr)
 
# METHOD A (Random Endpoints) --------------------------------------------------
n <- 300 # number of chords - can be changed

theta_A1 <- runif(n, 0, 2*pi) # randomise angles
theta_A2 <- runif(n, 0, 2*pi) # randomise angles

# Coordinates of random endpoints
endpoint <- tibble(
  x1 = cos(theta_A1),
  y1 = sin(theta_A1),
  x2 = cos(theta_A2),
  y2 = sin(theta_A2))

# Coordinates of equilateral triangle
eqtri_df <- tibble(
  x    = c(0, sqrt(3) / 2, -sqrt(3) / 2),
  y    = c(1, -0.5, -0.5),
  xend = c(sqrt(3) / 2, -sqrt(3) / 2, 0),
  yend = c(-0.5, -0.5, 1))

# New data for length l of chords and length s of the equilateral triangle
circle <- mutate(.data = endpoint, l = sqrt((x2 - x1)^2 + (y2 - y1)^2)) 
eqtri_df_new <- mutate(.data = eqtri_df, s = sqrt((xend - x)^2 + (yend - y)^2)) 

final_eqtri_df_new <- slice(.data = eqtri_df_new, 1) # only need 1 row as reference

s <- final_eqtri_df_new$s

final_table <- bind_cols(circle, s)
colnames(final_table)[6]  <- "s"

# Comparing lengths l and s
compare <- select(.data = final_table, l, s)
longer <- filter(.data = final_table, l > s)
shorter <- filter(.data = final_table, l < s)
print(longer)
chords_longer <- print(nrow(longer))

# Plot
ggplot(data = endpoint, aes(x = x1, y = y1)) +
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray17", lwd = 1.2) +
  geom_point() + 
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend), col = "indianred2", lwd = 1.2) +
  geom_segment(data = longer , aes(x = x1, y = y1, xend = x2, yend = y2), col = "maroon2") + 
  geom_segment(data = shorter , aes(x = x1, y = y1, xend = x2, yend = y2), col = "steelblue4") +
  labs(title = "Bertrand's Paradox",
       subtitle = "Random Endpoints Method",
       x = "x", y = "y") +
  # move title and subtitle texts to the centre
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))

# Use Principal of Indifference to calculate probability, P of chord length, l
# being longer than a side of triangle, s
prob = chords_longer/n
# Print the probability as the output  
sprintf("P(l > s) = %f", prob)


# METHOD B (Random Radial Points) ----------------------------------------------
n <- 300 # number of chords - can be changed
r <- 1

theta_B <- runif(n, 0, 2*pi) # randomise angles
P <- runif(n,0,r) # randomise radius
Q <- sqrt(r^2-P^2) 

# Coordinates of random endpoints
endpoint <- tibble(
  x1 = P*cos(theta_B) + Q*sin(theta_B),
  y1 = P*sin(theta_B) - Q*cos(theta_B),
  x2 = P*cos(theta_B) - Q*sin(theta_B),
  y2 = P*sin(theta_B) + Q*cos(theta_B))

# Coordinates of equilateral triangle
eqtri_df <- tibble(
  x    = c(0, sqrt(3) / 2, -sqrt(3) / 2),
  y    = c(1, -0.5, -0.5),
  xend = c(sqrt(3) / 2, -sqrt(3) / 2, 0),
  yend = c(-0.5, -0.5, 1))

# New data for length l of chords and length s of the equilateral triangle
endpoint_new <- mutate(.data = endpoint, l = sqrt((x2-x1)^2+(y2-y1)^2))
eqtri_df_new <- mutate(.data = eqtri_df, s = sqrt((xend-x)^2+(yend-y)^2))

final_eqtri_df_new <- slice(.data = eqtri_df_new, 1) # only need 1 row as reference

s <- final_eqtri_df_new$s 

final_table <- bind_cols(endpoint_new, s)
colnames(final_table)[6]  <- "s"

# Comparing lengths l and s
compare <- select(.data = final_table, l, s)
longer <- filter(.data = final_table, l > s)
shorter <- filter(.data = final_table, l < s)
print(longer) 
chords_longer <- print(nrow(longer))

# Plot 
ggplot() +
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray17", lwd = 1.2) +
  geom_segment(data = endpoint, aes(x = x1, y = y1,xend = x2, yend = y2)) + 
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend), col = "indianred2", lwd = 1.2) +
  geom_segment(data = longer , aes(x = x1, y = y1, xend = x2, yend = y2), col = "maroon2") + 
  geom_segment(data = shorter , aes(x = x1, y = y1, xend = x2, yend = y2), col = "steelblue4") +
  labs(title = "Bertrand's Paradox",
       subtitle = "Random Radial Points Method",
       x = "x", y = "y") +
  # move title and subtitle texts to the centre
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))

# Use Principal of Indifference to calculate probability, P of chord length, l
# being longer than a side of triangle, s
prob = chords_longer/n
# Print the probability as the output  
sprintf("P(l > s) = %f", prob)


# METHOD C (Random Midpoints) --------------------------------------------------
n <- 300 # number of chords - can be changed
r <- 1

theta_C <- runif(n, 0, 2*pi) # randomise angles
V <- runif(n, 0, 1) 
V1 <- sqrt(V)
U <- sqrt(r^2 - V1^2)

# Coordinates of random endpoints
end_point <- tibble(
  x1 = V1*cos(theta_C) + U*sin(theta_C),
  y1 = V1*sin(theta_C) - U*cos(theta_C),
  x2 = V1*cos(theta_C) - U*sin(theta_C),
  y2 = V1*sin(theta_C) + U*cos(theta_C))

# Coordinates of equilateral triangle
eqtri_df <- tibble(
  x    = c(0, sqrt(3) / 2, -sqrt(3) / 2),
  y    = c(1, -0.5, -0.5),
  xend = c(sqrt(3) / 2, -sqrt(3) / 2, 0),
  yend = c(-0.5, -0.5, 1))

# New data for length l of chords and length s of the equilateral triangle
end_point_new <- mutate(.data = end_point, l = sqrt((x2 - x1)^2 + (y2 - y1)^2))
eqtri_df_new <- mutate(.data = eqtri_df, s = sqrt((xend - x)^2 + (yend - y)^2))

final_eqtri_df_new <- slice(.data = eqtri_df_new, 1) # only need 1 row as reference

s <- final_eqtri_df_new$s

final_table <- bind_cols(end_point_new, s)
colnames(final_table)[6]  <- "s"

# Comparing lengths l and s
compare <- select(.data = final_table, l, s)
longer <- filter(.data = final_table, l > s)
shorter <- filter(.data = final_table, l < s)
print(longer)
chords_longer <- print(nrow(longer))

# Plot 
ggplot() +
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray17", lwd = 1.2 ) +
  geom_segment(data = end_point, aes(x = x1, y = y1, xend = x2, yend = y2)) +
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend), col = "indianred2", lwd = 1.2) +
  geom_segment(data = longer , aes(x = x1, y = y1, xend = x2, yend = y2), col = "maroon2") + 
  geom_segment(data = shorter , aes(x = x1, y = y1, xend = x2, yend = y2), col = "steelblue4") +
  labs(title = "Bertrand's Paradox",
       subtitle = "Random Midpoints Method",
       x = "x", y = "y") +
  # move title and subtitle texts to the centre
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))

# Use Principal of Indifference to calculate probability, P of chord length, l
# being longer than a side of triangle, s
prob = chords_longer/n
# Print the probability as the output  
sprintf("P(l > s) = %f", prob)
