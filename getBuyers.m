%calling function function [node]=simple_matching(sellers,buyers,node)

function [remainingBuyers] = getBuyers(node,buyers)
remainingBuyers =[];
for i = 1:length(buyers)
    if((node(buyers(i)).request > 0) && ~isempty(node(buyers(i)).unProccessedList))
       remainingBuyers = [remainingBuyers;buyers(i)];
    end
end
        