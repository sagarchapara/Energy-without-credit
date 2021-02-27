%updates the buyers mapping list
function [node] = update_buyer(node,buyers_id,isAdd,isPresent,sellers_id,blocks_sold,request)
request.sellers_id  = sellers_id;
request.blocks = blocks_sold;
request.buyers_id = buyers_id;
%addition or removal
mapping = node(buyers_id).mapping;
if isAdd ==1
    if isPresent == 1
        %find the seller in the mapping and update blocks
        for i = 1:length(mapping)
            if mapping(i).sellers_id == sellers_id
                %update mapping 
                mapping(i).blocks = mapping(i).blocks + blocks_sold;
                node(buyers_id).mapping = mapping;
                node(buyers_id).request_fullfilled = node(buyers_id).request_fullfilled + blocks_sold;
                node(buyers_id).required = node(buyers_id).required - blocks_sold;
                node(buyers_id).lsp = sellers_id;
            end
        end
    else
        %add the request as it is
        mapping  = [mapping ; request];
        node(buyers_id).mapping = mapping;
        node(buyers_id).request_fullfilled = node(buyers_id).request_fullfilled + blocks_sold;
        node(buyers_id).required = node(buyers_id).required - blocks_sold;
        node(buyers_id).lsp = sellers_id;
    end
else
    %find the index of seller in the mapping function
    index  = -1;
    for i = 1:length(mapping)
        if mapping(i).sellers_id == sellers_id
           index = i;
           break
        end
    end
    % if total blocks are removed
    if mapping(index).blocks  == blocks_sold
        %remove it from mapping
        mapping  = [mapping(1:index-1);mapping(index+1:end)];
        
    else
        mapping(index).blocks = mapping(index).blocks - blocks_sold;
    end
    node(buyers_id).mapping = mapping;
    node(buyers_id).request_fullfilled = node(buyers_id).request_fullfilled - blocks_sold;
    node(buyers_id).required = node(buyers_id).required + blocks_sold;
    node(buyers_id).rejected_last = 1;
end
        
    
                
       