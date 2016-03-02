function hs = plotAxes(GL, fhand, hs,arrow)

    if nargin < 2 || isempty(fhand)
        fhand = gcf;hold on
        if nargin < 2
            arrow = false;
        end
    end
    if nargin < 4
        if nargin == 3
            if isfield(get(hs), 'UData') % C'est pour une flèche
                arrow = true;
            else
                arrow = false;
            end
        else
            arrow = false;
        end
    end
    if nargin < 3 || isempty(hs)
        if arrow
            hs(1) = quiver3(nan,nan,nan,nan,nan,nan, 'LineWidth',3, 'color', 'r', 'maxheadsize', 8);
            hs(2) = quiver3(nan,nan,nan,nan,nan,nan, 'LineWidth',3, 'color', 'g', 'maxheadsize', 8);
            hs(3) = quiver3(nan,nan,nan,nan,nan,nan, 'LineWidth',3, 'color', 'b', 'maxheadsize', 8);
        else
            hs(1) = plot3(nan,nan,nan,'r', 'LineWidth',3);
        	hs(2) = plot3(nan,nan,nan,'g', 'LineWidth',3);
            hs(3) = plot3(nan,nan,nan,'b', 'LineWidth',3);
        end
    end
    

    X = GL * [0 0 0 1;.1 0  0 1]';
    Y = GL * [0 0 0 1;0  .1 0 1]';
    Z = GL * [0 0 0 1;0  0 .1 1]';
    
    figure(fhand);
    hold on
    
    if arrow
        set(hs(1), 'Xdata', X(1,1), 'Ydata', X(2,1), 'Zdata', X(3,1), 'Udata', X(1,2)-X(1,1), 'Vdata', X(2,2)-X(2,1), 'Wdata', X(3,2)-X(3,1));
        set(hs(2), 'Xdata', Y(1,1), 'Ydata', Y(2,1), 'Zdata', Y(3,1), 'Udata', Y(1,2)-Y(1,1), 'Vdata', Y(2,2)-Y(2,1), 'Wdata', Y(3,2)-Y(3,1));
        set(hs(3), 'Xdata', Z(1,1), 'Ydata', Z(2,1), 'Zdata', Z(3,1), 'Udata', Z(1,2)-Z(1,1), 'Vdata', Z(2,2)-Z(2,1), 'Wdata', Z(3,2)-Z(3,1));
    else
        set(hs(1), 'Xdata', X(1,:), 'Ydata', X(2,:), 'Zdata', X(3,:));
        set(hs(2), 'Xdata', Y(1,:), 'Ydata', Y(2,:), 'Zdata', Y(3,:));
        set(hs(3), 'Xdata', Z(1,:), 'Ydata', Z(2,:), 'Zdata', Z(3,:));
    end
    axis equal


end