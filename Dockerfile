# 1. استخدام نسخة بايثون رسمية مستقرة وخفيفة
FROM python:3.11-slim

# 2. إعداد متغيرات بيئة لتحسين أداء بايثون داخل الحاوية
# منع بايثون من كتابة ملفات .pyc المؤقتة
ENV PYTHONDONTWRITEBYTECODE 1
# ضمان عرض السجلات (Logs) فوراً في الترمينال دون تأخير
ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "dicussion_board.wsgi:application"]