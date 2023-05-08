function [x,fx,vec,vec2]=algol60(func,a,b,t,iter_out,MCno,vec,vec2,debug)
% function [x,fx]=algol60(a,b,t,debug)
iter=1;
c=(3-sqrt(5))/2;
x= a + c*(b-a);v=x;w=x;e=0;
[fx,vec,vec2]=func(x,iter,iter_out,MCno,vec,vec2,debug);fw=fx;fv=fx;
while true
    iter=iter+1;
    m=(a+b)/2;          % Line 10
    tol=eps*abs(x)+t;
    t2=2*tol;
    if abs(x-m)>t2-(b-a)/2
        p=0;q=0;r=0;
        if abs(e)>tol
            r=(x-w)*(fx-fv);
            q=(x-v)*(fx-fw);
            p=(x-v)*q - (x-w)*r;
            q=2*(q-r);
            if q>0
                p=-p;
            else
                q=-q;       % Line 20
            end
            r=e;            % Line 30
            e=d;
        end
        if ( (abs(p) < abs(q*r/2)) && (p < q*(a-x)) && (p < q*(b-x)) )  % Line 40
            d=p/q;
            u=x+d;
            if ( ((u-a) < t2) || ((b-u) < t2) )
                if x<m
                    d=tol;
                else
                    d=-tol;     % Line 50
                end
            end
        else        % Golden section step
            if x<m
                e=b-x;
            else                % Line 60
                e=a-x;          % Line 70
            end
            d=c*e;              % Line 80
        end
        if abs(d) >= tol
            u=x+d;
        elseif d>0          % Line 90
            u=x+tol;
        else                % Line 100
            u=x-tol;        % Line 110
        end
        
        [fu,vec,vec2]=func(u,iter,iter_out,MCno,vec,vec2,debug);   % Line 120
        if fu<=fx
            if u<x
                b=x;
            else
                a=x;        % Line 130
            end
            v=w;            % Line 140
            fv=fw;
            w=x;
            fw=fx;
            x=u;
            fx=fu;
        else
            if u<x
                a=u;
            else            % Line 150
                b=u;        % Line 160
            end 
            if( (fu<=fw) || (w==x) )    % Line 170
                v=w;
                fv=fw;
                w=u;
                fw=fu;
            elseif( (fu<=fv) || (v==x) || (v==w) )  % Line 180
                v=u;
                fv=fu;
            end
        end
       if debug
           %fprintf('rD_cb = %d  |  obj.= %d\n',x,fx);
       end
    else
        break;
    end
end
fprintf('Found local minima in %d iterations at:\nx=%d | f(x)=%d\n',iter,x,fx);
end