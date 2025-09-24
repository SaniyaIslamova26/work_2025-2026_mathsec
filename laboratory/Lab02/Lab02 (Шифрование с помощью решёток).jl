function fleissner_main()
    
    while true
       
        println("Введите Ш для шифрования, Р для расшифрования, В для выхода")
        
        print(">>> ")
        
        cmd = lowercase(strip(readline()))
        
        
        cmd == "в" && (println("Выход"); break)
        
        cmd in ["ш", "р"] || (println("Неверная команда"); continue)
        
        
        print("Введите текст: ")
       
        text = readline()
        
        print("Введите пароль (4 символа): ")
       
        password = readline()
        
        
        clean_chars = collect(replace(uppercase(text), " " => ""))
        
        pass_chars = collect(uppercase(password))
        
        k = 2  
        
       
        size_2k = 2k
        
        grille = falses(size_2k, size_2k)
       
        for i in 1:k, j in 1:k
            grille[i, j] = grille[i, k+j] = grille[k+i, j] = grille[k+i, k+j] = true
        end
        
        
        total = size_2k^2
        
        length(clean_chars) < total && append!(clean_chars, fill('А', total - length(clean_chars)))
       
        table, idx, mask = fill(' ', size_2k, size_2k), 1, copy(grille)
        
        
        for _ in 1:4
            
            for i in 1:size_2k, j in 1:size_2k
                
                mask[i,j] && idx <= length(clean_chars) && (table[i,j] = clean_chars[idx]; idx += 1)
            end
            
            mask = reverse(mask, dims=1)'
        end
        
       
        sorted_cols = sort(1:length(pass_chars), by=i -> pass_chars[i])
       
        result = join([table[i,j] for j in sorted_cols for i in 1:size_2k])
        
       
        println("Результат: $result")
       
        println("-"^50)
    end
end


fleissner_main()