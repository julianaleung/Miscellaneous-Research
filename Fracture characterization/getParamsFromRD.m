%Copyright - Francis Nwabia & Juliana Y. Leung

function [Iy,newVal,CI]=getParamsFromRD(rD,ci,Ix,Iy,pdfX,pdfY,I2PDF,iter,iter_out,figNo,lege,MCno,debug)

NoOfIndicators=length(Ix);

if isempty(ci)
    [~,ci]=max(Iy);
end

P=double(false(size(Iy)));      % Variable for the probabilities of the indicators at the next step. This is PPM.
for i=1:NoOfIndicators
    if i~=ci
        P(i)=rD*Iy(i);
    end
end
P(ci)=1-sum(P);
Iy=P;

if debug 
    figure(figNo);clf;subplot(1,3,1);hold on;
    plot(Ix,Iy,'.','DisplayName',sprintf('rD=%.3f',rD));
    title(['PDF with ind. for ',lege]);legend show;
end

% Transform PDF to CDF and plot it in Fig. 4
cumu=getCDF(Iy);

% N - Monte-Carlo sampling
idx=double(false(MCno,1));newVal=double(false(MCno,1));
CI=MCSamples(cumu,MCno);
newVal=I2PDF(CI);

% cmuO=getCDF(pdfY);
% cmuO=cmuO/max(cmuO);
% for i=1:MCno
%     [~,idx(i)]=min(abs(cmuO-cumu(CI(i))));
%     newVal(i)=pdfX(idx(i));
% end

if debug
    figure(figNo);
    subplot(1,3,2);hold on;
    plot(Ix,cumu,'.','DisplayName','CDF');
    for i=1:MCno
        plot(Ix(CI(i)),cumu(CI(i)),'*','DisplayName',['MC #',num2str(i)]);
    end
    title(['CDF with ind. for ',lege]);
%     legend show;
    figure(figNo);
    subplot(1,3,3);hold on;
    plot(I2PDF(Ix),cumu,'.','DisplayName','CDF');
    for i=1:MCno
        plot(newVal(i),cumu(CI(i)),'*','DisplayName',['MC #',num2str(i)]);
    end
    title(['CDF for ',lege]);
    legend show;set(legend,'Location','EastOutside','Box','off');
    saveas(figNo,[lege,'_CDF_',num2str(iter_out),'_',num2str(iter),'_distri.png']);
end