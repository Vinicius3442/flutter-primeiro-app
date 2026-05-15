# SENN Connect - MVP Social Network

SENN Connect is a modern social network MVP developed for **SENN.AI**. It utilizes Flutter for the frontend and Supabase for authentication and database management.

## 👥 Equipe
- **Vinicius Montuani**
- **Pietro Rennó**

## 🚀 Tecnologias Utilizadas
- **Flutter**: Framework para desenvolvimento mobile.
- **Supabase**: Backend-as-a-Service (Auth & DB).
- **Provider**: Gerenciamento de estado.
- **Google Fonts**: Tipografia moderna.
- **Flutter Animate**: Animações fluidas.

## 🛠️ Instruções de Instalação

1.  **Clone o repositório:**
    ```bash
    git clone [URL_DO_REPOSITORIO]
    ```
2.  **Instale as dependências:**
    ```bash
    flutter pub get
    ```
3.  **Configuração do Supabase:**
    - Os dados de conexão estão no arquivo `.env`.
    - Execute o script `database.sql` no SQL Editor do seu dashboard Supabase para criar as tabelas necessárias.
4.  **Execute o aplicativo:**
    ```bash
    flutter run
    ```

## 🔐 Acesso para Professores (Credenciais de Teste)
Para validar o acesso, utilize as seguintes credenciais:

- **E-mail:** `professor@senn.ai`
- **Senha:** `SennAI#2026`

## 🎨 Identidade Visual
- **Cores:** Azul Escuro (`#0D47A1`) e Branco.
- **Logo:** Localizada em `/assets/logo.png`.

## 📂 Arquitetura
O projeto segue uma estrutura organizada:
- `lib/screens`: Interfaces de usuário.
- `lib/providers`: Lógica de estado.
- `lib/services`: Integrações externas.
- `lib/models`: Estruturas de dados.
