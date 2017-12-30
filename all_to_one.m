function y_one = all_to_one(y)

m=size(y,1);
n=size(y,2);
y_one=zeros(m,1);
for i=1:m
    yi=y(i,:);
    for j=1:n
        
        if yi(j)==1
            y_one(i)=j;
        end
    end
end

end
