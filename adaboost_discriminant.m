function c = adaboost_discriminant(data, mu, sigma, p, alpha, classes, T)
% c: Mx1
[num_row_data,num_col_data]=size(data);

num_class=length(classes);
num_feature=num_col_data;

H=zeros(num_row_data,num_class);
class_matrix=ones(num_row_data,num_class);
for c=1:num_class
    class_matrix(:,c)= class_matrix(:,c)*classes(c);
end

mu_t=zeros(num_class,num_feature);
sigma_t=zeros(num_class,num_feature);
p_t=zeros(num_class,1);

for t=1:T
    for c=1:num_class
        for n=1:num_feature
            mu_t(c,n)=mu(c, n ,t);
            sigma_t(c,n)=sigma(c, n, t);
        end
        p_t(c)=p(t,c);
    end
    
    h = discriminant(data(:,1:2), mu_t, sigma_t, p_t);
    [dummy class] = max(h, [], 2);
    class = class - 1;
        
    for i=1:num_class
        H(:,i)=H(:,i)+ (class == class_matrix(:,i))*alpha(t);
    end   
end
[class content]=max(H, [], 2);
c=content-1;
end