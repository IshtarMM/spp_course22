# this is a comment in this line
getwd() #get working directory
setwd("/home/ubuntu/microbiome") #set working directory


#Creating Variables in R
#Variables are containers for storing data values.
test <- "Hello student in microbiome course!"
test #output "Hello student in microbiome course!"
name = "Maryam"
age <- 40
age = 40
age    # output 40


#A function is a set of statements organized together to perform a specific task
print(age)
print(age)
?print
help(print)

#Concatenate Elements
text <- "awesome"
paste("R is", text)


#structure 
num <- c(1:10)
str(num)
class(num)

#Simple Math

#The +  operator is used to add together two values:
10 + 5

#And the - operator is used for subtraction:
10 - 5
#Built-in Math Functions
max(5, 10, 15)
min(5, 10, 15)

#Conditions and If Statements
#R supports the usual logical conditions from mathematics:

#   ==	Equal	x == y	
#   !=	Not equal	x != y	
#  >	Greater than	x > y	
#  <	Less than	x < y	
#  >=	Greater than or equal to	x >= y	
#  <=	Less than or equal to	x <= y

#You can also run a condition in an if statement, which you will learn much more about in the if..else chapter.

a <- 200
b <- 33

if (b > a) {
  print ("b is greater than a")
  }

###
if (b > a) {
  print ("b is greater than a")
} else {
  print("b is not greater than a")
}


#Loops
#Loops can execute a block of code as long as a specified condition is reached.

#Loops are handy because they save time, reduce errors, and they make code more readable.

#R has two loop commands:
#for loop
#A for loop is used for iterating over a sequence:
  
for (x in 1:10) {
  print(x)
}

microbes <- list("Bacteria", "Fungi", "Virus")

for (x in microbes) {
  print(x)
  
}



#A function is a block of code which only runs when it is called.

#You can pass data, known as parameters, into a function.

#A function can return data as a result.

#Creating a Function
#To create a function, use the function() keyword:

ReverseGenSeq <- function(seq) {
  paste("seq =",seq,"reverse =",reverse(seq))
}

ReverseGenSeq("ATCG")
ReverseGenSeq(c("ATCG"))
              
########
##R Data Structures

#1. Vector of strings:
#A vector is simply a list of items that are of the same type.
#To combine the list of items to a vector, use the c() function and separate the items by a comma.
#In the example below, we create a vector variable called fruits, that combine strings and numbers:

fruits <- c("banana", "apple", "orange" ,1)

fruits
fruits[4]

#2. Lists
#A list in R can contain many different data types inside it. A list is a collection of data which is ordered and changeable.
#To create a list, use the list() function:
# List of strings
thislist <- list("apple", "banana", "cherry" ,1)

# Print the list
thislist[4]

#Data Frames
#Data Frames are data displayed in a format as a table.
#Data Frames can have different types of data inside it. While the first column can be character, the second and third can be numeric or logical. However, each column should have the same type of data.
#Use the data.frame() function to create a data frame:

Data_Frame <- data.frame (
  OTU = c("Otu1", "Otu2", "Otu3"),
  Genus = c("bacillus", " Betacoronavirus", "fungi unclassified"),
  MeanAbandance = c(60, 20, 45)
)

# Print the data frame
Data_Frame
Data_Frame$OTU
Data_Frame[]
Data_Frame[1,]
Data_Frame[,3]
Data_Frame[2,2] 
Data_Frame[1:2,2] 
  
summary(Data_Frame)

#R Plotting
plot(1, 3)
plot(c(1, 8), c(3, 10))
plot(1:10)
plot(1:10, main="My Graph", xlab="The x-axis", ylab="The y axis")
plot(1:10, col="red")


##how to install a package in R????
#R packages are collections of functions and data sets developed by 
#the community. They increase the power of R by improving existing base R functionalities

install.packages("ggplot2")
library(ggplot2)

#2. What Are Repositories?
# A repository is a place where packages are located
#CRAN,Bioconductor,Github 

#mtcars Motor Trend Car Road Tests
mtcars = mtcars
rownames(mtcars)
colnames(mtcars)

g2 <- ggplot(mtcars, aes(x=drat, y=qsec, color=cyl)) + geom_point(size=5) + theme(legend.position="none")
g3 <- ggplot(mtcars, aes(x=factor(cyl), y=qsec, fill=cyl)) + geom_boxplot() + theme(legend.position="none")
g4 <- ggplot(mtcars , aes(x=factor(cyl), fill=factor(cyl))) +  geom_bar()
ggsave("plot1.png" , g2 , height = 5 , width = 6)


install.packages("gridExtra")
library(gridExtra)
plot1  = grid.arrange(g2, arrangeGrob(g3, g4, ncol=2), nrow = 2)
plot2  = grid.arrange(g2,g3, g4, ncol=1, nrow = 3)

ggsave("plot2.png" , plot1 , height = 5 , width = 6)

#save a file in R
Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

write.table(Data_Frame,"Dataframe1.txt" , sep = "," , row.names = F)

file1f <- read.table("Dataframe1.txt", h=T , sep = ",")

# bar plot in R
Otu1 <- c(38.9, 61.2, 73.3, 21.8, 63.4, 64.6, 48.4, 48.8, 48.5)
Otu2 <- c(2.8, 4, 3.4, 4, 9.4, 73.3, 67.3, 61.3, 62.4) 
Otu3 <- c(67.8, 60, 63.4, 76, 89.4, 20.3, 1.3, 2.3, 0.4) 
# Create a data frame

my_data <- data.frame( 
  microbes = rep(c("Bacillus", "Fungi1","virus"), each = 9),
   Abundance = c(Otu1,  Otu2,Otu3),
  group = c(rep("control", each = 5),rep("non-infected", each = 5),
            rep("infected", each = 5), 
            rep("control", each = 4),rep("non-infected", each = 4),
            rep("infected", each = 4)))

my_data 

p1 = ggplot(my_data, aes(x = microbes, y = Abundance, 
          color = microbes),
          ylab = Abundance, xlab = microbes) + geom_boxplot() + geom_point()

##bar plots
p2 <- ggplot()  + geom_bar(data=my_data, aes(x=group, y=Abundance, fill = microbes), stat="identity", position="fill") +
  guides(fill=guide_legend(ncol=1))  +
  theme_classic() + theme(
    text = element_text(size = 12 , colour = "black"),
    axis.text = element_text(size = 12 , colour = "black" ),
    axis.title = element_text(size = 12 , colour = "black" ),
    strip.text = element_text(size = 12 , colour = "black" ),
    axis.text.x = element_text(angle = 60, hjust = 1 , colour="black", size = 12),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(), 
    axis.line = element_line(colour = "black") ,
    legend.title = element_text(color = "black", size = 12),
    legend.text = element_text(color = "black", size = 12) ,
    strip.background = element_rect(colour = "black", fill = "white")) 

ggsave("Abundance.png",p2)

#statistic in R

anova_result <- aov(Abundance ~ group , my_data)
anova_result_summary = summary(anova_result)
TukeyHSD(anova_result)


t.test(otu1,otu2 , exact = FALSE )
wilcox.test(otu1,otu2, data = my_data , exact = FALSE )

#install.packages(c("ade4"  ,"vegan"))
library(ade4)
library(vegan)

