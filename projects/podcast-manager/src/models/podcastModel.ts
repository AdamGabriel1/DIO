/**
 * Interfaces e tipagens do domínio Podcast
 */

export interface Episode {
  id: string;
  name: string;
  duration: number; // em segundos
  videoUrl: string;
  podcastId: string;
  createdAt: string;
}

export interface Podcast {
  id: string;
  name: string;
  description: string;
  category: string;
  episodes: Episode[];
  createdAt: string;
  updatedAt: string;
}

export interface CreatePodcastDTO {
  name: string;
  description: string;
  category: string;
  episodes?: Omit<Episode, 'id' | 'podcastId' | 'createdAt'>[];
}

export interface UpdatePodcastDTO {
  name?: string;
  description?: string;
  category?: string;
}

// Categorias permitidas
export const CATEGORIES = [
  'tecnologia',
  'educacao',
  'negocios',
  'entretenimento',
  'saude',
  'esportes',
  'outros'
] as const;

export type Category = typeof CATEGORIES[number];
