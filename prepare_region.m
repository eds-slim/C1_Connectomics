%% load and prepare region-specific data

% redefine CIJcell according to value of region
% k = rumber of ROIs

disp(hemisphere)

switch hemisphere
    case 'all'
        ind = 1:k;
    case 'left'
        ind = 1:(k/2);
    case 'right'
        ind = (k/2+1):k;
    otherwise
        error('wrong hemisphere')
end

missing=cellfun(@(m)(isempty(m)),CIJcell);
CIJcell_region=cell(size(CIJcell));
CIJcell_region(~missing) = cellfun(@(m)(m(ind,ind)),CIJcell(~missing),'uni',false);

clear idx