function [mu, sigma] = bayes(data)

    %get the classes label and the number of classes
    [num_row_data,num_col_data]=size(data);
    class_label=unique(data(:,num_col_data));% the 3rd colum is the class information 
    num_class=length(class_label);
    num_feature=num_col_data-1;
    
    %get the M
    M=zeros(1,num_class);
    for i=1:num_class
        M(i)=length(find(data(:,num_col_data)==class_label(i)));
    end
    
    %get mu
    mu=zeros(num_class,num_feature);
    for i=1:num_class
        ind_class=find(data(:,num_col_data)==class_label(i));
        for n=1:num_feature
            for m=1:M(i)    
                mu(i,n)=mu(i,n)+data(ind_class(m),n);
            end
            mu(i,n)=mu(i,n)/M(i);
        end
    end
    
    %get sigma
    sigma=zeros(num_class,num_feature);
    for i=1:num_class
        ind_class=find(data(:,num_col_data)==class_label(i));
        for n=1:num_feature
            for m=1:M(i)    
                sigma(i,n)=sigma(i,n)+(data(ind_class(m),n)-mu(i,n))^2;
            end
            sigma(i,n)=sigma(i,n)/M(i);
        end
    end
end