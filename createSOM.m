function [ SOM ] = createSOM( FileName, Nx, Ny, w, r0, lambda, L0, Tolerance, MaxSteps, Graph)
%CREATESOM Creates an Nx by Ny self organizing map which with corresponding
%vector of size w and radius ('of learning') of size r0 nodes.  Program will
%run until either the difference between two SOMs is Tolerance or until
%MaxSteps is reached.  Lambda is the time constant for the rate of decay of
% learning and L0 is the time rate of learning.
%Graph=1 will show the intermediate plots with imagesc()
%FileName is the text file containing the data to be learned (training
%data)

    load(FileName); %Load the data into DATA
    
    rng shuffle
    SOM=rand(Nx,Ny,w);  %initialize the SOM
    SOM2=SOM;  %copy to get error
    
    Iterations = 0;  %initialize values to get set
    Error = 1000;
    
    while Iterations<MaxSteps && Error>Tolerance
        Iterations = Iterations + 1;
        
        %set the radius of learning
        r = r0 * exp(-1*Iterations / lambda);
        
        
        %go through the training data
        for i=1:size(DATA,1)    %find closest norm to the current vest
            
            %start each vector by finding the closest norm
            V = DATA(i,:);  %current training data
            
            %get weights of all current SOM nodes
            WEIGHTS = getWeights(SOM);  %get weights of current map
            [X Y] = getBestMatch(WEIGHTS,V); %find (x,y) of smallest difference
            
            %Have best match, now do one learning round
            
            DecayMap = getDecayMap(X,Y,Nx,Ny,r,lambda,L0,Iterations); %get strength of learning
            
            for s=1:Nx
                for t=1:Ny
                    for u=1:w
                        SOM(s,t,u) = SOM(s,t,u) + DecayMap(s,t) * ( V(u) - SOM(s,t,u) );
                    end
                end
            end
            
        end
        
        if Graph
            surf(getWeights(SOM));pause(0.05);
        end
        
        
        Error = norm(getWeights(SOM)-getWeights(SOM2));
        SOM = SOM2; %get ready for next iteration
    end
    

end

