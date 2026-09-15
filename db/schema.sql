-- Rode este script no Supabase: painel do projeto > SQL Editor > New query > Run.

-- Tabela única que guarda todos os dados do painel (pedidos, clientes, produtos,
-- despesas e dados da empresa) em uma única linha, no formato jsonb.
create table if not exists app_data (
  id int primary key default 1,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- Garante que sempre exista a linha única (id = 1) que o app vai ler/atualizar.
insert into app_data (id, data)
values (1, '{}'::jsonb)
on conflict (id) do nothing;

-- Liga a segurança por linha (RLS): sem isso, com a chave pública (anon) qualquer
-- pessoa poderia ler ou alterar os dados. Com RLS, só usuários logados (autenticados
-- no Supabase Auth) conseguem acessar.
alter table app_data enable row level security;

drop policy if exists "Usuários autenticados podem ler" on app_data;
create policy "Usuários autenticados podem ler"
  on app_data for select
  to authenticated
  using (true);

drop policy if exists "Usuários autenticados podem atualizar" on app_data;
create policy "Usuários autenticados podem atualizar"
  on app_data for update
  to authenticated
  using (true)
  with check (true);

drop policy if exists "Usuários autenticados podem inserir" on app_data;
create policy "Usuários autenticados podem inserir"
  on app_data for insert
  to authenticated
  with check (true);

-- Depois de rodar este script, crie o seu usuário de acesso em:
-- Painel do Supabase > Authentication > Users > Add user (email + senha).
-- É com esse e-mail/senha que você vai logar no painel.
