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

n <- 1000 #number of chords - can change this

theta_1 <- runif(n, 0, 2*pi)
endpoint_1 <- tibble(
  x0 = cos(theta_1),
  y0 = sin(theta_1))

theta_2 <- runif(n, 0, 2*pi)
endpoint_2 <- tibble(
  x1 = cos(theta_2),
  y1 = sin(theta_2))

circle <- bind_cols(endpoint_1, endpoint_2)

eqtri_df <- tibble(
  x    = c(0, sqrt(3) / 2, -sqrt(3) / 2),
  y    = c(1, -0.5, -0.5),
  xend = c(sqrt(3) / 2, -sqrt(3) / 2, 0),
  yend = c(-0.5, -0.5, 1))

ggplot(data = circle, mapping = aes(x = x0, y = y0)) +
  geom_point() + 
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend), color = "red") 

  #+ geom_segment(data = circle, aes(x0 = x0, y0 = y0, x1= x1, y1 = y1)) +
  #coord_equal()

circle_new <- mutate(.data = circle, l = sqrt((x1 - x0)^2 + (y1 - y0)^2)) # add new column l

eqtri_df_new <- mutate(.data = eqtri_df, s = sqrt((xend - x)^2 + (yend - y)^2)) # add new column s

final_eqtri_df_new <- slice(.data = eqtri_df_new, 1)

s <- last_col_eqtri_df_new <- final_eqtri_df_new$s

final_table <- bind_cols(circle_new, s)
colnames(final_table)[6]  <- "s"

compare <- select(.data = final_table, l, s)
result <- filter(.data = compare, l > s)
print(result)
print(nrow(result))

#ggplot(data = circle, mapping = aes(x = x0, y = y0)) +
 # geom_point() + 
#  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend), color = "red") 
 #+ geom_segment(data = circle, aes(x0 = x0, y0 = y0, x1= x1, y1 = y1)) +
 #coord_equal()

# Using Principle of Indifference
prob = nrow(result)/n
print(prob)

# 1. Select the random endpoints directly from the dataframe
circle[1:2,]

# 2. Transform tibble to matrix
make_matrix <- function(df,rownames = NULL){
  my_matrix <-  as.matrix(df)
  if(!is.null(rownames))
    rownames(my_matrix) = rownames
  my_matrix
}

make_matrix(circle, rownames = NULL)



# METHOD B (Random Radial Points) ----------------------------------------------



# METHOD C (Random Midpoints) --------------------------------------------------
