fid = fopen('./connectomes/stroke_hemi.csv','r');
data = textscan(fid, '%s%s', 'Delimiter', ',');
fclose(fid);

subs = data{1};
side = data{2};

clear data

CIJcell = cell(1,1,numel(subs),4);

for s = 1:numel(subs)
    for i = 1:4
        CIJcell{1,1,s,i} = dlmread(fullfile('./connectomes', subs{s}, ['ses-0' num2str(i)], 'connectome.csv'), ' ');
    end
end

k = size(CIJcell{1},1);

measures = {@(m)(median(m(:))), @(m)(efficiency_wei(m,0,k/2)),@modularity}; %, user-defined handle for Louvain_modularity_und
labels = {'connectivity','efficiency','modularity'};

clear GGP
filename = 'ggp.dat';
fid = fopen(filename,'w');
fprintf(fid,'sub, ses, hemisphere, lesionside, lab, GGP\n');
for hemisphere = {'left', 'right'}
    hemisphere = hemisphere{1};
    prepare_region
    for i = 1:numel(measures)
        for j = 1:numel(subs)
            for ses = 1:4
                v = measures{i}(CIJcell_region{1,1,j,ses});
                GGP.(hemisphere).(labels{i})(j,ses) = v;
                fprintf(fid, '%s, %d, %s, %s, %s, %f\n', subs{j}, ses, hemisphere, side{j}, labels{i}, v);
            end
        end
        
    end
end


fclose(fid);