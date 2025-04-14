% Read the parcellation 
parc_img = niftiread('/Users/bened/Library/CloudStorage/OneDrive-FondazioneIstitutoItalianoTecnologia/Desktop/University/PhD_IIT/Turbulence_Autisms/Schaefer_Parcellation/Schaefer2018_1000Parcels_7Networks_order_FSLMNI152_2mm.nii');
donders_img = niftiread('/Users/bened/Library/CloudStorage/OneDrive-FondazioneIstitutoItalianoTecnologia/Desktop/University/PhD_IIT/Turbulence_Autisms/Turbulence_Project/data/postproc/Files/Schaefer1054_7networks_2mm.nii');
% Header info needed later for the storage of the new parcellation file
parc_info = niftiinfo('/Users/bened/Library/CloudStorage/OneDrive-FondazioneIstitutoItalianoTecnologia/Desktop/University/PhD_IIT/Turbulence_Autisms/Schaefer_Parcellation/Schaefer2018_1000Parcels_7Networks_order_FSLMNI152_2mm.nii');

% Convert parc_img to match the datatype of the original NIfTI
switch parc_info.Datatype
    case 'uint8'
        parc_img = uint8(parc_img);
    case 'int16'
        parc_img = int16(parc_img);
    case 'int32'
        parc_img = int32(parc_img);
    case 'single'
        parc_img = single(parc_img);
    case 'double'
        parc_img = double(parc_img);
    otherwise
        error('Unsupported NIfTI data type: %s', nifti_info.Datatype);
end

% Modify the parcellation based on region IDs from donders_parc (1001:1054)
for i = 1001:1054
    mask = ismember(donders_img, i);  % Create a mask for each region
    parc_img(mask) = i;  % Modify parc_img with the region IDs from donders_parc
end

% Save the modified parcellation back with correct metadata
parc_info.Filename = 'Schaefer1054_7networks_2mm.nii.gz';  % Set output filename
niftiwrite(parc_img, 'Schaefer1054_7networks_2mm.nii.gz', parc_info, 'Compressed', false);