% File paths
atlas_path = '/Users/bened/Library/CloudStorage/OneDrive-FondazioneIstitutoItalianoTecnologia/Desktop/University/PhD_IIT/Turbulence_Autisms/Turbulence_Project/data/postproc/Files/Schaefer2018_1000Parcels_7Networks_order_FSLMNI152_2mm.nii';

% Load the files and data
atlas_file = spm_vol(atlas_path);
atlas_data = spm_read_vols(atlas_file);

% Initialize a 3D matrix to store the coordinates 
coords_3D = NaN * ones([size(atlas_data), 3]); 

% Get the size of the atlas
[dim_x, dim_y, dim_z] = size(atlas_data);

% Loop over all voxels in the atlas and get the coordinates
for x = 1:dim_x
    for y = 1:dim_y
        for z = 1:dim_z
            % If the voxel is non-zero, get its coordinates
            if atlas_data(x, y, z) > 0
                % Convert voxel (x, y, z) to coordinates
                real_world_coords = atlas_file.mat * [x; y; z; 1]; % Homogeneous coordinates
                coords_3D(x, y, z, :) = real_world_coords(1:3); % Store x, y, z in the 4th dimension
            end
        end
    end
end


%Compute CoG

CoG = ones(1000,3);
for parc = 1:1000
    curr_Mask = atlas_data == parc;
    curr_voxel = coords_3D(repmat(curr_Mask, [1 1 1 3]));
    curr_coords = reshape(curr_voxel,[],3);
    CoG(parc,:) = mean(curr_coords,1);
end