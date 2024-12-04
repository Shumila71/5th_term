package afisha_shop.service;
import afisha_shop.model.Event ;
import afisha_shop.model.Users;
import afisha_shop.repository.EventRepository;
import afisha_shop.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class BookingService {

    @Autowired
    private EventRepository eventRepository;

    @Autowired
    private UserRepository userRepository;

    public Users registerUser(String firstName, String lastName, String email, Long eventId) {
        if (userRepository.existsByEmailAndEventId(email, eventId)) {
            throw new RuntimeException("Пользователь с этой почтой уже зарегистрирован на данное событие.");
        }

        Event event = eventRepository.findById(eventId)
                .orElseThrow(() -> new RuntimeException("Событие не найдено."));

        if (event.getAvailableTickets() <= 0) {
            throw new RuntimeException("Билеты кончились.");
        }

        Users user = new Users();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setTicketNumber(UUID.randomUUID().toString());
        user.setEvent(event);

        event.setAvailableTickets(event.getAvailableTickets() - 1);
        eventRepository.save(event);
        return userRepository.save(user);
    }


    public List<Users> findTicketsByEmail(String email) {
        return userRepository.findAllByEmail(email);
    }
}