import express from "express";
import path from "path";
import { createServer as createViteServer } from "vite";
import dotenv from "dotenv";

dotenv.config();

async function startServer() {
  const app = express();
  const PORT = 3000;

  // Middleware para JSON
  app.use(express.json());

  // Proxy para Football-Data.org
  app.get("/api/football/*", async (req, res) => {
    try {
      const endpoint = req.params[0];
      const apiKey = process.env.FOOTBALL_DATA_API_KEY;
      
      if (!apiKey) {
        return res.status(500).json({ error: "API Key (FOOTBALL_DATA_API_KEY) não configurada" });
      }

      const url = `https://api.football-data.org/v4/${endpoint}`;

      console.log(`Proxying to: ${url}`);

      const response = await fetch(url, {
        headers: {
          "X-Auth-Token": apiKey
        }
      });

      const data = await response.json();
      res.status(response.status).json(data);
    } catch (error) {
      console.error("Proxy Error:", error);
      res.status(500).json({ error: "Erro ao buscar dados da API" });
    }
  });

  // Vite middleware for development
  if (process.env.NODE_ENV !== "production") {
    const vite = await createViteServer({
      server: { middlewareMode: true },
      appType: "spa",
    });
    app.use(vite.middlewares);
  } else {
    const distPath = path.join(process.cwd(), 'dist');
    app.use(express.static(distPath));
    app.get('*', (req, res) => {
      res.sendFile(path.join(distPath, 'index.html'));
    });
  }

  app.listen(PORT, "0.0.0.0", () => {
    console.log(`Servidor rodando em http://localhost:${PORT}`);
  });
}

startServer();
