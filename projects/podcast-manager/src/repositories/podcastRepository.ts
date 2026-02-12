/**
 * Camada de acesso a dados
 * Persistência em arquivo JSON
 */

import fs from 'fs/promises';
import path from 'path';
import { Podcast, Episode, CreatePodcastDTO, UpdatePodcastDTO } from '../models/podcastModel.js';
import { generateId } from '../utils/httpHelpers.js';

const DATA_FILE = path.join(process.cwd(), 'src', 'data', 'podcasts.json');

// Garante que o arquivo existe
async function ensureFile(): Promise<void> {
  try {
    await fs.access(DATA_FILE);
  } catch {
    await fs.mkdir(path.dirname(DATA_FILE), { recursive: true });
    await fs.writeFile(DATA_FILE, JSON.stringify({ podcasts: [] }, null, 2));
  }
}

async function readData(): Promise<{ podcasts: Podcast[] }> {
  await ensureFile();
  const data = await fs.readFile(DATA_FILE, 'utf-8');
  return JSON.parse(data);
}

async function writeData(data: { podcasts: Podcast[] }): Promise<void> {
  await fs.writeFile(DATA_FILE, JSON.stringify(data, null, 2));
}

export const podcastRepository = {
  async findAll(): Promise<Podcast[]> {
    const data = await readData();
    return data.podcasts;
  },

  async findById(id: string): Promise<Podcast | null> {
    const data = await readData();
    return data.podcasts.find(p => p.id === id) || null;
  },

  async findByCategory(category: string): Promise<Podcast[]> {
    const data = await readData();
    return data.podcasts.filter(p => 
      p.category.toLowerCase() === category.toLowerCase()
    );
  },

  async create(dto: CreatePodcastDTO): Promise<Podcast> {
    const data = await readData();
    
    const newPodcast: Podcast = {
      id: generateId(),
      name: dto.name,
      description: dto.description,
      category: dto.category,
      episodes: (dto.episodes || []).map((ep, index) => ({
        ...ep,
        id: generateId(),
        podcastId: 'temp', // será atualizado
        createdAt: new Date().toISOString()
      })).map(ep => ({ ...ep, podcastId: 'temp' })),
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString()
    };

    // Atualiza podcastId dos episódios
    newPodcast.episodes = newPodcast.episodes.map(ep => ({
      ...ep,
      podcastId: newPodcast.id
    }));

    data.podcasts.push(newPodcast);
    await writeData(data);
    
    return newPodcast;
  },

  async update(id: string, dto: UpdatePodcastDTO): Promise<Podcast | null> {
    const data = await readData();
    const index = data.podcasts.findIndex(p => p.id === id);
    
    if (index === -1) return null;
    
    data.podcasts[index] = {
      ...data.podcasts[index],
      ...dto,
      updatedAt: new Date().toISOString()
    };
    
    await writeData(data);
    return data.podcasts[index];
  },

  async delete(id: string): Promise<boolean> {
    const data = await readData();
    const initialLength = data.podcasts.length;
    
    data.podcasts = data.podcasts.filter(p => p.id !== id);
    
    if (data.podcasts.length === initialLength) return false;
    
    await writeData(data);
    return true;
  },

  // Retorna todos os episódios (flat) com referência ao podcast
  async getAllEpisodes(): Promise<(Episode & { podcastName: string })[]> {
    const data = await readData();
    const episodes: (Episode & { podcastName: string })[] = [];
    
    data.podcasts.forEach(podcast => {
      podcast.episodes.forEach(ep => {
        episodes.push({
          ...ep,
          podcastName: podcast.name
        });
      });
    });
    
    return episodes;
  }
};
