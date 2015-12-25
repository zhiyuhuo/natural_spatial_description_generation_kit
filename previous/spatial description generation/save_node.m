function res = save_node(cmdstr, spname, node)
%     str = [spname];
%     sp = node{1};
%     dd = node{2};
%     strdir = num2str(sp.spdir);
%     strdist = num2str(sp.spdist);
%     strdd = num2str(dd);
%     str = [str, '\n', strdir, '\n', strdist, '\n', strdd, '\n'];
%     fileID = fopen([cmdstr '/' spname '.txt'], 'w');
%     fprintf(fileID,str);
%     fclose(fileID);
%     save([cmdstr '/' spname '.mat'], 'node');
    

    text = [spname ' \n'];
    outdirw = node.outdirw;
    indirw = node.indirw;
    distw = node.distw;
    for i = 1:length(outdirw)
        text = [text sprintf('%f ', outdirw(i))];
    end
    text = [text '\n'];

    for i = 1:length(indirw)
        text = [text sprintf('%f ', indirw(i))];
    end
    text = [text '\n'];
    
    for i = 1:length(distw)
        text = [text sprintf('%f ', distw(i))];
    end
    text = [text '\n'];
    
    fileID = fopen(['Targets/' cmdstr '/' spname '.txt'], 'w');
    fprintf(fileID,text);
    fclose(fileID);
    save(['Mats/' cmdstr '/' spname '.mat'], 'node');

end