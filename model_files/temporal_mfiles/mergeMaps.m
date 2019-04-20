function [newMap, angles] = mergeMaps(mapx,mapy,params)
%this function merges mapx and mapy and estimates the
%the angles of all objects
if size(mapx) ~= size(mapy)
    error('X and Y maps are different sizes');
end
xVel = params.target.xVel;
yVel = params.target.yVel;
[maxX indX] = max(mapx,[],4);
[mapY indY] = max(mapy,[],4);
vel = zeros(size(mapx,1),size(mapx,2),size(mapx,3),length(xVel)*length(yVel));
for f = 1:size(mapx,3)
    for i = 1:size(mapx,4)
        temp = squeeze(mapx(:,:,f,i));
        temp(indX(:,:,f)~= i) = 0;
        mapx(:,:,f,i) = temp;
        clear temp
        temp = squeeze(mapy(:,:,f,i));
        temp(indY(:,:,f)~= i) = 0;
        mapy(:,:,f,i) = temp;
        clear temp    
    end
    for x= 1:size(mapx,4)
       for y = 1:size(mapy,4)
           vel(:,:,f,4*x+y) = (mapx(:,:,f,x).^2+mapy(:,:,f,y).^2);
       end
    end
end
% indmapx = zeros(size(mapx,1),size(mapx,2),size(mapx,3));
% indmapy = zeros(size(mapx,1),size(mapx,2),size(mapx,3));
% angles = zeros(size(mapx,1),size(mapx,2),size(mapx,3));

% for f = 1:size(mapx,3)
%     for j = 1:size(mapx,1)
%         for k = 1:size(mapx,2)
%            xind = find(mapx(j,k,f,:)==mapxv(j,k,f));
% 
%            
% %            indmapx(j,k,f) =  temp(1);
%            yind = find(mapx(j,k,f,:)==mapxv(j,k,f));
% 
% %            indmapy(j,k,f) = temp(1);
% 
%            angles(j,k,f) = atand(yVel(yind(1))/xVel(xind(1)));
%            
%            clear yind;
%            clear xind;
%            
%         end
%     end
%     map(:,:,f) = sqrt(mapx(:,:,f).^2+mapy(:,:,f).^2);
%     angles(:,:,f) = atand(mapy(:,:,f)./mapx(:,:,f));
% end
newMap(:,:,1,:)= map;
newMap(:,:,2,:)= map;
newMap(:,:,3,:)= map;