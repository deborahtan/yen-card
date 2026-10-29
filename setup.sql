-- Run this once in Supabase: SQL Editor -> New query -> paste -> Run.

create table if not exists public.messages (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  name text not null check (char_length(name) between 1 and 60),
  message text not null check (char_length(message) between 1 and 600)
);

alter table public.messages enable row level security;

-- Anyone can read the card.
create policy "Anyone can read messages"
  on public.messages for select
  to anon
  using (true);

-- Anyone can sign the card.
create policy "Anyone can add a message"
  on public.messages for insert
  to anon
  with check (true);

-- No update or delete policies: visitors can't edit or remove notes.
-- You can still delete rows yourself in Table Editor -> messages.

insert into public.messages (created_at, name, message) values
  (now() - interval '6 minutes', 'Debbie', 'Yen, it''s been such a pleasure working alongside you. I''m really going to miss having you on the team — your willingness to dive into anything and learn, and the positivity you bring every day, made such a difference. Wishing you all the very best for what''s next 💛'),
  (now() - interval '5 minutes', 'James', 'Yen – it''s been an absolute pleasure having you in the team. Your constant curiosity and willingness to jump in and work on things that are out of your comfort zone are a real gift, so don''t stop! I''m sure whatever your next adventure, you''ll smash it out of the park! Wishing you all the best'),
  (now() - interval '4 minutes', 'Leo', 'Sad to see you go! While we didn''t get the chance to work together too much, I really enjoyed getting to know you throughout the years. Wishing you all the very best for what''s next, and I''m sure our paths will cross again in this small industry 😊'),
  (now() - interval '3 minutes', 'Mary', 'Yen! Good time having you around in the office. All the very best in whatever comes next xx'),
  (now() - interval '2 minutes', 'Karissa', 'Hey Yen, all the best on your next adventure! Thank you for always saying hi whenever we bump into each other. Take care'),
  (now() - interval '1 minute', 'Avi', 'All the best for the future Yen, it was lovely getting to work with you, xx');
