package afisha_shop.controller;

import afisha_shop.model.Event;
import afisha_shop.model.Users;
import afisha_shop.service.BookingService;
import afisha_shop.repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
//@RequestMapping("/events")
public class BookingController {

    @Autowired
    private BookingService bookingService;

    @Autowired
    private EventRepository eventRepository;

    // Отображение всех событий
    @GetMapping
    public String getEventsPage(Model model) {
        List<Event> events = eventRepository.findAllByOrderByIdAsc();
        model.addAttribute("events", events);
        return "index";  // Страница с событиями
    }

    // Регистрация на событие
    @PostMapping("/register")
    public String registerUser(
            @RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam String email,
            @RequestParam Long eventId,
            RedirectAttributes redirectAttributes) { // Используем RedirectAttributes для передачи сообщений
        try {
            Users user = bookingService.registerUser(firstName, lastName, email, eventId);
            redirectAttributes.addFlashAttribute("successMessage", "Вы успешно забронировали билет на: " + user.getEvent().getName() + ". Уникальный номер вашего билиета: " + user.getTicketNumber() );
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/";  // Возвращаем на страницу с событиями
    }

    @GetMapping("/find-tickets")
    public String findTicketsByEmail(
            @RequestParam String email,
            RedirectAttributes redirectAttributes) {
        try {
            List<Users> tickets = bookingService.findTicketsByEmail(email);
            if (tickets.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage_search", "Не найденно билетов, забронированных на почту: " + email);
            } else {
                redirectAttributes.addFlashAttribute("tickets", tickets);
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage_search", "An error occurred: " + e.getMessage());
        }
        return "redirect:/";  // Остаемся на той же странице
    }

}
