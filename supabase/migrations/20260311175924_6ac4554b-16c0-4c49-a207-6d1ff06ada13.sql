
-- Profiles table
CREATE TABLE public.profiles (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  age_range text,
  skin_type text,
  skin_concerns text[],
  heritage text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view own profile" ON public.profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can insert own profile" ON public.profiles FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON public.profiles FOR UPDATE USING (auth.uid() = id);

-- Brands table
CREATE TABLE public.brands (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  logo_url text,
  website_url text,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE public.brands ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Brands are publicly readable" ON public.brands FOR SELECT TO authenticated USING (true);

-- Foundation products table
CREATE TABLE public.foundation_products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  brand_id uuid REFERENCES public.brands(id) ON DELETE CASCADE,
  name text NOT NULL,
  coverage text DEFAULT 'medium',
  finish text DEFAULT 'natural',
  price numeric DEFAULT 0,
  product_url text,
  image_url text,
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE public.foundation_products ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Products are publicly readable" ON public.foundation_products FOR SELECT TO authenticated USING (true);

-- Foundation shades table
CREATE TABLE public.foundation_shades (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id uuid REFERENCES public.foundation_products(id) ON DELETE CASCADE,
  shade_name text NOT NULL,
  hex_color text,
  undertone text,
  depth_level integer,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE public.foundation_shades ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Shades are publicly readable" ON public.foundation_shades FOR SELECT TO authenticated USING (true);

-- Scan sessions table
CREATE TABLE public.scan_sessions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  calibration_completed boolean DEFAULT false,
  calibration_data jsonb,
  photo_urls text[],
  analysis_complete boolean DEFAULT false,
  analysis_data jsonb,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE public.scan_sessions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view own sessions" ON public.scan_sessions FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own sessions" ON public.scan_sessions FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own sessions" ON public.scan_sessions FOR UPDATE USING (auth.uid() = user_id);

-- Face regions table
CREATE TABLE public.face_regions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id uuid REFERENCES public.scan_sessions(id) ON DELETE CASCADE,
  region_name text,
  avg_rgb_values jsonb,
  hex_color text,
  undertone text,
  depth_level integer,
  confidence_score numeric,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE public.face_regions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view own face regions" ON public.face_regions FOR SELECT USING (
  EXISTS (SELECT 1 FROM public.scan_sessions WHERE scan_sessions.id = face_regions.session_id AND scan_sessions.user_id = auth.uid())
);
CREATE POLICY "Users can insert own face regions" ON public.face_regions FOR INSERT WITH CHECK (
  EXISTS (SELECT 1 FROM public.scan_sessions WHERE scan_sessions.id = face_regions.session_id AND scan_sessions.user_id = auth.uid())
);

-- Foundation matches table
CREATE TABLE public.foundation_matches (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id uuid REFERENCES public.scan_sessions(id) ON DELETE CASCADE,
  product_id text,
  shade_id text,
  match_type text,
  confidence_score numeric,
  delta_e_value numeric,
  purchase_url text,
  price numeric,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE public.foundation_matches ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view own matches" ON public.foundation_matches FOR SELECT USING (
  EXISTS (SELECT 1 FROM public.scan_sessions WHERE scan_sessions.id = foundation_matches.session_id AND scan_sessions.user_id = auth.uid())
);
CREATE POLICY "Users can insert own matches" ON public.foundation_matches FOR INSERT WITH CHECK (
  EXISTS (SELECT 1 FROM public.scan_sessions WHERE scan_sessions.id = foundation_matches.session_id AND scan_sessions.user_id = auth.uid())
);
