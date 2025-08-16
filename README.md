# rebel-bots
Pojeto de desenvolvimeto de jogo educacional em 2D com o intuito de contruibuir com a comunidade reginal de Joinville/SC

Ferramentas:
Godot engine v4.41
IDE nativa Godot

Assets:
https://opengameart.org/
https://www.kenney.nl/assets
https://www.piskelapp.com/p/create/sprite/
https://inkscape.org/gallery/item/56342/inkscape-1.4.2_2025-05-13_f4327f4-x64.7z
https://download.kde.org/stable/krita/5.2.11/krita-x64-5.2.11.zip

Desenvolvimento: 
  Todo desenvolvimento vai para branch master.
  Quando for criar ou ajustar uma nova feature, criar uma branch baseada na branch master, com o nome da feature desenvolvida
  Ao terminar desenvolvimento da nova feature, abrir pull request ou avisar a mim(LUIS FERNANDO) que a feature está pronta
  
  Todo o código do projeto será feito em português
  
#LEMBRETES!!!
  Não esqueça de fazer fetch+merge na sua branch periodicamente 
  Atualizar seu projeto antes de criar pull request

Estrutura de diretórios é baseada neste formato

CLICAR EM VISUALIZAR RAW PARA VER MELHOR ARVORE DE ARQUIVOS

IDEALMENTE:
    salvar projeto em C://users/seu usuario/workspace (criar arquivo workspace)    

res://app
├── assets/                # Todos os recursos brutos (imagens, sons, fontes, etc.)
│   ├── audio/
│   ├── fonts/
│   ├── graphics/
│   │   ├── characters/
│   │   ├── environment/
│   │   └── ui/
│   └── video/
│
├── scenes/                # Cenas do jogo
│   ├── main/              # Cena principal (menu, etc.)
│   ├── levels/            # Fases/mapas do jogo
│   ├── player/            # Cena do jogador
│   ├── enemies/           # Inimigos
│   └── ui/                # Interface (HUD, menus, etc.)
│
├── scripts/               # Scripts GDScript ou C#
│   ├── player/
│   ├── enemies/
│   ├── ui/
│   └── utils/
│
├── prefabs/               # "Cenas prontas" reutilizáveis (ex: botões, power-ups)
│
├── autoload/              # Scripts autoload/singletons (GameManager, AudioManager, etc.)
│
├── data/                  # Dados do jogo (configurações, save files, tabelas)
│
├── addons/                # Plugins ou addons externos
│
├── icon.png               # Ícone do projeto
├── project.godot          # Arquivo de configuração do projeto
└── README.md              # (opcional) Documentação do projeto
