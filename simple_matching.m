% Calling function: [node]=energy_trade(node,n,total_sellers);

function [node]=simple_matching(sellers,buyers,node)
%Matching sellers with buyers
% We employ a very simple matching, where cost of each unit of energy is same.

% Retrieving  network constants.
CONST=networkConstants();  
n=CONST.n;   % Total number of nodes in the network;
total_sellers=CONST.total_sellers;   % Total number of sellers in the network;
coordinates = CONST.coordinates;

itrb=1;  % Counter for tracking sellers
itrs=1;  % Counter for tracking sellers
total_buyers=n-total_sellers;

%getting prefernce list
%prefernce list is unprocessed list

%latest service provider(lsp) 
%all initialized to zeros

for i = 1:length(buyers)
    p = getPreferenceList(buyers(i),sellers,coordinates);
    node(buyers(i)).unProcessedList = p;
    node(buyers(i)).lsp =0;
end


while (~isempty(getBuyers(node,buyers)) )
    current_buyers = getBuyers(node,buyers);
%     size(current_buyers)
    for i= 1:length(current_buyers)
        list = node(current_buyers(i)).unProcessedList;
        s = list(1);
        blocks_requested = node(current_buyers(i)).request - node(current_buyers(i)).request_fullfilled;
        request.buyers_id = current_buyers(i);
        request.blocks = blocks_requested;
        request.bid_price = node(current_buyers(i)).bidPrice;
        request.distance = sqrt((coordinates(s).x - coordinates(current_buyers(i)).x)^2 + (coordinates(s).y - coordinates(current_buyers(i)).y)^2 );
        node(s).requestList = [node(s).requestList;request];
        node(current_buyers(i)).unProcessedList =  node(current_buyers(i)).unProcessedList(2:end);
    end
    current_sellers = getSellers(node,sellers);
    for i = 1:length(current_sellers)
        node  = performTrade2(node,current_sellers(i));
    end
    
    for i =1 :length(buyers)
        if node(buyers(i)).rejected_last ==1 
            node(buyers(i)).rejected_last =0;
            if node(buyers(i)).lsp >0
                node(buyers(i)).unProcessedList = [node(buyers(i)).lsp , node(buyers(i)).unProcessedList];
            end
        end
    end
    
    for i = 1:length(sellers)
        node(sellers(i)).requestList = [];
    end
end

        
        
        
        
        
    










% while (itrb<=total_buyers)    % Counter for tracking buyers
%     curnt_buyer=buyers(itrb);
%     curnt_seller=sellers(itrs);     
%     blocks_required=node(curnt_buyer).request-node(curnt_buyer).request_fullfilled;   % The number of blocks required by the node
%     unsold_blocks=node(curnt_seller).service-node(curnt_seller).sold_blocks;               
%     
%     % How many blocks are traded between given a seller and a receiver;
%     blocks_traded=getBlocksTraded(node,curnt_buyer,curnt_seller,blocks_required,unsold_blocks);
%     %blocks_traded=min(blocks_required, unsold_blocks);
%     
%     % Updaing unsold and blocks required for seller and receiver respectively
%     unsold_blocks=unsold_blocks-blocks_traded;
%     blocks_required=blocks_required-blocks_traded;
%         
%     % This function transers money for the blocks transffered from seller
%     % to receiver.
%     [node]=money_trasfer(node,curnt_buyer,curnt_seller,blocks_traded);
%     % Updating requirements and current transaction detailes of requester
%     % and sender node
%     [node]=updating_requester(node,curnt_buyer,curnt_seller,blocks_traded);
%     [node]=updating_seller(node,curnt_buyer,curnt_seller,blocks_traded);
%     
%      
%     % Two conditions arise for seller to be changed
%     % IF a seller has sold all of his blocks, then it will be replaced by
%     % If the buyer has not enough money to pay the seller. Then buyer will shift to the next seller. The next seller may offer cheaper blocks to the buyer.
%     
%     if((unsold_blocks==0)||(blocks_traded==0))
%         itrs=itrs+1;        % We now select next serving node for the request
%     end 
%     
%    
%     % IF a buyer has received all of his blocks, then it will be replaced by
%     % the new buyer.
%     if(blocks_required==0)
%        itrb=itrb+1;
%        itrs=1;     % The new buyer will start checking each and every seller
%     end 
%     
%     % If all the sellers have been requested by buyer, it implies the current buyer has equasted all its option. We then shift to next buyer 
%     if(itrs>total_sellers)
%         itrb=itrb+1;
%         itrs=1;      % The next buyer will start from the first seller
%     end
%     
% end





end
