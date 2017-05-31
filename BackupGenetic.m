close all;
% Close all windows
child_handles = allchild(0);
names = get(child_handles,'Name');
k = find(strncmp('Biograph Viewer', names, 15));
close(child_handles(k))

generationNumber=0 ;
best_score=1000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Input networks
Links = ReadGml('D:\NetworkProject\basicNet.gml',1)  ;
%Links = ReadGml('D:\NetworkProject\NfsNet.gml',1)  ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% Genetic algorithm properties
generations =500000000000000000;
mutations = 10;
crossovers = 5;
selectionRatio = 0.4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% Experiment properties
p=0.05;
epsilon = 0.01;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Flows = [Links,zeros(length(Links),1)];
disp 'Initial population:'
population = InitializePopulation(p,epsilon,Flows)

for i = 1:1:generations
    population_new = [];
    pop_size = size(population,1);
    
    for a = 1:1:mutations
        new_solution =  Mutate(Flows,population(randi(pop_size),1));
        [score , new_solution] = ComputeGoalFun(p,epsilon,Flows, new_solution);
        population_new = [population_new ;{new_solution,score}];
    end

    for b = 1:1:crossovers

        [new_solution1,new_solution2]=Crossover(Flows,population(randi(pop_size),1),population(randi(pop_size),1));
        [score1, new_solution1]=ComputeGoalFun(p,epsilon,Flows, new_solution1);
        [score2, new_solution2]=ComputeGoalFun(p,epsilon,Flows, new_solution2);
        population_new=[population_new ; {new_solution1,score1} ; {new_solution2,score2}];
    end

    population = [population ; population_new];

    
    
    
    population = SelectSolutions(population,selectionRatio);
    generationNumber = generationNumber+1;
    
    if cell2mat(population(1,2))<best_score
         disp 'New best score':
         best_score=cell2mat(population(1,2))
         generationNumber
         disp 'Current solution':
         BackupNetwork=cell2mat(population(1,1))
         %%% Display whole population?
         population
         
        view(biograph(cell2mat(population(1,1)),[], 'LayoutType','equilibrium','ShowArrows','on','ShowWeights','on'))
        
        
    end
 

end

disp '*********** END ****************'

  
%view(biograph(backupNetwork,[], 'LayoutType','equilibrium','ShowArrows','off','ShowWeights','off')) % hierarchical , radial, equilibrium


