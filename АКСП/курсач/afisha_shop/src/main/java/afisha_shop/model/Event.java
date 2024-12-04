package afisha_shop.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Event {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private int availableTickets;

    public Event(String name, int availableTickets)
    {
        this.name = name;
        this.availableTickets = availableTickets;
    }
}
