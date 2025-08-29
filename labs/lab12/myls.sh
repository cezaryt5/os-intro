#!/bin/bash

# Скрипт-аналог команды ls

# Функция для вывода справки
show_help() {
    echo "Использование: $0 [опции] [каталог]"
    echo "Опции:"
    echo "  -a    Показать все файлы, включая скрытые"
    echo "  -l    Подробный формат вывода"
    echo "  -h    Показать эту справку"
    exit 0
}

# Инициализация переменных
show_hidden=0
long_format=0
directory="."

# Обработка опций
while getopts "alh" opt; do
    case $opt in
        a) show_hidden=1 ;;
        l) long_format=1 ;;
        h) show_help ;;
        \?) echo "Неизвестная опция: -$OPTARG" >&2; exit 1 ;;
    esac
done

# Сдвиг обработанных опций
shift $((OPTIND - 1))

# Если указан каталог, используем его
if [ $# -gt 0 ]; then
    directory="$1"
fi

# Проверка существования каталога
if [ ! -d "$directory" ]; then
    echo "Ошибка: Каталог '$directory' не существует."
    exit 1
fi

# Получение списка файлов
if [ $show_hidden -eq 1 ]; then
    files=($(ls -a "$directory"))
else
    files=($(ls "$directory"))
fi

# Вывод результатов
echo "Содержимое каталога: $directory"
echo "------------------------"

for file in "${files[@]}"; do
    # Пропускаем . и .. если не показываем скрытые файлы
    if [ $show_hidden -eq 0 ] && [[ "$file" == "." || "$file" == ".." ]]; then
        continue
    fi
    
    full_path="$directory/$file"
    
    if [ $long_format -eq 1 ]; then
        # Тип файла
        if [ -d "$full_path" ]; then
            type="d"
        elif [ -L "$full_path" ]; then
            type="l"
        else
            type="-"
        fi
        
        # Права доступа
        permissions=""
        if [ -r "$full_path" ]; then permissions="${permissions}r"; else permissions="${permissions}-"; fi
        if [ -w "$full_path" ]; then permissions="${permissions}w"; else permissions="${permissions}-"; fi
        if [ -x "$full_path" ]; then permissions="${permissions}x"; else permissions="${permissions}-"; fi
        
        # Размер и дата модификации
        size=$(du -h "$full_path" 2>/dev/null | cut -f1)
        mod_date=$(date -r "$full_path" "+%Y-%m-%d %H:%M")
        
        echo "$type$permissions $size $mod_date $file"
    else
        echo "$file"
    fi
done

exit 0
