% Calling function: main

function [node]=energy_trade(node)
% This function caters to the trading process between the nodes.

[sellers,buyers]=list_sellers_buyers(node);
[node]=simple_matching(sellers,buyers,node);

end

