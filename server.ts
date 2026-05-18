import express from "express";
import dotenv from "dotenv";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

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

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Servidor API rodando em http://0.0.0.0:${PORT}`);
});

export default app;
