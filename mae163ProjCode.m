%MAE 163 Research Report
clear all; clc;

cd300Price = 120000; %$
io550Price = 55000; %$ 
cd155Price = 75000; %$
io360Price = 55000; %$

dieselPrice = 4.69; %$
jetAPrice = 5.57; %$
avgasPrice = 6.46; %$

cd300Burn = 9.2; %gallons/hour
io550Burn = 17.5; %gallons/hour
io550TBO= 2200; %hours
cd300tbo = 2000; %hours
cd155burn = 4.89;
cd155tbr = 2100;
io360Burn = 9;
io360tbo = 1500;


%x = linspace(1, 20000, 100);
%plot(x, cd300Price + dieselPrice*x, x, io550Price + avgasPrice*x)


cd155Cost_Diesel = [];
cd155Cost_JetA = [];
io360Cost = [];
cd300Cost_Diesel = [];
cd300Cost_JetA = [];
io550Cost = [];

cd155TotalCost_Diesel = cd155Price;
cd155TotalCost_JetA = cd155Price;
io360TotalCost = io360Price;
cd300TotalCost_Diesel = cd300Price;
cd300TotalCost_JetA = cd300Price;
io550TotalCost = io550Price;

cd155NewCost_Diesel = 0;
cd155NewCost_JetA = 0;
io360NewCost = 0;
cd300NewCost_Diesel = 0;
cd300NewCost_JetA = 0;
io550NewCost = 0;

maxHours = 7500;

for i = 1:maxHours
    cd155TotalCost_Diesel = cd155TotalCost_Diesel + cd155burn * dieselPrice; 
    cd155TotalCost_JetA = cd155TotalCost_JetA + cd155burn * jetAPrice;     
    io360TotalCost = io360TotalCost + io360Burn * avgasPrice;               
    cd300TotalCost_Diesel = cd300TotalCost_Diesel + cd300Burn * dieselPrice;
    cd300TotalCost_JetA = cd300TotalCost_JetA + cd300Burn * jetAPrice;
    io550TotalCost = io550TotalCost + io550Burn * avgasPrice;   
if rem(i, cd155tbr) == 0
    cd155NewCost_Diesel = cd155NewCost_Diesel + cd155Price;
    cd155NewCost_JetA = cd155NewCost_JetA + cd155Price;
end
    
if rem(i, io360tbo) == 0
    io360NewCost = io360NewCost + io360Price;
end
    
if rem(i, cd300tbo) == 0
    cd300NewCost_Diesel = cd300NewCost_Diesel + cd300Price;
    cd300NewCost_JetA = cd300NewCost_JetA + cd300Price;
end
    
if rem(i, io550TBO) == 0
    io550NewCost = io550NewCost + io550Price;
end

    cd155Cost_Diesel = [cd155Cost_Diesel, cd155NewCost_Diesel + cd155TotalCost_Diesel];
    cd155Cost_JetA = [cd155Cost_JetA, cd155NewCost_JetA + cd155TotalCost_JetA];
    io360Cost = [io360Cost, io360NewCost + io360TotalCost];
    cd300Cost_Diesel = [cd300Cost_Diesel, cd300NewCost_Diesel + cd300TotalCost_Diesel];
    cd300Cost_JetA = [cd300Cost_JetA, cd300NewCost_JetA + cd300TotalCost_JetA];
    io550Cost = [io550Cost, io550NewCost + io550TotalCost];
end

figure;
plot(1:maxHours, cd155Cost_Diesel, 'b', 'LineWidth', 2) 
hold on;
plot(1:maxHours, cd155Cost_JetA, 'g', 'LineWidth', 2)  
plot(1:maxHours, io360Cost, 'r', 'LineWidth', 2)        
hold off;

xlabel('Hours');
ylabel('Total Cost ($)');
title('Total Cost of Operating CD-155 (Diesel & Jet A) vs IO-360');
legend('CD-155 (Diesel)', 'CD-155 (Jet A)', 'IO-360 (Avgas)', 'Location', 'northwest', 'FontSize', 14);
grid on;
ylim([0 max([cd155Cost_Diesel, cd155Cost_JetA, io360Cost])]); 
set(gca, 'FontSize', 14);

figure;
plot(1:maxHours, cd300Cost_Diesel, 'c', 'LineWidth', 2) 
hold on;
plot(1:maxHours, cd300Cost_JetA, 'b', 'LineWidth', 2)   
plot(1:maxHours, io550Cost, 'm', 'LineWidth', 2)        
hold off;

xlabel('Hours');
ylabel('Total Cost ($)');
title('Total Cost of Operating CD-300 (Diesel & Jet A) vs IO-550 (AVGAS 100LL');
legend('CD-300 (Diesel)', 'CD-300 (Jet A)', 'IO-550 (Avgas 100LL)', 'Location', 'northwest','FontSize', 14);
grid on;
ylim([0 max([cd300Cost_Diesel, cd300Cost_JetA, io550Cost])]);
set(gca, 'FontSize', 14);