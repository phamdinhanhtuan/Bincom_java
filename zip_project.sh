#!/bin/bash
set -e

echo "=== BINCOM E-COMMERCE: PACKAGING PROJECT FOR PORTING ==="

# 1. Clean maven build directories to keep ZIP small
echo "Cleaning project build files..."
if [ -f "./apache-maven-3.9.9/bin/mvn" ]; then
    ./apache-maven-3.9.9/bin/mvn clean
else
    mvn clean
fi

# 2. Package to ZIP
ZIP_NAME="Bincom_Ecommerce_JAVA.zip"
echo "Packaging into $ZIP_NAME..."

# Remove old zip if exists
rm -f "$ZIP_NAME"

# Zip all project files, excluding build/IDE files
zip -r "$ZIP_NAME" . \
    -x "target/*" \
    -x ".git/*" \
    -x ".idea/*" \
    -x ".vscode/*" \
    -x "*/.DS_Store" \
    -x ".DS_Store" \
    -x "apache-tomcat-9.0.100/work/*" \
    -x "apache-tomcat-9.0.100/temp/*" \
    -x "apache-tomcat-9.0.100/logs/*" \
    -x "apache-tomcat-9.0.100/webapps/ECommerceSystem*" \
    -x "$ZIP_NAME"

echo "======================================================="
echo "✅ DỰ ÁN ĐÃ ĐƯỢC ĐÓNG GÓI THÀNH CÔNG!"
echo "-> File nén: $ZIP_NAME"
echo "-> Kích thước: $(du -sh $ZIP_NAME | cut -f1)"
echo "======================================================="
echo "Cách chạy trên máy khác:"
echo "1. Giải nén file $ZIP_NAME"
echo "2. Đảm bảo MySQL đang chạy ở localhost:3306"
echo "   (Nếu password root của MySQL máy mới khác rỗng, sửa trong file: "
echo "    src/main/webapp/WEB-INF/spring/db.properties)"
echo "3. Chạy file ./run.sh để khởi chạy ứng dụng"
echo "   (Ứng dụng sẽ tự động tạo database 'ecommerce_db' và tự động khôi phục"
echo "    toàn bộ sản phẩm, danh mục, hình ảnh Base64 từ máy cũ sang!)"
echo "======================================================="
