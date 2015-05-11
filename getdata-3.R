## Getting and cleaning data, lecture 3 tidying data 

install.packages("dplyr")
library(dplyr)

cran %>% 
    select(ip_id, country, package, size)
    print
    
#versus 
select(cran, ip_id, country, package, size)

#tidying data with tidyr package 

install.packages("tidyr")
install.packages("stringi")
library(stringi)
library(tidyr)

#In this lesson, you'll learn how to tidy your data with the tidyr package.

#Tidy data is standard format. 
#tidy data satisfies 3 conditions
    #each variable forms a column
    #each obs forms a row
    #each type of obs unit forms a table 

#use the gather() function from tidyr to have one column for each of the variables 

gather(students, sex, count, -grade) #gets all columns except grade
#combined the variables for A-Male and A-Female, etc ...
    
#now lets see multiple variables stored in one column 

res<-gather(students2, sex_class, count, -grade)
#print res to see it's change
res

#still there are two diff variables (sex and class) stored together in teh sex_class column. tidyr can provide convenient separate() function to separate one column in to multiple. 

?separate
separate(res,sex_class,into=c("sex","class")) #we didn't use the sep argument, which is sometimes necessary to tell R how to separate the column 
#it splits on non alphanumeric values. 


# Repeat your calls to gather() and separate(), but this time
# use the %>% operator to chain the commands together without
# storing an intermediate result.
#
# If this is your first time seeing the %>% operator, check
# out ?chain, which will bring up the relevant documentation.
# You can also look at the Examples section at the bottom
# of ?gather and ?separate.
#
# The main idea is that the result to the left of %>%
# takes the place of the first argument of the function to
# the right. Therefore, you OMIT THE FIRST ARGUMENT to each
# function.
#
students2 %>%
  gather(sex_class, count, -grade) %>%
  separate(sex_class, c("sex","class")) %>%
  print

  
#sometimes variables are stored as rows and columns
#    name    test class1 class2 class3 class4 class5
#1  Sally midterm      A   <NA>      B   <NA>   <NA>
#2  Sally   final      C   <NA>      C   <NA>   <NA>
#3   Jeff midterm   <NA>      D   <NA>      A   <NA>
#4   Jeff   final   <NA>      E   <NA>      C   <NA>
#5  Roger midterm   <NA>      C   <NA>   <NA>      B
#6  Roger   final   <NA>      A   <NA>   <NA>      A
#7  Karen midterm   <NA>   <NA>      C      A   <NA>
#8  Karen   final   <NA>   <NA>      C      A   <NA>
#9  Brian midterm      B   <NA>   <NA>   <NA>      A
#10 Brian   final      B   <NA>   <NA>   <NA>      C

#| In students3, we have midterm and final exam grades for five
#| students, each of whom were enrolled in exactly two of five
#| possible classes.

#| The first variable, name, is already a column and should
#| remain as it is. The headers of the last five columns,
#| class1 through class5, are all different values of what
#| should be a class variable. The values in the test column,
#| midterm and final, should each be its own variable
#| containing the respective grades for each student.

#| This will require multiple steps, which we will build up
#| gradually using %>%. Edit the R script, save it, then type
#| submit() when you are ready. Type reset() to reset the
#| script to its original state.

#script begin:
# Call gather() to gather the columns class1 through
# through class5 into a new variable called class.
# The 'key' should be class, and the 'value'
# should be grade.
#
# tidyr makes it easy to reference multiple adjacent
# columns with class1:class5, just like with sequences
# of numbers.
#
# Since each student is only enrolled in two of
# the five possible classes, there are lots of missing
# values (i.e. NAs). Use the argument na.rm = TRUE
# to omit these values from the final result.
#
# Remember that when you're using the %>% operator,
# the value to the left of it gets inserted as the
# first argument to the function on the right.
#
# Consult ?gather and/or ?chain if you get stuck.
#
students3 %>%
  gather(class,grade,class1:class5 ,na.rm = TRUE) %>%
  print
#recall gather(data, key, value, ..., na.rm = FALSE, convert = FALSE)


#next part will require spread()
?spread


#sometimes variables are stored as rows and columns
#    name    test class1 class2 class3 class4 class5
#1  Sally midterm      A   <NA>      B   <NA>   <NA>
#2  Sally   final      C   <NA>      C   <NA>   <NA>
#3   Jeff midterm   <NA>      D   <NA>      A   <NA>
#4   Jeff   final   <NA>      E   <NA>      C   <NA>
#5  Roger midterm   <NA>      C   <NA>   <NA>      B
#6  Roger   final   <NA>      A   <NA>   <NA>      A
#7  Karen midterm   <NA>   <NA>      C      A   <NA>
#8  Karen   final   <NA>   <NA>      C      A   <NA>
#9  Brian midterm      B   <NA>   <NA>   <NA>      A
#10 Brian   final      B   <NA>   <NA>   <NA>      C

#turns into...

#    name    test  class grade
#1  Sally midterm class1     A
#2  Sally   final class1     C
#3  Brian midterm class1     B
#4  Brian   final class1     B
#5   Jeff midterm class2     D
#6   Jeff   final class2     E
#7  Roger midterm class2     C
#8  Roger   final class2     A
#9  Sally midterm class3     B
#10 Sally   final class3     C
#11 Karen midterm class3     C
#12 Karen   final class3     C
#13  Jeff midterm class4     A
#14  Jeff   final class4     C
#15 Karen midterm class4     A
#16 Karen   final class4     A
#17 Roger midterm class5     B
#18 Roger   final class5     A
#19 Brian midterm class5     A
#20 Brian   final class5     C

#script start:
# This script builds on the previous one by appending
# a call to spread(), which will allow us to turn the
# values of the test column, midterm and final, into
# column headers (i.e. variables).
#
# You only need to specify two arguments to spread().
# Can you figure out what they are? (Hint: You don't
# have to specify the data argument since we're using
# the %>% operator.
#
students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  print
#spread(data, key, value, fill = NA, convert = FALSE, drop = TRUE)

#produces ...

#    name  class final midterm
#1  Brian class1     B       B
#2  Brian class5     C       A
#3   Jeff class2     E       D
#4   Jeff class4     C       A
#5  Karen class3     C       C
#6  Karen class4     A       A
#7  Roger class2     A       C
#8  Roger class5     A       B
#9  Sally class1     C       A
#10 Sally class3     C       B

#we want the classes to be numeric (eg class 1 = 1) 
#this requires extract_numeric()

?extract_numeric
extract_numeric("class5") #returns 5

# We want the values in the class columns to be
# 1, 2, ..., 5 and not class1, class2, ..., class5.
#
# Use the mutate() function from dplyr along with
# extract_numeric(). Hint: You can "overwrite" a column
# with mutate() by assigning a new value to the existing
# column instead of creating a new column.
#
# Check out ?mutate and/or ?extract_numeric if you need
# a refresher.
#
#REMEMBER THIS IS WHAT WE ARE OPERATING ON 

#    name  class final midterm
#1  Brian class1     B       B
#2  Brian class5     C       A
#3   Jeff class2     E       D
#4   Jeff class4     C       A
#5  Karen class3     C       C
#6  Karen class4     A       A
#7  Roger class2     A       C
#8  Roger class5     A       B
#9  Sally class1     C       A
#10 Sally class3     C       B
students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  mutate(class=extract_numeric(class)) %>%
  print
#returns...
#    name class final midterm
#1  Brian     1     B       B
#2  Brian     5     C       A
#3   Jeff     2     E       D
#4   Jeff     4     C       A
#5  Karen     3     C       C
#6  Karen     4     A       A
#7  Roger     2     A       C
#8  Roger     5     A       B
#9  Sally     1     C       A
#10 Sally     3     C       B

#| The fourth messy data problem we'll look at occurs when
#| multiple observational units are stored in the same table.
#| students4 presents an example of this. Take a look at the
#| data now.

#    id  name sex class midterm final
#1  168 Brian   F     1       B     B
#2  168 Brian   F     5       A     C
#3  588 Sally   M     1       A     C
#4  588 Sally   M     3       B     C
#5  710  Jeff   M     2       D     E
#6  710  Jeff   M     4       A     C
#7  731 Roger   F     2       C     A
#8  731 Roger   F     5       B     A
#9  908 Karen   M     3       C     C
#10 908 Karen   M     4       A     A

#| students4 is almost the same as our tidy version of
#| students3. The only difference is that students4 provides a
#| unique id for each student, as well as his or her sex (M =
#| male; F = female).

#| At first glance, there doesn't seem to be much of a problem
#| with students4. All columns are variables and all rows are
#| observations. However, notice that each id, name, and sex is
#| repeated twice, which seems quite redundant. This is a hint
#| that our data contains multiple observational units in a
#| single table.

#| Our solution will be to break students4 into two separate
#| tables -- one containing basic student information (id,
#| name, and sex) and the other containing grades (id, class,
#| midterm, final).
#| 
#| Edit the R script, save it, then type submit() when you are
#| ready. Type reset() to reset the script to its original
#| state.

#begin script:

# Complete the chained command below so that we are
# selecting the id, name, and sex column from students4
# and storing the result in student_info.
#
student_info <- students4 %>%
  select(id,name,sex) %>%
  print
#returns...

#    id  name sex
#1  168 Brian   F
#2  168 Brian   F
#3  588 Sally   M
#4  588 Sally   M
#5  710  Jeff   M
#6  710  Jeff   M
#7  731 Roger   F
#8  731 Roger   F
#9  908 Karen   M
#10 908 Karen   M

#| Notice anything strange about student_info? It contains five
#| duplicate rows! See the script for directions on how to fix
#| this. Save the script and type submit() when you are ready,
#| or type reset() to reset the script to its original state.


  
#| Notice anything strange about student_info? It contains five
#| duplicate rows! See the script for directions on how to fix
#| this. Save the script and type submit() when you are ready,
#| or type reset() to reset the script to its original state.

student_info #note five duplicate rows, not unique observations

#    id  name sex
#1  168 Brian   F
#2  168 Brian   F
#3  588 Sally   M
#4  588 Sally   M
#5  710  Jeff   M
#6  710  Jeff   M
#7  731 Roger   F
#8  731 Roger   F
#9  908 Karen   M
#10 908 Karen   M

#start script:

# Add a call to unique() below, which will remove
# duplicate rows from student_info.
#
# Like with the call to the print() function below,
# you can omit the parentheses after the function name.
# This is a nice feature of %>% that applies when
# there are no additional arguments to specify.
#
student_info <- students4 %>%
  select(id, name, sex) %>%
  unique %>%
  print

#returns
#   id  name sex
#1 168 Brian   F
#3 588 Sally   M
#5 710  Jeff   M
#7 731 Roger   F
#9 908 Karen   M

#| Now, using the script I just opened for you, create a second
#| table called gradebook using the id, class, midterm, and
#| final columns (in that order).
#| 
#| Edit the R script, save it, then type submit() when you are
#| ready. Type reset() to reset the script to its original
#| state.

# select() the id, class, midterm, and final columns
# (in that order) and store the result in gradebook.
#
gradebook <- students4 %>%
  select(id, class, midterm, final) %>%
  print

#returns
#    id class midterm final
#1  168     1       B     B
#2  168     5       A     C
#3  588     1       A     C
#4  588     3       B     C
#5  710     2       D     E
#6  710     4       A     C
#7  731     2       C     A
#8  731     5       B     A
#9  908     3       C     C
#10 908     4       A     A

#| It's important to note that we left the id column in both
#| tables. In the world of relational databases, 'id' is called
#| our 'primary key' since it allows us to connect each student
#| listed in student_info with their grades listed in
#| gradebook. Without a unique identifier, we might not know
#| how the tables are related. (In this case, we could have
#| also used the name variable, since each student happens to
#| have a unique name.)



#| The fifth and final messy data scenario that we'll address
#| is when a single observational unit is stored in multiple
#| tables. It's the opposite of the fourth problem.

#| To illustrate this, we've created two datasets, passed and
#| failed. Take a look at passed now.
#passed
#   name class final
#1 Brian     1     B
#2 Roger     2     A
#3 Roger     5     A
#4 Karen     4     A
#failed
#   name class final
#1 Brian     5     C
#2 Sally     1     C
#3 Sally     3     C
#4  Jeff     2     E
#5  Jeff     4     C
#6 Karen     3     C

#| The name of each dataset actually represents the value of a
#| new variable that we will call 'status'. Before joining the
#| two tables together, we'll add a new column to each
#| containing this information so that its not lost when we put
#| everything together.

#| Use dplyr's mutate() to add a new column to the passed
#| table. The column should be called status and the value,
#| "passed" (a character string), should be the same for all
#| students. 'Overwrite' the current version of passed with the
#| new one.

passed <- passed %>%
    mutate("status" = "passed")

failed <- failed %>%
    mutate("status" = "failed")

#| Now, pass as arguments the passed and failed tables (in
#| order) to the dplyr function bind_rows(), which will join
#| them together into a single unit. Check ?bind_rows if you
#| need help.
#| 
#| Note: bind_rows() is only available in dplyr 0.4.0 or later.
#| If you have an older version of dplyr, please quit the
#| lesson, update dplyr, then restart the lesson where you left
#| off. If you're not sure what version of dplyr you have, type
#| packageVersion('dplyr').


bind_rows(passed, failed)

#    name class final status
#1  Brian     1     B passed
#2  Roger     2     A passed
#3  Roger     5     A passed
#4  Karen     4     A passed
#5  Brian     5     C failed
#6  Sally     1     C failed
#7  Sally     3     C failed
#8   Jeff     2     E failed
#9   Jeff     4     C failed
#10 Karen     3     C failed

#| Of course, we could arrange the rows however we wish at this
#| point, but the important thing is that each row is an
#| observation, each column is a variable, and the table
#| contains a single observational unit. Thus, the data are
#| tidy.

#PUTTING IT TOGETHER

#| The SAT is a popular college-readiness exam in the United
#| States that consists of three sections: critical reading,
#| mathematics, and writing. Students can earn up to 800 points
#| on each section. This dataset presents the total number of
#| students, for each combination of exam section and sex,
#| within each of six score ranges. It comes from the 'Total
#| Group Report 2013', which can be found here:
#| 
#| http://research.collegeboard.org/programs/sat/data/cb-seniors-2013

sat 

#  score_range read_male read_fem read_total math_male math_fem
#1     700-800     40151    38898      79049     74461    46040
#2     600-690    121950   126084     248034    162564   133954
#3     500-590    227141   259553     486694    233141   257678
#4     400-490    242554   296793     539347    204670   288696
#5     300-390    113568   133473     247041     82468   131025
#6     200-290     30728    29154      59882     18788    26562
#Variables not shown: math_total (int), write_male (int),
#  write_fem (int), write_total (int)

#| As we've done before, we'll build up a series of chained
#| commands, using functions from both tidyr and dplyr. Edit
#| the R script, save it, then type submit() when you are
#| ready. Type reset() to reset the script to its original
#| state.

# Accomplish the following three goals:
#
# 1. select() all columns that do NOT contain the word "total",
# since if we have the male and female data, we can always
# recreate the total count in a separate column, if we want it.
# Hint: Use the contains() function, which you'll
# find detailed in 'Selection' section of ?select.
#
# 2. gather() all columns EXCEPT score_range, using
# key = part_sex and value = count.
#
# 3. separate() part_sex into two separate variables (columns),
# called "part" and "sex", respectively. You may need to check
# the 'Examples' section of ?separate to remember how the 'into'
# argument should be phrased.
#
sat %>% 
    select(-contains("total")) %>%
    gather(part_sex, count, -c(score_range)) %>%
    separate(part_sex,into = c("part","sex")) %>% 
    print

#separate(data, col, into, sep = "[^[:alnum:]]+", remove = TRUE,
#  convert = FALSE, extra = "error", ...)

#   score_range part  sex  count
#1      700-800 read male  40151
#2      600-690 read male 121950
#3      500-590 read male 227141
#4      400-490 read male 242554
#5      300-390 read male 113568
#6      200-290 read male  30728
#7      700-800 read  fem  38898
#8      600-690 read  fem 126084
#9      500-590 read  fem 259553
#10     400-490 read  fem 296793
#..         ...  ...  ...    ...

#| Finish off the job by following the directions in the
#| script. Save the script and type submit() when you are
#| ready, or type reset() to reset the script to its original
#| state.



# Append two more function calls to accomplish the following:
#
# 1. Use group_by() (from dplyr) to group the data by part and
# sex, in that order.
#
# 2. Use mutate to add two new columns, whose values will be
# automatically computed group-by-group:
#
#   * total = sum(count)
#   * prop = count / total
#
sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range) %>%
  separate(part_sex, c("part", "sex")) %>%
  group_by(part, sex) %>%
  mutate(total = sum(count),
         prop = count / total 
  ) %>% print

#group_by(.data, ..., add = FALSE)

#returns  

#   score_range part  sex  count  total       prop
#1      700-800 read male  40151 776092 0.05173485
#2      600-690 read male 121950 776092 0.15713343
#3      500-590 read male 227141 776092 0.29267278
#4      400-490 read male 242554 776092 0.31253253
#5      300-390 read male 113568 776092 0.14633317
#6      200-290 read male  30728 776092 0.03959324
#7      700-800 read  fem  38898 883955 0.04400450
#8      600-690 read  fem 126084 883955 0.14263622
#9      500-590 read  fem 259553 883955 0.29362694
#10     400-490 read  fem 296793 883955 0.33575578
#..         ...  ...  ...    ...    ...        ...





#####################################################################################################################################################################################################################
