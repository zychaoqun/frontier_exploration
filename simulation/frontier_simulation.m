%colors
black = [0 0 0];
grey = [0.5 0.5 0.5];
white = [1 1 1];
red = [1 0 0];

cmap = [black; grey; white; red];

start_pose = [240 240];

%Occupancy Map
path = '~/research/frontier_exploration/map.bmp';
occupancy_map_pixel = imread(path);
occupancy_map = rgb2ind(occupancy_map_pixel,cmap);

%Explored Map
map = ones(size(occupancy_map));
map = map*2;
%Frontier Map
frontier_map = zeros(size(occupancy_map));

map = updateMap(start_pose, map, occupancy_map, 200);

figure(1)
imshow(ind2rgb(occupancy_map, cmap))
colormap(cmap);
colorbar;


%figure(2)
%imshow(ind2rgb(map, cmap))
%colormap(cmap);
%colorbar;

%map = updateMap([100, 120], map, occupancy_map, 150);

%figure(3)
%imshow(ind2rgb(map, cmap))
%colormap(cmap);
%olorbar;

pose = start_pose;
dist = 20;
direction = 'inc';
goal = [start_pose(1) start_pose(2) + dist]
while(true)
    map = updateMap(pose, map, occupancy_map, 150);

    if(direction == 'inc')
        if(pose(2) - start_pose(2) > dist)
            direction = 'dec';
        end
        pose(2) = pose(2) + 1;
    end
    
    if(direction == 'dec')
        if(pose(2) - start_pose(2) < -dist)
            direction = 'inc';
        end
        pose(2) = pose(2) - 1;
    end
    
    figure(2)
    imshow(ind2rgb(map, cmap))
    colormap(cmap);
    %colorbar;
    
    pause(0.1);
end