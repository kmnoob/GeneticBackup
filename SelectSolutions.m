function [ population ] = SelectSolutions( population, ratio )

population=sortrows(population,2);
sajz = size(population)*(1-ratio);
for i=1:1:sajz(1)/2
    population(randi([2, size(population,1)]),:)=[];
end
for i=1:1:sajz(1)/2
    population(size(population,1),:)=[];
end



end

