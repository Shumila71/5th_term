package main.prac5;


import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class MessageController {
    private final MessageService messageService;

    @GetMapping("/findAll")
    public List<Message> getMessage() {
        return messageService.findAll();
    }

    @PostMapping("/save")
    public boolean save(@RequestBody Message message) {
        return messageService.save(message);
    }
}
