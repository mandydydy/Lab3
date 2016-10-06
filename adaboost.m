function [mu, sigma, p, alpha, classes] = adaboost(data, T)

[num_row_data,num_col_data]=size(data);
class_label=unique(data(:,num_col_data));% the 3rd colum is the class information
num_class=length(class_label);
num_feature=num_col_data-1;

mu=zeros(T, num_class, num_feature);
sigma=zeros(T, num_class, num_feature);
p=zeros(T,num_class);
alpha=zeros(T,1);
classes=class_label;

w_t=ones(num_row_data,1);
w_t=w_t/num_row_data;

for t=1:T
    [mu_t sigma_t]=bayes_weight(data, w_t);
    [M N] = size(data);
    p_t = prior(data,w_t);
    g = discriminant(data(:,1:2), mu_t, sigma_t, p_t);
    [dummy class] = max(g, [], 2);
    class = class - 1;
    error_test = 1.0-sum((class == data(:,end)).*w_t);
    alpha_t = 1/(2*log((1-error_test)/error_test));
    
    sign=-2*(class == data(:,end))+1;%if class is right, sign equals to -1
    w_t=w_t.*exp(alpha_t*sign);
    w_t=w_t/sum(w_t);
    
    for c=1:num_class
        for n=1:num_feature
            mu(t,c,n)=mu_t(c,n);
            sigma(t,c,n)=sigma_t(c,n);
        end
        p(t,c)=p_t(c);
    end
    alpha(t)=alpha_t;
end


end