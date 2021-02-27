%calling function function [node]=simple_matching(sellers,buyers,node)

function [remainingBuyers] = getBuyers(node,buyers)
remainingBuyers =[];
for i = 1:length(buyers)
    if((node(buyers(i)).request > node(buyers(i)).request_fullfilled) && length(node(buyers(i)).unProcessedList)>0)
       remainingBuyers = [remainingBuyers;buyers(i)];
    end
end
        