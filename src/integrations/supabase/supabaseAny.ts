// Helper to bypass type checking for tables not yet in the schema
// This allows database operations to work while the schema is being set up
import { supabase } from './client';

// Export supabase as any type to bypass strict table type checking
export const supabaseAny = supabase as any;
