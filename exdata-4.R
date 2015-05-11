###UNSURE WHY THE BREAK IS HERE 

plot(cars, sub = "My Plot Subtitle")

#| The plot help page (?plot) only covers a small
#| number of the many arguments that can be passed
#| in to plot() and to other graphical functions.
#| To begin to explore the many other options, look
#| at ?par. Let's look at some of the more commonly
#| used ones. Continue using plot(cars, ...) as the
#| base answer to these questions.

#| Plot cars with a red color. (Use col = 2 to
#| achieve this effect.)

plot(cars,col=2)

#| Plot cars while limiting the x-axis to 10
#| through 15.  (Use xlim = c(10, 15) to achieve
#| this effect.)

plot(cars,xlim=c(10,15))

#| You can also change the shape of the symbols in
#| the plot. The help page for points (?points)
#| provides the details.

#| Plot cars using triangles.  (Use pch = 2 to
#| achieve this effect.)

plot(cars,pch=2)

#| Arguments like "col" and "pch" may not seem very
#| intuitive. And that is because they aren't! So,
#| many/most people use more modern packages, like
#| ggplot2, for creating their graphics in R.

#| It is, however, useful to have an introduction
#| to base graphics because many of the idioms in
#| lattice and ggplot2 are modeled on them.

#| Let's now look at some other functions in base
#| graphics that may be useful, starting with
#| boxplots.

data(mtcars)

#| Anytime that you load up a new data frame, you
#| should explore it before using it. In the middle
#| of a swirl lesson, just type play(). This
#| temporarily suspends the lesson (without losing
#| the work you have already done) and allows you
#| to issue commands like dim(mtcares) and
#| head(mtcars). Once you are done examining the
#| data, just type nxt() and the lesson will pick
#| up where it left off.

dim(mtcars)
str(mtcars)

?boxplot

## S3 method for class 'formula'
#boxplot(formula, data = NULL, ..., subset, na.action = NULL)

## Default S3 method:
#boxplot(x, ..., range = 1.5, width = NULL, varwidth = FALSE,
#        notch = FALSE, outline = TRUE, names, plot = TRUE,
#        border = par("fg"), col = NULL, log = "",
#        pars = list(boxwex = 0.8, staplewex = 0.5, outwex = 0.5),
#        horizontal = FALSE, add = FALSE, at = NULL)

#| Instead of adding data columns directly as input
#| arguments, as we did with plot(), it is often
#| handy to pass in the entire data frame. This is
#| what the "data" argument in boxplot() allows.

#| boxplot(), like many R functions, also takes a
#| "formula" argument, generally an expression with
#| a tilde ("~") which indicates the relationship
#| between the input variables. This allows you to
#| enter something like mpg ~ cyl to plot the
#| relationship between cyl (number of cylinders)
#| on the x-axis and mpg (miles per gallon) on the
#| y-axis.

#| Use boxplot() with formula = mpg ~ cyl and data
#| = mtcars to create a box plot.

boxplot(formula=mpg~cyl,data=mtcars)

#| The plot shows that mpg is much lower for cars
#| with more cylinders. Note that we can use the
#| same set of arguments that we explored with
#| plot() above to add axis labels, titles and so
#| on.

#| When looking at a single variable, histograms
#| are a useful tool. hist() is the associated R
#| function. Like plot(), hist() is best used by
#| just passing in a single vector.

#| Use hist() with the vector mtcars$mpg to create
#| a histogram.

hist(mtcars$mpg)

#| In this lesson, you learned how to work with
#| base graphics in R. The best place to go from
#| here is to study the ggplot2 package. If you
#| want to explore other elements of base graphics,
#| then this web page
#| (http://www.ling.upenn.edu/~joseff/rstudy/week4.html)
#| provides a useful overview.




