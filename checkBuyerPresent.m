%calling function performTrade

%checks whether the buyer already exists and returns the buyers index

function [isPresent,index] = checkBuyerPresent(buyers_list,buyers_id)
isPresent = 0;
index = -1;
for i = 1:length(buyers_list)
    if buyers_list(i).buyers_id == buyers_id
        isPresent = 1;
        index = i;
        return ;
    end
end