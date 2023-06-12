%funtion output=functioname (varible used to input argument)
function z = ObjectiveFunction (InitialData)   

RF_form = 44.2611...                                         %1
        - 92.4334*InitialData(:,1)...                       %2        
        + 11.2251*InitialData(:,2)...                         %3
        - 0.0803844*InitialData(:,3)...                        %4
        + 0.3666*InitialData(:,4)...                        %5
        + 0.2076*InitialData(:,5)...                         %6
        + 0.00128195*InitialData(:,6)...                         %7
        - 0.00431056*InitialData(:,7)...                         %8
        + 55.9839*InitialData(:,1).^2 ...                    %9
        + 0.0983895*InitialData(:,1)*InitialData(:,3)...       %10
        + 0.00391434*InitialData(:,1)* InitialData(:,6)...       %11                         
        + 0.00576544*InitialData(:,1)* InitialData(:,7)...       %12
        - 0.0484607*InitialData(:,2)* InitialData(:,3)...       %13
        - 0.0871226*InitialData(:,2)* InitialData(:,4)...      %14
        + 0.000597187*InitialData(:,3)* InitialData(:,4)...       %15  
        - 0.00264996*InitialData(:,4).^2 ...                     %16
        -0.000375624*InitialData(:,4)* InitialData(:,5);          %17

cSOR_form = 3.47592...                                       %1
        +0.1629*InitialData(:,1)...                          %2        
        + 0.0010*InitialData(:,3)...                         %3
        + 0.0021*InitialData(:,8)...                         %4
        + 0.0012*InitialData(:,4)...                         %5
        - 0.001152*InitialData(:,5)...                         %6
        - 0.0008*InitialData(:,6)...                         %7
        - 0.0007*InitialData(:,7)...                         %8
        - 0.0037*InitialData(:,1)*InitialData(:,3)...        %9
        + 1.0741e-7*InitialData(:,6).^2 ...                  %10
        + 1.3851e-7*InitialData(:,6)*InitialData(:,7);                     %11
    
Solv_Inj_form=(1.51299e6...
        -2.37536e6*InitialData(:,1)...
        +238867*InitialData(:,2)...
        -1706.02*InitialData(:,3)...
        -19461.8*InitialData(:,8)...
        +5724.81*InitialData(:,4)...
        +1168.8*InitialData(:,5)...
        +2.43993*InitialData(:,6)...
        -400.491*InitialData(:,7)...
        +1.24262e6*InitialData(:,1).^2 ...
        +2873.72*InitialData(:,1)*InitialData(:,3)...
        +228.911*InitialData(:,1)*InitialData(:,6)...
        -1830.97*InitialData(:,2)*InitialData(:,3)...
        +31.0246*InitialData(:,3)*InitialData(:,4)...
        +6.79374*InitialData(:,8)*InitialData(:,7)...
        -68.1075*InitialData(:,4).^2 ...
        -8.26458*InitialData(:,4)*InitialData(:,5));

    
z=[1/RF_form
   cSOR_form
   Solv_Inj_form];

end 


% cOil_form = 7747.23...                                         %1
%         - 16179.10*InitialData(:,1)...                       %2        
%         + 1964.80*InitialData(:,2)...                         %3
%         - 14.0701*InitialData(:,3)...                        %4
%         + 64.1850*InitialData(:,4)...                        %5
%         + 3.6353*InitialData(:,5)...                         %6
%         + 0.2244*InitialData(:,6)...                         %7
%         - 0.7545*InitialData(:,7)...                         %8
%         + 9799.17*InitialData(:,1).^2 ...                    %9
%         + 17.2216*InitialData(:,1)*InitialData(:,3)...       %10
%         + 0.6851*InitialData(:,1)* InitialData(:,6)...       %11                         
%         + 1.0092*InitialData(:,1)* InitialData(:,7)...       %12
%         - 8.4824*InitialData(:,2)* InitialData(:,3)...       %13
%         - 15.2496*InitialData(:,2)* InitialData(:,4)...      %14
%         + 0.1045*InitialData(:,3)* InitialData(:,4)...       %15  
%         - 0.4638*InitialData(:,4).^2 ...                     %16
%         -0.0656*InitialData(:,4)* InitialData(:,5);          %17