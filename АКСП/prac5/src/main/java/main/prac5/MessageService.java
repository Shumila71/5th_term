package main.prac5;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MessageService {
    private final MessageRepo messageRepo;

    public boolean save(Message message) {
        messageRepo.save(message);
        return true;
    }

    public List<Message> findAll() {
        return messageRepo.findAll();
    }
}
