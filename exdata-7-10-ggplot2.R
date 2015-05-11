# Swirl Lecture 8: GGPlot2 Part1 

#| GGPlot2_Part1. (Slides for this and other Data
#| Science courses may be found at github
#| https://github.com/DataScienceSpecialization/courses/.
#| If you care to use them, they must be downloaded as a
#| zip file and viewed locally. This lesson corresponds
#| to 04_ExploratoryAnalysis/ggplot2.)

#| The ggplot2 package is an add-on package available
#| from CRAN via install.packages(). (Don't worry, we've
#| installed it for you already.) It is an
#| implementation of The Grammar of Graphics, an
#| abstract concept (as well as book) authored and
#| invented by Leland Wilkinson and implemented by
#| Hadley Wickham while he was a graduate student at
#| Iowa State. The web site http://ggplot2.org provides
#| complete documentation.

#| A grammar of graphics represents an abstraction of
#| graphics, that is, a theory of graphics which
#| conceptualizes basic pieces from which you can build
#| new graphics and graphical objects. The goal of the
#| grammar is to “Shorten the distance from mind to
#| page”. From Hadley Wickham's book we learn that

#| The ggplot2 package "is composed of a set of
#| independent components that can be composed in many
#| different ways. ... you can create new graphics that
#| are precisely tailored for your problem." These
#| components include aesthetics which are attributes
#| such as colour, shape, and size, and geometric
#| objects or geoms such as points, lines, and bars.

#| Before we delve into details, let's review the other
#| 2 plotting systems.
####In base system cannot easily go back and replace typos 
####In Lattice, cannot add to plot once it is created 

#| If we told you that ggplot2 combines the best of base
#| and lattice, that would mean it ...?

#1: Automatically deals with spacings, text, titles but also allows you to annotate
####2: All of the others
#3: Its default mode makes many choices for you (but you can customize!)
#4: Like lattice it allows for multipanels but more easily and intuitively

#| Yes, ggplot2 combines the best of base and lattice.
#| It allows for multipanel (conditioning) plots (as
#| lattice does) but also post facto annotation (as base
#| does), so you can add titles and labels. It uses the
#| low-level grid package (which comes with R) to draw
#| the graphics. As part of its grammar philosophy,
#| ggplot2 plots are composed of aesthetics (attributes
#| such as size, shape, color) and geoms (points, lines,
#| and bars), the geometric objects you see on the plot.

#| The ggplot2 package has 2 workhorse functions. The
#| more basic workhorse function is qplot, (think quick
#| plot), which works like the plot function in the base
#| graphics system. It can produce many types of plots
#| (scatter, histograms, box and whisker) while hiding
#| tedious details from the user. Similar to lattice
#| functions, it looks for data in a data frame or
#| parent environment.

#| The more advanced workhorse function in the package
#| is ggplot, which is more flexible and can be
#| customized for doing things qplot cannot do. In this
#| lesson we'll focus on qplot.

#| We'll start by showing how easy and versatile qplot
#| is. First, let's look at some data which comes with
#| the ggplot2 package. The mpg data frame contains fuel
#| economy data for 38 models of cars manufactured in
#| 1999 and 2008. Run the R command str with the
#| argument mpg. This will give you an idea of what mpg
#| contains.

str(mpg)
#'data.frame':	234 obs. of  11 variables:
# $ manufacturer: Factor w/ 15 levels "audi","chevrolet",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ model       : Factor w/ 38 levels "4runner 4wd",..: 2 2 2 2 2 2 2 3 3 3 ...
# $ displ       : num  1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
# $ year        : int  1999 1999 2008 2008 1999 1999 2008 1999 1999 2008 ...
# $ cyl         : int  4 4 4 4 6 6 6 4 4 4 ...
# $ trans       : Factor w/ 10 levels "auto(av)","auto(l3)",..: 4 9 10 1 4 9 1 9 4 10 ...
# $ drv         : Factor w/ 3 levels "4","f","r": 2 2 2 2 2 2 2 1 1 1 ...
# $ cty         : int  18 21 20 21 16 18 18 18 16 20 ...
# $ hwy         : int  29 29 31 30 26 26 27 26 25 28 ...
# $ fl          : Factor w/ 5 levels "c","d","e","p",..: 4 4 4 4 4 4 4 4 4 4 ...
# $ class       : Factor w/ 7 levels "2seater","compact",..: 2 2 2 2 2 2 2 2 2 2 ...

#| We see that there are 234 points in the dataset
#| concerning 11 different characteristics of the cars.
#| Suppose we want to see if there's a correlation
#| between engine displacement (displ) and highway miles
#| per gallon (hwy). As we did with the plot function of
#| the base system we could simply call qplot with 3
#| arguments, the first two are the variables we want to
#| examine and the third argument data is set equal to
#| the name of the dataset which contains them (in this
#| case, mpg). Try this now.

qplot(displ,hwy,data=mpg)

#| A nice scatterplot done simply, right? All the labels
#| are provided. The first argument is shown along the
#| x-axis and the second along the y-axis. The negative
#| trend (increasing displacement and lower gas mileage)
#| is pretty clear. Now suppose we want to do the same
#| plot but this time use different colors to
#| distinguish between the 3 factors (subsets) of
#| different types of drive (drv) in the data
#| (front-wheel, rear-wheel, and 4-wheel). Again, qplot
#| makes this very easy. We'll just add what ggplot2
#| calls an aesthetic, a fourth argument, color, and set
#| it equal to drv. Try this now. (Use the up arrow key
#| to save some typing.)

qplot(displ,hwy,data=mpg,color=drv)

#| Pretty cool, right? See the legend to the right which
#| qplot helpfully supplied? The colors were
#| automatically assigned by qplot so the legend decodes
#| the colors for you. Notice that qplot automatically
#| used dots or points to indicate the data. These
#| points are geoms (geometric objects). We could have
#| used a different aesthetic, for instance shape
#| instead of color, to distinguish between the drive
#| types.

qplot(displ,hwy,data=mpg,color=drv,geom=c("point","smooth"))

#geom_smooth: method="auto" and size of largest group is# <1000, so using loess. Use 'method = x' to change the #smoothing method.

#| Note the helpful message R returns in red telling you
#| what function (loess) it used to create the trend
#| lines. No need to worry - we'll see another example
#| of method in another (Extras) lesson. Notice the gray
#| areas surrounding each trend lines. These indicate
#| the 95% confidence intervals for the lines

#| Before we leave qplot's scatterplotting ability, call
#| qplot again, this time with 3 arguments. The first is
#| y set equal to hwy, the second is data set equal to
#| mpg, and the third is color set equal to drv. Try
#| this now.

qplot(y=hwy,data=mpg,color=drv)

#| What's this plot showing? We see the x-axis ranges
#| from 0 to 250 and we remember that we had 234 data
#| points in our set, so we can infer that each point in
#| the plot represents one of the hwy values (indicated
#| by the y-axis). We've created the vector myhigh for
#| you which contains the hwy data from the mpg dataset.
#| Look at myhigh now.

myhigh
#  [1] 29 29 31 30 26 26 27 26 25 28 27 25 25 25 25 24 25
# [18] 23 20 15 20 17 17 26 23 26 25 24 19 14 15 17 27 30
# [35] 26 29 26 24 24 22 22 24 24 17 22 21 23 23 19 18 17
# [52] 17 19 19 12 17 15 17 17 12 17 16 18 15 16 12 17 17
# [69] 16 12 15 16 17 15 17 17 18 17 19 17 19 19 17 17 17
# [86] 16 16 17 15 17 26 25 26 24 21 22 23 22 20 33 32 32
#[103] 29 32 34 36 36 29 26 27 30 31 26 26 28 26 29 28 27
#[120] 24 24 24 22 19 20 17 12 19 18 14 15 18 18 15 17 16
#[137] 18 17 19 19 17 29 27 31 32 27 26 26 25 25 17 17 20
#[154] 18 26 26 27 28 25 25 24 27 25 26 23 26 26 26 26 25
#[171] 27 25 27 20 20 19 17 20 17 29 27 31 31 26 26 28 27
#[188] 29 31 31 26 26 27 30 33 35 37 35 15 18 20 20 22 17
#[205] 19 18 20 29 26 29 29 24 44 29 26 29 29 29 29 23 24
#[222] 44 41 29 26 28 29 29 29 28 29 26 26 26

#| Comparing the values of myhigh with the plot, we see
#| the first entries in the vector (29, 29, 31, 30,...)
#| correspond to the leftmost points in the the plot (in
#| order), and the last entries in myhigh (28, 29, 26,
#| 26, 26) correspond to the rightmost plotted points.
#| So, specifying the y parameter only, without an x
#| argument, plots the values of the y argument in the
#| order in which they occur in the data.

#| The all-purpose qplot can also create box and whisker
#| plots.  Call qplot now with 4 arguments. First
#| specify the variable by which you'll split the data,
#| in this case drv, then specify the variable which you
#| want to examine, in this case hwy. The third argument
#| is data (set equal to mpg), and the fourth, the geom,
#| set equal to the string "boxplot"

qplot(drv,hwy,data=mpg,geom="boxplot")

#| We see 3 boxes, one for each drive. Now to impress
#| you, call qplot with 5 arguments. The first 4 are
#| just as you used previously, (drv, hwy, data set
#| equal to mpg, and geom set equal to the string
#| "boxplot"). Now add a fifth argument, color, equal to
#| manufacturer.

qplot(drv,hwy,data=mpg,geom="boxplot",color=manufacturer)

#| It's a little squished but we just wanted to
#| illustrate qplot's capabilities. Notice that there
#| are still 3 regions of the plot (determined by the
#| factor drv). Each is subdivided into several boxes
#| depicting different manufacturers.

#| Now, on to histograms. These display frequency counts
#| for a single variable. Let's start with an easy one.
#| Call qplot with 3 arguments. First specify the
#| variable for which you want the frequency count, in
#| this case hwy, then specify the data (set equal to
#| mpg), and finally, the aesthetic, fill, set equal to
#| drv. Instead of a plain old histogram, this will
#| again use colors to distinguish the 3 different drive
#| factors.

#| See how qplot consistently uses the colors. Red (if
#| 4-wheel drv is in the bin) is at the bottom of the
#| bin, then green on top of it (if present), followed
#| by blue (rear wheel drv). The color lets us see right
#| away that 4-wheel drive vehicles in this dataset
#| don't have gas mileages exceeding 30 miles per
#| gallon.

#| It's cool that qplot can do this so easily, but some
#| people may find this multi-color histogram hard to
#| interpret. Instead of using colors to distinguish
#| between the drive factors let's use facets or panels.
#| (That's what lattice called them.) This just means
#| we'll split the data into 3 subsets (according to
#| drive) and make 3 smaller individual plots of each
#| subset in one plot (and with one call to qplot).

#| Remember that with base plot we had to do each
#| subplot individually. The lattice system made
#| plotting conditioning plots easier. Let's see how
#| easy it is with qplot.

#| We'll do two plots, a scatterplot and then a
#| histogram, each with 3 facets. For the scatterplot,
#| call qplot with 4 arguments. The first two are displ
#| and hwy and the third is the argument data set equal
#| to mpg. The fourth is the argument facets which will
#| be set equal to the expression . ~ drv which is
#| ggplot2's shorthand for number of rows (to the left
#| of the ~) and number of columns (to the right of the
#| ~). Here the . indicates a single row and drv implies
#| 3, since there are 3 distinct drive factors. Try this
#| now.

#| The result is a 1 by 3 array of plots. Note how each
#| is labeled at the top with the factor label (4,f, or
#| r). This shows us more detailed information than the
#| histogram. We see the relationship between
#| displacement and highway mileage for each of the 3
#| drive factors.

qplot(hwy,data=mpg,facets=drv~.,binwidth=2)

#| The facets argument, drv ~ ., resulted in what
#| arrangement of facets --> 3 by 1 

#### END OF LECTURE 






# SWIRL Exploratory Data Analysis
# 9: GGPlot2 Part2

#| GGPlot2_Part2. (Slides for this and other Data
#| Science courses may be found at github
#| https://github.com/DataScienceSpecialization/courses/.
#| If you care to use them, they must be downloaded as a
#| zip file and viewed locally. This lesson corresponds
#| to 04_ExploratoryAnalysis/ggplot2.)

#| In a previous lesson we showed you the vast
#| capabilities of qplot, the basic workhorse function
#| of the ggplot2 package. In this lesson we'll focus on
#| some fundamental components of the package. These
#| underlie qplot which uses default values when it
#| calls them. If you understand these building blocks,
#| you will be better able to customize your plots.
#| We'll use the second workhorse function in the
#| package, ggplot, as well as other graphing functions.

#| A "grammar" of graphics means that ggplot2 contains
#| building blocks with which you can create your own
#| graphical objects. What are these basic components of
#| ggplot2 plots? There are 7 of them.

#| Obviously, there's a DATA FRAME which contains the
#| data you're trying to plot. Then the AESTHETIC
#| MAPPINGS determine how data are mapped to color,
#| size, etc. The GEOMS (geometric objects) are what you
#| see in the plot (points, lines, shapes) and FACETS
#| are the panels used in conditional plots. You've used
#| these or seen them used in the first ggplot2 (qplot)
#| lesson.

#| There are 3 more. STATS are statistical
#| transformations such as binning, quantiles, and
#| smoothing which ggplot2 applies to the data. SCALES
#| show what coding an aesthetic map uses (for example,
#| male = red, female = blue). Finally, the plots are
#| depicted on a COORDINATE SYSTEM. When you use qplot
#| these were taken care of for you.

#| Plots are built up in LAYERS ... As in the base plotting system (and in contrast to
#| the lattice system), when building plots with
#| ggplot2, the plots are built up in layers, maybe in
#| several steps. You can plot the data, then overlay a
#| summary (for instance, a regression line or smoother)
#| and then add any metadata and annotations you need.

#| We'll keep using the mpg data that comes with the
#| ggplot2 package. Recall the versatility of qplot.
#| Just as a refresher, call qplot now with 6 arguments.
#| The first 3 deal with data - displ, hwy, and
#| data=mpg. The fourth is geom set equal to the
#| concatenation of the two strings, "point" and
#| "smooth". The fifth is facets set equal to the
#| formula .~drv, and the final argument is method set
#| equal to the string "loess". Try this now.

qplot(displ, hwy, data = mpg, geom=c("point", "smooth"),facets=.~drv,method="loess")

#| We see a 3 facet plot, one for each drive type (4,
#| f, and r). The method argument specified the
#| smoothing function (loess) we wanted to use to draw
#| trend lines through the data. (We did this to avoid
#| getting a warning message from R.) Now we'll see how
#| ggplot works. We'll build up a similar plot using
#| the basic components of the package. We'll do this
#| in a series of steps.

#| First we'll create a variable g by assigning to it
#| the output of a call to ggplot with 2 arguments. The
#| first is mpg (our dataset) and the second will tell
#| ggplot what we want to plot, in this case, displ and
#| hwy. These are what we want our aesthetics to
#| represent so we enclose these as two arguments to
#| the function aes. Try this now.

g <- ggplot(mpg,aes(displ,hwy))

#| Notice that nothing happened? As in the lattice
#| system, ggplot created a graphical object which we
#| assigned to the variable g.

summary(g)
#data: manufacturer, model, displ, year, cyl,
#  trans, drv, cty, hwy, fl, class [234x11]
#mapping:  x = displ, y = hwy
#faceting: facet_null() 

#| So g contains the mpg data with all its named
#| components in a 234 by 11 matrix. It also contains a
#| mapping, x (displ) and y (hwy) which you specified,
#| and no faceting.

#| Note that if you tried to print g with the
#| expressions g or print(g) you'd get an error! Even
#| though it's a great package, ggplot doesn't know how
#| to display the data yet since you didn't specify how
#| you wanted to see it. Now type g+geom_point() and
#| see what happens.

g+geom_point()

#| By calling the function geom_point you added a
#| layer. By not assigning the expression to a variable
#| you displayed a plot. Notice that you didn't have to
#| pass any arguments to the function geom_point.
#| That's because the object g has all the data stored
#| in it. (Remember you saw that when you ran summary
#| on g before.) Now use the expression you just typed
#| (g + geom_point()) and add to it another layer, a
#| call to geom_smooth(). Notice the red message R
#| gives you.

g+geom_point()+geom_smooth()

#| R is telling you that it used the smoothing function
#| loess to display the trend of the data. The gray
#| shadow around the blue line is the confidence band.
#| See how wide it is at the right? Let's try a
#| different smoothing function. Use the up arrow to
#| recover the expression you just typed, and instead
#| of calling geom_smooth with no arguments, call it
#| with the argument method set equal to the string
#| "lm".

g+geom_point()+geom_smooth(method="lm")

#| By changing the smoothing function to "lm" (linear
#| model) ggplot2 generated a regression line through
#| the data. Now recall the expression you just used
#| and add to it another call, this time to the
#| function facet_grid. Use the formula . ~ drv as it
#| argument. Note that this is the same type of formula
#| used in the calls to qplot.

g+geom_point()+geom_smooth(method="lm") + facet_grid(.~drv)

#| Notice how each panel is labeled with the
#| appropriate factor. All the data associated with
#| 4-wheel drive cars is in the leftmost panel,
#| front-wheel drive data is shown in the middle panel,
#| and rear-wheel drive data in the rightmost. Notice
#| that this is similar to the plot you created at the
#| start of the lesson using qplot. (We used a
#| different smoothing function than previously.)

#| So far you've just used the default labels that
#| ggplot provides. You can add your own annotation
#| using functions such as xlab(), ylab(), and
#| ggtitle(). In addition, the function labs() is more
#| general and can be used to label either or both axes
#| as well as provide a title. Now recall the
#| expression you just typed and add a call to the
#| function ggtitle with the argument "Swirl Rules!".

g+geom_point()+geom_smooth(method="lm"),+facet_grid(.~drv)+ggtitle("Swirl Rules!")

#| Now that you've seen the basics we'll talk about
#| customizing. Each of the “geom” functions (e.g.,
#| _point and _smooth) has options to modify it. Also,
#| the function theme() can be used to modify aspects
#| of the entire plot, e.g. the position of the legend.
#| Two standard appearance themes are included in
#| ggplot. These are theme_gray() which is the default
#| theme (gray background with white grid lines) and
#| theme_bw() which is a plainer (black and white)
#| color scheme.

#| Let's practice modifying aesthetics now. We'll use
#| the graphic object g that we already filled with mpg
#| data and add a call to the function geom_point, but
#| this time we'll give geom_point 3 arguments. Set the
#| argument color equal to "pink", the argument size to
#| 4, and the argument alpha to 1/2. Notice that all
#| the arguments are set equal to constants.

g+geom_point(color="pink",size=4,alpha=1/2)

#| Notice the different shades of pink? That's the
#| result of the alpha aesthetic which you set to 1/2.
#| This aesthetic tells ggplot how transparent the
#| points should be. Darker circles indicate values hit
#| by multiple data points.

#| Now we'll modify the aesthetics so that color
#| indicates which drv type each point represents.
#| Again, use g and add to it a call to the function
#| geom_point with 3 arguments. The first is size set
#| equal to 4, the second is alpha equal to 1/2. The
#| third is a call to the function aes with the
#| argument color set equal to drv. Note that you MUST
#| use the function aes since the color of the points
#| is data dependent and not a constant as it was in
#| the previous example.

g+geom_point(size=4,alpha=1/2,aes(color=drv))

#| Notice the helpful legend on the right decoding the
#| relationship between color and drv.

#| Now we'll practice modifying labels. Again, we'll
#| use g and add to it calls to 3 functions. First, add
#| a call to geom_point with an argument making the
#| color dependent on the drv type (as we did in the
#| previous example). Second, add a call to the
#| function labs with the argument title set equal to
#| "Swirl Rules!". Finally, add a call to labs with 2
#| arguments, one setting x equal to "Displacement" and
#| the other setting y equal to "Hwy Mileage".

g+geom_point(aes(color=drv))+labs(title="Swirl Rules!")+labs(x="Displacement", y="Hwy Mileage")

#| Note that you could have combined the two calls to
#| the function labs in the previous example. Now we'll
#| practice customizing the geom_smooth calls. Use g
#| and add to it a call to geom_point setting the color
#| to drv type (remember to use the call to the aes
#| function), size set to 2 and alpha to 1/2. Then add
#| a call to geom_smooth with 4 arguments. Set size
#| equal to 4, linetype to 3, method to "lm", and se to
#| FALSE.

g+geom_point(aes(color=drv),size=2,alpha=1/2)+geom_smooth(size=4,linetype=3,method="lm",se=FALSE)

#| What did these arguments do? The method specified a
#| linear regression (note the negative slope
#| indicating that the bigger the displacement the
#| lower the gas mileage), the linetype specified that
#| it should be dashed (not continuous), the size made
#| the dashes big, and the se flag told ggplot to turn
#| off the gray shadows indicating standard errors
#| (confidence intervals).

#| Finally, let's do a simple plot using the black and
#| white theme, theme_bw. Specify g and add a call to
#| the function geom_point with the argument setting
#| the color to the drv type. Then add a call to the
#| function theme_bw with the argument base_family set
#| equal to "Times". See if you notice the difference.

g+geom_point(aes(color=drv))+theme_bw(base_family="Times")

#| No more gray background! Also, if you have good
#| eyesight, you'll notice that the font in the labels
#| changed.

#| One final note before we go through a more
#| complicated, layered ggplot example, and this
#| concerns the limits of the axes. We're pointing this
#| out to emphasize a subtle difference between ggplot
#| and the base plotting function plot.

#| We've created some random x and y data, called myx
#| and myy, components of a dataframe called testdat.
#| These represent 100 random normal points, except
#| halfway through, we made one of the points be an
#| outlier. That is, we set its y-value to be out of
#| range of the other points. Use the base plotting
#| function plot to create a line plot of this data.
#| Call it with 4 arguments - myx, myy, type="l", and
#| ylim=c(-3,3). The type="l" tells plot you want to
#| display the data as a line instead of as a
#| scatterplot.

#warning messages from top-level task callback 'mini'
#There were 40 warnings (use warnings() to see them)

plot(myx, myy, type = "l", ylim = c(-3,3))

g <- ggplot(testdat, aes(x = myx, y = myy))

g+geom_line()

#| Notice how ggplot DID display the outlier point at
#| (50,100). As a result the rest of the data is
#| smashed down so you don't get to see what the bulk
#| of it looks like. The single outlier probably isn't
#| important enough to dominate the graph. How do we
#| get ggplot to behave more like plot in a situation
#| like this?

#| Let's take a guess that in addition to adding
#| geom_line() to g we also just have to add ylim(-3,3)
#| to it as we did with the call to plot. Try this now
#| to see what happens.

g+geom_line()+ylim(-3,3)

#| Notice that by doing this, ggplot simply ignored the
#| outlier point at (50,100). There's a break in the
#| line which isn't very noticeable. Now recall that at
#| the beginning of the lesson we mentioned 7
#| components of a ggplot plot, one of which was a
#| coordinate system. This is a situation where using a
#| coordinate system would be helpful. Instead of
#| adding ylim(-3,3) to the expression g+geom_line(),
#| add a call to the function coord_cartesian with the
#| argument ylim set equal to c(-3,3).

g+geom_line()+coord_cartesian(ylim=c(-3,3))

#| See the difference? This looks more like the plot
#| produced by the base plot function. The outlier y
#| value at x=50 is not shown, but the plot indicates
#| that it is larger than 3.

#| We'll close with a more complicated example to show
#| you the full power of ggplot and the entire ggplot2
#| package. We'll continue to work with the mpg
#| dataset.

#| Start by creating the graphical object g by
#| assigning to it a call to ggplot with 2 arguments.
#| The first is the dataset and the second is a call to
#| the function aes. This call will have 3 arguments, x
#| set equal to displ, y set equal to hwy, and color
#| set equal to factor(year). This last will allow us
#| to distinguish between the two manufacturing years
#| (1999 and 2008) in our data.

g<-ggplot(mpg,aes(x=displ,y=hwy,color=factor(year)))

#| Uh oh! Nothing happened. Does g exist? Of course, it
#| just isn't visible yet since you didn't add a layer.

####Printing g at the command line will return an error

g+geom_point()

#| A simple, yet comfortingly familiar scatterplot
#| appears. Let's make our display a 2 dimensional
#| multi-panel plot. Recall your last command (with the
#| up arrow) and add to it a call the function
#| facet_grid. Give it 2 arguments. The first is the
#| formula drv~cyl, and the second is the argument
#| margins set equal to TRUE. Try this now.

g+geom_point()+facet_grid(drv~cyl,margins=TRUE)

#| A 4 by 5 plot, huh? The margins argument tells
#| ggplot to display the marginal totals over each row
#| and column, so instead of seeing 3 rows (the number
#| of drv factors) and 4 columns (the number of cyl
#| factors) we see a 4 by 5 display. Note that the
#| panel in position (4,5) is a tiny version of the
#| scatterplot of the entire dataset.

g+geom_point()+facet_grid(drv~cyl,margins=TRUE)+geom_smooth(method="lm",se=FALSE,size=2,color="black")

#| Angry Birds? Finally, add to your last command (or
#| retype it if you like to type) a call to the
#| function labs with 3 arguments. These are x set to
#| "Displacement", y set to "Highway Mileage", and
#| title set to "Swirl Rules!".

g+geom_point()+facet_grid(drv~cyl,margins=TRUE)+geom_smooth(method="lm",se=FALSE,size=2,color="black")+labs(x="Displacement",y="Highway Mileage",title="Swirl Rules!")

#| You could have done these labels with separate calls
#| to labs but we thought you'd be sick of this by now.
#| Anyway, congrats! You've concluded part 2 of
#| ggplot2. We hope you got enough mileage out of the
#| lesson. If you like ggplot2 you can do some extras
#| with the extra lesson.

######END GGPLOT2 PART 2 SWIRL LESSON 

## GGPLOT2 EXTRAS

#| GGPlot2_Extras. (Slides for this and other Data
#| Science courses may be found at github
#| https://github.com/DataScienceSpecialization/courses/.
#| If you care to use them, they must be downloaded as
#| a zip file and viewed locally. This lesson
#| corresponds to 04_ExploratoryAnalysis/ggplot2.)

str(diamonds)
#'data.frame':	53940 obs. of  10 variables:
# $ carat  : num  0.23 0.21 0.23 0.29 0.31 0.24 0.24 0.26 0.22 0.23 ...
# $ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 5 4 2 4 2 3 3 3 1 3 ...
# $ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 2 2 6 7 7 6 5 2 5 ...
# $ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 2 3 5 4 2 6 7 3 4 5 ...
# $ depth  : num  61.5 59.8 56.9 62.4 63.3 62.8 62.3 61.9 65.1 59.4 ...
# $ table  : num  55 61 65 58 58 57 57 55 61 61 ...
# $ price  : int  326 326 327 334 335 336 336 337 337 338 ...
# $ x      : num  3.95 3.89 4.05 4.2 4.34 3.94 3.95 4.07 3.87 4 ...
# $ y      : num  3.98 3.84 4.07 4.23 4.35 3.96 3.98 4.11 3.78 4.05 ...
# $ z      : num  2.43 2.31 2.31 2.63 2.75 2.48 2.47 2.53 2.49 2.39 ...

#| From the output, how many characteristics of
#| diamonds do you think this data contains? ==>10 

#| From the output of str, how many diamonds are
#| characterized in this dataset? ==> 53940 

#| Now let's plot a histogram of the price of the
#| 53940 diamonds in this dataset. Recall that a
#| histogram requires only one variable of the
#| data, so run the R command qplot with the
#| first argument price and the argument data set
#| equal to diamonds. This will show the
#| frequency of different diamond prices.

qplot(price,data=diamonds)

#| Not only do you get a histogram, but you also
#| get a message about the binwidth defaulting to
#| range/30. Recall that range refers to the
#| spread or dispersion of the data, in this case
#| price of diamonds. Run the R command range now
#| with diamonds$price as its argument.

range(diamonds$price)
#[1]   326 18823

#| We see that range returned the minimum and
#| maximum prices, so the diamonds vary in price
#| from $326 to $18823. We've done the arithmetic
#| for you, the range (difference between these
#| two numbers) is $18497.

#| Rerun qplot now with 3 arguments. The first is
#| price, the second is data set equal to
#| diamonds, and the third is binwidth set equal
#| to 18497/30). (Use the up arrow to save
#| yourself some typing.) See if the plot looks
#| familiar.

qplot(price,data=diamonds,binwidth=18497/30)

#| No more messages in red, but a histogram
#| almost identical to the previous one! If you
#| typed 18497/30 at the command line you would
#| get the result 616.5667. This means that the
#| height of each bin tells you how many diamonds
#| have a price between x and x+617 where x is
#| the left edge of the bin.

#| We've created a vector containing integers
#| that are multiples of 617 for you. It's called
#| brk. Look at it now.

brk
# [1]     0   617  1234  1851  2468  3085  3702
# [8]  4319  4936  5553  6170  6787  7404  8021
#[15]  8638  9255  9872 10489 11106 11723 12340
#[22] 12957 13574 14191 14808 15425 16042 16659
#[29] 17276 17893 18510 19127

#| We've also created a vector containing the
#| number of diamonds with prices between each
#| pair of adjacent entries of brk. For instance,
#| the first count is the number of diamonds with
#| prices between 0 and $617, and the second is
#| the number of diamonds with prices between
#| $617 and $1234. Look at the vector named
#| counts now.

counts
# [1]  4611 13255  5230  4262  3362  2567  2831
# [8]  2841  2203  1666  1445  1112   987   766
#[15]   796   655   606   553   540   427   429
#[22]   376   348   338   298   305   269   287
#[29]   227   251    97

#| See how it matches the histogram you just
#| plotted? So, qplot really works!

#| You're probably sick of it but rerun qplot
#| again, this time with 4 arguments. The first 3
#| are the same as the last qplot command you
#| just ran (price, data set equal to diamonds,
#| and binwidth set equal to 18497/30). (Use the
#| up arrow to save yourself some typing.) The
#| fourth argument is fill set equal to cut. The
#| shape of the histogram will be familiar, but
#| it will be more colorful.

qplot(price,data=diamonds,binwidth=18497/30,fill=cut)

#| This shows how the counts within each price
#| grouping (bin) are distributed among the
#| different cuts of diamonds. Notice how qplot
#| displays these distributions relative to the
#| cut legend on the right. The fair cut diamonds
#| are at the bottom of each bin, the good cuts
#| are above them, then the very good above them,
#| until the ideal cuts are at the top of each
#| bin. You can quickly see from this display
#| that there are very few fair cut diamonds
#| priced above $5000.

#| Now we'll replot the histogram as a density
#| function which will show the proportion of
#| diamonds in each bin. This means that the
#| shape will be similar but the scale on the
#| y-axis will be different since, by definition,
#| the density function is nonnegative
#| everywhere, and the area under the curve is
#| one. To do this, simply call qplot with 3
#| arguments. The first 2 are price and data (set
#| equal to diamonds). The third is geom which
#| should be set equal to the string "density".
#| Try this now.

qplot(price,data=diamonds,geom="density")

#| Notice that the shape is similar to that of
#| the histogram we saw previously. The highest
#| peak is close to 0 on the x-axis meaning that
#| most of the diamonds in the dataset were
#| inexpensive. In general, as prices increase
#| (move right along the x-axis) the number of
#| diamonds (at those prices) decrease. The
#| exception to this is when the price is around
#| $4000; there's a slight increase in frequency.
#| Let's see if cut is responsible for this
#| increase.

#| Rerun qplot, this time with 4 arguments. The
#| first 2 are the usual, and the third is geom
#| set equal to "density". The fourth is color
#| set equal to cut. Try this now.

qplot(price,data=diamonds,geom="density",color=cut)

#| See how easily qplot did this? Four of the
#| five cuts have 2 peaks, one at price $1000 and
#| the other between $4000 and $5000. The
#| exception is the Fair cut which has a single
#| peak at $2500. This gives us a little more
#| understanding of the histogram we saw before.

#| Let's move on to scatterplots. For these we'll
#| need to specify two variables from the diamond
#| dataset.

#| Let's start with carat and price. Use these as
#| the first 2 arguments of qplot. The third
#| should be data set equal to the dataset. Try
#| this now.

qplot(carat,price,data=diamonds)#scatterplot 

#| We see the positive trend here, as the number
#| of carats increases the price also goes up.

#| Now rerun the same command, except add a
#| fourth parameter, shape, set equal to cut

qplot(carat,price,data=diamonds,shape=cut)

#| The same scatterplot appears, except the cuts
#| of the diamonds are distinguished by different
#| symbols. The legend at the right tells you
#| which symbol is associated with each cut.
#| These are small and hard to read, so rerun the
#| same command, except this time instead of
#| setting the argument shape equal to cut, set
#| the argument color equal to cut.

#| That's easier to see! Now we'll close with
#| two, more complicated scatterplot examples.

#| We'll rerun the plot you just did
#| (carat,price,data=diamonds and color=cut) but
#| add two more parameters. The first is the
#| argument geom set equal to the concatenation
#| of the 2 strings, "point" and "smooth". The
#| second is the argument method set equal to the
#| string "lm". Try this now.

qplot(carat,price,data=diamonds,color=cut,geom=c("point","smooth"),method="lm")

#| Again, we see the same scatterplot, but
#| slightly more compressed and showing 5
#| regression lines, one for each cut of
#| diamonds. It might be hard to see, but around
#| each line is a shadow showing the 95%
#| confidence interval. We see, unsurprisingly,
#| that the better the cut, the steeper (more
#| positive) the slope of the lines.

#| Finally, let's rerun that plot you just did
#| (carat,price,data=diamonds, color=cut, geom
#| =c("point","smooth"),method="lm") but add one
#| (just one) more argument. The new argument is
#| facets and it should be set equal to the
#| formula .~cut. Recall that the facets argument
#| indicates we want a multi-panel plot. The
#| symbol to the left of the tilde indicates rows
#| (in this case just one) and the symbol to the
#| right of the tilde indicates columns (in this
#| five, the number of cuts). Try this now.

qplot(carat,price,data=diamonds,color=cut,geom=c("point","smooth"),method="lm",facets=.~cut)

#| First create a graphical object g by assigning
#| to it the output of a call to the function
#| ggplot with 2 arguments. The first is the
#| dataset diamonds and the second is a call to
#| the function aes with 2 arguments, depth and
#| price. Remember you won't see any result.

g<-ggplot(diamonds,aes(depth,price))
summary(g)
#data: carat, cut, color, clarity, depth,
#  table, price, x, y, z [53940x10]
#mapping:  x = depth, y = price
#faceting: facet_null()

#| We see that g holds the entire dataset. Now
#| suppose we want to see a scatterplot of the
#| relationship. Add to g a call to the function
#| geom_point with 1 argument, alpha set equal to
#| 1/3.

g+geom_point(alpha=1/3)

#| That's somewhat interesting. We see that depth
#| ranges from 43 to 79, but the densest
#| distribution is around 60 to 65. Suppose we
#| want to see if this relationship (between
#| depth and price) is affected by cut or carat.
#| We know cut is a factor with 5 levels (Fair,
#| Good, Very Good, Premium, and Ideal). But
#| carat is numeric and not a discrete factor.
#| Can we do this?

#| Of course! That's why we asked. R has a handy
#| command, cut, which allows you to divide your
#| data into sets and label each entry as
#| belonging to one of the sets, in effect
#| creating a new factor. First, we'll have to
#| decide where to cut the data.

#| Let's divide the data into 3 pockets, so 1/3
#| of the data falls into each. We'll use the R
#| command quantile to do this. Create the
#| variable cutpoints and assign to it the output
#| of a call to the function quantile with 3
#| arguments. The first is the data to cut,
#| namely diamonds$carat; the second is a call to
#| the R function seq. This is also called with 3
#| arguments, (0, 1, and length set equal to 4).
#| The third argument to the call to quantile is
#| the boolean na.rm set equal to TRUE.

cutpoints<-quantile(diamonds$carat,seq(0,1,length=4),na.rm=TRUE)

#| Look at cutpoints now to understand what it
#| is.

cutpoints 
#       0% 33.33333% 66.66667%      100% 
#     0.20      0.50      1.00      5.01 

#| We see a 4-long vector (explaining why length
#| was set equal to 4). We also see that .2 is
#| the smallest carat size in the dataset and
#| 5.01 is the largest. One third of the diamonds
#| are between .2 and .5 carats and another third
#| are between .5 and 1 carat in size. The
#| remaining third are between 1 and 5.01 carats.
#| Now we can use the R command cut to label each
#| of the 53940 diamonds in the dataset as
#| belonging to one of these 3 factors. Create a
#| new name in diamonds, diamonds$car2 by
#| assigning it the output of the call to cut.
#| This command takes 2 arguments,
#| diamonds$carat, which is what we want to cut,
#| and cutpoints, the places where we'll cut.

diamonds$car2<-cut(diamonds$carat,cutpoints) #what we want to cut, places we will cut 

#| Now we can continue with our multi-facet plot.
#| First we have to reset g since we changed the
#| dataset (diamonds) it contained (by adding a
#| new column). Assign to g the output of a call
#| to ggplot with 2 arguments. The dataset
#| diamonds is the first, and a call to the
#| function aes with 2 arguments (depth,price) is
#| the second.

g<-ggplot(diamonds,aes(depth,price))

#| Now add to g calls to 2 functions. This first
#| is a call to geom_point with the argument
#| alpha set equal to 1/3. The second is a call
#| to the function facet_grid using the formula
#| cut ~ car2 as its argument.

g+geom_point(alpha=1/3)+facet_grid(cut~car2)

#| We see a multi-facet plot with 5 rows, each
#| corresponding to a cut factor. Not surprising.
#| What is surprising is the number of columns.
#| We were expecting 3 and got 4. Why?

#| The first 3 columns are labeled with the
#| cutpoint boundaries. The fourth is labeled NA
#| and shows us where the data points with
#| missing data (NA or Not Available) occurred.
#| We see that there were only a handful (12 in
#| fact) and they occurred in Very Good, Premium,
#| and Ideal cuts. We created a vector, myd,
#| containing the indices of these datapoints.
#| Look at these entries in diamonds by typing
#| the expression diamonds[myd,]. The myd tells R
#| what rows to show and the empty column entry
#| says to print all the columns.

diamonds[myd,]

#| We see these entries match the plots. Whew -
#| that's a relief. The car2 field is, in fact,
#| NA for these entries, but the carat field
#| shows they each had a carat size of .2. What's
#| going on here?

#| Actually our plot answers this question. The
#| boundaries for each column appear in the gray
#| labels at the top of each column, and we see
#| that the first column is labeled (0.2,0.5].
#| This indicates that this column contains data
#| greater than .2 and less than or equal to .5.
#| So diamonds with carat size .2 were excluded
#| from the car2 field.

#| Finally, recall the last plotting command
#| (g+geom_point(alpha=1/3)+facet_grid(cut~car2))
#| or retype it if you like and add another call.
#| This one to the function geom_smooth. Pass it
#| 3 arguments, method set equal to the string
#| "lm", size set equal to 3, and color equal to
#| the string "pink".

g+geom_point(alpha=1/3)+facet_grid(cut~car2)+geom_smooth(method="lm",size=3,color="pink")

#| Nice thick regression lines which are somewhat
#| interesting. You can add labels to the plot if
#| you want but we'll let you experiment on your
#| own.

#| Lastly, ggplot2 can, of course, produce
#| boxplots. This final exercise is the sum of 3
#| function calls. The first call is to ggplot
#| with 2 arguments, diamonds and a call to aes
#| with carat and price as arguments. The second
#| call is to geom_boxplot with no arguments. The
#| third is to facet_grid with one argument, the
#| formula . ~ cut. Try this now.

ggplot(diamonds,aes(carat,price))+geom_boxplot()+facet_grid(.~cut)


## END 

