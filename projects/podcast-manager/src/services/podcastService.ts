/**
 * Camada de regras de negócio
 */

import { Podcast, CreatePodcastDTO, UpdatePodcastDTO, Episode } from '../models/podcastModel.js';
import { podcastRepository } from '../repositories/podcastRepository.js';

export const podcastService = {
  async getAllPodcasts(): Promise<Podcast[]> {
    return await podcastRepository.findAll();
  },

  async getPodcastById(id: string): Promise<Podcast | null> {
    return await podcastRepository.findById(id);
  },

  async createPodcast(dto: CreatePodcastDTO): Promise<{ success: boolean; data?: Podcast; error?: string }> {
    // Validações de negócio
    if (!dto.name || dto.name.length < 3) {
      return { success: false, error: 'Nome deve ter pelo menos 3 caracteres' };
    }

    if (!dto.description || dto.description.length < 10) {
      return { success: false, error: 'Descrição deve ter pelo menos 10 caracteres' };
    }

    if (!dto.category) {
      return { success: false, error: 'Categoria é obrigatória' };
    }

    const podcast = await podcastRepository.create(dto);
    return { success: true, data: podcast };
  },

  async updatePodcast(id: string, dto: UpdatePodcastDTO): Promise<{ success: boolean; data?: Podcast; error?: string }> {
    const existing = await podcastRepository.findById(id);
    if (!existing) {
      return { success: false, error: 'Podcast não encontrado' };
    }

    const podcast = await podcastRepository.update(id, dto);
    return { success: true, data: podcast! };
  },

  async deletePodcast(id: string): Promise<{ success: boolean; error?: string }> {
    const deleted = await podcastRepository.delete(id);
    if (!deleted) {
      return { success: false, error: 'Podcast não encontrado' };
    }
    return { success: true };
  },

  async getEpisodesByCategory(category?: string): Promise<{
    episodes: (Episode & { podcastName: string })[];
    meta: {
      total: number;
      category?: string;
      totalDuration: number;
    }
  }> {
    let episodes = await podcastRepository.getAllEpisodes();
    
    if (category) {
      // Filtra por categoria do podcast pai
      const podcasts = await podcastRepository.findByCategory(category);
      const podcastIds = podcasts.map(p => p.id);
      episodes = episodes.filter(ep => podcastIds.includes(ep.podcastId));
    }

    const totalDuration = episodes.reduce((sum, ep) => sum + ep.duration, 0);

    return {
      episodes,
      meta: {
        total: episodes.length,
        category,
        totalDuration
      }
    };
  }
};
