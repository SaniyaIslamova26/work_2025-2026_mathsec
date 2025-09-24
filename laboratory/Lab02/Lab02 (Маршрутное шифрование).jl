function columnar_main()
    

    while true
        
        println("Введите Ш для шифрования, Р для расшифрования, В для выхода")
        print(">>> ")
        cmd = lowercase(strip(readline()))
        cmd == "в" && (println("Выход"); 
break)
        
        cmd in ["ш", "р"] || (println("Неверная команда"); continue)
        
        print("Введите текст: ")
        text = readline()
        print("Введите пароль: ")
        password = readline()
        clean_text = replace(uppercase(text), " " => "")
       
        pass_chars = collect(uppercase(password))
        
        n, m = length(pass_chars), ceil(Int, length(clean_text) / length(pass_chars))
        
        
        padded = clean_text * "А"^(m*n - length(clean_text))
        
        table = reshape(collect(padded), (m, n))
        
       
        
        column_pairs = [(pass_chars[i], i) for i in 1:length(pass_chars)]
        
        sort!(column_pairs, by = x -> x[1])
        
        sorted_cols = [idx for (char, idx) in column_pairs]
        
        
        result = join([table[i,j] for j in sorted_cols for i in 1:m])
        
        
        println("Результат: $result")
        
        println("-"^50)
    end
end


columnar_main()
