# REI DAS TAREFAS

**REI DAS TAREFAS** é um aplicativo de gerenciamento de tarefas desenvolvido em SwiftUI para iOS. Ele permite organizar, priorizar e acompanhar o progresso das tarefas do dia a dia de forma simples e moderna.


🎥 Assista ao vídeo demonstração do app no YouTube


[![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/shorts/JRRWfLoxB0g)

---

## 📸 Capturas de Tela

| 🌓 Modo Claro | 🌑 Modo Escuro |
|--------------|---------------|
| <img src="REI%20DAS%20TAREFAS/Screenshots/Claro.png" width="300" alt="Modo Claro" /> | <img src="REI%20DAS%20TAREFAS/Screenshots/Escuro.png" width="300" alt="Modo Escuro" /> |

---

## 🏗 Arquitetura

O projeto utiliza a arquitetura **MVVM (Model - View - ViewModel)** para uma separação clara das responsabilidades:

- **Model**: Representa os dados (`Task`, `TaskPriority`)
- **View**: Interface construída com SwiftUI
- **ViewModel**: Camada de lógica e controle (`TaskViewModel`)

---

## ✨ Funcionalidades

- ✅ **Adicionar tarefas com:**
  - Título
  - Descrição
  - Prioridade (Alta 🔴, Média 🟡, Baixa 🔵)
  - Data
- 📆 **Visualizar tarefas por data** com mini calendário
- 🎯 **Acompanhar progresso** com slider
- ✅ **Marcar tarefas como concluídas**
- ✏️ **Editar e excluir tarefas** com swipe
- ➕ **Animação no botão de adicionar tarefa**
- 🎨 **UI refinada com cores por prioridade**
- 🗂 **Lista de tarefas agrupada por data**

---

## 📂 Estrutura do Projeto

```
REI DAS TAREFAS/
├── Models/
│   └── Task.swift
├── ViewModels/
│   └── TaskViewModel.swift
├── Views/
│   ├── TaskListView.swift
│   ├── AddTaskView.swift
│   ├── EditTaskView.swift
│   └── TaskCardView.swift
├── Resources/
│   └── Assets.xcassets
└── REI DAS TAREFAS.xcodeproj

```

---

## 🛠 Tecnologias

- SwiftUI  
- Swift 5.9  
- Xcode 15  
- iOS 18 SDK  

---

## 🧩 Requisitos

- macOS com Xcode 15 ou superior instalado
- Simulador ou dispositivo rodando **iOS 18**
- Swift 5.9 configurado no ambiente do Xcode

---

## ▶️ Como Rodar o Projeto

1. Clone o repositório:

   ```bash
   git clone https://github.com/Marcelo1802/REI-DAS-TAREFAS.git
   ```

2. Abra o projeto no Xcode:

   ```bash
   open "REI DAS TAREFAS/REI DAS TAREFAS.xcodeproj"
   ```

3. Selecione um simulador com iOS 18 e clique em **Run (⌘R)**.

---

## 📌 Melhorias futuras

- As tarefas são armazenadas apenas em memória (não persistem ao fechar o app).
- O app pode ser facilmente estendido para usar **Core Data** ou **Firebase**.



---

## 🧑‍💻 Autor

**Marcelo José Guimarães Júnior**  

