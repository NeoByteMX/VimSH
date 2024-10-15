#!/bin/bash

# Salir inmediatamente si un comando falla
set -e

# Función para mostrar mensajes informativos
function info {
    echo -e "\e[32m[INFO]\e[0m $1"
}

# Verificar si el script se está ejecutando con permisos de sudo
if [ "$EUID" -eq 0 ]; then
    echo "Este script no debe ser ejecutado con sudo. Ejecútalo como un usuario normal."
    exit 1
fi

# Actualizar la lista de paquetes
info "Actualizando la lista de paquetes..."
sudo apt-get update

# Instalar Vim si no está instalado
if ! command -v vim &> /dev/null
then
    info "Instalando Vim..."
    sudo apt-get install vim -y
else
    info "Vim ya está instalado."
fi

# Verificar e instalar curl si no está instalado
if ! command -v curl &> /dev/null
then
    info "Instalando curl..."
    sudo apt-get install curl -y
else
    info "curl ya está instalado."
fi

# Descargar Vim-Plug
info "Descargando Vim-Plug..."
mkdir -p "$HOME/.vim/autoload"
curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Hacer una copia de seguridad del .vimrc existente si existe
if [ -f "$HOME/.vimrc" ]; then
    info "Creando copia de seguridad de .vimrc existente..."
    cp "$HOME/.vimrc" "$HOME/.vimrc.backup_$(date +%F)"
fi

# Crear el archivo .vimrc
info "Creando archivo .vimrc..."
cat <<EOF > "$HOME/.vimrc"
" Habilitar la numeración de líneas
set number

" Establecer el ancho de tabulación y el tipo de tabulación
set tabstop=2
set shiftwidth=2
set expandtab

" Habilitar el resaltado de sintaxis
syntax enable

" Mostrar números de línea relativa
set relativenumber

" Mostrar el número de columna y fila actual en la esquina inferior derecha
set ruler

" Mostrar el estado de encuadre
set showmatch

" Atajos de teclado para abrir/cerrar el explorador de archivos NERDTree
nnoremap <F3> :NERDTreeToggle<CR>
inoremap <F3> <Esc>:NERDTreeToggle<CR>i

" Configuración de complementos con Vim-Plug
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
call plug#end()

" Configurar el tema gruvbox
set background=dark
colorscheme gruvbox

" Remap de navegación para teclado Dvorak
" QWERTY h,j,k,l → Dvorak d,h,t,n
nnoremap d h
nnoremap h j
nnoremap t k
nnoremap n l

" Opcional: Remap en modo visual para Dvorak
vnoremap d h
vnoremap h j
vnoremap t k
vnoremap n l

EOF

# Instalar los plugins de Vim-Plug
info "Instalando plugins de Vim-Plug..."
vim +PlugInstall +qall

info "Vim, Vim-Plug y la configuración de .vimrc se han instalado y configurado correctamente."
