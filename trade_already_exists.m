%calling function performTrade
%performing trade on seller if buyer already exists in the buyers_list
function [node] = trade_already_exists(node,seller,buyers_id,index,request)
service  = node(seller).service;
cnt_upto_now =0;

buyers_list = node(seller).buyers_list;
for i=1:index
    cnt_upto_now = cnt_upto_now + buyers_list(i).blocks;
end

min_sold = min(request.blocks,service - cnt_upto_now);

if(min_sold >0)
    %update buyer
    node = update_buyer(node,buyers_id,1,1,seller,min_sold,request);
    
    %update seller and remove extra blocks
    buyers_list(index).blocks = node(seller).buyers_list(index).blocks + min_sold;
    
    cnt_upto_now = cnt_upto_now + min_sold;
    %remove extra blocks
    
    %find the index where cnt > service
    temp_index = -1;
    for i = index+1: length(buyers_list)
        cnt_upto_now = cnt_upto_now + buyers_list(i).blocks;
        if(cnt_upto_now > service)
            temp_index =i;
            break;
        end
    end
    
    if temp_index >0
        %update temp_index one and remove others
        cnt_upto_now = cnt_upto_now - buyers_list(temp_index).blocks;
        
        min_keep = service - cnt_upto_now;
        
        blocks_removed = buyers_list(temp_index).blocks - min_keep;
        temp_request = buyers_list(temp_index);
        %updating temp_index buyer
        node = update_buyer(node,buyers_list(temp_index).buyers_id,0,1,seller,blocks_removed,temp_request);
        
        %updating remaining 
        for i = temp_index+1:length(buyers_list)
            blocks_removed = buyers_list(i).blocks;
            temp_request  = buyers_list(i);
            temp_id = buyers_list(i).buyers_id;
            node = update_buyer(node,temp_id,0,1,seller,blocks_removed,temp_request);
        end
       
        if min_keep >0
            buyers_list(temp_index).blocks = min_keep;
            buyers_list = buyers_list(1:temp_index);
        else
            buyers_list = buyers_list(1:temp_index-1);
        end
        
        node(seller).buyers_list = buyers_list;
    else
        node(seller).buyers_list = buyers_list;
    end
end
        
       
    
    
       
 
    
    