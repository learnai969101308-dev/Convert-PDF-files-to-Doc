# ប្រើប្រាស់ Python ជំនាន់ទី 3.10 ជាគោល
FROM python:3.10-slim

# ដំឡើងកម្មវិធីប្រព័ន្ធ Linux ដែលចាំបាច់ (Tesseract ខ្មែរ, Poppler និង OpenCV)
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-khm \
    poppler-utils \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# បង្កើតថតផ្ទុកឯកសារការងារក្នុង Server
WORKDIR /app

# ចម្លងឯកសារទាំងអស់ពី GitHub ទៅកាន់ Server
COPY . /app

# ដំឡើងបណ្ណាល័យ Python ទាំងអស់ពី requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# បញ្ជាឱ្យ Server ដំណើរការកម្មវិធីតាមរយៈ Gunicorn
CMD gunicorn -w 2 -b 0.0.0.0:$PORT app:app
