%Desarrollado por: Peter Savier Oropeza Martínez
%fecha: 26/11/2018

clc;
clear;
close all;

%% Definición del problema

%[model]=CreateModel();
format short;
filename = 'input.txt';
delimiterIn = '\t';
headerlinesIn = 1;
model = importdata(filename,delimiterIn,headerlinesIn);

n=numel(model.data(:,1));

disp(n);%197,769  tendria que restarle 1 para tener el total de casas sin tomar en cuenta el depósito de Santa Claus

%plot(model.data(:,2),model.data(:,3),'o');


D=zeros(n,n); %matriz para las distancias entre clientes      
    
    
% 
% 
%             % Parámetros de ACO
% 
% 
%             MaxIt=50;      % Número máximo de iteraciones
% 
%             nAnt=197769;        % Número de hormigas (Tamaño de la población)
% 
%             Q=1;            %variable de control para la generación de feromona
% 
%             alpha=4;        % seguir valores de intensidad de la feromona
%             beta=12;         % seguir los valores respecto a ciudades cercanas (distancias)
%             rho=0.6;       % Tasa de Evaporación de feromona
% 
% 
% for r=1:model.rutas  %recorre todas las rutas
%     
%     CostFunction=@(tour)TourLength(tour,model,r);%CostFunction es una variable que contendrá el valor que retorna TourLength
%     
%     nVar=model.n;
%     
%     %tau0=10*Q/(nVar1*mean(model.z(r).matrizD(:)));	% Feromona inicial guardada en tau0
%     tau0=10*Q/(nVar*mean(model.D(:)));
%     
%     % Inicialización
% 
%     %eta=1./model.z(r).matrizD;             % Matriz de información heurística
%     eta=1./model.D; 
%     
%     tau=tau0*ones(nVar,nVar);   % Matriz de feromona
% 
%     BestCost=zeros(MaxIt,1);    % Arreglo que contiene los mejores costos
%     
%   
% 
%     % Hormiga vacía
%     empty_ant.Tour=[];
%     empty_ant.Cost=[];
% 
%     % Matriz de la colonia de hormigas
%     ant=repmat(empty_ant,nAnt,1);
% 
%     % Hormiga candidata a mejor solución
%     BestSol.Cost=inf;
% 
% 
%     % Ciclo principal de ACO 
% 
%         
%         disp('ruta:');
%         disp(r);
%       
%         
%         for it=1:MaxIt
% 
%             % Mover hormigas
%             for k=1:nAnt
%                 
%                 ant(k).Tour=model.z(r).ff(r).ruta(1);
%                 generated=(randi([2 nVar1])); %la hormiga elige una ciudad al azar 
%                 ant(k).Tour= [ant(k).Tour model.z(r).ff(r).ruta(generated)];
%                 %ant(k).Tour=[ant(k).Tour, model.z(r).ff(r).ruta(generated)];
%                
%                 %ant(k).Tour=[model.z(r).ff(r).ruta,1];
%                 
%                 for l=2:nVar1-1
%                     
%                     
%                         i=ant(k).Tour(end);
%                         %i=model.z(r).ff(r).ruta(l);
% 
%                         P=tau(i,:).^alpha.*eta(i,:).^beta;
% 
% 
%                         P(ant(k).Tour)=0;
% 
%                         P=P/sum(P);
%                             
%                         j=RouletteWheelSelection(P);
%                         
%                         AUX= zeros(size(model.z(r).ff(r).ruta));
%                         if ismember(model.z(r).ff(r).ruta,j)==AUX %j no pertenece a la ruta
%                             while ismember(model.z(r).ff(r).ruta,j)==AUX
%                                i=ant(k).Tour(end);
%                                 %i=model.z(r).ff(r).ruta(l);
% 
%                                 P=tau(i,:).^alpha.*eta(i,:).^beta;
% 
% 
%                                 P(ant(k).Tour)=0;
% 
%                                 P=P/sum(P);
% 
%                                 j=RouletteWheelSelection(P);
%                             end
%                         end
%                         
%                         %generated=randi([2 nVar1]); %la hormiga elige una ciudad al azar 
%                         %index=find(ant(k).Tour==model.z(r).ff(r).ruta(generated));
% 
%                         %if ~isnan(index) 
%                          %   while  ~isnan(index)
%                           %     generated=randi([2 nVar1]); %la hormiga elige una ciudad al azar 
%                            %    index=find(ant(k).Tour==model.z(r). ff(r).ruta(generated));
%                             %end
% 
%                         %end
% 
%                         %valor=model.z(r).ff(r).ruta(generated);
%                         
% 
%                         %ant(k).Tour=[ant(k).Tour valor];
%                         ant(k).Tour=[ant(k).Tour,j];
%                         %ant(k).Tour=[ant(k).Tour,model.z(r).ff(r).ruta(j)];
%                         %ant(k).Tour=[model.z(r).ff(r).ruta,1];
%                      
%                     
% 
%                     
% 
%                  end
%                 
%                 ant(k).Tour=[ant(k).Tour 1];
% 
%                 ant(k).Cost=CostFunction(ant(k).Tour);
% 
%                 if ant(k).Cost<BestSol.Cost %verifica si el costo de cierta hormiga es mejor que el óptimo registrado
%                     BestSol=ant(k);
%                 end
% 
%             end
% 
%             % Actualizar feromonas
%             for k=1:nAnt
% 
%                 tour=ant(k).Tour;
%                
% 
%                 tour=[tour tour(1)]; %#ok
% 
%                 for l=1:nVar1
% 
%                     i=tour(l);
%                     
%                     j=tour(l+1);
% 
%                     tau(i,j)=tau(i,j)+Q/ant(k).Cost;
% 
%                 end
% 
%             end
%             
%            % disp(tau);
% 
%             % Evaporación
%             tau=(1-rho)*tau;
% 
%             % Guardar el mejor costo
%             BestCost(it)=BestSol.Cost;
%             
%            
% 
%             % Mostrar la información de la iteración
%             
%             disp([' Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
%             if it==MaxIt
%                 
%                 disp([model.z(r).ruta model.z(r).ruta(1)]);%cambiar posteriormente, para que aparezca los nombre
%                 ruta=displayTour(BestSol.Tour);
%                 disp(ruta);
%                 %de la solución y no de la ruta inicial
%                 
%                 % Graficar la solución en figure1
%                 hold on
%                % figure;
%                 PlotSolution(BestSol.Tour,model,r);
% 
%                 title('ACO VRP FOR BAXTER IN MORELOS');
%                 hold on
%                 pause(0.001); 
%                 
%                 
%                      
%             end
%             
% 
%              
%             
% 
% 
%          % if it ~= MaxIt 
%                 %clf;
%           % end
%            
% 
%         end
% 
%     
% 
% end
% 
% 
%  %% Resultados
% 
%   % figure;
%   % plot(BestCost,'LineWidth',2);
%   % title([' TIEMPO TOTAL DE SIMULACIÓN: ' num2str(toc)]);
%   % xlabel('Iteración');
%   % ylabel('Mejor Costo');
%   % grid on;              
%    
%   % disp([' TIEMPO TOTAL DE SIMULACIÓN: ' num2str(toc)]);
%      clear; %libera memoria
