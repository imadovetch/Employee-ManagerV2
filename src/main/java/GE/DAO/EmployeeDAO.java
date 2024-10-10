package GE.DAO;

import GE.model.Aplyment;
import jakarta.persistence.*;

import java.util.List;

public class EmployeeDAO<T> {

    private Class<T> entityClass;
    private EntityManagerFactory entityManagerFactory;

    public EmployeeDAO(Class<T> entityClass) {
        this.entityClass = entityClass;
        entityManagerFactory = Persistence.createEntityManagerFactory("Employee-management");
    }

    // Save or insert an entity
    public void save(T entity) {
        EntityManager entityManager = null;
        EntityTransaction transaction = null;

        try {
            entityManager = entityManagerFactory.createEntityManager();
            transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.persist(entity); // Insert the entity
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
        }
    }

    // Fetch all entities
    public List<T> fetchAll() {
        EntityManager entityManager = null;
        List<T> entities = null;

        try {
            entityManager = entityManagerFactory.createEntityManager();
            entities = entityManager.createQuery("from " + entityClass.getSimpleName(), entityClass).getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
        }

        return entities;
    }

    public List<T> fetchWhere(String fieldName, String value) {
        EntityManager entityManager = null;
        List<T> entities = null;

        try {
            entityManager = entityManagerFactory.createEntityManager();
            String queryStr = "FROM " + entityClass.getSimpleName() + " WHERE " + fieldName + " = :value";
            var query = entityManager.createQuery(queryStr, entityClass);

            // Check if the field is "status" and convert the value to the enum type if necessary
            if ("status".equals(fieldName)) {
                // Convert String to Enum
                Aplyment.Status statusValue = Aplyment.Status.valueOf(value);
                query.setParameter("value", statusValue);
            } else {
                // Handle other fields
                query.setParameter("value", value);
            }

            entities = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
        }

        return entities;
    }

    // Update an entity
    public boolean update(T entity, Long id) {
        EntityManager entityManager = null;
        EntityTransaction transaction = null;
        boolean isUpdated = false;

        try {
            entityManager = entityManagerFactory.createEntityManager();
            transaction = entityManager.getTransaction();
            transaction.begin();
            T existingEntity = entityManager.find(entityClass, id);

            if (existingEntity != null) {
                entityManager.merge(entity); // Update the entity
                transaction.commit();
                isUpdated = true;
            } else {
                System.out.println(entityClass.getSimpleName() + " not found with ID: " + id);
            }
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
        }

        return isUpdated;
    }

    // Delete an entity by ID
    public boolean delete(Long id) {
        EntityManager entityManager = null;
        EntityTransaction transaction = null;
        boolean isDeleted = false;

        try {
            entityManager = entityManagerFactory.createEntityManager();
            transaction = entityManager.getTransaction();
            transaction.begin();
            T entity = entityManager.find(entityClass, id);

            if (entity != null) {
                entityManager.remove(entity); // Remove the entity
                transaction.commit();
                isDeleted = true;
            } else {
                System.out.println(entityClass.getSimpleName() + " not found with ID: " + id);
            }
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
        }

        return isDeleted;
    }

    // Find an entity by ID
    public T findById(Long id) {
        EntityManager entityManager = null;
        T entity = null;

        try {
            entityManager = entityManagerFactory.createEntityManager();
            entity = entityManager.find(entityClass, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
        }

        return entity;
    }
    public T findByEmail(String email,String name) {
        EntityManager entityManager = null;
        T entity = null;

        try {
            entityManager = entityManagerFactory.createEntityManager();

            String queryString = "SELECT e FROM " + name + " e WHERE e.email = :email";
            TypedQuery<T> query = entityManager.createQuery(queryString, entityClass);
            query.setParameter("email", email);

            entity = query.getSingleResult();
        } catch (NoResultException e) {

            System.out.println("No entity found with email: " + email);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
        }

        return entity;
    }

    public int count() {
        EntityManager entityManager = null;
        int count = 0;

        try {
            entityManager = entityManagerFactory.createEntityManager();
            String queryString = "SELECT COUNT(e) FROM " + entityClass.getSimpleName() + " e";
            TypedQuery<Long> query = entityManager.createQuery(queryString, Long.class);
            count = query.getSingleResult().intValue();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
        }

        return count;
    }

}
