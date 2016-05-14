clear
%map size is nxn
rng shuffle;
n=100;

%radius is radius of map
r0=n;

%node weight is a 1xw vector
w=1;

% learning steps is Nt
Nt=2500;
% requires Nt inputs in a matrix form inputdata() whose size is Ntxw
% for i=1:Nt
%     for j=1:w
%         inputdata(i,1:w) = rand(1,w);
%     end
% end

for i=1:Nt
    if mod(i,5)==1
         inputdata(i,1:w)=1;
    elseif mod(i,5)==2
        inputdata(i,1:w)=0.5;
    elseif mod(i,5)==3
        inputdata(i,1:w)=0.25;
    elseif mod(i,5)==4
        inputdata(i,1:w)=0.75;
    else
        inputdata(i,1:w)=rand;
    end
end


%assign initial random weights to nxn
for i=1:n
    for j=1:n
        weights(i,j,:) = rand(1,w);
    end
end
weights0 = weights;
%LEARNING PARAMETERS
lambda = 1000;  %time constant for decay of learning
L0 = 0.2;  %learning rate


% LEARNING REPEATS Nt TIMES
% (Same as the # of sample inputs)
for Tstep=1:Nt
    %get radius as it changes through time
    r = r0 * exp(-1* Tstep / lambda);
    %Take first input and find the nearest node at (X,Y) in the map
    %by using Euclidean Distance
    X=1;Y=1;  %Start at the first node
    %get initial weight distance
    for i=1:w
        %take difference and square
        Diff(i) = abs(   (  weights(1,1,i)-inputdata(Tstep,i)  )^2 );
    end
    %sum of squares
    SUM=0;
    for i=1:w
        SUM = SUM + Diff(i);
    end
    %sqrt
    distance = sqrt(SUM);
    
    for i=1:n
        for j=1:n
            %calc dist and see if it is smaller than the first one
            for k=1:w
                Diff(k) = abs(   (  weights(i,j,k)-inputdata(Tstep,k)  )^2 );
            end
            SUM=0;
            for k=1:w
                SUM = SUM + Diff(k);
            end
            distance0 = sqrt(SUM);
            
            if distance0 < distance 
                distance = distance0; %found a smaller distance
                X = i;
                Y = j;  %at these coords 
            end
        end
    end
    
    %Best match node is found at (X,Y).  LEARN TIME
    %for any node within r of (X,Y) its weights will be changed.
    for i=1:n
        for j=1:n
            d = sqrt((i-X)^2 + (j-Y)^2);
            %if, by pythag, the X,Y is within radius then change
            if d < r
                
                %Weight(t+1) = W(t) + theta(t) L(t) [ input(t)-W(t) ]
                %get L & theta
                L = L0 * exp(-1* Tstep / lambda);
                theta = exp( (-1 * d^2 ) / (2* r^2)  );
                
                %change weights
                for k=1:w
                    weights(i,j,k) = weights(i,j,k) + (theta*L*( inputdata(Tstep,k) - weights(i,j,k) ));
                end
                
            end
        end
    end
%     subplot(3,1,1);figure(gcf);
%     surf(weights(:,:,1));
%     subplot(3,1,2);figure(gcf);
%     surf(weights(:,:,2));
%     subplot(3,1,3);figure(gcf);
    %Norms~~~~
    for i=1:n
        for j=1:n
            MMEAN(i,j) = mean(weights(i,j,:));
        end
    end
    imagesc(MMEAN);title(Tstep/Nt);figure(gcf);pause(0.01)
    
end

%  weights-weights0
% 
% for i=1:n
%     for j=1:n
%         sum = 0;
%         for k=1:w
%             
%         end
%     end
% end