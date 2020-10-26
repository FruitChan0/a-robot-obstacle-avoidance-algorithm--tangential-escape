function movetoPv()
global Pv P Pvect xbot ybot t v;
    D0=sqrt((Pv(2)-P(2))^2+(Pv(1)-P(1))^2);
    Pvect=Pv-P';
    o=2;
    while(o)
         o=o-1;
        plot(P(1),P(2),'.','markersize',15)%?ºå?¨äºº???¹ç??å°ºå??
        t=atan2(Pvect(2),Pvect(1));
        xbot=xbot+v*cos(t);
        ybot=ybot+v*sin(t);
        P=[xbot ybot];
        pause(0.1);
    end
    
end