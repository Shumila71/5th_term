import java.net.Socket;

public class Client {
    public static void main(String... args) {
        try (Socket socket = new Socket("localhost", 8080)) {
            System.out.println("Стартовал клиент!");
            ClientReader reader = new ClientReader(socket);
            ClientSender sender = new ClientSender(socket);

            sender.start();
            reader.start();

            sender.join();
            reader.join();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}


