# Utiliser une image Python officielle
FROM python:3.9-slim

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de dépendances et les installer
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le code source de l'application, les templates et les fichiers statiques
COPY . .

# Exposer le port sur lequel Flask va tourner
EXPOSE 5000

# Commande pour lancer l'application
CMD ["python", "app.py"]