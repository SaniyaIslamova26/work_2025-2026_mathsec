println("ρ-метод Полларда для дискретного логарифмирования")
while true
    println("\nВведите p a b r через пробел (или 'выход' для завершения):")
    input = readline()
    input == "выход" && break
    
    try
        p,a,b,r = parse.(BigInt, split(input))
        function ρ(p,a,b,r)
            u,v = rand(0:r-1,2)
            c = powermod(a,u,p)*powermod(b,v,p)%p
            d = c
            α1,β1,α2,β2 = u,v,u,v
            while (c = (c<p÷2 ? a*c : b*c)%p) != 
                  (d = (d<p÷2 ? a*d : b*d)%p; d = (d<p÷2 ? a*d : b*d)%p)
                α1,β1 = (α1+(c<p÷2))%r, (β1+(c≥p÷2))%r
                α2,β2 = (α2+2(d<p÷2))%r, (β2+2(d≥p÷2))%r
            end
            g,x,_ = gcdx((β1-β2)%r, r)
            (Δα=(α2-α1)%r)%g ≠ 0 ? nothing : (x*Δα÷g)%r
        end
        x = ρ(p,a,b,r)
        println(x===nothing ? "Нет решений" : "x = $x")
    catch
        println("Ошибка: введите 4 числа или 'выход'")
    end
end
println("Программа завершена")