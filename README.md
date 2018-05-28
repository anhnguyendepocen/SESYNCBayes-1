Welcome to the SESYNC Bayesian modeling course being held May 29 - June 8, 2018 at the National Socio-Environmental Synthesis Center ([SESYNC](https://www.sesync.org)) in Annapolis, MD.

#### I. Motivation

You will access the course materials by cloning our GitHub course repository locally on your laptop and by installing our course-specific R package `SESYNCBayes`. After completing the initial install of these materials, plan on updating throughout the course as we add new content or tweak pre-existing material.  Instructions for the initial setup and ongoing updates are below.

A quick note about GitHub: at the heart of GitHub is an open source version control system (VCS) called Git. Git is responsible for everything GitHub-related that happens locally on your computer. There are a few things that you will need to do to get going with git/GitHub. Mainly, you must create free a GitHub account and get your machine ready to interact with your account.

#### II. Create a GitHub account

Do you have a GitHub account?

1. Yes: Great! Know your login credentials.

2. No: go to [https://github.com](https://github.com) and sign up.

#### III. Git install on your machine

Does your computer have git installed?

1. Yes: Great! Potentially lend a hand to fellow students.

2. No: go to [the git set up page here](https://help.github.com/articles/set-up-git) and pick the appropriate operating system and follow the steps associated with the "Setting up Git" section.

3. Not sure? Open a terminal/bash window and type the command below. If it reports a git installation, you are good to go. Otherwise, go to step 2.

    ```bash
    git --version
    ```

#### IV. Initial clone of the course repository

Open terminal/bash and navigate to the directory where you would like to hold the course materials. If you are not familiar or comfortable using the command line, we **highly** recommend using your home directory. For the rest of this quick intro, we will refer to the path to your home directory as `home`.  

1.  To navigate quickly to the home directory type the following terminal/bash window:

    ```bash
    cd
    ```

2.  To clone the course repository into your current directory paste the following into your terminal/bash window: 

    ```bash
    git clone https://github.com/CCheCastaldo/SESYNCBayes.git
    ```

#### V. Ongoing update of course materials

We plan to update the course repository on a regular basis. It is likely that you will need to update your materials several times per day.  To do this you will `pull` a current copy of the repository. To do this: 

1.  You'll need to open your terminal/bash.

2.  Navigate to the course repository. If this is in your home directory then type:

    ```bash
    cd
    cd SESYNCBayes
    ```
    
3.  Execute the following into the terminal/bash:

    ```bash
    git pull
    ```

#### VI. EXTREMELY IMPORTANT: Using git course materials 

As noted in the previous section, each time you `pull` and updated version of the course repository your local machine will have a clean (untouched) copy of **all** course materials.  **Therefore, if you modify the course materials it is extremely important that you save your work under a different name.**  If you fail to save your work with a new name, your work will be lost the next time you `pull` to get the most up-to-date materials. Where you choose to save your work doesn't matter. You can choose a brand new directory or you can save within the directory that you've created for our course `SESYNCBayes`. 

Inevitably, you will make an inadvertent or deliberate change to a file in the course materials. In this case, your `pull` will fail. To remedy this:

1.  You'll need to open your terminal/bash.

2.  Execute the following simple steps one at a time in your terminal/bash:

    ```bash
    git checkout .
    git pull
    ```
    
#### VII. Install course-specific R package `SESYNCBayes` 

We have prepared an R package that contains all the data you will need to complete our lab exercises.  The package is part of the course materials that you now have on your local machine. You will need to do an initial install of this package and do periodic updates throughout the course. For both the install and update the commands are the same.

1. Open R or RStudio run the following line of code to install the `SESYNCBayes` package from source. Remember to change `<path>` to the path to the directory where you cloned the SESYNCBayes course repository.

    ```bash
    install.packages("<path>/Packages/SESYNCBayes_0.2.0.tar.gz", repos = NULL, type = "source")
    ```

2. When working in RStudio you load the library like any other R library:

    ```bash
    library(SESYNCBayes)
    ```
    
3.  It is easy to see the help files for `SESYNCBayes` type in R:

    ```bash
    ?SESYNCBayes
    ```
    
4.  Here is how to load a dataset from `SESYNCBayes`. For example:

    ```bash
    data(LynxFamilies)
    ```
    
#### Authors and Contributors

Mary Collins (@mbcolli), Tom Hobbs (@nthobbs50), and Christian Che-Castaldo (@CCheCastaldo) are responsible for the materials on this website. 
