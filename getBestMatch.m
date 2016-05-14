function [ X, Y ] = getBestMatch( WEIGHTS, V )
%GETBESTMATCH Returns the node (X,Y) with closest matching norm to V

    Vweight = norm(V);
    [M N]=size(WEIGHTS);
    
    %initialize the weight difference
    Diff0 = Vweight - WEIGHTS(1,1);
    X=1;Y=1;  %Start here until a better one is found
    for i=1:M
        for j=1:N
            Diff1 = Vweight - WEIGHTS(i,j);
            
            if Diff1<Diff0
                %found a lower difference
                X=i; Y=j;
                Diff0 = Diff1;
            end
            
        end
    end


end

