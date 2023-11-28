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

" Autoindentación al presionar Enter en modo insertar
inoremap <CR> <CR>:autoindent<CR>

" Mapear la tecla F5 para ejecutar el script de Python en la ventana actual
nnoremap <F5> :!python3 %<CR>
inoremap <F5> <Esc>:!python3 %<CR>a

" Atajos de teclado para abrir/cerrar el explorador de archivos NERDTree
nnoremap <F3> :NERDTreeToggle<CR>
inoremap <F3> <Esc>:NERDTreeToggle<CR>i

" Configuración de complementos con Vim-Plug
call plug#begin('~/.vim/plugged')

" Tema
Plug 'morhetz/gruvbox'

" Complementos para Python
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'ervandew/supertab'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary', {'for': ['sh', 'python', 'markdown']}
Plug 'ironcamel/vim-script-runner', {'for': ['sh', 'python']}
Plug 'SirVer/ultisnips', {'for': ['sh', 'python', 'markdown']}
Plug 'honza/vim-snippets', {'for': ['sh', 'python', 'markdown']}
Plug 'vim-syntastic/syntastic', {'for': 'python'}

call plug#end()

" Configurar el tema gruvbox
set background=dark
colorscheme gruvbox
EOF

echo "Vim, Vim-Plug y la configuración de .vimrc se han instalado y configurado."
