srate_time = 200;
time = linspace(0,1, srate_time);
freqs_time = linspace(0,srate_time/2, floor(length(time)/2+1));
freqs_time = freqs_time(1:end-1);
nChan = 50;
frex = 10;
phaseOffset = fliplr(cumsum(repmat(linspace(-.7,.7,150), nChan, 1),1));
time2D = repmat(time,nChan, 1);

figure
for i_phase = 1:size(phaseOffset,2)
    sinWave2D = sin(2*pi*frex*time2D + phaseOffset(:,i_phase));
    fft2D = abs(fftshift(fft2(sinWave2D)));
    half2D = fft2D(:,size(fft2D,2)/2+1:end);
    
    %plot sines
    subplot(121)
    I = imagesc(time, [], sinWave2D);
    xlabel('time (s)')
    ylabel('channels')
    title('Stacked EEG Channels')
    %plot 2D fft
    subplot(122)
    imagesc(freqs_time, [], half2D)
    xlabel('temporal frequency (hz)')
    ylabel('spatial frequency')
    title('2-D Fourier Transform')
    yticks([nChan/2+1])
    yticklabels({'0'})
    xlim([0 40])
    %get the max point
    maxvalue = max(half2D, [], 'all');
    [x,y] = find(half2D == maxvalue);
    hold on
    plot(freqs_time(y), x, 'rs', 'MarkerSize', 20)
    txtstr = ['Phase Offset' newline num2str(phaseOffset(1,i_phase))];
    T = text(20, 10, txtstr, 'Color', [1 1 1], 'EdgeColor', [1 1 1], 'HorizontalAlignment', 'center');

    pause(0.2)
end
