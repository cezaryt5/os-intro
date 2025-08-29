#!/bin/bash

# Скрипт для подсчета файлов по форматам

# Проверка наличия аргумента
if [ $# -lt 1 ]; then
    echo "Использование: $0 <каталог>"
    exit 1
fi

# Получение аргумента
directory="$1"

# Проверка существования каталога
if [ ! -d "$directory" ]; then
    echo "Ошибка: Каталог '$directory' не существует."
    exit 1
fi

echo "Подсчет файлов по форматам в каталоге: $directory"
echo "------------------------------------------------"

# Получение списка всех файлов рекурсивно
files=$(find "$directory" -type f | sort)

# Инициализация ассоциативного массива для подсчета
declare -A formats_count

# Подсчет файлов по расширениям
for file in $files; do
    # Получение расширения файла
    extension="${file##*.}"
    
    # Если файл не имеет расширения, считаем его как "без расширения"
    if [ "$extension" = "$file" ]; then
        extension="без расширения"
    else
        extension=".$extension"
    fi
    
    # Увеличиваем счетчик для данного расширения
    if [ -z "${formats_count[$extension]}" ]; then
        formats_count[$extension]=1
    else
        formats_count[$extension]=$((formats_count[$extension] + 1))
    fi
done

# Вывод результатов
echo "Формат | Количество файлов"
echo "------------------------"
for format in "${!formats_count[@]}"; do
    count=${formats_count[$format]}
    
    # Правильное склонение слова "файл"
    if [ $count -eq 1 ]; then
        word="файл"
    elif [ $count -ge 2 ] && [ $count -le 4 ]; then
        word="файла"
    else
        word="файлов"
    fi
    
    echo "$format: ${formats_count[$format]} $word"
done

# Общее количество файлов
total=0
for count in "${formats_count[@]}"; do
    total=$((total + count))
done

echo "------------------------"
echo "Всего: $total файлов"

exit 0
