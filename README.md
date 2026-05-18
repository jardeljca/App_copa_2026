# App Copa 2026

App móvel para acompanhar a Copa do Mundo 2026. Concebido como um cliente nativo Flutter apoiado por um backend leve em Node.js, o projeto centraliza informações de competições, partidas, classificação e chaves do torneio.

**Visão**

Prover uma experiência móvel fluida e focada em fãs de futebol: dados em tempo real, navegação simples pelas fases do torneio e apresentação clara de resultados e estatísticas.

**Objetivos do projeto**

- Fornecer um cliente móvel nativo com UX otimizada para partidas e tabelas.
- Manter a lógica de integração com APIs e regras de negócio no backend, garantindo segurança e flexibilidade.
- Facilitar futuras integrações (notificações, analytics, monetização).

**Principais funcionalidades**

- Visualização de partidas por fase e por dia
- Chaveamento (bracket) com avanço de equipes
- Tabelas de classificação por grupo
- Página de detalhes da partida (elenco, placar, estatísticas básicas)
- Cache local e imagens otimizadas para melhor performance

**Arquitetura resumida**

- Aplicativo: Flutter (Dart) — interface, gestão de estado e persistência local.
- Backend: Node.js + Express — proxy para APIs externas, agregação de dados e camada de segurança.
- API externa (fonte de verdade): Football-Data.org (ou provedores equivalentes).

**Stack tecnológico**

- Flutter / Dart
- Provider (ou outro gerenciador de estado dependendo da evolução)
- Node.js / Express
- Integração com serviços de terceiros via API REST

**Status**

Projeto em desenvolvimento; estrutura inicial do app Flutter e backend implementados. Trabalho em andamento para consolidar modelos de dados e rotas protegidas.

**Licença & contribuições**

Repositório aberto para contribuições. Consulte os arquivos de configuração e políticas do projeto para detalhes sobre a licença e normas de contribuição.


## Run Locally

**Prerequisites:**  Node.js


1. Install dependencies:
   `npm install`
2. Set the `GEMINI_API_KEY` in [.env.local](.env.local) to your Gemini API key
3. Run the app:
   `npm run dev`
