
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The GUI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout =Supervision(varargin)

% Simulink model
modelName = 'Microgrid_24h_Simulation';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read the parameters from the workspace %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Execute MATLAB expression in specified workspace(Allow visibility for the GUI)
Ins_M=evalin('caller','Ins_Monsoon');         
Ins_I=evalin('caller',' Ins_Intermediate');   
Ins_W=evalin('caller','Ins_Winter'); 
Temp1=evalin('caller','Temp1');
Temp2=evalin('caller','Temp2');
Temp3=evalin('caller','Temp3');
xdiscretized=evalin('caller','xdiscretized'); 
ActivePower_dataALLMonsoon=evalin('caller','newyfitdiscretized1');
ActivePower_dataALLIntermediate=evalin('caller','newyfitdiscretized2');
ActivePower_dataALLWinter=evalin('caller','newyfitdiscretized3');
ActivePower_dataDMonsoon=evalin('caller','newyfitdiscretized4');
ActivePower_dataDIntermediate=evalin('caller','newyfitdiscretized5');
ActivePower_dataDWinter=evalin('caller','newyfitdiscretized6');
ActivePower_dataEMonsoon=evalin('caller','newyfitdiscretized7');
ActivePower_dataEIntermediate=evalin('caller','newyfitdiscretized8');
ActivePower_dataEWinter=evalin('caller','newyfitdiscretized9');
ActivePower_dataCMonsoon=evalin('caller','newyfitdiscretized10');
ActivePower_dataCIntermediate=evalin('caller','newyfitdiscretized11');
ActivePower_dataCWinter=evalin('caller','newyfitdiscretized12');
ActivePower_dataAMonsoon=evalin('caller','newyfitdiscretized13');
ActivePower_dataAIntermediate=evalin('caller','newyfitdiscretized14');
ActivePower_dataAWinter=evalin('caller','newyfitdiscretized15');
ActivePower_dataBMonsoon=evalin('caller','newyfitdiscretized16');
ActivePower_dataBIntermediate=evalin('caller','newyfitdiscretized17');
ActivePower_dataBWinter=evalin('caller','newyfitdiscretized18');
ActivePower_dataLHMonsoon=evalin('caller','newyfitdiscretized19');
ActivePower_dataLHIntermediate=evalin('caller','newyfitdiscretized20');
ActivePower_dataLHWinter=evalin('caller','newyfitdiscretized21');
ActivePower_dataRHMonsoon=evalin('caller','newyfitdiscretized22');
ActivePower_dataRHIntermediate=evalin('caller','newyfitdiscretized23');
ActivePower_dataRHWinter=evalin('caller','newyfitdiscretized24');
jpg=evalin('caller','jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create the user interface %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  Create and then hide the GUI as it is being constructed.
f = figure('Visible','off','Position',[360,500,450,285],'MenuBar','None');

% Change the name of the window
set(f,'Name','Design of a Solar Microgrid','NumberTitle','off')

% Construct the components %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add "Monsoon" button to window
hmonsoon = uicontrol('Style','pushbutton','String','Monsoon',...
  'Parent', f, ...
  'Position',[15,250,30,10],...
  'Callback',{@monsoonbutton_Callback});

% Add "Intermediate" button to window
hintermediate = uicontrol('Style','pushbutton','String','Intermediate',...
  'Parent', f, ...
  'Position',[15,235,30,10],...
  'Callback',{@intermediatebutton_Callback});

% Add "Winter" button to window
hwinter = uicontrol('Style','pushbutton',...
  'Parent', f, ...
  'String','Winter',...
  'Position',[15,220,30,10],...
  'Callback',{@winterbutton_Callback}); 

% Add "Run" button to window
hrun = uicontrol('Style','pushbutton',...
  'Parent', f, ...
  'String','Run',...
  'Tag','run',...
  'Enable','on',...
  'Position',[15,100,30,10],...
  'Callback',{@runbutton_Callback}); 

% Add "Stop" button to window
hstop = uicontrol('Style','pushbutton',...
  'Parent', f, ...
  'String','Stop',...
  'Tag','stop',...
  'Position',[15,85,30,10],...
  'Enable','off',...
  'Callback',{@stopbutton_Callback}); 


% Add "Temperature outside = �C" text to window
htext1 = uicontrol('Style','text','String','Temperature outside = �C',...
  'Position',[15,205,50,5]);

% Add "SUPERVISION" text to window
htext2 = uicontrol('Style','text','String','SUPERVISION',...
  'Position',[0,275,450,10],'FontSize', 16); 

% Add "Temperature pannel =  �C" text to window
htext3 = uicontrol('Style','text','String','Temperature pannel =  �C',...
  'Position',[15,195,50,5]); 

% Add Vertical ligne to window
htext4 = uicontrol('Style','text','String','',...
  'Position',[90,0,1,185]);

% Add Vertical ligne to window
htext5 = uicontrol('Style','text','String','',...
  'Position',[210,0,1,275]); 

% Add Horizontal ligne to window
htext7 = uicontrol('Style','text','String','',...
  'Position',[0,185,210,1]);

% Add "ESTIMATED INSOLATION" to window
htext8 = uicontrol('Style','text','String','ESTIMATED INSOLATION',...
  'Position',[70,269,80,5]);

% Add "PARAMETERS" text to window
htextparameters = uicontrol('Style','text','String','PARAMETERS',...
  'Position',[5,179,80,5]);

% Add "LOAD PROFIL" text to window
htextpower = uicontrol('Style','text','String','LOAD PROFIL',...
  'Position',[112.5,179,80,5]);

% Add "STABILITY OF THE GRID" text to window
htextstability = uicontrol('Style','text','String','STABILITY OF THE GRID',...
  'Position',[290,269,80,5]); 

% Add text to window
htextboxpopup = uicontrol('Style','text','String','Choose the block according the season',...
  'Position',[15,135,70,5]);

% Add "'All Blocks','Block D','Block E','Block C', 'Block A','Block B','Block LH','Block RH" pop-up button to window
hpopup = uicontrol('Style','popupmenu',...
  'Parent', f, ...
  'String',{'All Blocks Monsoon','All Blocks Intermediate','All Blocks Winter','Block D Monsoon','Block D Intermediate','Block D Winter',...
  'Block E Monsoon','Block E Intermediate','Block E Winter','Block C Monsoon','Block C Intermediate','Block C Winter','Block A Monsoon','Block A Intermediate',...
  'Block A Winter','Block B Monsoon','Block B Intermediate','Block B Winter','Block LH Monsoon','Block LH Intermediate','Block LH Winter','Block RH Monsoon','Block RH Intermediate','Block RH Winter'},...
  'Position',[15,120,50,15],...
  'Enable','on',...
  'Callback',{@popup_menu_Callback});  

% Add "h1" axe to window (Insolation)
h1 = axes('Units','Pixels','Position',[107.5,200,95,60]);

% Add "h2" axe to window (Active power)
h2 = axes('Units','Pixels','Position',[107.5,110,95,60]); 

% Add "h3" axe to window (Reactive power)
h3 = axes('Units','Pixels','Position',[107.5,20,95,60]); 

% Add "h4" axe to window (Voltage)
h4 = axes('Parent', f, ...
    'Tag','h4',...
    'Units','Pixels','Position',[227.5,200,95,60],'Tag','newdata4');

% Add "h5" axe to window (Frequency)
h5 = axes('Parent', f, ...
    'Tag','h5',...
    'Units','Pixels','Position',[227.5,110,95,60],'Tag','newdata5');

% Add "h6" axe to window (State of charge SOC)
h6 = axes('Parent', f, ...
    'Tag','h6',...
    'Units','Pixels','Position',[227.5,20,95,60],'Tag','newdata6');

% Add "h8" axe to window (State of charge SOC)
h8 = axes('Parent', f, ...
    'Tag','h8',...
    'Units','Pixels','Position',[350,200,95,60],'Tag','newdata8');

% Add "h9" axe to window (State of charge SOC)
h9 = axes('Parent', f, ...
    'Tag','h9',...
    'Units','Pixels','Position',[350,110,95,60],'Tag','newdata9');

% Add "h10" axe to window (State of charge SOC)
h10 = axes('Parent', f, ...
    'Tag','h10',...
    'Units','Pixels','Position',[350,20,95,60],'Tag','newdata10');

% Add text to window
htexttxtbox1 = uicontrol('Style','text','String','Enter the number of pannel',...
  'Position',[15,165,50,5]);
% Add Text box to window 
txtbox1 = uicontrol(f,'Style','edit',...
  'String','',...
  'Position',[15 160 15 5]);
% Add text to window
htexttxtbox2 = uicontrol('Style','text','String','Enter the number of battery',...
  'Position',[15,150,50,5]);
% Add Text box to window
txtbox2 = uicontrol(f,'Style','edit',...
   'String','',...
   'Position',[15 145 15 5]);

% Add "h7" axe to window (Picture)
h7 = axes('Units','Pixels','Position',[10,10,70,70]); 

% Initialize the GUI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add picture to window 
imshow(jpg);
title('Bhutan Project');


% Align elements in parameters 
align([hmonsoon,hintermediate,hwinter,hstop,htextboxpopup,hrun,htexttxtbox1,htexttxtbox2,htext1,htext3,txtbox1,txtbox2,htextparameters,h7,hpopup],'Center','None');

% Color 
set(hrun,'BackgroundColor', [0.396 1 0.558]);
set(hstop,'BackgroundColor', [1 0.286 0.145]);

% Change units to normalized so components resize automatically.
set([f,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,hmonsoon,hintermediate,htextboxpopup,htexttxtbox1,htexttxtbox2,hwinter,hstop,hrun,txtbox1,txtbox2,htext1,htext8,htext2,htext3,htext7,htext4,htext5,htextparameters,htextstability,htextpower,hpopup],...
'Units','normalized');

% Full screen
set(f, 'Units', 'Normalized', 'Position', [0 0 1 1]);

% Initialize a plot in the axes
SampleTime=0.1;
xdiscretized=0.1:SampleTime:2.4;

% Initialize the plot h1 with Ins_Monsoon from DataBase.m
plot(h1,xdiscretized*10,Ins_M,'m'); 
xlabel(h1,'Time (Hours)');
ylabel(h1,'Insolation (W/m�)');
title(h1,'Insolation during the Monsoon');
grid(h1,'on');
set(htext1, 'String', 'Temperature outside = 26.8�C');
set(htext3, 'String', 'Temperature pannel = 46�C');
% Vector Data for the Simulink (Insolation)
VARins = [xdiscretized;Ins_M];
% Vector Data for the Simulink (Temperature)
VARTemp = [xdiscretized;Temp1];
% Vector Data for the Simulink (Power)
VARPA= [xdiscretized;ActivePower_dataALLMonsoon];
VARPQ= [xdiscretized;ActivePower_dataALLMonsoon/10];
% Write Data vectors in the workspace for the Simulink 
assignin('base', 'VARins', VARins);
assignin('base', 'VARTemp', VARTemp);
assignin('base', 'VARPA', VARPA);
assignin('base', 'VARPQ', VARPQ);

% Initialize variable clock generate by the simulink mandatory for the use of linkdata
clock=0;
assignin('base','clock', clock);
superclock=[clock;clock;clock];
assignin('base', 'superclock', superclock);

Achargecontrol=0;
assignin('base', 'Achargecontrol', Achargecontrol);
 
% Initialize axes h4 voltage
Av =[0;0;0]
assignin('base','Av', Av);
Bv =[0;0;0];
assignin('base','Bv', Bv);
H4=plot(h4,Av,Bv,'ro');
% xlim(h4,[0 25]);
ylim(h4,[-1000 1000]);
set(H4,'XDataSource','Av')
set(H4,'YDataSource','Bv')
xlabel(h4,'Time (Hours)');
ylabel(h4,'Load Voltage (V)');
title(h4,'Voltage Grid');
grid(h4,'on');

%Initialize axes h5 frequency
Af = 0;
assignin('base','Af', Af);
Bf = 0;
assignin('base','Bf', Bf);
H5=plot(h5,Af,Bf);
% xlim(h5,[0 25]);
ylim(h5,[-100 100]);
set(H5,'XDataSource','Af')
set(H5,'YDataSource','Bf')
xlabel(h5,'Time (Hours)');
ylabel(h5,'f (Hz)');
title(h5,'Frequency');
grid(h5,'on');

% Initialize axes h6 state of charge SOC
Asoc = 0;
assignin('base','Asoc', Asoc);
Bsoc = 0;
assignin('base','Bsoc', Bsoc);
H6=plot(h6,Asoc,Bsoc,'m');
% xlim(h6,[0 25]);
ylim(h6,[0 100]);
set(H6,'XDataSource','Asoc')
set(H6,'YDataSource','Bsoc')
xlabel(h6,'Time (Hours)');
ylabel(h6,'SOC (%)');
title(h6,'State of charge');
grid(h6,'on');

% Initialize axes h8 Load current
Acurrent = [0;0;0];
assignin('base','Acurrent', Acurrent);
Bcurrent = [0;0;0];
assignin('base','Bcurrent', Bcurrent);
H8=plot(h8,Acurrent,Bcurrent,'ro');
% xlim(h8,[0 25]);
set(H8,'XDataSource','Acurrent')
set(H8,'YDataSource','Bcurrent')
xlabel(h8,'Time (Hours)');
ylabel(h8,'Current (A)');
title(h8,'Load Current');
grid(h8,'on');

% Initialize axes h9 Load active power
Aactivepower = 0;
assignin('base','Aactivepower', Aactivepower);
Bactivepower = 0;
assignin('base','Bactivepower', Bactivepower);
H9=plot(h9,Aactivepower,Bactivepower,'g');
% xlim(h9,[0 25]);
set(H9,'XDataSource','Aactivepower')
set(H9,'YDataSource','Bactivepower')
xlabel(h9,'Time (Hours)');
ylabel(h9,'Active Power (W)');
title(h9,'Load Active Power');
grid(h9,'on');

% Initialize axes h10 Load reactive power
Areactivepower = 0;
assignin('base','Areactivepower', Areactivepower);
Breactivepower = 0;
assignin('base','Breactivepower', Breactivepower);
H10=plot(h10,Aactivepower,Bactivepower,'r');
% xlim(h10,[0 25]);
set(H10,'XDataSource','Areactivepower')
set(H10,'YDataSource','Breactivepower')
xlabel(h10,'Time (Hours)');
ylabel(h10,'Reactive Power (kVAR)');
title(h10,'Load Reactive Power');
grid(h10,'on');

% Initialize plot h2 for the Active power with dataBase/PowerAllMonsoon.mat
plot(h2,xdiscretized*10,ActivePower_dataALLMonsoon);
xlabel(h2,'Time (Hours)');
ylabel(h2,'Active Power (kW)');
title(h2,'Active Power All Blocks during Monsoon');

% Initialize plote h3 for the Reactive power (In our case we make an assumption, it is just the Active power divided by 10).
plot(h3,xdiscretized*10,ActivePower_dataALLMonsoon/10,'r');
xlabel(h3,'Time (Hours)');
ylabel(h3,'Reactive Power (kVAR)');
title(h3,'Reactive Power All Blocks during Monsoon')

% Initialize grid 
grid(h2,'on');
grid(h3,'on');
grid(h4,'on');
grid(h5,'on');
grid(h6,'on');

% Move the GUI to the center of the screen.
movegui(f,'center');

% Make the GUI visible.
set(f,'Visible','on');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Callback Function for the popup menu %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function popup_menu_Callback(source, eventdata, handles)

 % Determine the selected data set.
 str = get(source, 'String');
 val = get(source,'Value');

 % Set current data to the selected data set.
 switch str{val};           

 % User selects All Blocks %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'All Blocks Monsoon'  
 plot(h2,xdiscretized*10,ActivePower_dataALLMonsoon);
 title(h2,'Active Power All Blocks during the Monsoon');
 xlabel(h2,'Time (Hours)');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataALLMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power All Blocks during the Monsoon')
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataALLMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataALLMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'All Blocks Intermediate'  
 plot(h2,xdiscretized*10,ActivePower_dataALLIntermediate);
 title(h2,'Active Power All Blocks during the Intermediate Season');
 xlabel(h2,'Time (Hours)');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataALLIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power All Blocks during the Intermediate Season')
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataALLIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataALLIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'All Blocks Winter'  
 plot(h2,xdiscretized*10,ActivePower_dataALLWinter);
 title(h2,'Active Power All Blocks during the Winter');
 xlabel(h2,'Time (Hours)');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataALLWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power All Blocks during the Winter')
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataALLWinter];
 VARPQ= [xdiscretized;ActivePower_dataALLWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 % User selects Block D %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'Block D Monsoon' 
 plot(h2,xdiscretized*10,ActivePower_dataDMonsoon);
 title(h2,'Active Power Block D during the Monsoon');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataDMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block D during the Monsoon');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataDMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataDMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block D Intermediate' 
 plot(h2,xdiscretized*10,ActivePower_dataDIntermediate);
 title(h2,'Active Power Block D during the Intermediate Season');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataDIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block D during the Intermediate Season');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataDIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataDIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block D Winter' 
 plot(h2,xdiscretized*10,ActivePower_dataDWinter);
 title(h2,'Active Power Block D during the Winter');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataDWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block D during the Winter');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataDWinter];
 VARPQ= [xdiscretized;ActivePower_dataDWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 % User selects Block E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'Block E Monsoon' 
 plot(h2,xdiscretized*10,ActivePower_dataEMonsoon);
 title(h2,'Active Power Block E during the Monsoon');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataEMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block E during the Monsoon');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp= [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataEMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataEMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block E Intermediate' 
 plot(h2,xdiscretized*10,ActivePower_dataEIntermediate);
 title(h2,'Active Power Block E during the Intermediate Season');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataEIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block E during the Intermediate Season')
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataEIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataEIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block E Winter' 
 plot(h2,xdiscretized*10,ActivePower_dataEWinter);
 title(h2,'Active Power Block E during the Winter');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataEWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block E during the Winter');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataEWinter];
 VARPQ= [xdiscretized;ActivePower_dataEWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 % User selects Block C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'Block C Monsoon' 
 plot(h2,xdiscretized*10,ActivePower_dataCMonsoon);
 title(h2,'Active Power Block C during the Monsoon');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataCMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block C during the Monsoon');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataCMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataCMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block C Intermediate' 
 plot(h2,xdiscretized*10,ActivePower_dataCIntermediate);
 title(h2,'Active Power Block C during the Intermediate Season');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataCIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block C during the Intermediate Season');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataCIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataCIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block C Winter' 
 plot(h2,xdiscretized*10,ActivePower_dataCWinter);
 title(h2,'Active Power Block C during the Winter');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataCWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block C during the Winter');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataCWinter];
 VARPQ= [xdiscretized;ActivePower_dataCWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 % User selects Block A %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'Block A Monsoon' 
 plot(h2,xdiscretized*10,ActivePower_dataAMonsoon);
 title(h2,'Active Power Block A during the Monsoon');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataAMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block A during the Monsoon');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataAMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataAMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block A Intermediate' 
 plot(h2,xdiscretized*10,ActivePower_dataAIntermediate);
 title(h2,'Active Power Block A during the Intermediate Season');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataAIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block A during the Intermediate Season');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataAIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataAIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block A Winter' 
 plot(h2,xdiscretized*10,ActivePower_dataAWinter);
 title(h2,'Active Power Block A during the Winter');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataAWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block A during the Winter');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataAWinter];
 VARPQ= [xdiscretized;ActivePower_dataAWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 % User selects Block B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'Block B Monsoon' 
 plot(h2,xdiscretized*10,ActivePower_dataBMonsoon);
 title(h2,'Active Power Block B during the Monsoon');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataBMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block B during the Monsoon');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataBMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataBMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block B Intermediate' 
 plot(h2,xdiscretized*10,ActivePower_dataBIntermediate);
 title(h2,'Active Power Block B during the Intermediate Season');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataBIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block B during the Intermediate Season');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataBIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataBIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block B Winter'
 plot(h2,xdiscretized*10,ActivePower_dataBWinter);
 title(h2,'Active Power Block B during the Winter');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataBWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block B during the Winter');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataBWinter];
 VARPQ= [xdiscretized;ActivePower_dataBWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 % User selects Block LH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'Block LH Monsoon' 
 plot(h2,xdiscretized*10,ActivePower_dataLHMonsoon);
 title(h2,'Active Power Block LH during the Monsoon');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataLHMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block LH during the Monsoon');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataLHMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataLHMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block LH Intermediate' 
 plot(h2,xdiscretized*10,ActivePower_dataLHIntermediate);
 title(h2,'Active Power Block LH during the Intermediate Season');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataLHIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block LH during the Intermediate Season');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataLHIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataLHIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block LH Winter' 
 plot(h2,xdiscretized*10,ActivePower_dataLHWinter);
 title(h2,'Active Power Block LH during the Winter');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataLHWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block LH during the Winter');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataLHWinter];
 VARPQ= [xdiscretized;ActivePower_dataLHWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 % User selects Block RH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'Block RH Monsoon'
 plot(h2,xdiscretized*10,ActivePower_dataRHMonsoon);
 title(h2,'Active Power Block RH during the Monsoon');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataRHMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block RH during the Monsoon');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataRHMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataRHMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block RH Intermediate'
 plot(h2,xdiscretized*10,ActivePower_dataRHIntermediate);
 title(h2,'Active Power Block RH during the Intermediate Season');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataRHIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block RH during the Intermediate Season');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataRHIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataRHIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block RH Winter'
 plot(h2,xdiscretized*10,ActivePower_dataRHWinter);
 title(h2,'Active Power Block RH during the Winter');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized*10,ActivePower_dataRHWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block RH during the Winter');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataRHWinter];
 VARPQ= [xdiscretized;ActivePower_dataRHWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);
 end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Callback Function for the monsoon button %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function monsoonbutton_Callback(source, eventdata, handles) 

% Plot monsoon season from dataBase
plot(h1,xdiscretized*10,Ins_M,'r'); 
xlabel(h1,'Time (Hours)');
ylabel(h1,'Insolation (W/m�)');
title(h1,'Insolation during the Monsoon');
grid(h1,'on');
set(htext1, 'String', 'Temperature outside = 26.8�C');
set(htext3, 'String', 'Temperature pannel = 46�C');
% Turn off the monsoon button
set(hmonsoon,'Enable','off');
set(hintermediate,'Enable','on');
set(hwinter,'Enable','on');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Callback Function for the intermediate button %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function intermediatebutton_Callback(source, eventdata, handles) 

% Plot intemediate season from dataBase
plot(h1,xdiscretized*10,Ins_I,'m');
xlabel(h1,'Time (Hours)');
ylabel(h1,'Insolation (W/m�)');
title(h1,'Insolation during the Intermediate Season');
grid(h1,'on');
set(htext1, 'String', 'Temperature outside = 17.4�C');
set(htext3, 'String', 'Temperature pannel = 46�C');

% Turn off the intermediate button
set(hmonsoon,'Enable','on');
set(hintermediate,'Enable','off');
set(hwinter,'Enable','on');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Callback Function for the winter button %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function winterbutton_Callback(source, eventdata, handles) 

% Plot winter season from dataBase
plot(h1,xdiscretized*10,Ins_W,'g');
xlabel(h1,'Time (Hours)');
ylabel(h1,'Insolation (W/m�)');
title(h1,'Insolation during the Winter');
grid(h1,'on');
set(htext1, 'String', 'Temperature outside = 23.4�C');
set(htext3, 'String', 'Temperature pannel = 46�C');

% Turn off the winter button
set(hmonsoon,'Enable','on');
set(hintermediate,'Enable','on');
set(hwinter,'Enable','off');

end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Callback Function for the run button %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function runbutton_Callback(source, eventdata, handles)
      
% toggle the buttons %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Turn off the Start button
set(hrun,'Enable','off');
% Turn on the Stop button
set(hstop,'Enable','on');
% Turn off the popup menu
set(hpopup,'Enable','off');
% % Turn on the update button
% set(hupdate,'Enable','on');
% Turn off  
set(txtbox2,'Enable','off');
set(txtbox1,'Enable','off');

% start the model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set_param(modelName,'SimulationCommand','start');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Callback Function for the stop button %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function stopbutton_Callback(source, eventdata, handles) 
    
% toggle the buttons %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Turn on the Start button
set(hrun,'Enable','on');
% Turn off the Stop button
set(hstop,'Enable','off');
% Turn on the popup menu
set(hpopup,'Enable','on');
% % Turn off the update button
% set(hupdate,'Enable','off');
% Turn on 
set(txtbox2,'Enable','on');
set(txtbox1,'Enable','on');

% stop the model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set_param(modelName,'SimulationCommand','stop');

end

end


function varargout = updategui(varargin)
    
% Take the data from the simulink %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Time
rtoc = get_param('Microgrid_24h_Simulation/Subsystem/Clock','RuntimeObject');
clock= rtoc.OutputPort(1).Data;
superclock=[clock;clock;clock];
assignin('base', 'clock', clock);
assignin('base', 'superclock', superclock);
 
% Voltage
rto1 = get_param('Microgrid_24h_Simulation/Subsystem/Gain1','RuntimeObject');
voltage= rto1.OutputPort(1).Data;
assignin('base','voltage', voltage);

% Frequency
rto2 = get_param('Microgrid_24h_Simulation/Subsystem/Gain2','RuntimeObject');
frequency= rto2.OutputPort(1).Data;
assignin('base','frequency', frequency);

% SOC
rto3 = get_param('Microgrid_24h_Simulation/Subsystem/Gain3','RuntimeObject');
SOC= rto3.OutputPort(1).Data;
assignin('base', 'SOC', SOC);

 
% Load current
rto4 = get_param('Microgrid_24h_Simulation/Subsystem/Gain4','RuntimeObject');
current= rto4.OutputPort(1).Data;
assignin('base','current', current);

% Load active power
rto5 = get_param('Microgrid_24h_Simulation/Subsystem/Gain5','RuntimeObject');
activepower= rto5.OutputPort(1).Data;
assignin('base','activepower', activepower);

% Load reactive power
rto6 = get_param('Microgrid_24h_Simulation/Subsystem/Gain6','RuntimeObject');
reactivepower= rto6.OutputPort(1).Data;
assignin('base','reactivepower', reactivepower);

% Load chargecontrol
rto7 = get_param('Microgrid_24h_Simulation/Subsystem/Gain7','RuntimeObject');
chargecontrol= rto7.OutputPort(1).Data;
assignin('base','chargecontrol', chargecontrol);

% Dynamic upload of the data to files for the plot frequency 

Af=evalin('caller','Af');
Bf=evalin('caller','Bf');

    if size(Af)==size(Bf)
        
    % Open and write the new value of clock in clocktxt    
    fid = fopen('dataBase/clocktxt.txt','a+');
    fprintf(fid,' %i\n',clock);
    fclose(fid)
    fid = fopen('dataBase/clocktxt.txt','r');
    Af = fscanf(fid,'%f');
    assignin('base','Af', Af);
    fclose(fid);
    
    % Open and write the new value of frequency in frequencytxt
    fid2 = fopen('dataBase/frequencytxt.txt','a+');
    fprintf(fid2,' %i\n',frequency);
    fclose(fid2)
    fid2 = fopen('dataBase/frequencytxt.txt','r');
    Bf = fscanf(fid2,'%f');
    assignin('base','Bf', Bf);
    fclose(fid2);

    elseif size(Bf)<size(Af)
        
    % Open and write the new value of frequency in frequencytxt    
    fid2 = fopen('dataBase/frequencytxt.txt','a+');
    fprintf(fid2,' %i\n',frequency);
    fclose(fid2)
    fid2 = fopen('dataBase/frequencytxt.txt','r');
    Bf = fscanf(fid2,'%f');
    assignin('base','Bf', Bf);
    fclose(fid2);

    elseif size(Bf)>size(Af)
        
    % Open and write the new value of clock in clocktxt      
    fid = fopen('dataBase/clocktxt.txt','a+');
    fprintf(fid,' %i\n',clock);
    fclose(fid)
    fid = fopen('dataBase/clocktxt.txt','r');
    Af = fscanf(fid,'%f');
    assignin('base','Af', Af);
    fclose(fid); 
    end


% Dynamic upload of the data to files for the plot voltage %%%%%%%%%%%%%%% 

Av=evalin('caller','Av');
Bv=evalin('caller','Bv');

    if size(Av)==size(Bv)
        
    % Open and write the new value of clock in clocktxtvoltage     
    fidv = fopen('dataBase/clocktxtvoltage.txt','a+');
    fprintf(fidv,' %i\n',superclock);
    fclose(fidv)
    fidv = fopen('dataBase/clocktxtvoltage.txt','r');
    Av = fscanf(fidv,'%f');
    assignin('base','Av', Av);
    fclose(fidv);
    
    % Open and write the new value of voltage in voltagetxt
    fid1 = fopen('dataBase/voltagetxt.txt','a+');
    fprintf(fid1,' %i\n',voltage);
    fclose(fid1)
    fid1 = fopen('dataBase/voltagetxt.txt','r');
    Bv = fscanf(fid1,'%f');
    assignin('base','Bv', Bv);
    fclose(fid1);

    elseif size(Bv)<size(Av)
        
    % Open and write the new value of voltage in voltagetxt    
    fid1 = fopen('dataBase/voltagetxt.txt','a+');
    fprintf(fid1,' %i\n',voltage);
    fclose(fid1)
    fid1 = fopen('dataBase/voltagetxt.txt','r');
    Bv = fscanf(fid1,'%f');
    assignin('base','Bv', Bv);
    fclose(fid1);

    elseif size(Bv)>size(Av)
        
    % Open and write the new value of clock in clocktxtvoltage   
    fidv = fopen('dataBase/clocktxtvoltage.txt','a+');
    fprintf(fidv,' %i\n',superclock);
    fclose(fidv)
    fidv = fopen('dataBase/clocktxtvoltage.txt','r');
    Av = fscanf(fidv,'%f');
    assignin('base','Av',Av);
    fclose(fidv); 
    
    end
    
% Dynamic upload of the data for the plot SOC %%%%%%%%%%%%%%%%%%%%%%%%%%%%

Asoc=evalin('caller','Asoc');
Bsoc=evalin('caller','Bsoc');

    if size(Asoc)==size(Bsoc)
        
    % Open and write the new value of clock in clocktxtsoc  
    fidsoc = fopen('dataBase/clocktxtsoc.txt','a+');
    fprintf(fidsoc,' %i\n',clock);
    fclose(fidsoc)
    % Update the plot
    fidsoc = fopen('dataBase/clocktxtsoc.txt','r');
    Asoc = fscanf(fidsoc,'%f');
    assignin('base','Asoc', Asoc);
    fclose(fidsoc);
    
    % Open and write the new value of SOC in soctxt
    fid3 = fopen('dataBase/soctxt.txt','a+');
    fprintf(fid3,' %i\n',SOC);
    fclose(fid3)
    fid3 = fopen('dataBase/soctxt.txt','r');
    Bsoc = fscanf(fid3,'%f');
    assignin('base','Bsoc', Bsoc);
    fclose(fid3);

    elseif size(Bsoc)<size(Asoc)
        
    % Open and write the new value of SOC in soctxt
    fid3 = fopen('dataBase/soctxt.txt','a+');
    fprintf(fid3,' %i\n',SOC);
    fclose(fid3)
    fid3 = fopen('dataBase/soctxt.txt','r');
    Bf = fscanf(fid3,'%f');
    assignin('base','Bsoc', Bsoc);
    fclose(fid3);

    elseif size(Bsoc)>size(Asoc)
        
    % Open and write the new value of SOC in soctxt 
    fidsoc = fopen('dataBase/clocktxtsoc.txt','a+');
    fprintf(fidsoc,' %i\n',clock);
    fclose(fidsoc)
    fidsoc = fopen('dataBase/clocktxtsoc.txt','r');
    Af = fscanf(fidsoc,'%f');
    assignin('base','Asoc', Asoc);
    fclose(fidsoc); 
    end
    
% Dynamic upload of the data to file for the plot current %%%%%%%%%%%%%%%%

Acurrent=evalin('caller','Acurrent');
Bcurrent=evalin('caller','Bcurrent');

    if size(Acurrent)==size(Bcurrent)
        
    % Open and write the new value of clock in clocktxtc      
    fidc = fopen('dataBase/clocktxtc.txt','a+');
    fprintf(fidc,' %i\n',superclock);
    fclose(fidc)
    fidc = fopen('dataBase/clocktxtc.txt','r');
    Acurrent = fscanf(fidc,'%f');
    assignin('base','Acurrent', Acurrent);
    fclose(fidc);
    
    % Open and write the new value of current in currenttxt
    fid4 = fopen('dataBase/currenttxt.txt','a+');
    fprintf(fid4,' %i\n',current);
    fclose(fid4)
    fid4 = fopen('dataBase/currenttxt.txt','r');
    Bcurrent = fscanf(fid4,'%f');
    assignin('base','Bcurrent', Bcurrent);
    fclose(fid4);

    elseif size(Bcurrent)<size(Acurrent)
        
    % Open and write the new value of current in currenttxt  
    fid4 = fopen('dataBase/currenttxt.txt','a+');
    fprintf(fid4,' %i\n',current);
    fclose(fid4)
    fid4 = fopen('dataBase/currenttxt.txt','r');
    Bcurrent = fscanf(fid4,'%f');
    assignin('base','Bcurrent', Bcurrent);
    fclose(fid4);

    elseif size(Bcurrent)>size(Acurrent)
        
    % Open and write the new value of clock in clocktxtc    
    fidc = fopen('dataBase/clocktxtc.txt','a+');
    fprintf(fidc,' %i\n',superclock);
    fclose(fidc)
    fidc = fopen('dataBase/clocktxtc.txt','r');
    Acurrent = fscanf(fidc,'%f');
    assignin('base','Acurrent',Acurrent);
    fclose(fidc); 
    
    end
    
% Dynamic upload of the data to file for the plot Active power %%%%%%%%%%%

Aactivepower=evalin('caller','Aactivepower');
Bactivepower=evalin('caller','Bactivepower');

    if size(Aactivepower)==size(Bactivepower)
        
    % Open and write the new value of clock in clocktxtap  
    fidap = fopen('dataBase/clocktxtap.txt','a+');
    fprintf(fidap,' %i\n',clock);
    fclose(fidap)
    % Update the plot
    fidap = fopen('dataBase/clocktxtap.txt','r');
    Aactivepower = fscanf(fidap,'%f');
    assignin('base','Aactivepower', Aactivepower);
    fclose(fidap);
    
    % Open and write the new value of SOC in soctxt
    fid5 = fopen('dataBase/activepowertxt.txt','a+');
    fprintf(fid5,' %i\n',activepower);
    fclose(fid5)
    fid5 = fopen('dataBase/activepowertxt.txt','r');
    Bactivepower = fscanf(fid5,'%f');
    assignin('base','Bactivepower', Bactivepower);
    fclose(fid5);

    elseif size(Bactivepower)<size(Aactivepower)
        
    % Open and write the new value of SOC in soctxt
    fid5 = fopen('dataBase/activepowertxt.txt','a+');
    fprintf(fid5,' %i\n',activepower);
    fclose(fid5)
    fid5 = fopen('dataBase/activepowertxt.txt','r');
    Bactivepower = fscanf(fid5,'%f');
    assignin('base','Bactivepower', Bactivepower);
    fclose(fid5);

    elseif size(Bactivepower)>size(Aactivepower)
        
    % Open and write the new value of SOC in clocktxtap 
    fidap = fopen('dataBase/clocktxtap.txt','a+');
    fprintf(fidap,' %i\n',clock);
    fclose(fidap)
    fidap= fopen('dataBase/clocktxtap.txt','r');
    Aactivepower = fscanf(fidap,'%f');
    assignin('base','Aactivepower', Aactivepower);
    fclose(fidap); 
    end
     
% Dynamic upload of the data to file for the plot Reactive power %%%%%%%%%

Areactivepower=evalin('caller','Areactivepower');
Breactivepower=evalin('caller','Breactivepower');

    if size(Areactivepower)==size(Breactivepower)
        
    % Open and write the new value of clock in clocktxtrap  
    fidrap = fopen('dataBase/clocktxtrap.txt','a+');
    fprintf(fidrap,' %i\n',clock);
    fclose(fidrap)
    % Update the plot
    fidrap = fopen('dataBase/clocktxtrap.txt','r');
    Areactivepower = fscanf(fidrap,'%f');
    assignin('base','Areactivepower', Areactivepower);
    fclose(fidrap);
    
    % Open and write the new value of SOC in reactivepowertxt
    fid5 = fopen('dataBase/reactivepowertxt.txt','a+');
    fprintf(fid5,' %i\n',reactivepower);
    fclose(fid5)
    fid5 = fopen('dataBase/reactivepowertxt.txt','r');
    Breactivepower = fscanf(fid5,'%f');
    assignin('base','Breactivepower', Breactivepower);
    fclose(fid5);

    elseif size(Breactivepower)<size(Areactivepower)
        
    % Open and write the new value of SOC in reactivepowertxt
    fid5 = fopen('dataBase/reactivepowertxt.txt','a+');
    fprintf(fid5,' %i\n',reactivepower);
    fclose(fid5)
    fid5 = fopen('dataBase/reactivepowertxt.txt','r');
    Breactivepower = fscanf(fid5,'%f');
    assignin('base','Breactivepower', Breactivepower);
    fclose(fid5);

    elseif size(Breactivepower)>size(Areactivepower)
   
    % Open and write the new value of SOC in clocktxtrap 
    fidap = fopen('dataBase/clocktxtrap.txt','a+');
    fprintf(fidap,' %i\n',clock);
    fclose(fidap)
    fidap= fopen('dataBase/clocktxtrap.txt','r');
    Areactivepower = fscanf(fidap,'%f');
    assignin('base','Areactivepower', Areactivepower);
    fclose(fidap); 
    end

% Dynamic upload of the data to file for the control charge %%%%%%%%%%%%%%
    
    Achargecontrol=evalin('caller','Achargecontrol');
    
     % Open and write the new value of controlcharge in chargecontroltxt 
    fid7 = fopen('dataBase/chargecontroltxt.txt','a+');
    fprintf(fid7,' %i\n',chargecontrol);
    fclose(fid7)
    fid7= fopen('dataBase/chargecontroltxt.txt','r');
    Achargecontrol = fscanf(fid7,'%f');
    assignin('base','Achargecontrol', Achargecontrol);
    fclose(fid7); 
   
    
% Updating Graphs with refreshdata
refreshdata

end



