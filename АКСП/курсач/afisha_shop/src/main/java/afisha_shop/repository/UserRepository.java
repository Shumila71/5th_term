package afisha_shop.repository;

import afisha_shop.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;


public interface UserRepository extends JpaRepository<Users, Long> {

    // Проверка, существует ли пользователь с указанным email и eventId
    @Query("SELECT CASE WHEN COUNT(u) > 0 THEN true ELSE false END FROM Users u WHERE u.email = :email AND u.event.id = :event_id")
    boolean existsByEmailAndEventId(@Param("email") String email, @Param("event_id") Long eventId);

    @Query("SELECT u FROM Users u WHERE u.email = :email")
    List<Users> findAllByEmail(@Param("email") String email);
}