# Linux no MacBookPro
## Instalação do Arch no macbook
* localectl keymap -list (lista keymaps)
* loadkeys us-acentos (mapa com acentos para teclado US)
* timedatectl set-ntp-true (alinhar o tempo da máquina com tempo da internet)
* gdisk (organiza partições)
* mkfs.ext4 -> mount /mnt -> mount mnt/boot (no macbook é interessante não criar um boot EFI e sim usar a versão simples dual boot)
* pacstrap /mnt base linux linux-firmware intel-ucode vim broadcom-wl-dkms (sem o driver broadcom não há internet)
* genfstab -U >> /etc/fstab
* arch-chroot /mnt
* dd if=/dev/zero of=/swapfile bs=1G count=2 status=progress (cria e orienta duas swaps de 1giga)
* chmod 600 /swapfile (dá acesso usuário ao swapfile)
* mkswap /swapfile
* swapon /swapfile
* adicionar a linha seguinte no fstab:

/swapfile none swap defaults 0 0

* timedatectl list-timezones
* ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime (cria um localtime correspondente ao fuso SP)
* hwclock -systohc (assimila o hardware locale com o do sistema locale)
* vim /etc/locale-gen (desmarcar o locale-gen correto para gerar idiossincrasias correspondentes)
* locale-gen (gera o locale)
* echo LANG=pt_BR.UTF-8 >> /etc/locale.conf (linka a variável linguagem com o locale gerado)
* echo KEYMAP=us-acentos >> /etc/vconsole.conf (linka o teclado com o locale gerado)
* vim /etc/hostname/ (insira nesse file um nome para máquina)
* edite o arquivo vim /etc/hosts/ da seguinte forma: 

127.0.0.1	localhost

::		localhost

127.0.1.1	nome_da_maquina.localdomain nome_da_maquina 

* passwd (crie uma password para o root)
* pacman -S efibootmgr networkmanager dialog wpa_supplicant mtools dosfstools base-devel linux-heads git bluez bluez-utils pulseaudio pulseaudio-bluetooth alsa-utils cups xdg-utils xdg-user-dirs
* bootctl --path=/boot install
* adicione a linha em vim /boot/loader/loader.conf 

Arch-\*

* adicione as linhas em /boot/entries/arch.conf

title ArchLinux

linux /vmlinuz-linux

initrd /initramfs-linux.img

options root=/dev/sda3 rw

* sytemctl enable NetworkManager
* sytemctl enable bluetooth 
* sytemctl enable cups
* EDITOR=vim visudo e tire o comentário da linha root ALL=(ALL) ALL
* Com a tecla option direita ruim, eu altero o /usr/share/kbd/keymaps/i386/qwerty/us-acentos removendo a tecla 56
* exit (sair do arch-chroot)
* umount -a (desmonta tudo)
* sudo pacman -S xf86-video-intel xorg xorg-xinit i3 (instala driver gráfico e o servidor xorg junto WM i3)
* Alterar o ~/.Xresources: (Para resolver o problema de HiDpi)

Xft.dpi: 192 (sempre usar multiplos de 96)

Xft.autohint: 0

Xft.lcdfilter:  lcddefault

Xft.hintstyle:  hintfull

Xft.hinting: 1

Xft.antialias: 1

Xft.rgba: rgb

* incluir no .xinitrc as linhas: 

xrdb -merge ~/.Xresources &
setxkbmap -option compose:rwin (torna a tecla command como tecla windows)
exec i3

* Depois de inicializado, editar o ~/.config/i3/config :

floating_size min e máx (idealmente era pra deixar -1 para que o graphical decida, mas no caso do HiDpi usar 300x300)

Usando thetering do Android
* ls /sys/class/net/ e busque o device
conecta com nmcli ou connmanctl

o driver eh instalado no manjaro quando o pacote abaixo eh instalado 
linux515-broadcom-wl 

## Teclado
O teclado me custou muito...

Na verdade existem vários níveis de configuração. Desde o hardware do próprio teclado até a aplicação final usando ele como input.

No mais básico de acesso dentro do ambiente GNU-Linux temos o arquivo de map que fica em /usr/share/kbd/keymaps/

O ideal é montar uma versão desses arquivos em /etc/alguma_coisa... porém como meu problema é consertar a tecla 56 eu atribui ela no mapa original em /usr/share/kbd/keymaps/ para ser Num_Lock que é uma tecla ausente nesse teclado. NÃO FUNCIONA COLOCAR VAZIO, NULL, NUL OU OUTRA COISA. Tem que ser alguma tecla inútil pq o nível abaixo do kernel vai preencher os vazios com padrões, fazendo com que sempre tenha algo na tecla...

Por fim pra fazer os dead keys funcionarem eu fiz meus remaps num script:

##!/bin/bash
setxkbmap us intl
xmodmap -e 'keycode 49 = dead_grave dead_tilde'
xmodmap -e 'keycode 64 = ' 
xmodmap -e 'keycode 48 = dead_acute quotedbl apostrophe'
xmodmap -e 'keycode 54 = c C c C ccedilla Ccedilla' 
xmodmap -e 'keycode 59 = comma less comma less copyright cent copyright'

E finalmente o Ç/ç deve ser alterado diretamente no Compose do X11 em 

/usr/share/X11/locale/en_US.UTF-8 

acha certinho onde está o cedilha e elimina o c com agudo. Tem que achar o minúsculo e maiúsculo.
wifi é so instalar o dkms e o broadcom-wl que esta no repositiorio pacman mesmo

## Drivers
bluetooth é instalar o bluez e bluez-utils

camera é bcwc e antes instalar o facetime-hdfirmware que vai pedir o linux-headers
so conferir antes os headers com 
$ uname -r

teclado é so colocar keycode = Num_Lock na tecla 56 do mapa padrao sendo usado
/usr/share/kdb/keymaps/i386/qwerty/us.map.gz
