figure('position', [300, 50, 500, 500]);
axis([0, 100, 0, 100]);
global XEND YEND
axis square
grid on%添加栅格
grid minor
hold on
%自定义变量
XSTART = 30;%机器人起始点
YSTART = 29;
TSTART = 0;
XEND = 80;%target X
YEND = 80;
ROW = 100;
COL = 100;
BOXWIDTH = 1;
BOXHEIGHT = 1;
% i represent  y,j represent  x
mapgrid = zeros(ROW, COL);
%  for j=1:70%rol
%  mapgrid(50,j)=1;
%  end
for j=30:60
    mapgrid(j,80-j)=1;
end
%%  Paint all the obs
for i = 1:ROW
for j = 1:COL
if mapgrid(i, j)>0
y = (i-1)*BOXWIDTH;%obs Y
x = (j-1)*BOXHEIGHT;%bos X
rectangle('position', [x, y, BOXWIDTH, BOXHEIGHT],'Curvature',1);%paint the agent
end
end
end
%Plot End Point 

plot(XEND, YEND, 'rx', 'markersize', 10, 'linewidth', 3);%Paint the target point
text(XSTART,YSTART,'Start');%the start point
text(XEND,YEND,'Goal');%the target point
%% parameter set
%time set
ts = 0.1;%seconds
%START 
global xbot ybot tbot xvect yvect v dzero searchradius Pd P Pvect  D Pv Po mindobs DobsSave;
xbot = XSTART;%agent position
ybot = YSTART;
tbot = TSTART;
xvect=1;            %agent vector
yvect=0;

% velocity
v = 1;%velocity
b = plot(1, 1,'linewidth', 2, 'color', 'm');%agent plot
c = plot(xvect, yvect, 'c', 'linewidth', 3);%to be determined
dzero = 6; %the scan distance from the agent to obs
searchradius = 2; %scan radius
delta=pi/5;
Pd=[XEND YEND];
Praw=[XEND YEND];
P=[XSTART YSTART];
Pvect=[xvect yvect]';

Po=[1 0];


tsum=0;
while(1)
    D=sqrt((Pd(1)-P(1))^2+(Pd(2)-P(2))^2);
    xbot=P(1);
    ybot=P(2);
xstart = floor(xbot-searchradius);              %SCAN
if xstart<1
xstart = 1;
end
ystart = floor(ybot-searchradius);
if ystart<1
ystart = 1;
end
xend = floor(xbot+searchradius);
if xend>ROW
xend = ROW;
end
yend = floor(ybot+searchradius);
if yend>COL
yend = COL;
end                                    
DobsSave=zeros(xend-xstart,yend-ystart);
for i = ystart:yend
for j = xstart:xend
DobsSave(i+1-ystart,j+1-xstart)=50;
    if mapgrid(i, j)>0 %if is obs
    x = j;
    y = i;
    vxobs = (floor(xbot)) - x;
    vyobs = (floor(ybot)) - y;
    dobs = sqrt(vxobs^2+vyobs^2);
        if dobs<dzero
        DobsSave(i+1-ystart,j+1-xstart)=dobs;
        end
    end
end
end
mindobs=min(min(DobsSave));
        if D>1                      %reached the goal?
                                    %NO
                %obs detected?
                     %redifine the goal
             if mindobs > 0 && mindobs~=50         %find the nearest ob
                    [miny,minx]=find(DobsSave==mindobs);
                    Po=[minx-3 miny-3];
                    Pdv=[XEND-xbot YEND-ybot];
                    t1=atan2(Po(2),Po(1));
                    t2=atan2(Pvect(2),Pvect(1));
                    t3=atan2(Pdv(2),Pdv(1));
                    beta=t1-t2;
                    alpha=t3-t2;
                    
                    if beta>=0
                        gamma=beta-alpha-pi/2;
                    else 
                        gamma=beta-alpha+pi/2;
                    end
                    
                    Pv=P'+[cos(gamma) -sin(gamma);sin(gamma) cos(gamma)]*(Pdv');
                     plot(Pv(1), Pv(2), 'rx', 'markersize', 10, 'linewidth', 3);
                    text(Pv(1),Pv(2),'virtual')
                    movetoPv();
                    
                
               
            else                   %move to the goal
                move();
            end
        else%YES
            if(sqrt((Praw(1)-P(1))^2+(Praw(2)-P(2))^2)>1)
                Pd=Praw;
                continue;
            else
                break;
            end
            
                             %stop
        end
        pause(ts);
end
   
    

