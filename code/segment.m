function a = segment(filtered_signal,sampling_frequency);
for i=1:180
    a(1:1280,i)=filtered_signal(1+10*sampling_frequency*(i-1):10*sampling_frequency*i);
end
