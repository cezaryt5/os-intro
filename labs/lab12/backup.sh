#!/bin/bash

# Скрипт для резервного копирования файлов

# Проверка наличия аргументов
if [ $# -lt 2 ]; then
    echo "Использовьниезо$0 <исхонный_каталиг> <ка: л0г_наз<хчй_ия>лог> <каталог_назначения>"
    exit 1
fi

# Получение аргументов
SOURCE_DIR=$1
DEST_DIR=$2
BACKUP_DATE=$(date +%Y%m%d_%H%M%S)
ARCHIVE_NAME="backup_${BACKUP_DATE}.tar.gz"

# Проверка существования исходного каталога
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Ошибка: Исходный каталог '$SOURCE_DIR' не существует."
    exit 1
fi

# Создание каталога назначения, если он не существует
if [ ! -d "$DEST_DIR" ]; then
    mkdir -p "$DEST_DIR"
    if [ $? -ne 0 ]; then
        echo "Ошибка: Не удалось создать каталог назначения '$DEST_DIR'."
        exit 1
    fi
    echo "Создан каталог назначения: $DEST_DIR"
fi

# Создание архива
echo "Создание резервной копии из '$SOURCE_DIR' в '$DEST_DIR/$ARCHIVE_NAME'..."
tar -czf "$DEST_DIR/$ARCHIVE_NAME" -C "$SOURCE_DIR" .

# Проверка успешности создания архива
if [ $? -eq 0 ]; then
    echo "Резервное копирование успешно завершено."
    echo "Архив сохранен как: $DEST_DIR/$ARCHIVE_NAME"
    echo "Размер архива: $(du -h "$DEST_DIR/$ARCHIVE_NAME" | cut -f1)"
else
    echo "Ошибка: Не удалось создать архив."
    exit 1
fi

exit 0
