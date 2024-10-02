import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.List;

public class ClientHandler implements Runnable {
    private Socket socket;
    private BufferedReader in;
    private PrintWriter out;
    private List<String> messageBuffer;
    private List<ClientHandler> clients;

    public ClientHandler(Socket socket, List<ClientHandler> clients, List<String> messageBuffer) {
        this.socket = socket;
        this.clients = clients;
        this.messageBuffer = messageBuffer;
    }

    @Override
    public void run() {
        try {
            in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            out = new PrintWriter(socket.getOutputStream(), true);
            String message;
            while ((message = in.readLine()) != null) {
                System.out.println("Сообщение принято сервером: " + message);
                synchronized (messageBuffer) {
                    messageBuffer.add(message);
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                clients.remove(this);
                socket.close();
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }

    public void sendMessage(String msg) {
        out.println(msg);
    }
}
