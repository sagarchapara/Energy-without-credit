% Calling function [node]=creating_sellers_buyers(node);

function [node]=creating_sellers(node)
% Generating sellers for a given round

% Retrieving  network constants.
CONST=networkConstants();  
n=CONST.n;   % Total number of nodes in the network;
total_sellers=CONST.total_sellers;   % Total number of sellers in the network;
DSO_block_cost=CONST.DSO_block_cost;  % The cost of a single energy block sold by the DSO 

sellers=randperm(n,total_sellers);
    for itr=1:1:total_sellers
        seller_ID=sellers(itr);
        node(seller_ID).type=1;
        node(seller_ID).service=randi([1 5]); % A node can have blocks between 1 to 5 available for selling
        node(seller_ID).sold_blocks=0;  % Initislly alll the blocks remain unsold at the node. 
        node(seller_ID).buyers_list = [];  % The id of requesters to whome blocks have been sold.
        % Resetting the request variable of the serving node.
        node(seller_ID).request=0;       % Total blocks of energy requested by nodes in one round
        node(seller_ID).block_cost=DSO_block_cost;   % The cost of a sinle block sild by the seller.
    end    
end

