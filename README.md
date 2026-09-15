# Gestão de Produção - Gráfica (Dashboard)

Projeto React + Vite + Tailwind CSS, com os dados guardados no Supabase
(banco de dados na nuvem, acessível de qualquer aparelho, não só do navegador
onde você usou o app).

## 1. Criar o banco de dados no Supabase (grátis)

1. Crie uma conta em https://supabase.com e crie um novo projeto (escolha uma senha
   forte para o banco — guarde ela, mas ela não é a mesma senha do seu login no app).
2. No painel do projeto, vá em **SQL Editor > New query**, cole o conteúdo do
   arquivo `db/schema.sql` (que está nesta pasta) e clique em **Run**. Isso cria a
   tabela onde os dados do painel ficam guardados, já protegida (só quem estiver
   logado consegue ler/alterar).
3. Vá em **Authentication > Users > Add user** e crie o seu usuário (e-mail e senha).
   É com esse e-mail e senha que você vai entrar no painel — ninguém mais consegue
   criar conta, porque não existe tela de cadastro público.
4. Vá em **Project Settings > API** e copie dois valores: **Project URL** e a chave
   **anon public**.

## 2. Configurar o projeto com esses dados

Copie o arquivo `.env.example` para um novo arquivo chamado `.env` e cole os
valores que você copiou:

```
VITE_SUPABASE_URL=https://SEU-PROJETO.supabase.co
VITE_SUPABASE_ANON_KEY=SUA-CHAVE-ANON-PUBLICA
```

O arquivo `.env` nunca deve ser compartilhado publicamente nem subido para o
GitHub (ele já está no `.gitignore`).

## 3. Rodar localmente

```bash
npm install
npm run dev
```

Abra o endereço mostrado no terminal (geralmente `http://localhost:5173`) e
entre com o e-mail/senha que você criou no passo 1.3.

## 4. Hospedar o site

Depois de testar localmente, para colocar no ar (ex: Vercel, Netlify ou
Cloudflare Pages — todos têm plano grátis):

1. Suba este projeto para um repositório no GitHub.
2. Na plataforma escolhida, importe o repositório.
3. Configure o **build command** `npm run build` e a **pasta de saída** `dist`.
4. Nas configurações de **variáveis de ambiente** do projeto na plataforma,
   adicione `VITE_SUPABASE_URL` e `VITE_SUPABASE_ANON_KEY` com os mesmos valores
   do seu `.env` (o `.env` não vai junto no GitHub, então isso é obrigatório).
5. Publique. O site vai pedir login e, a partir daí, todos os dados ficam
   salvos no Supabase — você pode acessar o painel do celular, do computador
   do trabalho, de onde for, sempre com os mesmos dados.

## Estrutura

- `src/App.jsx` — componente principal do dashboard (todo o app)
- `src/supabaseClient.js` — conexão com o Supabase
- `src/main.jsx` — ponto de entrada do React
- `src/index.css` — diretivas do Tailwind CSS
- `db/schema.sql` — script para criar a tabela e as permissões no Supabase
- `tailwind.config.js` / `postcss.config.js` — configuração do Tailwind
- `vite.config.js` — configuração do Vite

## Dependências principais

- `react` / `react-dom`
- `@supabase/supabase-js` (banco de dados e login)
- `recharts` (gráficos)
- `lucide-react` (ícones)
- `tailwindcss` (estilos)
