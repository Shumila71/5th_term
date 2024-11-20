const grpc = require("@grpc/grpc-js");
const protoLoader = require("@grpc/proto-loader");
const path = require("path");
const express = require("express");
const bodyParser = require("body-parser");

// Настройка gRPC-клиента
const PROTO_PATH = path.resolve(__dirname, "user.proto");
const packageDefinition = protoLoader.loadSync(PROTO_PATH);
const userProto = grpc.loadPackageDefinition(packageDefinition).user;

const client = new userProto.UserService(
  "localhost:50051",
  grpc.credentials.createInsecure()
);

// Настройка Express-сервера
const app = express();
app.use(bodyParser.json());
app.use(express.static("public")); // Для отдачи HTML-файлов

// Эндпоинты API
app.post("/register", (req, res) => {
  const { id, username, password } = req.body;
  client.register({ id, username, password }, (err, response) => {
    if (err) {
      console.log(`Ошибка регистрации: ${err.message}`);
      res.status(400).json({ error: err.message });
    } else {
      console.log(`Успех регистрации: ${response.message}`);
      res.json({ message: response.message });
    }
  });
});

app.post("/login", (req, res) => {
  const { username, password } = req.body;
  client.login({ username, password }, (err, response) => {
    if (err) {
      console.log(`Ошибка входа: ${err.message}`);
      res.status(400).json({ error: err.message });
    } else {
      console.log(`Успех входа: ${response.message}`);
      res.json({ message: response.message });
    }
  });
});

app.post("/update", (req, res) => {
  const { id, username, password } = req.body;
  client.update({ id, username, password }, (err, response) => {
    if (err) {
      console.log(`Ошибка обновления: ${err.message}`);
      res.status(400).json({ error: err.message });
    } else {
      console.log(`Успех обновления: ${response.message}`);
      res.json({ message: response.message });
    }
  });
});

// Запуск Express-сервера
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Клиентский сервер работает по адресу http://localhost:${PORT}`);
});
