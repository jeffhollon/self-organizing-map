function [ WEIGHTS ] = getWeights( SOM )
%GETWEIGHTS Returns the norm of each node in the network

    [M N W]=size(SOM);
    WEIGHTS=zeros(M,N);
    
    for i=1:M
        for j=1:N
            for k=1:W
                WEIGHTS(i,j) = WEIGHTS(i,j) + SOM(i,j,k)^2;
            end
        end
    end

    WEIGHTS=sqrt(WEIGHTS);

end

