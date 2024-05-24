# Tower Experiment: A Template for OpenFAST Experimentation

This library provides another solution for managing experiments using the OpenFAST simulation tool [OpenFAST](https://github.com/OpenFAST/openfast?tab=readme-ov-file) for those who enjoy using MatLab.  Think of this code as template for further applications.

# Description:

The problem faced when running numerical experiments with OpenFAST is changing the input files in the appropriate manner.  With a large number of inputs, selecting only those pertinent to a particular study is difficult.  This library is a flexible, DIY inspired approach.  It is adaptable becuase it is based on text-editing.  It is modular, enabling this framework to apply to different turbine setups and experiment designs.

The heart of the library are two files.
- `ExpTableGenerator.m`
- `ExpDriver.m`

Once the user has configured these files (and the helper functions), running the experiment and organizing the results for further analysis is simple.  Simply run the `ExpTableGenerator.m` then run the `ExpDriver.m`.

This framework streamlines OpenFAST input-output handling, while keeping the data organized.  The user specifies an experiment to run by giving the input (independent) variables settings for each test in the experiment as a table.  Then the framework will set up and run the simulations required, organizing the outputs channels (dependent variables) requested by the user into a table that mirrors the input table provided.

# Instructions:

Note: Requires:
- MatLab
- OpenFAST excecutable (adjust the path in the `testdriver.m` file)
- Properly compiled DLL file (see the ServoDyn file)

Before running scripts, first copy the ***`Template_IEA-15-240-RWT-Monopile` folder and rename it `Simulate`***
Also, provide an inflow wind file to run tests on (and change `ExpTableGenerator.m` accordingly)

## Step by Step

Here we will explain how to go from desiging the input table, to modifying the helper functions, to handling how the outputs are organized into a final table.

### Step One: Table Generator 

The `ExpTableGenerator.m` file uses the selected OpenFAST inputs given to make an InputTable for each experiment.  The resulting table is saved as a text file and will be read by the `ExpDriver.m` script.  Each column represents an independent variable that will trigger a change in the files for OpenFAST to read.  Each test is a row of the table; a unique configuration of the inputs.  Taken together, all of the rows of the table will help to answer some question about wind turbine engineering.  Follow the comments within the table generator file in order to see where to make changes.  Two important lines to pay attention to:

- Not

### Step Two: How to Run a Simulation



### Step Three: Set-Up Function



### Step Four: Anatomy of a Helper Function 



### Step Five: Output Channel Control



### Step Six: Setting up Driver



### Step Seven: Setting up the Parameters of the Result Table



### Process for Running

- Run `ExpTableGenerator.m` to generate a table of inputs for each test.
- Run `ExpDriver.m` to set up the `Simulate` folder and run OpenFAST on each test, gathering up the results from all the tests into a data table, before moving the data table and the `StatusFile.txt` to the experiment folder within the Data folder.

# Example: Morris Method Applied with 4 Inputs

This application is already set up in these files.  Follow the following steps to recreate results.
1. Run `ExpTableGenerator.m`
2. Run `ExpDriver.m`
3. Run ONLY the second section and beyond within `MorrisMethod.iypn`.  Follow the comments to make changes to look at different outputs.
