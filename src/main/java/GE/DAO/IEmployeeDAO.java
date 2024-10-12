package GE.DAO;


import java.util.List;

public interface IEmployeeDAO<T> {

    // Save or insert an entity
    void save(T entity);

    // Fetch all entities
    List<T> fetchAll();

    // Fetch entities with a condition
    List<T> fetchWhere(String fieldName, String value);

    // Update an entity
    boolean update(T entity, Long id);

    // Delete an entity by ID
    boolean delete(Long id);

    // Find an entity by ID
    T findById(Long id);

    // Find an entity by email
    T findByEmail(String email, String name);

    // Count total entities
    int count();
}
