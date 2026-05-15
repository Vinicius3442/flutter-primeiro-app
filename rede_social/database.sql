-- Desenvolvido por: Vinicius Montuani e Pietro Rennó

-- 1. Tabela de Perfis (Vinculada ao Auth do Supabase)
CREATE TABLE profiles (
  id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
  username TEXT UNIQUE,
  bio TEXT,
  avatar_url TEXT,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Tabela de Postagens
CREATE TABLE posts (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  content TEXT NOT NULL,
  likes_count INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Tabela de Curtidas (Para evitar curtidas duplicadas)
CREATE TABLE likes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  post_id UUID REFERENCES posts(id) ON DELETE CASCADE NOT NULL,
  UNIQUE(user_id, post_id)
);

-- 4. Tabela de Mensagens (Chat)
CREATE TABLE messages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  sender_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  receiver_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Configuração de RLS (Row Level Security) - Básico
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE likes ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;

-- Políticas de acesso
CREATE POLICY "Perfis públicos são visíveis por todos" ON profiles FOR SELECT USING (true);
CREATE POLICY "Usuários podem editar seus próprios perfis" ON profiles FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Posts são visíveis por todos" ON posts FOR SELECT USING (true);
CREATE POLICY "Usuários podem criar seus próprios posts" ON posts FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Qualquer um pode ver curtidas" ON likes FOR SELECT USING (true);
CREATE POLICY "Usuários podem curtir posts" ON likes FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Usuários podem ver suas próprias mensagens" ON messages FOR SELECT USING (auth.uid() = sender_id OR auth.uid() = receiver_id);
CREATE POLICY "Usuários podem enviar mensagens" ON messages FOR INSERT WITH CHECK (auth.uid() = sender_id);
