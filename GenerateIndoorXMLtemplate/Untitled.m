text = fileread('indoor149.txt');
Astart = findstr(text, '<ORMTP>');
Aend = findstr(text, '</ORMTP>');
Bstart = findstr(text, '<ORMRP>');
Bend = findstr(text, '</ORMRP>');

f = ones(1,length(text));
for i = 1:length(Astart)
    f(Astart(i):Aend(i)+8) = 0;
end
for i = 1:length(Bstart)
    f(Bstart(i):Bend(i)+8) = 0;
end
res = text(find(f>0));