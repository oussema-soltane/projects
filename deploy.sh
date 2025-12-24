#!/bin/bash

# Interactive CV Deployment Script

echo "🚀 Deploying Ultimate Interactive CV..."

# Install dependencies
echo "📦 Installing dependencies..."
npm init -y
npm install three --save
npm install @types/three --save-dev

# Create directory structure
echo "📁 Creating directory structure..."
mkdir -p icons screenshots models

# Generate icons (requires ImageMagick or use pre-made icons)
echo "🎨 Generating icons..."
# Create placeholder icons
for size in 72 96 128 144 152 192 384 512; do
    convert -size ${size}x${size} xc:#6366f1 -fill "#0ea5e9" \
            -draw "circle $(($size/2)),$(($size/2)) $(($size/4)),$(($size/2))" \
            icons/icon-${size}x${size}.png
done

# Create screenshots
echo "📸 Creating screenshots..."
# These would be actual screenshots of your site
convert -size 1280x720 xc:#0f172a screenshots/desktop.png
convert -size 750x1334 xc:#0f172a screenshots/mobile.png

# Optimize files
echo "⚡ Optimizing files..."
# Minify HTML, CSS, JS
# You can use tools like terser, cssnano, html-minifier

# Create CNAME for custom domain (if any)
echo "🌐 Setting up custom domain..."
if [ -n "$CUSTOM_DOMAIN" ]; then
    echo $CUSTOM_DOMAIN > CNAME
fi

# Deploy to Vercel
echo "🚀 Deploying to Vercel..."
if command -v vercel &> /dev/null; then
    vercel --prod
else
    echo "⚠️ Vercel CLI not found. Installing..."
    npm i -g vercel
    vercel --prod
fi

# Generate QR Code
echo "🔳 Generating QR code..."
if command -v qrcode &> /dev/null; then
    qrcode -o qr-code.png https://$(vercel --prod 2>&1 | grep -o 'https://[^ ]*')
else
    echo "📱 Visit https://qr.io/ to generate QR code for your deployed URL"
fi

echo "✅ Deployment complete!"
echo "📱 Your interactive CV is now live!"
echo "🔗 URL: [Your Vercel URL]"
echo "📄 QR Code: qr-code.png"