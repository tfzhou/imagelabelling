function writefiles( filename, imagename, Outer, Inner, Line )

if ~isempty(Outer)
    I = find(Outer == 0);
    if ~isempty(Outer)
        h=helpdlg('�ⲿ���ο�ĳ������Ϊ0��ȷ�����棿','��ʾ');
    end
end

fileID = fopen(filename, 'w');



