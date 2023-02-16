---
title: Writing good code
author: Peter Crowther
tags:
  - code 
  - git
  - version control
published: true
---

Here we set out some simple steps that can make a big difference to the quality of your code. It is important that code is readable as well as just functional. Well designed readable code is much easier for you or others to understand, maintain and verify. These points are summarised from: [Good enough practices in scientific computing
](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005510)

### Use code comments
Place a brief explanatory comment at the start of every program to say what this script does. Give a comment at the start of each function to say what it does (it only takes a line). If your code does anything complex then add some comments next to the complex bit to say what is going on.

### Give functions and variables meaningful names
If your vairables are called i, j and k then it will be really hard to understand what your code is doing. Using really short variable names was a convention from many years ago when screens could only show 80 characters. These days it is not necessary. Use names that descirbe what you are doing. e.g.

```
# This code calculates the number of flocks of sheep 
# given the number of sheep and the flock size.
num_sheep = 100
flock_size = 20
num_flocks = num_sheep / flock_size
print(num_flocks)
```

### Use functions to break up code / don't repeat yourself
If your code is longer than 20 lines, it is time to start breaking it up into logical subsections. Using functions allows breaking down the problem being solved into smaller chunks so it can be more easily understood. It also reduces repetition which makes code easier to maintain. If you find yourself copying and pasting sections of code and renaming varaible names then you should be using a function.

### Dont reinvent the wheel
Before you start writing code, find out if someone else has written it first. Use functions from libraries.

### Provide a simple example and test data
If someone else wants to use your code, the easiest way to find out how it works is to run an example with test data. It also verifies that the code is working as expected.

### Use version control
Use version control to manage code. [Instructions on how to use git](./using-git)

### Submit code to a reputable DOI-issuing repository
Once you are done with your analysis, the code you have written forms part of the anayslsis pipeline. All parts of this need to be made public so people can reproduce the work.
