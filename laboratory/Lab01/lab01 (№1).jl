#Лабораторная работа №1
#Тема: Шифры простой замены
#Выполнила: Исламова Сания Маратовна (студ.билет 1132249576)

#Задание №1 - шифр Цезаря
function main()
    alphabet = collect("абвгдеёжзийклмнопрстуфхцчшщъыьэюя")
    n = length(alphabet)
    while true
        println("Введите Ш для шифрования сообщения, Р для расшифровки сообщения и В для выхода")
        print(">>>")
        menu=lowercase(strip(readline()))
        if menu =="в"
            printl("Выход из программы...")
            break
        elseif menu =="ш" 
            operation = "шифрование"
        elseif menu == "р" 
            operation = "расшифрование"
        else 
            println("Неверная команда! Повторите попытку.") 
            continue
        end
        print("Введите сообщение:")
        message = lowercase(strip(readline()))
        print("Введите ключ:")
        try 
            key = parse(Int,readline())
        catch e 
            println("Ошибка: введите целое цисло для ключа") 
            continue
        end
        if menu =="р" 
            key = -key
        end 
        output = ""

        for letter in message 
            idx = findfirst(isequal(letter), alphabet)
            if idx !== nothing 
                new_idx = mod(idx+key-1,n)+1 
                output *= string(alphabet[new_idx])
            else 
                output *= string(letter)
            end 
        end
        println("Результат $operation: $output")
        println("-"^50)
    end
end

main()


                