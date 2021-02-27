%calling function preformTrade
%returns sorted request list for a seller based on bid price and distance
function [sortedList] = getSortedList(requestList)
    sortedList =  nestedSortStruct(requestList,{'bid_price','distance'},[-1,1]);
end
