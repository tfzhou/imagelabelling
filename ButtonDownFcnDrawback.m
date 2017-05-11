function ButtonDownFcnDrawback(src, evnt)

[x,y,str] = disp_point(src);
hl = line('XData',x,'YData',y,'Marker','.');
text(x,y,str,'VerticalAlignment','bottom');drawnow
set(src,'WindowButtonMotionFcn',@wbmcb)

end

function wbmcb(src,evnt)
[xn,yn,str] = disp_point(ah);
xdat = [x,xn];
ydat = [y,yn];
set(hl,'XData',xdat,'YData',ydat);
end

function [x,y,str] = disp_point(ah)
cp = get(ah,'CurrentPoint');
x = cp(1,1);y = cp(1,2);
str = ['(',num2str(x,'%0.3g'),', ',num2str(y,'%0.3g'),')'];
end