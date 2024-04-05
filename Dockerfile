FROM python:3.9-slim

WORKDIR /opt/app

COPY src src
COPY requirements.txt .
COPY setup.py .

EXPOSE 8000

RUN pip install --no-cache-dir -e . && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["uvicorn", "src.app:app", "--host", "0.0.0.0", "--port", "8000"]

