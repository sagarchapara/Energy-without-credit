%calling function performTrade
%performing trade on seller if buyer doesnot exist in the buyers_list
function [node] = trade_not_present(node,seller,buyers_id,index,current_request)
service  = node(seller).service;
cnt_upto_now =0;

buyers_list = node(seller).buyers_list;
if index == -1
    %means it is present at the end
    for i = 1:length(buyers_list)
        cnt_upto_now = cnt_upto_now + buyers_list(i).blocks;
    end
    remaining  = min(service - cnt_upto_now,current_request.blocks);
    if remaining >0
        %update request
        current_request.blocks = remaining;
        current_request.sellers_id  = seller;
        current_request.buyers_id = buyers_id;
        %update buyer
        node = update_buyer(node,buyers_id,1,0,seller,remaining,current_request);
        
        %update seller buyers_list
        buyers_list = [buyers_list;current_request];
        node(seller).buyers_list = buyers_list;
    end
else
    % if index is not at the end
    for i = 1:index-1
        cnt_upto_now = cnt_upto_now + buyers_list(i).blocks;
    end
    min_sold  = min(service - cnt_upto_now,current_request.blocks);
    
    if min_sold >0
        % update buyer mapping
        %update request
        current_request.blocks = min_sold;
        current_request.sellers_id  = seller;
        current_request.buyers_id = buyers_id;
        %update buyer
        node = update_buyer(node,buyers_id,1,0,seller,min_sold,current_request);
        
        cnt_upto_now = cnt_upto_now + min_sold;
        
        %update buyers_list
        buyers_list = [buyers_list(1:index-1);current_request;buyers_list(index:end)];
        
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
        
            %updating remaining buyers
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
            
            node(seller).buyers_list =  buyers_list;
        else
            node(seller).buyers_list = buyers_list;
        end
    end
end
        
       
        
    
    