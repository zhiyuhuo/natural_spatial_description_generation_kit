clc;
clear;
close all;

%
text = fileread('Fixedunique149.xml');
Sstart = findstr(text, '<S>');
Send = findstr(text, '</S>');

f = ones(1,length(text));
L = length(Sstart);
st = [];
for i = 1:L
    s = text(Sstart(i):Send(i)+3);
    b = ~isempty(strfind(s, 'room'));
    b = b & ( ~isempty(strfind(s, 'table')) | ~isempty(strfind(s, 'chair')) | ~isempty(strfind(s, 'couch')) | ~isempty(strfind(s, 'bed')) | ~isempty(strfind(s, 'your')) );
    if b > 0
        disp(i)
        st = [st i];
    else
        f(Sstart:Send(i)+3) = 0;
    end
end

save('st_id.mat', 'st');
text = text(find(f>0));