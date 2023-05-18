#!/bin/bash
#вводим данные
    source=$(whiptail --title "Ввод исходной папки" --inputbox "Ввдите путь откуда вы хотите скопировать файлы" 10 60 /home/breit/otpr 3>&1 1>&2 2>&3)
    exitstatus=$?
    if [ $exitstatus = 0 ]; then
        echo "Вы будете копировать из папки" $source
    else
        echo "Вы выбрали отмену."
    fi

    target=$(whiptail --title "Ввод папки куда копируем" --inputbox "Ввдите путь куда вы хотите скопировать файлы" 10 60 /home/breit/proverka 3>&1 1>&2 2>&3)
    exitstatus=$?
    if [ $exitstatus -eq 0 ]; then
        echo "Вы будете копировать из папки" $source
    else
        echo "Вы выбрали отмену."
    fi


#существует ли папка откуда мы копируем
    if [[ -d "$source" ]]
        then
            echo "Исходная папка $source найдена, продолжаем"
        else 
            echo "Исходная папка не найдена"
            exit 1
    fi

#существует ли папка куда копируем
    if [[ -d "$target" ]]    
        then
            echo "$target существует, выполняем копирование"
        else 
            echo "Директории не существует, создаём $target и копируем туда"
            mkdir -p $target
    fi

#изменение названия и копирование
    if (whiptail --title "Изменение в названии" --yes-button "Да" --no-button "Нет" --yesno "Хотите ли вы добавить в название файлов что-то?" 10 60) 
        then
        name=$(whiptail --title "Ввод приставки" --inputbox "Введите приставку которую вы хотите добавить" 10 60 copy_ 3>&1 1>&2 2>&3)
        exitstatus=$?
            for file in "$source"/*
            do
                if [[ -f "$file" ]]
                then
                echo "Копируем файл $file"
                cp "$file" "$target/$name$(basename "$file")"
                fi
            done


        else
            echo "Не хотите, тогда продолжаем"
            for file in "$source"/*
            do
                if [[ -f "$file" ]]
                then
                echo "Копируем файл $file"
                cp "$file" "$target/$(basename "$file")"
                fi
            done
    fi
#конец
    if [ $? -eq 0 ]
        then
        echo "Копирование прошло успешно!"
        whiptail --title "Конец" --msgbox "Копирование прошло успешно!" 10 60
        else
        echo "Копирование не удалось. Ошибка"
    fi
