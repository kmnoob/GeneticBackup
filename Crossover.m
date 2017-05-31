function [ child_a, child_b ] = Crossover(Flows, matrix1, matrix2 )

matrix1=cell2mat(matrix1);
matrix2=cell2mat(matrix2);

    for i=1:1:size(matrix1,2)
        if randi(2)==1
        child_a(:,i)=matrix1(:,i);
        else
          child_a(:,i)= matrix2(:,i) ;
        end
    end

    for i=1:1:size(matrix1,1)
        if randi(2)==1
        child_b(i,:)=matrix1(i,:);
        else
          child_b(i,:)= matrix2(i,:) ;
        end
    end
    
% if graphconncomp(child_a)>1 || graphconncomp(child_a)>1
%     fullmat = sparse(Flows(:,1),Flows(:,2),1);
%     [child_a, child_a] = Crossover(Flows, {child_a}, {fullmat} );
% end
% if graphconncomp(child_b)>1
%     fullmat = sparse(Flows(:,1),Flows(:,2),1);
%     [child_b, child_b] = Crossover(Flows, {child_b}, {fullmat} );
% end

end

