function Pvirtual()
global mindobs Pv  P  xbot  miny minx Po ybot Pvect DobsSave XEND YEND gamma
                    %mindobs=min(min(DobsSave));     %redifine the goal
                    
                    [miny,minx]=find(DobsSave==mindobs);
                    Po=[minx-3 miny-3];
                    Pdv=[XEND-xbot YEND-ybot];
                    t1=atan2(P(2),P(1));
                    t2=atan2(Pvect(2),Pvect(1));
                    t3=atan2(Pdv(2)-P(2),Pdv(1)-P(1));
                    beta=t1-t2;
                    alpha=t3-t2;
                    
                    if beta>=0
                        gamma=beta-alpha-pi/2;
                    else 
                        gamma=beta-alpha+pi/2;
                    end
                    
                    Pv=P'+[cos(gamma) -sin(gamma);sin(gamma) cos(gamma)]*(Pdv'-P');
                    plot(Pv(1), Pv(2), 'rx', 'markersize', 10, 'linewidth', 3);
                    text(XEND,YEND,'Goal')
end             