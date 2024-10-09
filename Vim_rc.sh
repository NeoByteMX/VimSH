#!/bin/bash

# Instalar Vim
sudo apt-get update
sudo apt-get install vim -y

# Descargar Vim-Plug
mkdir -p ~/.vim/autoload
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Crear el archivo .vimrc
cat <<EOF > ~/.vimrc
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

" Tema
Plug 'morhetz/gruvbox'

call plug#end()

" Configurar el tema gruvbox
set background=dark
colorscheme gruvbox

EOF

echo "Vim, Vim-Plug y la configuración de .vimrc se han instalado y configurado."
