function [A] = ReadGml(fileName,isTwoWay)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Reads network data from a .gml file
%%% The network should be presented in the form of undirected graph
%%% example :
%  source 1
%     target 2
%     LinkSpeed 1
% 	////////////
% 	   source 2
%     target 3
%     LinkSpeed 1
% 		////////////
% 	   source 3
%     target 4
%     LinkSpeed 1
% 		////////////
% 	   source 4
%     target 5
%     LinkSpeed 1
% 			////////////
% 	   source 5
%     target 1
%     LinkSpeed 1

inputfile = fopen(fileName);
A=[];
k=1;

while 1
    tline = fgetl(inputfile) ;
    
    if ~ischar(tline)
        break
    end
   
    
     if (~isempty(regexp(tline,'source','match')))
         A(k,1) = str2double(regexp(tline,'\d+','match'));
     end
     if (~isempty(regexp(tline,'target','match')))
         A(k,2) = str2double(regexp(tline,'\d+','match'));
     end
     if (~isempty(regexp(tline,'LinkSpeed\s','match')))
         A(k,3) = str2double(regexp(tline,'\d+','match'));
         if (isTwoWay)
              A(k+1,1) = A(k,2);
              A(k+1,2) = A(k,1);
              A(k+1,3) = A(k,3);
             k=k+2;
         else
         k=k+1;
         end

     end

      
     end