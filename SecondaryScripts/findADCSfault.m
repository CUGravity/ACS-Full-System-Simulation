function errorPos = findADCSfault(ADCSs)
    % Given the ADCS system, this function finds the issue and reports it
    % back to the PowerBoard. The POwerBoard determines if an exit from the
    % safe mode is warranted.
    
    % Niccolo Porcari 2017
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    errorPos = zeros(1,7);
    %% ADCSs Structure for reference
    % 1  ADCS Functional Status            ADCS_Fs
    % 2  ADCS Sectional Status             ADCS_Ss
    % 3  ADCS Component Status             ADCS_Cs
    % 4  Mags
    % 5  Accelerometers 
    % 6  Gyros
    % 7  Sun Sensors
    % 8  X coil
    % 9  Y coil
    % 10 Z coil
    
    if ADCSs(2) == false
        if ADCSs(4) == false
            errorPos(1) = 1;
        end
        if ADCSs(5) == false
            errorPos(2) = 1;
        end
        if ADCSs(6) == false
            errorPos(3) = 1;
        end
        if ADCSs(7) == false
            errorPos(4) = 1;
        end
    end
    if ADCSs(3) == false
        if ADCSs(8) == false
            errorPos(5) = 1;
        end
        if ADCSs(9) == false
            errorPos(6) = 1;
        end
        if ADCSs(10) == false
            errorPos(7) = 1;
        end
    end
end