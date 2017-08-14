addpath(strcat(pwd,'./run'))
addpath(strcat(pwd,'./lib/extremevalues'))
addpath(strcat(pwd,'./lib/statistics'))
addpath(strcat(pwd,'./lib/import'))


Tool_MissionSelect

userrequest = 1;

while userrequest == 1
    inputOptions = {'Import IMU Data','Import Ship Data','Cut Signal','Filter Signal','Rotation Finder','Acceleration statistics','Extreme Values','Done :)'};
        defSelection = inputOptions{end};
        button = bttnChoiseDialog(inputOptions,'Hei der, velkomme',defSelection,'What will you do?'); 

        switch button

            case 1
                run_import_IMUdata
                userrequest = 1;
            case 2
                run_import_SQL
                userrequest = 1;
            case 3
                run_cutting
                userrequest = 1;
            case 4
                run_filtersignal;
                userrequest = 1;
			case 5
                run_rotationfinder
                userrequest = 1;
			case 6
				run_accl_statistics;
				userrequest = 1;
            case 7
				run_extreme_values;
                userrequest = 1;
            case 8
                userrequest = 0;
        end
        clear inputOptions defSelection button 
end
    clear inputOptions defSelection button userrequest
    
            