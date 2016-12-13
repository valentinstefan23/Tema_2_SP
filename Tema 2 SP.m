i=0:0.001:100
D=21;
P=40;
w0=2*pi/P;
duty=21/40*100;%factorul de umplere al semnalului
figure(1)
xq=0.5*square(w0*i,duty)+0.5;%semnalul dreptunghiular initial

%Afisarea semnalului dreptunghiular
D=21;
P=40;
w0=2*pi/P;
duty=21/40*100;%factorul de umplere al semnalului
figure(1)
plot(i,xq),hold on
xlabel('Timp')
ylabel('Amplitudine')
title('Semnalul dreptunghiular(cu albastru) si semnalul reconstruit(rosu)')
axis([0 100 -0.5 1.5]),grid on  %trasare  semnal initial

%----------------------------------------------------------------


%Afisarea spectrului de amplitudine a semnalului dreptunghic initial


j=-5%k este primul coeficient/cel de la care se va incepe afisarea
M=5%ultimul coeficient

while(j<=M )
fun = @(t) (0.5*(square(w0*t,duty))+0.5);
a0=(1/P)*integral(fun,0,P);%componenta continua a semnalului
cosf= @(t) (0.5*(square(w0*t,duty)) +0.5) .* cos(j*w0*t);
sinf= @(t) (0.5*(square(w0*t,duty))+0.5) .* sin(j*w0*t);
c=(2/P)*integral(cosf,0,P);%partea reala a coeficientului complex de 
%ordin k
s=(2/P)*integral(sinf,0,P);%partea imaginara a coeficientului complex 
%de ordin k

amp=sqrt(c*c+s*s);%amp este amplitudinea armonicei de ordin k<--din 
%forma armonica a semnalului


if(j==0)
   amp=a0%amp va fi componenta continua a semnalului
end
 
disp(amp)%afiseaza valoarea amplitudinei armonicei de ordin k
figure(2)
stem(j,amp),hold on,grid on
xlabel('Frecventa ')
ylabel('Amplitudine')
title('Spectrul de amplitudini al semnalului')
coef=(c-(1j)*s)/2%coef reprezinta coeficientul complex de ordin k 
%al dezvoltarii



disp(coef)%afiseaza valoarea coeficientului complex
j=j+1

end

%----------------------------------------------------------------


%Afisarea semnalului reconstruit prin intermediul coefticientilor Fourier


N=50%N este numarul dorit de coeficienti din dezvoltare seriei Fourier
k=-5%k este primul coeficient/cel de la care se va incepe
xr=0
while(k<=N )
fun = @(t) (0.5*(square(w0*t,duty))+0.5);%am definit semnalul ca functie de
%t

a0=(1/P)*integral(fun,0,P);%componenta continua a semnalului

cosf= @(t) (0.5*(square(w0*t,duty)) +0.5) .* cos(k*w0*t);%am definit 
%functia in urma carei integrari vom obtine partea reala a coeficientului
%complex

sinf= @(t) (0.5*(square(w0*t,duty))+0.5) .* sin(k*w0*t);%la fel ca pentru 
%cosf dar pentru partea imaginara

c=(2/P)*integral(cosf,0,P);%partea reala a coeficientului complex de 
%ordin k

s=(2/P)*integral(sinf,0,P);%partea imaginara a coeficientului complex 
%de ordin k

coef=(c-(1j)*s)/2%coef reprezinta coeficientul complex de ordin k 
%al dezvoltarii

xr=xr+coef*exp((1j)*k*w0*i)%xr este componenta a semnalului reconstruit
%prin coeficientii Fourier

disp(coef)%afiseaza valoarea coeficientului complex
k=k+1

end

xf=((1/P)*a0 + xr)%semnalul reconstruit prin intermediul coeficientilor 
%Fourier
figure(1)
plot(i,xf),grid on


%--------------------------------------------------------------------
