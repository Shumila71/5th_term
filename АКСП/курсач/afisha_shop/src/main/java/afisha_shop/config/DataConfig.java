package afisha_shop.config;

import afisha_shop.model.Event ;
import afisha_shop.repository.EventRepository ;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class DataConfig {

    @Bean
    public CommandLineRunner loadData(EventRepository eventRepository) {
        return (args) -> {
            // Проверяем, есть ли события в базе данных
            if (eventRepository.findAll().isEmpty()) {
                // Создаем список событий
                Event a = new Event("Футбольный матч", 300);
                Event b = new Event("Рок-концерт", 500);
                Event c = new Event("Выставка искусства", 200);
                Event d = new Event("АйТи-митап", 100);
                Event e = new Event("Гастрономический фестиваль", 400);
                Event f = new Event("Театральная постановка", 250);
                Event g = new Event("Оперный вечер", 150);
                Event h = new Event("Фестиваль кино", 350);
                Event i = new Event("Лекция по науке", 100);
                Event j = new Event("Турнир по шахматам", 50);
                Event k = new Event("Детский квест", 300);
                Event l = new Event("Фестиваль моды", 200);
                Event m = new Event("Музыкальный фестиваль", 600);
                Event n = new Event("Балетный спектакль", 180);
                Event o = new Event("Книжная ярмарка", 500);

                // Сохраняем события в базу данных
                eventRepository.saveAll(List.of(
                        a,b,c,d,e,f,g,h,i,j,k,l,m,n,o
                ));
            }
        };
    }

}

