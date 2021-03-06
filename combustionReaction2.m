function [] = combustionReaction2()
    close all;
    global gui;
    gui.fig = figure();
    gui.p = plot(0,0);
    gui.p.Parent.Position = [0.25 0.25 0.5 0.5];
    %this sets up the plot and the size of the plot
    
    gui.buttonGroup = uibuttongroup('visible','on','units','normalized','position',[0 0.4 0.15 0.2], 'selectionchangedfcn',{@radioSelect});
    gui.button1 = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .6 1 .2],'HandleVisibility','off','string','CO2');
    gui.button2 = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .2 1 .2],'HandleVisibility','off','string','H2O');
    %this makes my radio buttons to switch between CO2 and H2O
    
    gui.CH2Added = 0;
    gui.CH2DisplayMessage = uicontrol('style', 'text', 'units', 'normalized', 'position', [.77 .52 .1 .07], 'string', 'CH2 Added', 'horizontalalignment', 'left');
    gui.CH2Display = uicontrol('style', 'text', 'units', 'normalized', 'position', [.88 .54 .03 .05], 'string', num2str(gui.CH2Added), 'horizontalalignment', 'left');
    gui.hydrocarbons = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position',[.77 .6 .1 .05], 'string', 'add CH2', 'callback', {@hydrocarbons,1 });
    gui.methane = uicontrol('style','text','units','normalized','position',[0.77 0.65 0.22 0.05],'string','Starting at Methane (CH4)','horizontalalignment','left');
    %these lines are for the pushbutton which show what happen when CH2 is added to the previous hydrocarbon
    
    gui.scrollBar = uicontrol('style','slider','units','normalized','position',[0.2 0.1 0.6 0.05],'value',1,'min',1,'max',10,'sliderstep',[1/9 1/9],'callback',{@scrollbar});
    scrollbar();
    gui.animateButton = uicontrol('style','pushbutton','units','normalized','position',[0.05 0.05 0.1 0.1],'string','animate','callback',{@animate});
    %these lines run the scrollbar, so they switch between the ten different hydrocarbons that I used
    %all the lines in this main function run and they have callbacks to the functions below
end

function [] = animate (~,~)
    global gui
    for i=1:10
        gui.scrollBar.Value = i;
        scrollbar();
        pause(1);
    end
    %this function animates the scrollbar, it moves one spot and pauses for one second at each spot (or each hydrocarbon)
end

function [] = scrollbar(~,~)
    global gui;
    gui.scrollBar.Value = round(gui.scrollBar.Value);
    type = gui.buttonGroup.SelectedObject.String;
    plotSelectedHydrocarbon(type);
    %this function show what scrollbar scrolls through, it goes through the different hydrocarbons
end

function [] = radioSelect(~,~)
    global gui;
    type = gui.buttonGroup.SelectedObject.String;
    plotSelectedHydrocarbon(type);
    %this function is what makes the radio buttons run, the two radio buttons are CO2 and H2O and it plots whichever button is selected
end

function [] = hydrocarbons(source,event,CH2)
    global gui;
    gui.CH2Added = gui.CH2Added + CH2;
    gui.CH2Display.String = num2str(gui.CH2Added)
    if gui.CH2Added == 1
        msgbox('You have Ethane (C2H6)');
    elseif gui.CH2Added == 2
        msgbox('You have Propane (C2H6)');
    elseif gui.CH2Added == 3
        msgbox('You have Butane (C3H8)');
    elseif gui.CH2Added == 4
        msgbox('You have Pentane (C5H12)');
    elseif gui.CH2Added == 5
        msgbox('You have Hexane (C6H14)');
    elseif gui.CH2Added == 6
        msgbox('You have Heptane (C7H16)');
    elseif gui.CH2Added == 7
        msgbox('You have Octane (C8H18)');
	elseif gui.CH2Added == 8
        msgbox('You have Nonane (C9H20)');
	elseif gui.CH2Added == 9
        msgbox('You have Decane (C10H22)');
    elseif gui.CH2Added > 9
        msgbox('You have a Hydrocarbon');
    end
    %this function is for the pushbuttons, it adds one to the CH2Added everytime the button is pushed it is also set up to show what hydrocarbon is burned in a message box when CH2 is added
end

function [] = plotSelectedHydrocarbon(type)
    global gui;
    filename = 'Hydrocarbons.csv';
    fid = fopen(filename,'r');
    for j = 1:10
        line = fgetl(fid);
        if line == -1
            break
        end
        elements{j}.HydrocarbonString = line;
        for i = 1:7
            line = fgetl(fid);
            nums = str2num(line);
            elements{j}.time(i) = nums(2);
            elements{j}.CO2(i) = nums(3);
            elements{j}.H2O(i) = nums(4);
        end
    end
    currentHydrocarbon = gui.scrollBar.Value;
    
    if strcmp(type, 'CO2')
        gui.p = plot(elements{currentHydrocarbon}.time,elements{currentHydrocarbon}.CO2,'bx');
    else 
        gui.p = plot(elements{currentHydrocarbon}.time,elements{currentHydrocarbon}.H2O,'bx');
    end
    
    title(['Combustion Reaction Products of ' elements{currentHydrocarbon}.HydrocarbonString]);
    xlabel('Time (minutes)');
    ylabel('Products from 100 moles of Hydrocarbon Burned');
    %this function plots the data from my csv file. It reads the file and
    %takes the elements and graphs them with time on the x-axis and the
    %moles of the product created on the y-axis. It has to read differently
    %depending on what radio button has been selected. The title of the
    %graph also changes as the scrollbar scrolls through the different
    %hydrcarbons
end