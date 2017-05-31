function [ matrix ] = Mutate(Flows, matrix )
matrix=cell2mat(matrix);


for i=1:1:randi(8)
    edge = datasample(Flows,1,1);
    x = edge(1);
    y = edge(2);
    if matrix(x,y)==0 
       matrix(x,y)=1;
    else 
       matrix(x,y)=0;
            
            % if the graph becomes unconnected
            %if graphconncomp(matrix)>1
                %Do not mutate
            %end
            %This part was moved to compute goal function
    end 
end




end

