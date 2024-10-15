#!/bin/bash

# Salir inmediatamente si un comando falla
set -e

# Función para mostrar mensajes informativos
function info {
    echo -e "\e[32m[INFO]\e[0m $1"
}

# Verificar si el script se está ejecutando con permisos de sudo
if [ "$EUID" -eq 0 ]; then
    echo "Este script NO debe ser ejecutado con sudo. Ejecútalo como un usuario normal."
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

# Verificar e instalar fzf si no está instalado
if ! command -v fzf &> /dev/null
then
    info "Instalando fzf..."
    sudo apt-get install fzf -y
else
    info "fzf ya está instalado."
fi

# Instalar Node.js (necesario para coc.nvim)
if ! command -v node &> /dev/null
then
    info "Instalando Node.js..."
    # Usar NodeSource para instalar Node.js 18.x
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    info "Node.js ya está instalado."
fi

# Verificar e instalar pip si no está instalado
if ! command -v pip3 &> /dev/null
then
    info "Instalando pip3..."
    sudo apt-get install python3-pip -y
else
    info "pip3 ya está instalado."
fi

# Actualizar pip a la última versión
info "Actualizando pip..."
pip3 install --upgrade pip --user

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
" --- Inicio de la configuración de Vim ---

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

" Plugins Básicos
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'

" --- Plugins para Desarrollo en Python ---

" Autocompletado y Soporte de Lenguaje
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'davidhalter/jedi-vim'  " Alternativa ligera para autocompletado

" Linting y Formateo
Plug 'dense-analysis/ale'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Navegación y Exploración
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Integración con Git
Plug 'tpope/vim-fugitive'

" Depuración
Plug 'puremourning/vimspector'

" Manejo de Entornos Virtuales
Plug 'jmcantrell/vim-virtualenv'

call plug#end()

" Configurar el tema gruvbox
set background=dark
colorscheme gruvbox

" Remap de navegación para teclado Dvorak
" remuve las comillas de noremap
" QWERTY h,j,k,l → Dvorak d,h,t,n
"nnoremap d h
"nnoremap h j
"nnoremap t k
"nnoremap n l

" Opcional: Remap en modo visual para Dvorak
"vnoremap d h
"vnoremap h j
"vnoremap t k
"vnoremap n l

" --- Configuraciones Adicionales de Plugins ---

" Configuración de coc.nvim
" Usa <Tab> y <S-Tab> para navegar por las opciones de completado
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Mapear la tecla Enter para aceptar la selección de completado
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

" Mapeos para comandos de coc.nvim
nnoremap <silent> <leader>rn :CocRename<CR>
nnoremap <silent> <leader>ca :CocCodeAction<CR>

" Configuración de ALE
let g:ale_linters = {
\   'python': ['flake8', 'mypy'],
\}

let g:ale_fixers = {
\   'python': ['black', 'autopep8'],
\}

let g:ale_python_flake8_executable = 'flake8'
let g:ale_python_black_executable = 'black'

" Habilitar la corrección automática al guardar
let g:ale_fix_on_save = 1

" Configuración de UltiSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

" Habilitar el uso de snippets en modo inserción
imap <silent><expr> <Tab> UltiSnips#CanExpandSnippet() ? '<C-R>=UltiSnips#ExpandSnippet()<CR>' : '<Tab>'

" Mapeos rápidos para fzf.vim
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-f> :Rg<CR>

" Configuración básica de Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

" Configuración de vim-virtualenv
nmap <leader>ev :VenvActivate<CR>
nmap <leader>ed :VenvDeactivate<CR>

" --- Fin de la configuración ---
EOF

# Instalar los plugins de Vim-Plug
info "Instalando plugins de Vim-Plug..."
vim +PlugInstall +qall

# Instalar la extensión coc-pyright para Python
info "Instalando extensión coc-pyright para coc.nvim..."
vim +CocInstall\ coc-pyright +qall

# Instalar paquetes de Python necesarios para ALE y Vimspector
info "Instalando paquetes de Python necesarios..."
pip3 install --user flake8 black mypy autopep8 debugpy

# Informar al usuario sobre pasos adicionales
info "Instalación y configuración completadas exitosamente."

echo -e "\e[34m==============================================\e[0m"
echo -e "\e[34m|           Configuración de Vim Finalizada   |"
echo -e "\e[34m==============================================\e[0m"
echo "Para aplicar los cambios, reinicia Vim."
echo "A continuación, puedes probar tu configuración con un archivo de ejemplo."
echo "Ejecuta el siguiente comando para crear un archivo de prueba:"
echo "    echo 'print(\"Hola, Mundo!\")' > ~/ejemplo.py"
echo "Luego, abre Vim con el archivo de prueba:"
echo "    vim ~/ejemplo.py"
