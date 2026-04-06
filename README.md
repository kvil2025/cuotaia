# 📊 CuotaIA Chile

**Plataforma de análisis y monitoreo inteligente de fondos mutuos chilenos.**

Integra datos oficiales de la CMF, Yahoo Finance, predicción con IA y alertas proactivas vía Telegram.

![Python](https://img.shields.io/badge/Python-3.9+-blue?logo=python)
![FastAPI](https://img.shields.io/badge/FastAPI-0.110+-green?logo=fastapi)
![React](https://img.shields.io/badge/React-18+-61DAFB?logo=react)
![CMF](https://img.shields.io/badge/Datos-CMF%20Chile%20Oficial-red)
![License](https://img.shields.io/badge/License-MIT-yellow)

---

## ✨ Funcionalidades

### 📈 Dashboard Principal
- **Indicadores CMF Oficiales**: UF, Dólar observado, IPC, UTM, TPM en tiempo real
- **Barra de Mercado Global**: S&P 500, IPSA, USD/CLP, VIX, Bitcoin
- **Feed de Noticias**: Artículos de Yahoo Finance filtrados para Chile
- **ETFs Globales**: Tabla con los principales ETFs relacionados a Chile y renta fija

### 🏦 Fondos Mutuos
- Catálogo curado de fondos chilenos con métricas de rentabilidad
- Filtros por tipo (Monetario, Renta Fija CP/LP/UF, Accionario)
- Ordenamiento por rentabilidad 12M, 1M o patrimonio
- Vista detallada con historial de valor cuota

### 🔮 Predicción con IA
- Proyección del valor cuota a 30-90 días
- Modelo Ensemble (GBM + regresión lineal + media móvil)
- Intervalos de confianza y señal de tendencia

### 📊 Comparador de Fondos
- Comparación lado a lado de hasta 5 fondos
- Gráfico de rentabilidad normalizado (Base 100)
- Análisis de correlación con benchmarks (S&P 500, IPSA, Dólar)
- Coeficiente de Pearson calculado automáticamente

### 🤖 Bot Telegram Integrado
| Comando | Descripción |
|---------|-------------|
| `/uf` | Valor actual de la UF (CMF Oficial) |
| `/dolar` | Dólar observado del Banco Central |
| `/ipc` | Inflación mensual (CMF) |
| `/top` | Top 3 fondos más rentables (12M) |
| `/fondo <nombre>` | Info detallada de un fondo específico |
| `/reporte` | Resumen ejecutivo completo del mercado |
| `/ayuda` | Lista todos los comandos disponibles |

### 🔔 Alertas Automáticas (cada 30 min)
- 💵 Dólar supera $970 o baja de $920 CLP
- 📉 S&P 500 cae más de 2% en un día
- 🇨🇱 IPSA cae más de 1.5% en un día
- 😱 VIX supera 25 puntos
- 📐 UF publicada por la CMF
- 📊 IPC mensual > 0.5%

### 📅 Reportes Diarios
- ☀️ **9:00 AM** — Briefing matutino
- 🌆 **18:10 PM** — Resumen ejecutivo de cierre

---

## 🚀 Instalación

### Requisitos
- Python 3.9+ y Node.js 18+
- API Key CMF Chile (gratuita en [api.cmfchile.cl](https://api.cmfchile.cl))
- Bot de Telegram (crea uno con `@BotFather`)

### Setup
```bash
git clone https://github.com/kvil2025/cuotaia.git
cd cuotaia
cp .env.example .env
# Edita .env con tus credenciales
```

**Backend:**
```bash
cd backend
python -m venv venv && source venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload --port 8001
```

**Frontend:**
```bash
cd frontend && npm install && npm run dev
```

**Motor de Alertas:**
```bash
./start-alerts.sh
```

---

## 🏗️ Arquitectura

```
cuotaia/
├── backend/
│   ├── main.py                 # FastAPI + APScheduler + Telegram polling
│   ├── alert_engine.py         # Motor alertas autónomo (standalone)
│   ├── requirements.txt
│   ├── data/
│   │   ├── fondos_catalog.py   # Catálogo + generador GBM
│   │   ├── indicators.py       # CMF API + Yahoo Finance fallback
│   │   └── yahoo_data.py       # Mercado, noticias, ETFs
│   ├── models/
│   │   └── prophet_model.py    # Predicción Ensemble
│   └── services/
│       └── telegram_service.py # Bot commands + report formatter
├── frontend/src/
│   ├── components/             # Dashboard, FondoDetail, Comparador, etc.
│   └── services/api.js         # HTTP client
├── .env.example
├── .gitignore
└── start-alerts.sh
```

---

## 🔌 API Reference

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | `/api/indicators` | UF, Dólar, IPC, UTM (CMF Oficial) |
| GET | `/api/market` | S&P500, IPSA, Dólar, VIX, BTC |
| GET | `/api/news` | Noticias financieras Chile |
| GET | `/api/fondos` | Lista fondos (filtros: tipo, gestora, orden) |
| GET | `/api/fondos/{id}` | Detalle + historial |
| GET | `/api/fondos/{id}/predict` | Predicción N días (máx 90) |
| GET | `/api/comparar?ids=a,b` | Comparar 2-5 fondos |
| GET | `/api/benchmarks` | S&P500, IPSA, Dólar histórico |
| POST | `/api/telegram/test` | Test conexión bot |
| POST | `/api/telegram/send_report` | Enviar reporte manual |

**Rate Limit:** 60 req/min por IP

---

## 🔒 Seguridad

| Medida | Implementación |
|--------|----------------|
| Credenciales | Variables de entorno `.env`, nunca hardcodeadas |
| CORS | Lista blanca explícita (`ALLOWED_ORIGINS`) |
| Rate Limiting | `slowapi` — 60 req/min por IP |
| Validación | FastAPI tipos + límites Query params |
| Stack traces | No expuestos en errores de producción |

### Credenciales requeridas

| Variable | Dónde obtener |
|----------|---------------|
| `CMF_API_KEY` | [api.cmfchile.cl](https://api.cmfchile.cl) (gratis) |
| `TELEGRAM_TOKEN` | `@BotFather` en Telegram |
| `TELEGRAM_CHAT_ID` | `@userinfobot` en Telegram |

---

## 📦 Stack Tecnológico

**Backend:** FastAPI · uvicorn · yfinance · APScheduler · slowapi · pandas · scikit-learn

**Frontend:** React 18 · Vite · Recharts · Axios

**Fuentes de datos:** CMF Chile API · Yahoo Finance

---

## ⚠️ Disclaimer

Los datos de CuotaIA son **solo para fines informativos**. No constituyen asesoría financiera. Consulta siempre con un asesor certificado. Los rendimientos pasados no garantizan rendimientos futuros.

---

*Desarrollado con ❤️ usando datos oficiales de la [CMF Chile](https://www.cmfchile.cl)*
