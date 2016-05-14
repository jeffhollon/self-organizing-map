function [ DECAY ] = getDecayMap( X,Y,Nx,Ny,r,lambda, L0, Iteration)
%GETDECAYMAP returns the strength of the learning process centered at (X,Y)
    
    DECAY=zeros(Nx,Ny);
    
    for i=1:Nx
        for j=1:Ny
            
            D = sqrt( (X-i)^2+(Y-j)^2 ); %distance from (X,Y)
            
            if D<r  %if within the learning radius
                L = L0 * exp(-1 * Iteration/lambda);
                theta = exp( (-1*D^2) / (2*r^2) );
                
                DECAY(i,j)=theta*L;
            end
            
        end
    end

end

