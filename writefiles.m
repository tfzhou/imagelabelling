function writefiles( filename, imagename, Outer, Inner, Line )

if ~isempty(Outer)
    I = find(Outer == 0);
    if ~isempty(Outer)
        h=helpdlg('外部矩形框某个坐标为0，确定保存？','提示');
    end
end

fileID = fopen(filename, 'w');



