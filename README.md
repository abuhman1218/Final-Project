# Final-Project
Combustion Reaction of Hydrocarbons
Directions for how to run the code:
The file being read needs to be a .csv file saved in the Matlab folder. 
The file I used, I made on excel and in the first column I put whatever number hydrocarbon I was on, so methane was one, ethane was 2, and so on. 
The second column was the time from 0 to 60 minutes, so there are seven data points for each graph because it was a hydrocarbon burned to completion over and hour. 
The third column was the CO2 produced and the fourth was the H2O produced. The data uploaded in a file needs to have ten elements used over an hour counting by tens from 0 to 60. 
To get it to run, put the name of the file on line 83, so filename = ‘nameOfFile.csv’. 
If more elements were used, the value for j on line 85 would have to change from 1:10 to 1: however many elements were used.
The scrollbar would also have to be updated to scroll to stop more than 10 times. 
If more than 7 times are used, the I value on line 91 would have to change. 
Once all this is set, simply run the code and it will graph the file. 
The radio buttons can be clicked to get the different products. 
The scrollbar is activated by clicking the animate button. 
The pushbuttons is used by simply clicking it and seeing what happens when CH2 is added.
