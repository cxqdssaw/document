
dim = 10;
data_size = 1000;
bound = 10;
iteration = 100;
itera = zeros(iteration,1);
for i = 1:iteration
 %   w = ones(dim, 1);
    w = random('unif', -10, 10, dim + 1, 1);
    X = random('unif', -bound, bound, data_size, dim);
    X_aug = [X ones(size(X(:,1)))];
    y = sign(X_aug * w);% warning: value could be 0
    
    if dim == 2
        figure
        plot(X((y > 0),1),X((y > 0),2), 'g*');
        hold on
        plot(X((y < 0),1),X((y < 0),2), 'ro');
        
        linex = -bound : 1 : bound;
        liney =( -w(1,1) *linex - w(3,1) *ones(1, length(linex)) )./w(2,1);
        plot(linex, liney);
        xlabel('x_1');
        ylabel('x_2');
        legend('+1','-1');
    end
    
    w_learn = [1; zeros(dim, 1)];%initial point
    y_pre = sign(X_aug * w_learn);
    updates = 0;
    while sum(y_pre .* y < 0) > 0
        
        yy = y(y_pre .* y < 0,:);
        xx = X_aug(y_pre .* y < 0,:);
        w_learn = w_learn +  (yy(1) .* xx(1,:))';
      
   %     w_learn = w_learn +  sum(yy .* xx)';
        updates = updates + 1;
        y_pre = sign(X_aug * w_learn);
    end
    sprintf('updates: %d', updates)
    disp('w_learn: ')
    disp(w_learn)
    itera(i) = updates;
    
    if dim == 2
        if w_learn(2) ~= 0
            line2y = (-w_learn(1) * linex - w_learn(3)) ./w_learn(2);
            plot(linex, line2y, 'y--');
        else
            plot(-w_learn(3)/w_learn(1).*ones(21,1), -10:10, 'y--');
        end
    end
    
end

    


