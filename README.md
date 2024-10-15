# Configuración Automática de Vim para Desarrollo en Python3 con Soporte para Teclado Dvorak

Este script automatiza la instalación y configuración de **Vim** con una serie de plugins esenciales para el desarrollo en **Python3**, optimizando el entorno de desarrollo para usuarios de teclado **Dvorak**. Incluye la instalación de **Vim-Plug**, configuración de plugins para autocompletado, linting, formateo, snippets, navegación, integración con Git, depuración y manejo de entornos virtuales.

## Tabla de Contenidos

- [Características](#características)
- [Prerequisitos](#prerequisitos)
- [Instalación](#instalación)
- [Uso](#uso)
- [Verificación](#verificación)
- [Configuraciones Adicionales](#configuraciones-adicionales)
- [Solución de Problemas](#solución-de-problemas)
- [Contribuciones](#contribuciones)
- [Licencia](#licencia)

## Características

- **Instalación de Vim y Dependencias:** Automatiza la instalación de Vim, `curl`, `fzf`, Node.js, y `pip3`.
- **Gestión de Plugins con Vim-Plug:** Descarga e instala Vim-Plug para gestionar plugins de manera eficiente.
- **Plugins Esenciales para Python3:**
  - **Autocompletado y Soporte de Lenguaje:** `coc.nvim`
  - **Linting y Formateo:** `ALE` con `flake8`, `black`, `mypy`, y `autopep8`
  - **Snippets:** `UltiSnips` y `vim-snippets`
  - **Navegación y Exploración:** `fzf.vim`
  - **Integración con Git:** `vim-fugitive`
  - **Depuración:** `Vimspector`
  - **Manejo de Entornos Virtuales:** `vim-virtualenv`
- **Configuraciones Personalizadas:**
  - **Remapeo de Navegación para Teclado Dvorak**
  - **Configuraciones específicas para cada plugin**
- **Instalación de Extensiones y Paquetes de Python:** `coc-pyright`, `debugpy`, y paquetes necesarios para `ALE`.

## Prerequisitos

Antes de ejecutar el script, asegúrate de tener lo siguiente:

- **Sistema Operativo:** Basado en Debian/Ubuntu (ajustar si usas otra distribución).
- **Acceso a Internet:** Para descargar paquetes y plugins.
- **Permisos de Sudo:** Para instalar paquetes del sistema.
- **Python3 y pip3:** Instalados en el sistema.

## Instalación

1. **Clonar o Descargar el Script:**

   Puedes clonar este repositorio o simplemente descargar el script `setup_vim_python.sh`.

   ```bash
   git clone https://github.com/NeoByteMX/VimSH
   cd VimSH
