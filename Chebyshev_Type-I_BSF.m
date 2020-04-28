

f1=input("Enter the lower stop-band frequency");
f2=input("Enetr the higher stop-band frequency");
fu=input("Enter the higher pass-band frequency");
fl=input("Enter the lower pass-band frequency");
pr=input("Enter the pass-band ripple");
sa=input("Enter the stop-band attenuation");
fs=2000;
T=1/fs;

w1=2*pi*f1/fs;
w2=2*pi*f2/fs;
wu=2*pi*fu/fs;
wl=2*pi*fl/fs;

o1=(2/T)*(tan(w1/2));
o2=(2/T)*(tan(w2/2));
ou=(2/T)*(tan(wu/2));
ol=(2/T)*(tan(wl/2));

x=(o1*(ou-ol))/(-o1^2+ou*ol);
y=(o2*(ou-ol))/(-o2^2+ou*ol);
Or=min(abs(x),abs(y));

ep=sqrt(10^(pr/10)-1);
A=10^(pr/20);
g=sqrt(((A^2)-1)/ep^2);

N=ceil(log(g+sqrt(g^2+1))/log(1/Or));

s=tf('s');
hsde=1;
for k=1:N
	sigmak=-sinh((1/N)asinh(1/ep))*sin((2*k-1)*(pi/2*N));
	omegak=cosh((1/N)asinh(1/ep))*cos((2*k-1)*(pi/2*N));
	sk(k)=sigmak+i*omegak;
	hsde=hsde*(s-sk(k));
end
Hn=1/hsde;
b0=N