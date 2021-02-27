function [node] = performTrade2(node,seller)
requestList = node(seller).requestList;
%get the sorted List
sortedList = getSortedList(requestList);

%for every element in request list find its position in buyers_list and
%update buyers_list

for i= 1:length(sortedList)
    buyers_list  = node(seller).buyers_list;
    current_request = sortedList(i);
    
    buyers_id = current_request.buyers_id;
    %check if the buyer already exists
    [isBuyerPresent,index] = checkBuyerPresent(buyers_list,buyers_id);
    
    if(isBuyerPresent)
        node = trade_already_exists(node,seller,buyers_id,index,current_request);
    else
        %find position in the buyers_list
        index = getPosition(buyers_list,current_request);
        node = trade_not_present(node,seller,buyers_id,index,current_request);
    end
end
        
    
    
        
    

