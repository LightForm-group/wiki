---
title: Creating ODF slices of evolving texture from simulated data 
author: Aiden Ha, Guy Bowker
tags:
  - MTEX
  - ma
  - EBSD
published: true
subcollection: MTEX
---
based on Guy Bowker's codes...

Assuming you have a list of orientations for every time-step as quaternions as a txt file:
It should be formatted like this:

```
xyzw
      0.550647107000000      0.759967622000000     -0.236600486000000     -0.251509817000000
      0.550647107000000      0.759967622000000     -0.236600486000000     -0.251509817000000
      0.550647107000000      0.759967622000000     -0.236600486000000     -0.251509817000000
      0.550647107000000      0.759967622000000     -0.236600486000000     -0.251509817000000
      0.550647107000000      0.759967622000000     -0.236600486000000     -0.251509817000000
      0.550647107000000      0.759967622000000     -0.236600486000000     -0.251509817000000
      0.550647107000000      0.759967622000000     -0.236600486000000     -0.251509817000000
      0.550647107000000      0.759967622000000     -0.236600486000000     -0.251509817000000
      0.575272627000000      0.741162387000000     -0.231873625000000     -0.256854711000000
      0.575272627000000      0.741162387000000     -0.231873625000000     -0.256854711000000
      0.575272627000000      0.741162387000000     -0.231873625000000     -0.256854711000000
      0.575272627000000      0.741162387000000     -0.231873625000000     -0.256854711000000
      0.575272627000000      0.741162387000000     -0.231873625000000     -0.256854711000000
      0.575272627000000      0.741162387000000     -0.231873625000000     -0.256854711000000
      0.575272627000000      0.741162387000000     -0.231873625000000     -0.256854711000000
      0.575272627000000      0.741162387000000     -0.231873625000000     -0.256854711000000
      0.575272627000000      0.741162387000000     -0.231873625000000     -0.256854711000000
      0.575272627000000      0.741162387000000     -0.231873625000000     -0.256854711000000
      0.575272627000000      0.741162387000000     -0.231873625000000     -0.256854711000000
      0.575272627000000      0.741162387000000     -0.231873625000000     -0.256854711000000
      0.575272627000000      0.741162387000000     -0.231873625000000     -0.256854711000000
```
My files are named QDF_quat_list_{increment} and I have 121 time steps, so to read these in MTEX...

```matlab
CS = { ...
  'notIndexed', ...
  crystalSymmetry('6/mmm', [3 3 4.7], 'X||a*', 'Y||b', 'Z||c*', 'mineral', 'Ti-Hex', 'color', [0.53 0.81 0.98]), ...
  crystalSymmetry('m-3m', [3.2 3.2 3.2], 'mineral', 'Titanium cubic', 'color', [0.56 0.74 0.56]) ...
};

% Select beta phase (Titanium cubic)
CS_beta = CS{3};

% Set specimen symmetry
SS = specimenSymmetry('orthorhombic');


%% 
setMTEXpref('xAxisDirection','north');
setMTEXpref('zAxisDirection','intoplane');

%% --- Define path to quaternion.txts --- %%

path_to_txts = '/path/to/txts/';
n_incs = 121;
%%
for inc = 1:1:n_incs
    
    increment = string(inc);
    fprintf("\nInc %s:\n", increment);

%     % Define path to quaternion.txt files..

     ori_path = strcat(path_to_txts, 'ODF_quat_list_', increment, '.txt');
     fprintf("Reading: %s\n", ori_path);
     fid = fopen(ori_path,'r');
     quat_data = textscan(fid, '%f%f%f%f', 'HeaderLines', 1, 'CollectOutput', 1);
     quat_data = quat_data{:};
     fid = fclose(fid);
  %  q = quaternion(transpose(quat_data(:, :, inc))); % from HDF5
     q = quaternion(transpose(quat_data)); % from quat.txt
    
    % Estiamte an ODF from the orientations
    ori = orientation(q, CS_beta, SS);
    %psi = calcKernel(ori);

    %odf = calcDensity(ori, 'kernel', psi);
    odf = calcDensity(ori, 'kernel', SO3DeLaValleePoussinKernel, 'halfwidth', 10*degree);

    setMTEXpref('FontSize', 31);

 figure()
 plot(odf, 'phi2', 45*degree, ...
      'antipodal', ...
      'linewidth', 1, ...
      'colorbar', 'cs', 'ss', ...
      'minmax', 0:0.1:10, ...
      'colorRange', [0, 30]);
 
 mtexColorbar('location', 'southOutSide', 'title', 'mrd');
saveas(gcf, strcat(path_to_txts, 'ODF_quat_list_', increment, '.png'))
close(gcf);
end
```
This will loop through the quaternion lists to produce a 45-degree ODF slice for each time step


