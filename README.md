# Tower Experiment

## Description:

## Instructions:
Note: Requires:
- MatLab
- OpenFAST excecutable (adjust the path in the `testdriver.m` file)
- Windows machine (or properly compiled DLL file)

Before running scripts, first copy the `Template_IEA-15-240-RWT-Monopile` folder and rename it `Simulate`
Also, provide an inflow wind file to run tests on
### Process 
- Run `ExpTableGenerator.m` to generate a table of inputs for each test
- Run `ExpDriver.m` to set up the `Simulate` folder and run OpenFAST on each test, gathering up the results from all the tests into a data table
