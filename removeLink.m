function [outputNetwork,removedLink] = removeLink(primaryNetwork,number)

removedLink = primaryNetwork(number,:);
primaryNetwork(number,:) = [];
outputNetwork = primaryNetwork();



end