  FROM ghcr.io/astral-sh/uv:python3.11-bookworm-slim AS builder
  WORKDIR /app
  COPY pyproject.toml uv.lock ./
  RUN uv sync --frozen --no-dev

  FROM python:3.11-slim
  COPY --from=builder /app/.venv /app/.venv
  COPY app.py .
  ENV PATH="/app/.venv/bin:$PATH"
  CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8002"]
