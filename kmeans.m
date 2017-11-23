clear;close all;clc;
tic;
printf('\n');
string = input('Input the data file -->> ','s');
data = load(string);
printf('\n');
if(yes_or_no('Do you have labels in your data file?'))
data(:,columns(data)) = []; %deleting the label column of the data
endif
data = data(randperm(rows(data)),:); %randomise the data
data = normalize(data);
printf('\n');
range_of_K = input('Upto which K,you want to measure the DB index ');

for K = 2:range_of_K
max_iter = 1000;   % can change it later

index = randperm(rows(data))(1:K);

  for i = 1:K
    cluster(i,:) = data(index(i),:);  %k number of cluster center is taken,which are actually any random data points
  endfor


for j = 1:max_iter
  clusterCheck = cluster;
  count = zeros(K,1); %to count the number of data points in each clusters in every iterations
  clusterSum = zeros(K,columns(data));
  for i = 1:rows(data)
      for k = 1:K
          d(k,:) = distance(data(i,:),cluster(k,:)); %to calculate the distance from the data points to present cluster centers 
      endfor 
      for k = 1:K
         if(min(d) == d(k,:)) 
           clusterIndex(i,:) = k; %assigning the data example to a particular cluster center
           clusterSum(k,:) = clusterSum(k,:) + data(i,:);
           count(k,:)++;
         endif  
      endfor    
  endfor
  
  for k = 1:K
  cluster(k,:) = clusterSum(k,:)/count(k,:); %For next iteration,cluster center is changed to the mean of the data points for individual clusters
  endfor
  movement_of_clustercenters = 0;
  for k = 1:K
  movement_of_clustercenters = movement_of_clustercenters + distance(cluster(k,:),clusterCheck(k,:));
  endfor
  
  if(movement_of_clustercenters == 0)
  break
  endif
  
  
endfor

assignedCluster = [data';clusterIndex']';

for k = 1:K
 p = 1;
  for i = 1:rows(data)
    if(clusterIndex(i,1) == k)
      for j = 1:columns(data)
        DATA(p,j,k) = data(i,j);
      endfor
      p++;
    endif
  endfor
endfor




for k = 1:K
clusterPoints = DATA(:,:,k);
clusterPoints(~any(clusterPoints,2),:) = []; 
clusterCentroid = cluster(k,:);
clusterSize(k,1) = clustsize(clusterPoints,clusterCentroid); %clusterSize is the size of a cluster
endfor


clusterDistances = zeros(K,K);
for i = 1:(K-1)
  for j = (i+1):K
    cluster1 = DATA(:,:,i);
    cluster1(~any(cluster1,2),:) = [];
    cluster2 = DATA(:,:,j);
    cluster2(~any(cluster2,2),:) = [];
    clusterDistances(i,j) = disclust(cluster1,cluster2);
  endfor
endfor

for i = 1:(K-1)
  for j = (i+1):K
    clusterDistances(j,i) = clusterDistances(i,j);  %They were all 0 before this
  endfor 
endfor






for k = 1:K
R(k,1) = Rcal(k,K,clusterSize,clusterDistances);
endfor


DB_Index(K,1) = sum(R)/K;
printf('\n');
clear('clusterSize','clusterPoints','clusterCentroid','clusterDistances','cluster1','cluster2','R','DATA','cluster','clusterIndex','clusterSum','i','j','k','d','count','p','index','assignedCluster');


endfor

DB_Index(1,1) = 100+max(DB_Index);
[~,finalK] = min(DB_Index);
printf('\n');
printf('Minimum DB Index found for K = %d\n',finalK);
printf('\n');
printf('This K will be used for final clustering\n\nProgram paused,Press Enter for final Clustering \n');
pause;
K = finalK;

index = randperm(rows(data))(1:K);
for i = 1:K
  cluster(i,:) = data(index(i),:);  %k number of cluster center is taken,which are actually any random data points
endfor


for j = 1:max_iter
  clusterCheck = cluster;
  count = zeros(K,1); %to count the number of clusters in every iterations
  clusterSum = zeros(K,columns(data));
  for i = 1:rows(data)
      for k = 1:K
          d(k,:) = distance(data(i,:),cluster(k,:)); %to calculate the distance from the data points to present cluster centers 
      endfor 
      for k = 1:K
         if(min(d) == d(k,:)) 
           clusterIndex(i,:) = k; %assigning the data example to a particular cluster center
           clusterSum(k,:) = clusterSum(k,:) + data(i,:);
           count(k,:)++;
         endif  
      endfor    
  endfor
  
  
  for k = 1:K
  cluster(k,:) = clusterSum(k,:)/count(k,:); %For next iteration,cluster center is changed to the mean of the data points for individual clusters
  endfor
  
  movement_of_clustercenters = 0;
  for k = 1:K
  movement_of_clustercenters = movement_of_clustercenters + distance(cluster(k,:),clusterCheck(k,:));
  endfor
  
  if(movement_of_clustercenters == 0)
  break
  endif
  
endfor

assignedCluster = [data';clusterIndex']';


printf('\n');
printf('The number of data points in individual clusters = \n');
count
printf('Program paused,Press Enter to continue\n');
pause;

for k = 1:K
 p = 1;
  for i = 1:size(data,1)
    if(clusterIndex(i,1) == k)
      for j = 1:size(data,2)
        DATA(p,j,k) = data(i,j);
      endfor
      p++;
    endif
  endfor
endfor
printf('\n');
if(yes_or_no('Do you want to print all the data points of each clusters? '))
p = 1;
for k = 1:K
D = DATA(:,:,k);
D(~any(D,2),:) = [];
printf("\nPoints assigned to cluster %d=\n",k);
D 
endfor
endif

if(columns(data)==2)
cmap = hsv(K);
for k = 1:K
D = DATA(:,:,k);
D(~any(D,2),:) = [];
plot(D(:,1),D(:,2),'o','Color',cmap(k,:));
hold on;
endfor
endif

toc;
