const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const PORT = 3000;

app.use(bodyParser.json());

const validateCPF = (cpf) => {
  cpf = cpf.replace(/\D/g, '');
  
  if (cpf.length !== 11) return false;

  let sum = 0, remainder;

  for (let i = 1; i <= 9; i++) {
    sum += parseInt(cpf.charAt(i - 1)) * (11 - i);
  }

  remainder = (sum * 10) % 11;
  if (remainder === 10 || remainder === 11) {
    remainder = 0;
  }

  if (remainder !== parseInt(cpf.charAt(9))) {
    return false;
  }

  sum = 0;
  for (let i = 1; i <= 10; i++) {
    sum += parseInt(cpf.charAt(i - 1)) * (12 - i);
  }

  remainder = (sum * 10) % 11;
  if (remainder === 10 || remainder === 11) {
    remainder = 0;
  }

  return remainder === parseInt(cpf.charAt(10));
};

app.get('/validate', (req, res) => {
  const cpf = req.query.cpf;

  if (!cpf) {
    return res.status(400).json({ message: 'CPF is required.' });
  }

  const isValid = validateCPF(cpf);
  return res.json({ valid: isValid });
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
