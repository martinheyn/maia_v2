function[enginedata_cut,shipdata_cut] = cutshipdataauto(imu_data,enginedata_in,shipdata_in) 

            try
                enginedata_cut = cut_enginedataOden(enginedata_in,imu_data.IMU3.matdatenum(1),imu_data.IMU3.matdatenum(end));
            catch
                enginedata_cut = cut_enginedataFrej(enginedata_in,imu_data.IMU3.matdatenum(1),imu_data.IMU3.matdatenum(end));
                fprintf('It was Frej \n')
            end
            
            shipdata_cut = cut_shipdata(shipdata_in,imu_data.IMU3.matdatenum(1),imu_data.IMU3.matdatenum(end));
end