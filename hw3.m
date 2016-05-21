%Problem 1
N=256;
x=zeros(1,N);
A=0.5;

for i=1:N
    x(1,i)=A^(i-1);
end
figure;stem(x(1:9));title('Original Sequence');

a = [1 -A];
b = [1];
figure; zplane(b,a);
%Downsample in frequency
[h,w] = freqz(b,a, 16,'whole');
figure; stem(w,abs(h));title('Frequency Domain');
hn = ifft(h(1:9));  
figure;stem(hn);title('Inverse Transform');

pause;close all;

%%
%Problem 2
%design the filter in 1-D using firpm 
f = [0 0.08 0.19 1];
a = [0 0.0 1.0 1.0];
[b, err, res] = firpm(50,f,a);
figure; stem(b); title('Symmetric Zero-Phase Filter (firpm)');xlabel 'n', ylabel 'Coefficients'

[h,w] = freqz(b,1,512);
figure;plot(f,a,w/pi,abs(h))
legend('Ideal','firpm Design')
title('Impulse Response');
xlabel 'Radian Frequency (\omega/\pi)', ylabel 'Magnitude'

%Convert to 2-D
h2d = ftrans2(b);
freqz2(h2d);