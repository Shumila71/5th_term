import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Server {

    private static final List<ClientHandler> clients = new ArrayList<>();
    private static final List<String> messages = new ArrayList<>();

    public static void main(String... args) throws IOException {
        ExecutorService executorService = Executors.newCachedThreadPool();

        try (ServerSocket serverSocket = new ServerSocket(8080)) {
            System.out.println("Запущен сервер!");
            executorService.execute(() -> {
                while (true) {
                    try {
                        Thread.sleep(5000);
                        synchronized (messages) {
                            if (!messages.isEmpty()) {
                                sendMessagesToClients();
                                messages.clear();
                            }
                        }
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                }
            });
            while (true) {
                Socket socket = serverSocket.accept();
                ClientHandler clientHandler = new ClientHandler(socket, clients, messages);
                clients.add(clientHandler);
                executorService.execute(clientHandler);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }


    private static void sendMessagesToClients() {
        for (ClientHandler clientHandler : clients) {
            try {
                for (String message: messages) {
                    clientHandler.sendMessage(message);
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }
}
