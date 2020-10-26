function move()
global P xbot v t ybot theta Pvect Pd;
 plot(P(1),P(2),'.','markersize',15)%机器人圆点的尺寸
 theta=atan2(Pd(2)-P(2),Pd(1)-P(1));
 t=atan2(Pvect(2),Pvect(1));
 if t~=theta
            if t>theta
               turnright();
            else if t<theta
                turnleft();
                end
            end
 end
 t=atan2(Pvect(2),Pvect(1));
 xbot=xbot+v*cos(t);
 ybot=ybot+v*sin(t);
 P=[xbot ybot];
end