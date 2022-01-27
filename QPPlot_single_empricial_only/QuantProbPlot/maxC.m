%find the largest element among all the element in a cell array
%EXAMPLE
%f=@() randi(100) %just to type faster the following
%a={{{ [f() f(); f() f()]} {f()} [f() f() f()]}; [f() f() f()]};
%max(a)
function [maxN]=maxC(data)

maxN=maxChelp(data, []); 

function [maxN]=maxChelp(data, maxN)
if iscell(data)
    for i=1:numel(data)
        [maxN]=max(maxChelp(data{i},maxN));
    end
else
    [maxN]=[maxN max(data(:))];
end

