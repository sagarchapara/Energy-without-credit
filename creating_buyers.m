% Calling function[node]=creating_sellers_buyers(node)
function [node]=creating_buyers(node,n)
% Creating buyers in a given round 

% Retrieving  network constants.
CONST=networkConstants();  
n=CONST.n;   % Total number of nodes in the network;

% Initially it is assumed that every node is buyer. Thereafter some of the buyers are 
%converted into sellers sellers

for itr=1:1:n
    node(itr).type=0;          % Type =0 buyer,
    node(itr).request=randi([1 5]); % A node can buy 1 to 5 blocks durin a round;
    node(itr).request_fullfilled=0; % The blocks requirement that remained unfilled at the node. 
    node(itr).bidPrice = randi([1 10]); %The bid price 
    node(itr).mapping  = [];
end