%calling function getPosition 
%compares the requests and returns 1 or -1

function [cmp] = compareRequests(original,current)
if original.bid_price > current.bid_price
    cmp = 1;
    return;
end
if original.bid_price == current.bid_price
    if original.distance <= current.distance
        cmp = 1;
        return;
    else
        cmp = -1;
        return;
    end
else
    cmp = -1;
    return;
end

end