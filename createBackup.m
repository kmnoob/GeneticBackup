function [backupNetwork] = createBackup(primaryNetwork)

for i=1:1:length(primaryNetwork)
    primaryNetwork(i,3) = 1 ;
    backupNetwork(i,:) = primaryNetwork(i,:) ;
end
end
