%calling function function [node]=simple_matching(sellers,buyers,node)
function [pref_list] = getPreferenceList(buyer,sellers,cooridinates)
num_sellers = length(sellers);
distance = zeros(num_sellers);
for i = 1:num_sellers
    dist = (cooridinates(sellers(i)).x-cooridinates(buyer).x)^2 + (cooridinates(sellers(i)).y-cooridinates(buyer).y)^2;
    distance(i) = dist;
end
[out,idx] = sort(distance)
pref_list = zeros(num_sellers)
for i = 1:num_sellers
    pref_list(i) = sellers(idx)
end
end




