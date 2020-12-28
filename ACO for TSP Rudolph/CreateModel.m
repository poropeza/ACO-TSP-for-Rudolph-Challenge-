function [model]=CreateModel()

    Problem=Problem25();
    
    %lee el archivo de los clientes
    x= Problem(:,2);%arreglo en el que almacena las coordenadas en x de los clientes
    y= Problem(:,3);%arreglo en el que almacena las coordenadas en y de los clientes
    idCasa= Problem(:,1);%arreglo en el que almacena las demandas de los clientes
     

    n=numel(x);

    
%     %calcula la distancia entre los clientes
%     for i=1:n-1
%         for j=i+1:n            
%             D(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);            
%              D(j,i)=D(i,j);
%         end
%     end
    
    
   %solo tendrá una ruta
    model.n=n;
    model.x=x;
    model.y=y;
    model.indice=idCasa;


end