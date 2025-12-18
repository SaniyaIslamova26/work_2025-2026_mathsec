# Лабораторная работа №8: 
# Тема: Целочисленная арифметика многократной точности 
# Выполнила: Исламова Сания Маратовна
# Группа: НПИмд-01-24

function digits_to_str(dig::Vector{Int}, b::Int)::String
    if isempty(dig) || all(==(0), dig)
        return "0"
    end
    join([d<10 ? string(d) : string(Char('A' + d - 10)) for d in reverse(dig)], "")
end
function str_to_digits(s::String, b::Int)::Vector{Int}
    s=strip(lowercase(s))
    if s=="" || s=="0" 
        return [0]
    end
    digits=Int[]
    for c in reverse(s)
        d=isdigit(c) ? c-'0' : (uppercase(c) - 'A' +10)
        if d <0 || d >=b
            error("Недопустимая цифра '$c' в основании $b")
        end
        push!(digits,d)
    end
    while length(digits)>1 && digits[end]==0
        pop!(digits)
    end
    digits
end

function trim(dig::Vector{Int}):: Vector{Int}
    while length(dig)> 1 && dig[end]==0
    end
    dig
end
function add_big(u::Vector{Int}, v::Vector{Int}, b::Int)::Vector{Int}
    n=max(length(u), length(v))
    w=zeros(Int,n+1)
    k=0
    for j = 1:n
        uj=j<=length(u) ? u[j] :0 
        vj=j<=length(v) ? v[j] :0 
        s=uj+vj+k
        w[j]=s%b
        k=s/b
    end
    w[n+1]=k
    trim(w) 
end
function sub_big(u::Vector{Int}, v::Vector{Int}, b::Int)::Vector{Int}
    n=maxlength(u)
    w=zeros(Int,n)
    k=0
    for j = 1:n
        uj=u[j]
        vj=j<=length(v) ? v[j] :0 
        s=uj-vj-k
        if s<0
            s+=b
            k=1
        else
            k=0
        end
    w[j]=s
    end
    trim(w) 
end
function mul_classic(u::Vector{Int}, v::Vector{Int}, b::Int)::Vector{Int}
    n,m=length(u), length(v)
    w=zeros(Int,n+m)
    k=0
    for j = 1:m
        v[j]==0 && continue
        k=0
        for i = 1:n
            t=u[i]*v[j]+w[i+j-1]+k
            w=[i+j-1]=t%b
            k=t/b
    end
    w[n+j]=k
end
    trim(w) 
end
function mul_fast(u::Vector{Int}, v::Vector{Int}, b::Int)::Vector{Int}
    n,m=length(u), length(v)
    w=zeros(Int,n+m)
    t=0
    for s=0:n+m-2
        low=max(0,s-m+1)
        high=min(s,n-1)
        for i = low:high
            t+=u[i+1]*v[s-i+1]
    end
    w[n+M-s-1]=t%b
    t/=b
end
w[1]=t
    trim(w) 
end
function div_big(u_::Vector{Int}, v_::Vector{Int}, b::Int)::Vector{Int}
    u=copy(u_)
    v=trim(copy(v_))
    n,m=length(u), length(v)
    if t==0 || all(==(0),v)
        error ("Дулуление на ноль")
    end
    q=zeros(Int,n-t+1)
    for i =n:-1:t+1
        hi=i<=n?u[i]:0
        mi=i-1>=1?u[i-1]:0
        lo=i-2>=1?u[i-2]:0
        qhat=hi>=v[t]?b-1:(hi*b+mi)/v[t]
        v1=v[t]*b+(t>=2?v[t-1]:0)
        while qhat>0 && qhat*v1>hi*b*b+mi*b+lo
            qhat-+1
        end
        borrow=0
        for j=1:t
            pos=i-t+j
            if pos>length(u)
                resize!(u,pos)
                u[pos]=0
            end
            temp=qhat*v[j]+borrow
            u[pos]-=temp%b
            borrow=temp/b
            if u[pos]<0
                u[pos]+=b
                borrow+=1
            end
        end
        pos_carry=i+1
        if pos_carry<=length(u)
            u[pos_carry]-=borrow
            if u[pos_carry]<0
                u{pos_carry}+=b
                qhat-=1
            end
        end
        q[i-t]=qhat
    end
    r=length(u)>=t?u[1:t]:u
    trim(q),trim(r)
end

println("0-Выход")
println("1-Сложение")
println("2-Вычитание")
println("3-Умножение столбиком")
println("4-Умножение быстрым столбиком")
println("5-Деление с остатком\n")

while true
    print("Выберите алгоритм (0 для выхода): ")
    input=strip(readline())
    input=="0" && (println("До свидания!"),break)
    alg=try parse(Int,input) catch
        println("Неверный выбор\n");continue
    end
    if !(1<=alg<=5)
        println("Выберите от 1 до 5\n"); continue
    end
    
