%DRLanalysis
%
%This program will pull the structure and data that was created with...
%DRLunpack and analyze in order to be put into stats program 
%
%written by Abigail G. Schindler 1.5.17

%DRL(i).ratID = ratIDlist(i,:); 
%DRL(i).behavsessionlist= sessionlist;
%DRL(i).behavior=nan(3000,2,length(DRL(i).behavsessionlist))

%Event stamps
%1=rt lever press during DRL
%2=lt lever press during DRL
%5=reinforcement delivery
%37=DRL reset

clear all
close all

%load stats package to can use nanmean etc
pkg load statistics

%loading the .mat strucutre that you created with DRLunpack
load drlstructure.mat 

%ensure that correctly loaded
DRL
%1x2 struct array with fields:
    %group - this is a strucutre also
    %ratIDlist
    %Animal

%uses length, find, and nanmean functions

%%

for i=1:length(DRL);
    for j=1:length(DRL(i).ratIDlist)
        disp (num2str(i));
        %DRL resets 5sec
        DRL(i).Animal(j).DRLresets5=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLresetsmean5={};
        %DRL reinforcement delivery 5sec
        DRL(i).Animal(j).DRLpellets5=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLpelletsmean5={};
        %DRL lever presses right 5sec
        DRL(i).Animal(j).DRLpressright5=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLpressrightmean5={};
        %DRL lever presses left 5sec 
        DRL(i).Animal(j).DRLpressleft5=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLpressleftmean5={};
        %DRL effective lever presses left 5sec 
        DRL(i).Animal(j).DRLeffectivepressleft5=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLeffectivepressleftmean5={};
        %DRL effective lever presses right 5sec 
        DRL(i).Animal(j).DRLeffectivepressright5=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLeffectivepressrightmean5={};
        for k=1:5
            %DRL resets 5sec
            DRL(i).Animal(j).DRLresets5(:,:,k)=length(find(DRL(i).Animal(j).behavior(:,1,k)==37));
            DRL(i).Animal(j).DRLresetsmean5=nanmean(DRL(i).Animal(j).DRLresets5(:,:,1:5));
            %DRL reinforcement delivery 5sec
            DRL(i).Animal(j).DRLpellets5(:,:,k)=length(find(DRL(i).Animal(j).behavior(:,1,k)==5));
            DRL(i).Animal(j).DRLpelletsmean5=nanmean(DRL(i).Animal(j).DRLpellets5(:,:,1:5));
            %DRL lever presses right 5sec
            DRL(i).Animal(j).DRLpressright5(:,:,k)=length(find(DRL(i).Animal(j).behavior(:,1,k)==1));
            DRL(i).Animal(j).DRLpressrightmean5=nanmean(DRL(i).Animal(j).DRLpressright5(:,:,1:5));
            %DRL lever presses left 5sec 
            DRL(i).Animal(j).DRLpressleft5(:,:,k)=length(find(DRL(i).Animal(j).behavior(:,1,k)==2));
            DRL(i).Animal(j).DRLpressleftmean5=nanmean(DRL(i).Animal(j).DRLpressleft5(:,:,1:5));
            %DRL effective lever presses left 5sec 
            DRL(i).Animal(j).DRLeffectivepressleft5(:,:,k)=(DRL(i).Animal(j).DRLpellets5(:,:,k)./DRL(i).Animal(j).DRLpressleft5(:,:,k)).*100;
            DRL(i).Animal(j).DRLeffectivepressleftmean5=nanmean(DRL(i).Animal(j).DRLeffectivepressleft5(:,:,1:5));
            %DRL effective lever presses right 5sec 
            DRL(i).Animal(j).DRLeffectivepressright5(:,:,k)=(DRL(i).Animal(j).DRLpellets5(:,:,k)./DRL(i).Animal(j).DRLpressright5(:,:,k)).*100;
            DRL(i).Animal(j).DRLeffectivepressrightmean5=nanmean(DRL(i).Animal(j).DRLeffectivepressright5(:,:,1:5));
        end
        %DRL resets 10sec
        DRL(i).Animal(j).DRLresets10=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLresetsmean10={};
        %DRL reinforcement delivery 10sec
        DRL(i).Animal(j).DRLpellets10=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLpelletsmean10={};
        %DRL lever presses right 10sec
        DRL(i).Animal(j).DRLpressright10=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLpressrightmean10={};
        %DRL lever presses left 10sec 
        DRL(i).Animal(j).DRLpressleft10=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLpressleftmean10={};
        %DRL effective lever presses left 10sec 
        DRL(i).Animal(j).DRLeffectivepressleft10=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLeffectivepressleftmean10={};
        %DRL effective lever presses right 10sec 
        DRL(i).Animal(j).DRLeffectivepressright10=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLeffectivepressrightmean10={};
        for k=6:10
            %DRL resets 10sec
            DRL(i).Animal(j).DRLresets10(:,:,k)=length(find(DRL(i).Animal(j).behavior(:,1,k)==37));
            DRL(i).Animal(j).DRLresetsmean10=nanmean(DRL(i).Animal(j).DRLresets10(:,:,6:10));
            %DRL reinforcement delivery 10sec
            DRL(i).Animal(j).DRLpellets10(:,:,k)=length(find(DRL(i).Animal(j).behavior(:,1,k)==5));
            DRL(i).Animal(j).DRLpelletsmean10=nanmean(DRL(i).Animal(j).DRLpellets10(:,:,6:10));
            %DRL lever presses right 10sec
            DRL(i).Animal(j).DRLpressright10(:,:,k)=length(find(DRL(i).Animal(j).behavior(:,1,k)==1));
            DRL(i).Animal(j).DRLpressrightmean10=nanmean(DRL(i).Animal(j).DRLpressright10(:,:,6:10));
            %DRL lever presses left 10sec 
            DRL(i).Animal(j).DRLpressleft10(:,:,k)=length(find(DRL(i).Animal(j).behavior(:,1,k)==2));
            DRL(i).Animal(j).DRLpressleftmean10=nanmean(DRL(i).Animal(j).DRLpressleft10(:,:,6:10));
            %DRL effective lever presses left 10sec 
            DRL(i).Animal(j).DRLeffectivepressleft10(:,:,k)=(DRL(i).Animal(j).DRLpellets10(:,:,k)./DRL(i).Animal(j).DRLpressleft10(:,:,k)).*100;
            DRL(i).Animal(j).DRLeffectivepressleftmean10=nanmean(DRL(i).Animal(j).DRLeffectivepressleft10(:,:,6:10));
            %DRL effective lever presses right 10sec 
            DRL(i).Animal(j).DRLeffectivepressright10(:,:,k)=(DRL(i).Animal(j).DRLpellets10(:,:,k)./DRL(i).Animal(j).DRLpressright10(:,:,k)).*100;
            DRL(i).Animal(j).DRLeffectivepressrightmean10=nanmean(DRL(i).Animal(j).DRLeffectivepressright10(:,:,6:10));
        end
        %DRL resets 20sec
        DRL(i).Animal(j).DRLresets20=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLresetsmean20={};
        %DRL reinforcement delivery 20sec
        DRL(i).Animal(j).DRLpellets20=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLpelletsmean20={};
        %DRL lever presses right 20sec
        DRL(i).Animal(j).DRLpressright20=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLpressrightmean20={};
        %DRL lever presses left 20sec 
        DRL(i).Animal(j).DRLpressleft20=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLpressleftmean20={};
        %DRL effective lever presses left 20sec 
        DRL(i).Animal(j).DRLeffectivepressleft20=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLeffectivepressleftmean20={};
        %DRL effective lever presses right 20sec 
        DRL(i).Animal(j).DRLeffectivepressright20=nan(1,1,length(DRL(i).Animal(j).behavsessionlist));
        DRL(i).Animal(j).DRLeffectivepressrightmean20={};
        for k=11:15
            %DRL resets 20sec
            DRL(i).Animal(j).DRLresets20(:,:,k)=length(find(DRL(i).Animal(j).behavior(:,1,k)==37));
            DRL(i).Animal(j).DRLresetsmean20=nanmean(DRL(i).Animal(j).DRLresets20(:,:,11:15));
            %DRL reinforcement delivery 20sec
            DRL(i).Animal(j).DRLpellets20(:,:,k)=length(find(DRL(i).Animal(j).behavior(:,1,k)==5));
            DRL(i).Animal(j).DRLpelletsmean20=nanmean(DRL(i).Animal(j).DRLpellets20(:,:,11:15));
            %DRL lever presses right 20sec
            DRL(i).Animal(j).DRLpressright20(:,:,k)=length(find(DRL(i).Animal(j).behavior(:,1,k)==1));
            DRL(i).Animal(j).DRLpressrightmean20=nanmean(DRL(i).Animal(j).DRLpressright20(:,:,11:15));
            %DRL lever presses left 20sec 
            DRL(i).Animal(j).DRLpressleft20(:,:,k)=length(find(DRL(i).Animal(j).behavior(:,1,k)==2));
            DRL(i).Animal(j).DRLpressleftmean20=nanmean(DRL(i).Animal(j).DRLpressleft20(:,:,11:15));
            %DRL effective lever presses left 20sec 
            DRL(i).Animal(j).DRLeffectivepressleft20(:,:,k)=(DRL(i).Animal(j).DRLpellets20(:,:,k)./DRL(i).Animal(j).DRLpressleft20(:,:,k)).*100;
            DRL(i).Animal(j).DRLeffectivepressleftmean20=nanmean(DRL(i).Animal(j).DRLeffectivepressleft20(:,:,11:15));
            %DRL effective lever presses right 20sec 
            DRL(i).Animal(j).DRLeffectivepressright20(:,:,k)=(DRL(i).Animal(j).DRLpellets20(:,:,k)./DRL(i).Animal(j).DRLpressright20(:,:,k)).*100;
            DRL(i).Animal(j).DRLeffectivepressrightmean20=nanmean(DRL(i).Animal(j).DRLeffectivepressright20(:,:,11:15));
        end
    end
end

%%


for i=1;
    %DRL resets across animals for each DRL (within respective treatment groups) into one matrix
    DRL(i).DRLresets5 = [DRL(i).Animal(1).DRLresets5(:,:,1:5), DRL(i).Animal(2).DRLresets5(:,:,1:5),...
    DRL(i).Animal(3).DRLresets5(:,:,1:5), DRL(i).Animal(4).DRLresets5(:,:,1:5), DRL(i).Animal(5).DRLresets5(:,:,1:5)];

    DRL(i).DRLresets10 = [DRL(i).Animal(1).DRLresets10(:,:,6:10) DRL(i).Animal(2).DRLresets10(:,:,6:10)...
    DRL(i).Animal(3).DRLresets10(:,:,6:10) DRL(i).Animal(4).DRLresets10(:,:,6:10) DRL(i).Animal(5).DRLresets10(:,:,6:10)];

    DRL(i).DRLresets20 = [DRL(i).Animal(1).DRLresets20(:,:,11:15) DRL(i).Animal(2).DRLresets20(:,:,11:15)...
    DRL(i).Animal(3).DRLresets20(:,:,11:15) DRL(i).Animal(4).DRLresets20(:,:,11:15) DRL(i).Animal(5).DRLresets20(:,:,11:15)];

    %DRL(i).DRLresets30 = [DRL(i).Animal(1).DRLresets30(:,:,16:20) DRL(i).Animal(2).DRLresets30(:,:,16:20)...
    %DRL(i).Animal(3).DRLresets30(:,:,16:20) DRL(i).Animal(4).DRLresets30(:,:,16:20) DRL(i).Animal(5).DRLresets30(:,:,16:20)];
    
    %Taking 3D matrix and making into 2D for import into prism
    DRL(i).DRLresets5 = [DRL(i).DRLresets5(:,:,1); DRL(i).DRLresets5(:,:,2); DRL(i).DRLresets5(:,:,3);...
    DRL(i).DRLresets5(:,:,4); DRL(i).DRLresets5(:,:,5)]

    DRL(i).DRLresets10 = [DRL(i).DRLresets10(:,:,1); DRL(i).DRLresets10(:,:,2); DRL(i).DRLresets10(:,:,3);...
    DRL(i).DRLresets10(:,:,4); DRL(i).DRLresets10(:,:,5)]

    DRL(i).DRLresets20 = [DRL(i).DRLresets20(:,:,1); DRL(i).DRLresets20(:,:,2); DRL(i).DRLresets20(:,:,3);...
    DRL(i).DRLresets20(:,:,4); DRL(i).DRLresets20(:,:,5)]

    %DRL(i).DRLresets30 = [DRL(i).DRLresets30(:,:,1); DRL(i).DRLresets30(:,:,2); DRL(i).DRLresets30(:,:,3);...
    %DRL(i).DRLresets30(:,:,4); DRL(i).DRLresets30(:,:,5)]

    %DRL resets mean across animals (within respective treatment groups) into one matrix
    DRL(i).DRLresetsmean5 = [DRL(i).Animal(1).DRLresetsmean5 DRL(i).Animal(2).DRLresetsmean5...
    DRL(i).Animal(3).DRLresetsmean5 DRL(i).Animal(4).DRLresetsmean5 DRL(i).Animal(5).DRLresetsmean5];

    DRL(i).DRLresetsmean10 = [DRL(i).Animal(1).DRLresetsmean10 DRL(i).Animal(2).DRLresetsmean10...
    DRL(i).Animal(3).DRLresetsmean10 DRL(i).Animal(4).DRLresetsmean10 DRL(i).Animal(5).DRLresetsmean10];

    DRL(i).DRLresetsmean20 = [DRL(i).Animal(1).DRLresetsmean20 DRL(i).Animal(2).DRLresetsmean20...
    DRL(i).Animal(3).DRLresetsmean20 DRL(i).Animal(4).DRLresetsmean20 DRL(i).Animal(5).DRLresetsmean20];

    %DRL(i).DRLresetsmean30 = [DRL(i).Animal(1).DRLresetsmean30 DRL(i).Animal(2).DRLresetsmean30...
    %DRL(i).Animal(3).DRLresetsmean30 DRL(i).Animal(4).DRLresetsmean30 DRL(i).Animal(5).DRLresetsmean30];
    
    DRL(i).DRLresetsmean= [DRL(i).DRLresetsmean5; DRL(i).DRLresetsmean10; DRL(i).DRLresetsmean20] %DRL(i).DRLresets30
    %use ; in concatenating so will do vertical which is what we need for
    %this prism graph
end

for i=2;
    %DRL resets across animals for each DRL (within respective treatment groups) into one matrix
    DRL(i).DRLresets5 = [DRL(i).Animal(1).DRLresets5(:,:,1:5) DRL(i).Animal(2).DRLresets5(:,:,1:5)...
    DRL(i).Animal(3).DRLresets5(:,:,1:5) DRL(i).Animal(4).DRLresets5(:,:,1:5)];
    
    DRL(i).DRLresets10 = [DRL(i).Animal(1).DRLresets10(:,:,6:10) DRL(i).Animal(2).DRLresets10(:,:,6:10)...
    DRL(i).Animal(3).DRLresets10(:,:,6:10) DRL(i).Animal(4).DRLresets10(:,:,6:10)];

    DRL(i).DRLresets20 = [DRL(i).Animal(1).DRLresets20(:,:,11:15) DRL(i).Animal(2).DRLresets20(:,:,11:15)...
    DRL(i).Animal(3).DRLresets20(:,:,11:15) DRL(i).Animal(4).DRLresets20(:,:,11:15)];

    %DRL(i).DRLresets30 = [DRL(i).Animal(1).DRLresets30(:,:,16:20) DRL(i).Animal(2).DRLresets30(:,:,16:20)...
    %DRL(i).Animal(3).DRLresets30(:,:,16:20) DRL(i).Animal(4).DRLresets30(:,:,16:20)];
    
    %Taking 3D matrix and making into 2D for import into prism
    DRL(i).DRLresets5 = [DRL(i).DRLresets5(:,:,1); DRL(i).DRLresets5(:,:,2); DRL(i).DRLresets5(:,:,3);...
    DRL(i).DRLresets5(:,:,4)]

    DRL(i).DRLresets10 = [DRL(i).DRLresets10(:,:,1); DRL(i).DRLresets10(:,:,2); DRL(i).DRLresets10(:,:,3);...
    DRL(i).DRLresets10(:,:,4)]

    DRL(i).DRLresets20 = [DRL(i).DRLresets20(:,:,1); DRL(i).DRLresets20(:,:,2); DRL(i).DRLresets20(:,:,3);...
    DRL(i).DRLresets20(:,:,4)]

    %DRL(i).DRLresets30 = [DRL(i).DRLresets30(:,:,1); DRL(i).DRLresets30(:,:,2); DRL(i).DRLresets30(:,:,3);...
    %DRL(i).DRLresets30(:,:,4)]
    
    %DRL resets mean across animals (within respective treatment groups) into one matrix
    DRL(i).DRLresetsmean5 = [DRL(i).Animal(1).DRLresetsmean5 DRL(i).Animal(2).DRLresetsmean5...
    DRL(i).Animal(3).DRLresetsmean5 DRL(i).Animal(4).DRLresetsmean5];

    DRL(i).DRLresetsmean10 = [DRL(i).Animal(1).DRLresetsmean10 DRL(i).Animal(2).DRLresetsmean10...
    DRL(i).Animal(3).DRLresetsmean10 DRL(i).Animal(4).DRLresetsmean10];

    DRL(i).DRLresetsmean20 = [DRL(i).Animal(1).DRLresetsmean20 DRL(i).Animal(2).DRLresetsmean20...
    DRL(i).Animal(3).DRLresetsmean20 DRL(i).Animal(4).DRLresetsmean20];

    %DRL(i).DRLresetsmean30 = [DRL(i).Animal(1).DRLresetsmean30 DRL(i).Animal(2).DRLresetsmean30...
    %DRL(i).Animal(3).DRLresetsmean30 DRL(i).Animal(4).DRLresetsmean30];
    
    DRL(i).DRLresetsmean= [DRL(i).DRLresetsmean5; DRL(i).DRLresetsmean10; DRL(i).DRLresetsmean20] %DRL(i).DRLresets30
    %use ; in concatenating so will do vertical which is what we need for
    %this prism graph
end




    





















