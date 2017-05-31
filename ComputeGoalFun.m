function [ score, matrix] = ComputeGoalFun(p,epsilon, Flows, matrix )

if graphconncomp(matrix)>1
    score=999;
    return
end    
    


for j = 1:1:length(Flows)
[~,removedLink] = removeLink(Flows,j);
[~, path, ~] = graphshortestpath(matrix,removedLink(1),removedLink(2));
  for n =1:length(path)-1
      [isMem,index] = ismember([path(n),path(n+1)],Flows(:,1:2),'rows');
      if (isMem) 
      Flows(index,4) = Flows(index,4)+1 ;     
      end

  end
end

FinalFlows=Flows;

for i = 1:1:length(FinalFlows)
    FinalFlows(i,5)=FinalFlows(i,4);
    if FinalFlows(i,4)>0
        
        
    for capacity = 0:1:FinalFlows(i,4)-1   
        BlockingProbability=0;     
        for y=capacity+1:1:FinalFlows(i,4)
            BlockingProbability = BlockingProbability + nchoosek(FinalFlows(i,4),y) * (p^y) *(1-p)^(FinalFlows(i,4)-y);
        end
        
        if BlockingProbability<epsilon
             FinalFlows(i,5) = FinalFlows(i,5)-1;             
        end
        
    end

    x = FinalFlows(i,1);
    y = FinalFlows(i,2);
    matrix(x,y)=FinalFlows(i,5);
    
    end
end
score = sum(FinalFlows(:,5));
end

