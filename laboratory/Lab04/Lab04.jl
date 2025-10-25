# Лабораторная работа №4
# Тема: Вычисление наибольшего общего делителя (НОД)
#Выполнила: Исламова Сания
#Группа: НПИмд-01-24
#Задание: Реализовать все рассмотренные алгоритмы программно (НОД: алгоритм Евклида, Бинарный алгоритм Евклида, Расширенный алгоритм Евклида, Расширенный бинарный алгоритм Евклида)
g1(a,b)=b==0 ? a : g1(b,a%b)
g2(a,b)=a==b ? a : (a==0 ? b : (b==0 ? a : (iseven(a)&&iseven(b) ? 2*g2(a÷2,b÷2) : (iseven(a) ? g2(a÷2,b) : (iseven(b) ? g2(a,b÷2) : (a>b ? g2(a-b,b) : g2(a,b-a)))))))
function g3(a,b) u,v,x,y=1,0,0,1
while b!=0 q,a,b=a÷b,b,a%b; u,v,x,y=v,u-q*v,y,x-q*y end
(a,u,x) end
function g4(a,b) g,u,v,A,B,C,D=1,a,b,1,0,0,1
while iseven(u)&&iseven(v) u/=2;v/=2;g*=2 end
while u!=0
while iseven(u) u/=2; iseven(A)&&iseven(B) ? (A/=2;B/=2) : (A=(A+b)/2;B=(B-a)/2) end
while iseven(v) v/=2; iseven(C)&&iseven(D) ? (C/=2;D/=2) : (C=(C+b)/2;D=(D-a)/2) end
u>=v ? (u-=v;A-=C;B-=D) : (v-=u;C-=A;D-=B) end
(g*v,C,D) end

while true 
println("\n1К 2Б 3Р 4РБ В")
print(">") 
c=readline()
isempty(c)&&continue
c[1]=='в'&&break
if c[1] in ['1','2','3','4'] 
try 
print("ab: ") 
a,b=parse.(Int,split(readline()))
if c[1]=='1' println("Н: ",g1(a,b))
elseif c[1]=='2' println("Н: ",g2(a,b))
elseif c[1]=='3' d,x,y=g3(a,b);println("Н: $d=$a×$x+$b×$y")
else d,x,y=g4(a,b);println("Н: $d=$a×$x+$b×$y") end 
catch; println("Err") end 
end 
end