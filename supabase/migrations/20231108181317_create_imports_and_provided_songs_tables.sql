create type public.library_provider AS ENUM('iTunes');

create table
  public.songs (
    id uuid not null default gen_random_uuid (),
    created_at timestamp with time zone not null default now(),
    updated_at timestamp with time zone null default now(),
    title text not null,
    constraint songs_pkey primary key (id)
  ) tablespace pg_default;

create table
  public.imports (
    id uuid not null default gen_random_uuid (),
    created_at timestamp with time zone not null default now(),
    updated_at timestamp with time zone null default now(),
    snapshot_at timestamp with time zone not null,
    provided_by public.library_provider not null,
    constraint imports_pkey primary key (id)
  ) tablespace pg_default;

create table
  public.provided_songs (
    id uuid not null default gen_random_uuid (),
    created_at timestamp with time zone not null default now(),
    updated_at timestamp with time zone null default now(),
    title character varying not null,
    provider public.library_provider not null,
    external_id text not null,
    tags text[] null,
    song_id uuid null,
    artist text not null,
    album_artist text null,
    album text null,
    duration numeric not null,
    disc numeric null,
    track numeric null,
    added_at timestamp with time zone not null,
    modified_at timestamp with time zone not null,
    released_at date null,
    play_count numeric null,
    rating numeric null,
    composer text null,
    import_id uuid null,
    constraint provided_songs_pkey primary key (id),
    constraint provided_songs_external_id_key unique (external_id),
    constraint provided_songs_import_id_fkey foreign key (import_id) references imports (id) on update cascade on delete set null,
    constraint provided_songs_song_id_fkey foreign key (song_id) references songs (id) on update cascade on delete set null
  ) tablespace pg_default;