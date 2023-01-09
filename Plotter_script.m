% Plotter script for the article "Influence of fluids on earthquakes based 
% on numerical modeling" to Journal of Geophysical Research - Solid Earth. 

close all;
clear all;

Earthquake_velocity=0.1; % m/s, slip velocity, above which, an 'earthquake' is taking place 
Rock_friction=0.5774; % coefficient of friction

%% Fault velocity and Shear stress along the fault during the rupture sequences


% Time depth plot showing the sliding velocity
figure(1); surf(Fault_depth/1000,Time,log10(Fault_velocity),'EdgeColor','interp');view(2); colorbar
    xlabel('Depth (m)')
    ylabel('Time (yr)')
    title('Log10 Fault velocity (m/s)')
     
% Time depth plot showing the shear stress
figure(2); surf(Fault_depth/1000,Time,Shear_stress/1e6,'EdgeColor','interp');view(2); colorbar
    xlabel('Depth (m)')
    ylabel('Time (yr)')
    title('Shear Stress (MPa)')

for i=1:length(Fault_velocity(:,1))

    shear_stress_mean(i)=mean(Shear_stress(i,1:end)); %compute the average shear stress 
    normal_stress_mean(i)=mean(Normal_stress(i,1:end)); %compute the average normal stress 
end

% Mean shear stress (MPa) versus time
figure(3);plot(Time,shear_stress_mean/1e6,'k',Time,Rock_friction*normal_stress_mean/1e6,'k--') 
    legend('Mean shear stress', 'Frictional strength assuming constant friction')
    xlabel('Time (yr)')
    ylabel('Mean shear stress (MPa)')
    title('Mean shear stress')
  
    
%% Slip contours and mean slip during the rupture sequences

for i=1:length(Fault_velocity(:,1))
    
    maximum_fault=max(Fault_velocity(i,:)); %maximum of the fault velocity
    Mean_slip(i)=mean(Slip(i,:));
    
    figure(4); 
         if maximum_fault>Earthquake_velocity    
         hold on
         plot(Fault_depth/1000,Slip(i,:),'r','LineWidth',2) % Co-seismic period
         else
         hold on
         plot(Fault_depth/1000,Slip(i,:),'b','LineWidth',2) % Inter-seismic perio
         end
     xlabel('Depth (m)')
     ylabel('Slip (m)')
     title('Total fault slip (m)')

end

% Mean slip (MPa) versus time
figure(5);plot(Time,Mean_slip) 
    xlabel('Time (yr)')
    ylabel('Mean slip (m)')
    title('Mean slip')
    
%% For the Wet simulations: Pore-fluid factor and fluid overpressure during the rupture sequences

% Time depth plot showing the pore-fluid factor
figure(6); surf(Fault_depth_FLUID/1000,Time,Pore_Fluid_Factor,'EdgeColor','interp');view(2); colorbar
    xlabel('Depth (m)')
    ylabel('Time (yr)')
    title('Pore-fluid factor')
caxis([0.37 0.6])

% Time depth plot showing the fluid overpressure
figure(7); surf(Fault_depth_FLUID/1000,Time,Fluid_overpressure,'EdgeColor','interp');view(2); colorbar
    xlabel('Depth (m)')
    ylabel('Time (yr)')
    title('Fluid overpressure (MPa)')






