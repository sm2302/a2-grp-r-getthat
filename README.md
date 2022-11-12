# Betrand's Paradox

The Bertrand paradox is generally presented as follows:

> Consider an equilateral triangle inscribed in a circle.
> Suppose a chord of the circle is chosen at random.
> What is the probability $p$ that the chord is longer than a side of the triangle?

![](plot.png)

Three different solutions are presented, each hinging on the method of generating the random chord:

- **METHOD A (random endpoints)**: Choose two random points on the circumference of the circle, and draw the chord joining them.

- **METHOD B (random radial points)**: Choose a random radius of the circle, and a random point on this radius, and draw the chord through this point and perpendicular to the radius.

- **METHOD C (random midpoints)**: Choose a point anywhere within the circle, and construct the chord such that the point chosen is the midpoint of the chord.

The three different methods above, all seemingly valid, yield different results for the probability in question! The exact answer can be worked out using geometric reasoning, but the goal of this assignment is to provide a visual and empirical way of calculating the probabilities.

## Instructions

> Objective: Show, using simulation and appropriate visualisations, that the three methods above yield different $p$ values.

As a group, you will write R code in a single .R script (named `solution.R`) that performs the intended solutions. This script should be able to be run without errors.

Consider the following points when writing your solutions:

- You are free to choose the format of your solutions (`print()`, `cat()`, data frames, tibbles, ggplots, writing functions, etc.)--but note that marks are awarded for clarity.

- Comment on your code to make its intention clearer (but don't go overboard!)

- You may split the task among yourselves however you wish, as long as there is a proportional effort from all team members.

- If you wish, you may present your solutions within GitHub (e.g. by appending a new section at the top of this README.md file and/or by using GitHub pages).

## Tips

This assignment assumes some basic knowledge of geometry and simple probability, including but not limited to

- The equation of a circle with radius $r$ centred at $x_0$ and $y_0$ is given by $(x-x_0)^2 + (y-y_0)^2 = r^2$ (assuming a cartesian system of coordinates $(x,y)$ ).

- Basic trigonometry angles such as $\sin \theta$ and $\cos \theta$ and Pythagoras theorem $a^2 + b^2 = c^2$.

- Calculating distance between two points in 2-D space (Euclidean distance).

- The principle of indifference: The probability $\Pr(A)$ of an event $A$ happening is given by the ratio of the number of favourable outcomes to the total number of outcomes in the sample space. That is, in a random experiment, suppose $n(S)$ denotes the total number of outcomes, and $n(A)$ denotes the number of outcomes involving $A$, then $$\Pr(A) = \frac{n(A)}{n(S)}.$$

In addition, you might find R's `runif()` function helpful for random number generation.

--------------------------------------------------------------------------------
# GetThat° 
 We are going to briefly explain our approaches for each methods.
 
 > REMINDER! Before running the codes, do not forget to run all of the `library()` placed at the top of the script. 
 
**Method A (random endpoints)** :
 
 - Firstly, we randomise angle $\theta$ in the circle using `runif()` function.. Then, determine both endpoints $(x1, y1)$ & $(x2, y2)$ of the random chords. These coordinates are then tabulated using tibbles. 
 - Using the coordinates, the length of the chords is calculated by the **Distance between 2 points** equation. 
 - The lengths obtained are then compared with the length of side of the equilateral triangle from the table.
 - We used the **Principle of Indifference** for this part. Hence, For this method, the Probability of the length of the chords longer than the sides of the equilateral triangle will be around $1/3$ or $0.3$.

**Method B (random radial points)**
- Firstly, we randomise angle $\theta$ and radius *P* of the circle using `runif()` function.
 *Q* is found using **Pythagoras Theorem** $a^2 + b^2 = c^2$.
 - Then, determine both endpoints $(x1, y1)$ & $(x2, y2)$ of the random chords. 
 This [link](https://www.stewartcalculus.com/data/CALCULUS%20Early%20Transcendentals/upfiles/RotationofAxes.pdf) will help in understanding how the x and y values are obtained. 
 - These coordinates are then tabulated using tibbles. 
 - Using the coordinates, the length of the chords is calculated by the **Distance between 2 points** equation. 
 - The lengths obtained are then compared with the length of side of the equilateral triangle from the table.
 - We used the **Principle of Indifference** for this part. Hence, for this method, the Probability of the length of the chords longer than the sides of the equilateral triangle will be around $1/2$ or $0.5$. 
 
**Method C (random midpoints)**
-- Firstly, we randomise angle $\theta$ and radius *V* of the circle using `runif()` function. *V1*...
 *U* is found using **Pythagoras Theorem** $a^2 + b^2 = c^2$.
 - Then, determine both endpoints $(x1, y1)$ & $(x2, y2)$ of the random chords. 
 This [link](https://www.stewartcalculus.com/data/CALCULUS%20Early%20Transcendentals/upfiles/RotationofAxes.pdf) will help in understanding how the x and y values are obtained. 
 - These coordinates are then tabulated using tibbles. 
 - Using the coordinates, the length of the chords is calculated by the **Distance between 2 points** equation. 
 - The lengths obtained are then compared with the length of side of the equilateral triangle from the table.
 - We used the **Principle of Indifference** for this part. Hence, for this method, the Probability of the length of the chords longer than the sides of the equilateral triangle will be around $1/4$ or $0.25$. 
 

--------------------------------------------------------------------------------
For each of the three methods above, we printed "P(l > s)", the value of the probability, as the output. It can be observed that all three methods have different probabilities, depending on how the chord is defined. The chords plotted in the circle are grouped into two; the **pink** chords represent chords that are **longer** than the side of the equilateral triangle, whereas the **blue** chords represent those that are **shorter**.














