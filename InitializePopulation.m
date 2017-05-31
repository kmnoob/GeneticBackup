function [ population ] = InitializePopulation( p,epsilon,Flows )

%%%% Spanning tree backup
sparseRepresentation = sparse(Flows(:,1),Flows(:,2),1);
sparseRepresentation = tril(sparseRepresentation + sparseRepresentation') ;
[ST,pred] = graphminspantree(sparseRepresentation) ;
directedSpanningTree_KM = (full(ST))';

directedSpanningTree_KM = directedSpanningTree_KM + ST;
directedSpanningTree_KM = sparse(directedSpanningTree_KM);
[score_KM, directedSpanningTree_KM] = ComputeGoalFun(p,epsilon,Flows, directedSpanningTree_KM);
ST = {directedSpanningTree_KM,score_KM};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Transreduction backup - ONLY FOR FULLY CONNTECTED NETWORKS!!!!!
digraphRepresentation = digraph(Flows(:,1),Flows(:,2),1);
transreducedNetwork = transreduction(digraphRepresentation);
bubu=transreducedNetwork.Edges.EndNodes;
transreducedNetwork = sparse(bubu(:,1),bubu(:,2),1);
[score, transreducedNetwork] =ComputeGoalFun(p,epsilon,Flows, transreducedNetwork);
trans = {transreducedNetwork, score};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%% Fully connected graph
fullmat = sparse(Flows(:,1),Flows(:,2),1);
[score_full, fullmat] = ComputeGoalFun(p,epsilon,Flows, fullmat);
fullNet = {fullmat,score_full};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

score_full
view(biograph(fullmat,[], 'LayoutType','equilibrium','ShowArrows','off','ShowWeights','off')) % hierarchical , radial, equilibrium


population = [ fullNet; fullNet;];
%population = [fullNet; fullNet];
%population = [trans; trans];
%population = [ST; ST];
population=sortrows(population,2);



end

