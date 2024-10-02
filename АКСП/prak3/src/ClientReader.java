import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;

public class ClientReader extends Thread{
    private Socket socket;
    public ClientReader(Socket socket) {
        this.socket = socket;
    }

    @Override
    public void run() {
        try {
            System.out.println("Ридер запущен");
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            String message;
            while (true) {
                message = in.readLine();
                if (message != null) {
                    System.out.println("Пришло сообщение от сервера:\n" + message);
                }
            }
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }

    }
}