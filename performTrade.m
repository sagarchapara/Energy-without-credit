function [node] = performTrade(node,seller)
%sort the request list based on bid price and distance%
requestList = node(seller).requestList;
sorted_list =  nestedSortStruct(requestList,{'bid_price','distance'});
for i = 1:length(sorted_list)
    buyers_list = node(seller).buyers_list;
    request  = sorted_list(i);
    index = -1;
    total = node(seller).service;
    for j = 1:length(buyers_list)
        if(buyers_list(j).bid_price > request.bid_price)
            continue;
        end
        if (buyers_list(j).bid_price == request.bid_price)
            if (buyers_list(j).distance >= request.distance )
                continue;
            end
            index = j;
            break;
        end
        index = j;
        break;
    end
    if index == -1
        if node(seller).sold_blocks < total
            %(min(total - sold_blocks , requested) are sold)) and buyer and
            %seller mappings gets update
            blocks_requested = request.blocks;
            minimum = min(blocks_requested,total - node(seller).sold_blocks);
           
            if node(seller).buyers_list(end).buyer_id == request.buyer_id
                node(seller).buyers_list(end).blocks = node(seller).buyers_list(end).blocks + minimum;
                %update buyer
                node(request.buyer_id).request_fullfilled =  node(request.buyer_id).request_fullfilled+ minimum;
                mapping  = node(request.buyer_id).mapping;
                for j = 1:length(mapping)
                    if(mapping(j).seller_id == seller)
                        mapping(j).blocks = mapping(j).blocks + minimum;
                    end
                end
                node(request.buyer_id).mapping  = mapping ;
                node(request.buyer_id).lsp = seller;
            else
                request.blocks = minimum;
                node(seller).buyers_list = [node(seller).buyers_list;request];
                node(request.buyer_id).request_fullfilled =  node(request.buyer_id).request_fullfilled+ minimum;
                mapping  = node(request.buyer_id).mapping;
                request.seller_id = seller;
                mapping = [mapping;request];
                node(request.buyer_id).mapping  = mapping ;
                node(request.buyer_id).lsp = seller;
            end
        end
    else
        j = 1;
        blocks_upto_now =0;
        while j<index
            blocks_upto_now = blocks_upto_now + buyers_list(j).blocks ;
            j = j+1;
        end
        blocks_available = node(seller).service - blocks_upto_now;
        min_blocks  = min(blocks_available,request.blocks);
        
        if min_blocks > 0
            %update buyers list of seller
            request.blocks = min_blocks;
            node(seller).buyers_list = [node(seller).buyers_list(1:index-1);request;node(seller).buyers_list(index:end)];
            %update mapping of buyer
            node(request.buyer_id).request_fullfilled =  node(request.buyer_id).request_fullfilled+ minimum;
            mapping  = node(request.buyer_id).mapping;
            request.seller_id = seller;
            mapping = [mapping;request];
            node(request.buyer_id).mapping  = mapping ;
            node(request.buyer_id).lsp = seller;
            
            %now check for removal of extra blocks
            blocks_used = min_blocks + blocks_upto_now;
            
            end_index = index+1;
            buyersList = node(seller).buyers_list;
            
            for i = index+1 : length(buyersList);
                if 
            
                
            
            
        
    end
end
            
            
            
        
    
    
    