const grpc = require("@grpc/grpc-js");
const protoLoader = require("@grpc/proto-loader");
const path = require("path");

// Загрузка protobuf
const PROTO_PATH = path.resolve(__dirname, "user.proto");
const packageDefinition = protoLoader.loadSync(PROTO_PATH);
const userProto = grpc.loadPackageDefinition(packageDefinition).user;

// Хранилище данных
const users = [];

// Реализация методов gRPC
const server = new grpc.Server();

server.addService(userProto.UserService.service, {
  register: (call, callback) => {
    const { id, username, password } = call.request;
    if (users.find((user) => user.username === username)) {
      return callback({
        code: grpc.status.ALREADY_EXISTS,
        message: "Пользователь уже существует",
      });
    }
    users.push({ id, username, password });
    callback(null, { message: "Пользователь успешно зарегистрирован" });
  },

  login: (call, callback) => {
    const { username, password } = call.request;
    const user = users.find(
      (user) => user.username === username && user.password === password
    );
    if (!user) {
      return callback({
        code: grpc.status.NOT_FOUND,
        message: "Неверное имя пользователя или пароль",
      });
    }
    callback(null, { message: `Привет, ${username}!` });
  },

  update: (call, callback) => {
    const { id, username, password } = call.request;
    const user = users.find((user) => user.id === id);
    if (!user) {
      return callback({
        code: grpc.status.NOT_FOUND,
        message: "Пользователь не найден",
      });
    }
    user.username = username || user.username;
    user.password = password || user.password;
    callback(null, { message: "Пользователь успешно обновлен" });
  },
});

// Запуск сервера
const PORT = 50051;
server.bindAsync(
  `0.0.0.0:${PORT}`,
  grpc.ServerCredentials.createInsecure(),
  () => {
    console.log(`gRPC сервер работает на порту ${PORT}`);
    server.start();
  }
);
