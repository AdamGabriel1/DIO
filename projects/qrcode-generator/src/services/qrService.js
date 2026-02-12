/**
 * Serviço central de geração de QR Codes
 * Abstração da biblioteca qrcode
 */

import QRCode from 'qrcode';

export class QRCodeService {
  constructor(defaultOptions = {}) {
    this.defaultOptions = {
      errorCorrectionLevel: 'M',
      type: 'png',
      quality: 0.92,
      margin: 4,
      color: {
        dark: '#000000',
        light: '#FFFFFF'
      },
      ...defaultOptions
    };
  }

  async generateToFile(filePath, data, customOptions = {}) {
    const options = { ...this.defaultOptions, ...customOptions };
    await QRCode.toFile(filePath, data, options);
    return filePath;
  }

  async generateToDataURL(data, customOptions = {}) {
    const options = { ...this.defaultOptions, ...customOptions };
    return await QRCode.toDataURL(data, options);
  }

  async generateToString(data, customOptions = {}) {
    const options = { ...this.defaultOptions, ...customOptions };
    return await QRCode.toString(data, options);
  }

  async generateToBuffer(data, customOptions = {}) {
    const options = { ...this.defaultOptions, ...customOptions };
    return await QRCode.toBuffer(data, options);
  }
}
```

### src/utils/validator.js

```javascript
/**
 * Funções de validação
 */

export function validateUrl(string) {
  try {
    const url = new URL(string);
    return url.protocol === 'http:' || url.protocol === 'https:';
  } catch (_) {
    return false;
  }
}

export function validateHexColor(color) {
  return /^#([0-9A-F]{3}){1,2}$/i.test(color);
}

export function sanitizeFilename(name) {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '');
}
