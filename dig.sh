#!/bin/bash

# Kullanım kontrolü
if [ "$#" -ne 2 ]; then
    echo "Kullanım: $0 <input_file> <output_file>"
    exit 1
fi

# Argümanları değişkenlere ata
input_file="$1"
output_file="$2"

# Output dosyasını temizle
> "$output_file"

# URL dosyasını oku
while IFS= read -r url
do
    # Boş satırları atla
    if [ -z "$url" ]; then
        continue
    fi

    # dig komutunu çalıştır ve CNAME kaydını al
    dig_output=$(dig +short CNAME "$url")

    # Çıktıyı dosyaya yaz
    echo "$url --> $dig_output" >> "$output_file"

done < "$input_file"

echo "Çıktılar $output_file dosyasına yazıldı."
