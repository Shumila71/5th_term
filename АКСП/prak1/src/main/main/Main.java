

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;
public class Main {
    public static void main(String[] args) {
        ReentrantLock lock = new ReentrantLock();
        private final Condition pingCondition = lock.newCondition();
        private final Condition pongCondition = lock.newCondition();
        private boolean pingTurn = true;//флаг
        Thread pingThread = new Thread(() -> {
            for (int i = 0; i < 10; i++) {
                lock.lock();
                try {
                    while (!pingTurn) {
                        pingCondition.await();
                    }
                    System.out.print("Ping ");
                    pingTurn = false;
                    pongCondition.signal();
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                } finally {
                    lock.unlock();
                }
            }
        });

        Thread pongThread = new Thread(() -> {
            for (int i = 0; i < 10; i++) {
                lock.lock();
                try {
                    while (pingTurn) {
                        pongCondition.await();
                    }
                    System.out.print("Pong ");
                    pingTurn = true;
                    pingCondition.signal();
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                } finally {
                    lock.unlock();
                }
            }
        });

        pingThread.start();
        pongThread.start();
    }
}

