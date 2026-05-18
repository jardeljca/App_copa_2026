<div align="center">
<img width="1200" height="475" alt="GHBanner" src="https://github.com/user-attachments/assets/0aa67016-6eaf-458a-adb2-6e31a0763ed6" />
</div>


# App Copa 2026

Aplicativo móvel em Flutter para acompanhar a Copa do Mundo 2026 com um backend Node.js simples responsável por consultar a API de futebol.

## Estrutura do repositório

- `lib/` - código Flutter (app mobile)
- `server.ts` - backend Node/Express (API proxy)
- `package.json` - scripts e dependências do backend
- `pubspec.yaml` - dependências Flutter

## Pré-requisitos

- Flutter SDK instalado
- Node.js >= 18
- `FOOTBALL_DATA_API_KEY` (variável de ambiente para Football-Data.org)

## Rodando o backend (desenvolvimento)

1. Instale dependências:

```bash
npm install
```

2. Crie um arquivo `.env` com a chave:

```
FOOTBALL_DATA_API_KEY=your_api_key_here
PORT=3000
```

3. Inicie o servidor em modo dev:

```bash
npm run dev
```

O backend expõe a rota proxy `/api/football/*`. Ex.: `/api/football/competitions`.

## Rodando o app Flutter

1. Instale dependências Flutter:

```bash
flutter pub get
```

2. Rode no emulador/dispositivo:

```bash
flutter run
```

O app deve fazer chamadas para o backend (ajuste a URL base se necessário).

## Notas & recomendações

- Este repositório foi ajustado para conter apenas o app Flutter e o backend Node.
- Considere adicionar um arquivo `.env.example` e configurar CI que rode `npm ci` e `flutter analyze`.
- Mantenha a chave da API segura (não commitar `.env`).

## Contato

Se precisar, posso gerar o `.env.example`, um `README` mais detalhado ou um workflow de CI.

## Run Locally

**Prerequisites:**  Node.js


1. Install dependencies:
   `npm install`
2. Set the `GEMINI_API_KEY` in [.env.local](.env.local) to your Gemini API key
3. Run the app:
   `npm run dev`
