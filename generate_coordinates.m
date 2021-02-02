function [points] = generate_coordinates(R,N)
points  =[];
for i = 1:N
    r = R * sqrt(rand());
    theta = rand() * 2 * pi;
    pt.x = r * cos(theta);
    pt.y = r * sin(theta);
    points = [points,pt];
end






