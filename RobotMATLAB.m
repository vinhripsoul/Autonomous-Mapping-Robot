clear; clc;
width = importdata("width.csv");
depth = importdata("depth.csv");
height = importdata("height.csv");
Variable = input('What type of shape is being scanned?\n');
if Variable == "cube"
   % Establishing values for angle and length
   %%%% Width
   w_v1 = width(101:2:end); % odd rows
   w_v1_spacing = diff(w_v1);
   w_v2 = width(102:2:end); % even rows
   w_v2_spacing = diff(w_v2);
   tol = 1e-6;
   dTheta = 0.1;
   w_max1 = max(w_v1_spacing);
   w_max2 = max(w_v2_spacing);
   if (abs(dTheta - w_max1)) <= tol
       w_angle = w_v1;
       w_length = w_v2;
   elseif (abs(dTheta - w_max2)) <= tol
       w_angle = w_v2;
       w_length = w_v1;
   end
  
   w_max_distance = 11;
   w_angle_indices = find(w_angle>0);
   w_angle = w_angle(w_angle_indices);
   w_length = w_length(w_angle_indices);
   w_length_indices = find(w_length<=w_max_distance);
   w_angle = w_angle(w_length_indices);
   w_length = w_length(w_length_indices);
   w_less90_indices = find(w_angle<=90);
   w_great90_indices = find(w_angle>=90);
   w_less_angle = w_angle(w_less90_indices);
   w_great_angle = w_angle(w_great90_indices);
   % Calculating width
   w_dL1_array = [];
   w_dL2_array = [];
   for i = 1:length(w_less_angle)-1
       w_L1 = w_length(i)*cosd(w_angle(i));
       w_L2 = w_length(i+1)*cosd(w_angle(i+1));
       w_dL1 = w_L1 - w_L2;
       w_dL1_v = w_dL1;
       w_dL1_array = [w_dL1_array w_dL1_v];
   end
   for i = 1:length(w_great_angle)-1
       w_new_angle = w_great_angle - 90;
       w_L3 = w_length(i)*sind(w_new_angle(i));
       w_L4 = w_length(i+1)*sind(w_new_angle(i+1));
       w_dL2 = -(w_L3 - w_L4);
       w_dL2_v = w_dL2;
       w_dL2_array = [w_dL2_array w_dL2_v];
   end
   w_values1 = sum(w_dL1_array);
   w_values2 = sum(w_dL2_array);
   w = w_values1 + w_values2;
   % a: bottom and right sides
   Xa = [0 w; 0 w; 0 w; 0 w];
   Ya = [0 0; w w; 0 0; 0 0];
   Za = [0 0; 0 0; 0 0; w w];
   % b: left and back sides
   Xb = [w w; 0 0; w w; w w];
   Yb = [w w; w w; w w; 0 0];
   Zb = [0 w; 0 w; 0 w; 0 w];
   % c: top and front sides
   Xc = [0 0; w w; 0 0; 0 0];
   Yc = [0 w; 0 w; 0 w; 0 w];
   Zc = [w w; w w; w w; 0 0];
   fprintf('\nWidth: %.4f cm\n',w)
  
   figure(1)
   surf(Xa,Ya,Za)
   hold('on')
   surf(Xb,Yb,Zb)
   surf(Xc,Yc,Zc)
   hold('off')
   colormap([0.1 0.25 0.75])
   xlim([0 w*1.5])
   ylim([0 w*1.5])
   zlim([0 w*1.5])
   xlabel('x (cm)')
   ylabel('y (cm)')
   zlabel('z (cm)')
   daspect([1 1 1])
   title('Mapped Cube using Ultrasonic Sensor Measurements')
   figure(2)
   plot(w_angle,w_length)
   title('Distance Measurement vs. Angle within the Max Distance')
   xlabel('Angle (deg)')
   ylabel('Distance Measurement (cm)')
   legend('Width','Location','best')
elseif Variable == "rectangular prism"
   %%%% Width
   w_v1 = width(1201:2:end); % odd rows
   w_v1_spacing = diff(w_v1);
   w_v2 = width(1202:2:end); % even rows
   w_v2_spacing = diff(w_v2);
   tol = 1e-6;
   dTheta = 0.1;
   w_max1 = max(w_v1_spacing);
   w_max2 = max(w_v2_spacing);
   if (abs(dTheta - w_max1)) <= tol
       w_angle = w_v1;
       w_length = w_v2;
   elseif (abs(dTheta - w_max2)) <= tol
       w_angle = w_v2;
       w_length = w_v1;
   end
   w_max_distance = 12;
   w_angle_indices = find(w_angle>0);
   w_angle = w_angle(w_angle_indices);
   w_length = w_length(w_angle_indices);
   w_length_indices = find(w_length<=w_max_distance);
   w_angle = w_angle(w_length_indices);
   w_length = w_length(w_length_indices);
   w_less90_indices = find(w_angle<=90);
   w_great90_indices = find(w_angle>=90);
   w_less_angle = w_angle(w_less90_indices);
   w_great_angle = w_angle(w_great90_indices);
   % Calculating width
   w_dL1_array = [];
   w_dL2_array = [];
   for i = 1:length(w_less_angle)-1
       w_L1 = w_length(i)*cosd(w_angle(i));
       w_L2 = w_length(i+1)*cosd(w_angle(i+1));
       w_dL1 = w_L1 - w_L2;
       w_dL1_v = w_dL1;
       w_dL1_array = [w_dL1_array w_dL1_v];
   end
   for i = 1:length(w_great_angle)-1
       w_new_angle = w_great_angle - 90;
       w_L3 = w_length(i)*sind(w_new_angle(i));
       w_L4 = w_length(i+1)*sind(w_new_angle(i+1));
       w_dL2 = -(w_L3 - w_L4);
       w_dL2_v = w_dL2;
       w_dL2_array = [w_dL2_array w_dL2_v];
   end
   w_values1 = sum(w_dL1_array);
   w_values2 = sum(w_dL2_array);
   values3 = w_dL2_array;
   w = w_values1 + w_values2;
   %%%% Depth
   w_size = size(width);
   d_v1 = depth(w_size(1):2:end); % odd rows
   d_v1_spacing = abs(diff(d_v1));
   d_v2 = depth((w_size(1)+1):2:end); % even rows
   d_v2_spacing = abs(diff(d_v2));
   tol = 1e-6;
   d_max1 = max(d_v1_spacing);
   d_max2 = max(d_v2_spacing);
   if (abs(dTheta - d_max1)) < tol
       d_angle = d_v1;
       d_length = d_v2;
   elseif (abs(dTheta - d_max2)) < tol
       d_angle = d_v2;
       d_length = d_v1;
   end
   d_max_distance = 11;
   d_angle_indices = find(d_angle>0);
   d_angle = d_angle(d_angle_indices);
   d_length = d_length(d_angle_indices);
   d_length_indices = find(d_length<=d_max_distance);
   d_angle = d_angle(d_length_indices);
   d_length = d_length(d_length_indices);
   d_less90_indices = find(d_angle<=90);
   d_great90_indices = find(d_angle>=90);
   d_less_angle = d_angle(d_less90_indices);
   d_great_angle = d_angle(d_great90_indices);
   % Calculating depth
   d_dL1_array = [];
   d_dL2_array = [];
   for i = 1:length(d_less_angle)-1
       d_L3 = d_length(i)*cosd(d_angle(i));
       d_L4 = d_length(i+1)*cosd(d_angle(i+1));
       d_dL1 = d_L4 - d_L3;
       d_dL1_v = d_dL1;
       d_dL1_array = [d_dL1_array d_dL1_v];
   end
   for i = 1:length(d_great_angle)-1
       d_new_angle = d_great_angle - 90;
       d_L1 = d_length(i)*sind(d_new_angle(i));
       d_L2 = d_length(i+1)*sind(d_new_angle(i+1));
       d_dL2 = d_L1 - d_L2;
       d_dL2_v = d_dL2;
       d_dL2_array = [d_dL2_array d_dL2_v];
   end
   d_values1 = sum(d_dL1_array);
   d_values2 = sum(d_dL2_array);
   d = d_values1 + d_values2;
   %%%% Height
   d_size = size(depth);
   h_v1 = height(d_size(1):2:end); % odd rows
   h_v1_spacing = diff(h_v1);
   h_v2 = height((d_size(1)+1):2:end); % even rows
   h_v2_spacing = diff(h_v2);
   tol = 1e-6;
   h_max1 = max(h_v1_spacing);
   h_max2 = max(h_v2_spacing);
   if (abs(dTheta - h_max1)) <= tol
       h_angle = h_v1;
       h_length = h_v2;
   elseif (abs(dTheta - h_max2)) <= tol
       h_angle = h_v2;
       h_length = h_v1;
   end
   h_max_distance = 11;
   h_angle_indices = find(h_angle>0);
   h_angle = h_angle(h_angle_indices);
   h_length = h_length(h_angle_indices);
   h_length_indices = find(h_length<=h_max_distance);
   h_angle = h_angle(h_length_indices);
   h_length = h_length(h_length_indices);
   h_less90_indices = find(h_angle<=90);
   h_great90_indices = find(h_angle>=90);
   h_less_angle = h_angle(h_less90_indices);
   h_great_angle = h_angle(h_great90_indices);
   % Calculating height
   h_dL1_array = [];
   h_dL2_array = [];
   for i = 1:length(h_less_angle)-1
       h_L3 = h_length(i)*cosd(h_angle(i));
       h_L4 = h_length(i+1)*cosd(h_angle(i+1));
       h_dL1 = h_L4 - h_L3;
       h_dL1_v = h_dL1;
       h_dL1_array = [h_dL1_array h_dL1_v];
   end
   for i = 1:length(h_great_angle)-1
       h_new_angle = h_great_angle - 90;
       h_L3 = h_length(i)*sind(h_new_angle(i));
       h_L4 = h_length(i+1)*sind(h_new_angle(i+1));
       h_dL2 = -(h_L3 - h_L4);
       h_dL2_v = h_dL2;
       h_dL2_array = [h_dL2_array h_dL2_v];
   end
   h_values1 = sum(h_dL1_array);
   h_values2 = sum(h_dL2_array);
   h = h_values1 + h_values2;
   % a: bottom and right sides
   Xa = [0 w; 0 w; 0 w; 0 w];
   Ya = [0 0; d d; 0 0; 0 0];
   Za = [0 0; 0 0; 0 0; h h];
   % b: left and back sides
   Xb = [w w; 0 0; w w; w w];
   Yb = [d d; d d; d d; 0 0];
   Zb = [0 h; 0 h; 0 h; 0 h];
   % c: top and front sides
   Xc = [0 0; w w; 0 0; 0 0];
   Yc = [0 d; 0 d; 0 d; 0 d];
   Zc = [h h; h h; h h; 0 0];
   fprintf('\nWidth: %.4f cm\nDepth: %.4f cm\nHeight: %.4f cm\n',w,d,h)
   figure(1)
   surf(Xa,Ya,Za)
   hold('on')
   surf(Xb,Yb,Zb)
   surf(Xc,Yc,Zc)
   hold('off')
   colormap([0.1 0.25 0.75])
   xlim([0 w*1.5])
   ylim([0 d*1.5]);
   zlim([0  h*1.5])
   xlabel('x (cm)')
   ylabel('y (cm)')
   zlabel('z (cm)')
   daspect([1 1 1])
   title('Mapped Rectangular Prism using Ultrasonic Sensor Measurements')
   figure(2)
   plot(w_angle,w_length)
   hold('on')
   plot(d_angle,d_length)
   plot(h_angle,h_length)
   hold('off')
   legend('Width','Depth','Height','Location','best')
   title('Distance Measurement vs. Angle within the Max Distance')
   xlabel('Angle (deg)')
   ylabel('Distance Measurement (cm)')
end