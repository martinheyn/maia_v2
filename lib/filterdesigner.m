function [ df ] = filterdesigner()
%FILTERDESIGNER Summary of this function goes here
%   Detailed explanation goes here
inputOptions = {'Lowpass','Highpass','Bandpass','Take me back'};
            defSelection = inputOptions{1};
            button2 = bttnChoiseDialog(inputOptions,'What filter do you want?',defSelection,'Hei da :)');

            switch button2
                case 1
                    prompt = {'F_s:','F_pass','F_stop:'};
                    userinput = inputdlg(prompt,'Frequencies',1,{'F_s','F_pass','F_stop'});
                    Fs = str2double(cell2mat(userinput(1)));
                    Fpass = str2double(cell2mat(userinput(2)));
                    Fstop = str2double(cell2mat(userinput(3)));
                    
                    %Designing filter
                    Astop = 120;
                    Apass = 0.5;

                    df = designfilt('lowpassfir','StopbandFrequency',Fstop, ...
                      'PassbandFrequency',Fpass,'StopbandAttenuation',Astop, ...
                      'PassbandRipple',Apass,'SampleRate',Fs,'DesignMethod','equiripple');
                  
                case 2
                    prompt = {'F_s:','F_stop','F_pass:'};
                    userinput = inputdlg(prompt,'Frequencies',1,{'F_s','F_stop','F_pass'});
                    Fs = str2double(cell2mat(userinput(1)));
                    Fpass = str2double(cell2mat(userinput(3)));
                    Fstop = str2double(cell2mat(userinput(2)));
                    
                    %Designing filter
                    Astop = 120;
                    Apass = 0.5;

                    df = designfilt('highpassfir','StopbandFrequency',Fstop, ...
                      'PassbandFrequency',Fpass,'StopbandAttenuation',Astop, ...
                      'PassbandRipple',Apass,'SampleRate',Fs,'DesignMethod','equiripple');

                    %df = designfilt;
                    fvtool(df,'Fs',Fs,'Color','White') % Visualize filter
                    
                case 3
                    prompt = {'F_s:','F_stop1','F_pass1:','F_pass2','F_stop2:'};
                    userinput = inputdlg(prompt,'Frequencies',1,{'F_s:','F_stop1','F_pass1:','F_pass2','F_stop2:'});
                    Fs = str2double(cell2mat(userinput(1)));
                    Fpass1 = str2double(cell2mat(userinput(3)));
                    Fstop1 = str2double(cell2mat(userinput(2)));
                    Fpass2 = str2double(cell2mat(userinput(4)));
                    Fstop2 = str2double(cell2mat(userinput(5)));
                    
                    %Designing filter
                    Astop = 120;
                    Apass = 0.5;

                    df = designfilt('bandpassfir','StopbandFrequency1',Fstop1, ...
                        'PassbandFrequency1',Fpass1,'StopbandFrequency2',Fstop2, ...
                        'PassbandFrequency2',Fpass2,'StopbandAttenuation1',Astop, ...
                        'PassbandRipple',Apass,'StopbandAttenuation2',Astop,...
                        'SampleRate',Fs,'DesignMethod','equiripple');

                    %df = designfilt;
                    fvtool(df,'Fs',Fs,'Color','White') % Visualize filter
            end

end

