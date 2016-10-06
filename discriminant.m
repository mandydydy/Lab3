function g=discriminant(data, mu, sigma, p)
    [num_row_data,num_col_data]=size(data);
    N=num_col_data;
    M=num_row_data;
    C=length(p);
    %initialize g
    g=zeros(M,C);
    
    
    for x=1:M
       for i=1:C
           sum_sigma=0;
           sum_G=0;
           for n=1:N
              sum_sigma=sum_sigma+log10(sigma(i,n));
           end
           for n=1:N
               sum_G=sum_G+(data(x,n)-mu(i,n))^2/(2*sigma(i,n));
           end
           g(x,i)=log10(p(i))-sum_sigma-sum_G;
       end
    end
end