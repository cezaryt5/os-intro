---
title: "Презентация по лабораторной работе №5"
---

# Выполнение лабораторной работы  
## Менеджер паролей pass

### Установка  
#### Fedora  
```bash  
# Установка pass и gopass  
sudo dnf install pass pass-otp  
sudo dnf install gopass  
```  

### Настройка  
#### Ключи GPG  
```bash  
# Просмотр списка ключей  
gpg --list-secret-keys  

# Создание нового ключа (если отсутствует)  
gpg --full-generate-key  

# Инициализация хранилища pass  
pass init <gpg-id or email>  
```  

#### Синхронизация с git  
```bash  
# Инициализация git для pass  
pass git init  

# Добавление удаленного репозитория  
pass git remote add origin git@github.com:<git_username>/<git_repo>.git  

# Синхронизация  
pass git pull  
pass git push  
```  

### Интеграция с браузером  
#### Установка browserpass  
**Репозиторий:** [browserpass-extension](https://github.com/browserpass/browserpass-extension)  

**Native messaging:**  
```bash  
# Fedora  
sudo dnf copr enable maximbaz/browserpass  
sudo dnf install browserpass  
```  

### Работа с паролями  
```bash  
# Добавление пароля  
pass insert [OPTIONAL_DIR]/[FILENAME]  

# Отображение пароля  
pass [OPTIONAL_DIR]/[FILENAME]  

# Обновление пароля  
pass generate --in-place FILENAME  
```  

### Управление конфигурацией с помощью chezmoi  
#### Установка дополнительного ПО  
```bash  
sudo dnf -y install \  
         dunst \  
         fontawesome-fonts \  
         powerline-fonts \  
         light \  
         fuzzel \  
         swaylock \  
         kitty \  
         waybar swaybg \  
         wl-clipboard \  
         mpv \  
         grim \  
         slurp  
```  

#### Настройка chezmoi  
```bash  
# Установка chezmoi  
sh -c "$(wget -qO- chezmoi.io/get)"  

# Создание репозитория dotfiles  
gh repo create dotfiles --template="yamadharma/dotfiles-template" --private  

# Инициализация chezmoi  
chezmoi init git@github.com:<username>/dotfiles.git  

# Просмотр изменений  
chezmoi diff  

# Применение изменений  
chezmoi apply -v  
```  

### Вывод  
Менеджер паролей `pass` обеспечивает безопасное хранение и синхронизацию данных через GPG-шифрование и git. Интеграция с браузером через browserpass и автоматизация настройки через chezmoi позволяет эффективно управлять учетными данными и конфигурациями на нескольких устройствах.
