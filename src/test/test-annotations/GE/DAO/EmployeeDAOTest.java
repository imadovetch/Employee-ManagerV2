package GE.DAO;

import GE.model.Aplyment;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class EmployeeDAOTest {

    @Mock
    private EntityManagerFactory entityManagerFactory;

    @Mock
    private EntityManager entityManager;

    @Mock
    private EntityTransaction transaction;

    @Mock
    private TypedQuery<Aplyment> query;

    @InjectMocks
    private EmployeeDAO<Aplyment> employeeDAO;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        when(entityManagerFactory.createEntityManager()).thenReturn(entityManager);
        when(entityManager.getTransaction()).thenReturn(transaction);
    }

    @Test
    void testSave() {
        Aplyment aplyment = new Aplyment();
        employeeDAO.save(aplyment);

        verify(entityManager, times(1)).persist(aplyment);
        verify(transaction, times(1)).begin();
        verify(transaction, times(1)).commit();
        verify(entityManager, times(1)).close();
    }

    @Test
    void testFetchAll() {
        Aplyment aplyment1 = new Aplyment();
        Aplyment aplyment2 = new Aplyment();
        List<Aplyment> aplymentList = Arrays.asList(aplyment1, aplyment2);

        when(entityManager.createQuery("from Aplyment", Aplyment.class)).thenReturn(query);
        when(query.getResultList()).thenReturn(aplymentList);

        List<Aplyment> result = employeeDAO.fetchAll();

        assertEquals(2, result.size());
        assertEquals(aplymentList, result);
        verify(entityManager, times(1)).close();
    }

    @Test
    void testFindById() {
        Aplyment aplyment = new Aplyment();
        when(entityManager.find(Aplyment.class, 1L)).thenReturn(aplyment);

        Aplyment result = employeeDAO.findById(1L);

        assertNotNull(result);
        assertEquals(aplyment, result);
        verify(entityManager, times(1)).close();
    }

    @Test
    void testDelete() {
        Aplyment aplyment = new Aplyment();
        when(entityManager.find(Aplyment.class, 1L)).thenReturn(aplyment);

        boolean result = employeeDAO.delete(1L);

        assertTrue(result);
        verify(entityManager, times(1)).remove(aplyment);
        verify(transaction, times(1)).begin();
        verify(transaction, times(1)).commit();
        verify(entityManager, times(1)).close();
    }

    @Test
    void testCount() {
//        when(entityManager.createQuery("SELECT COUNT(e) FROM Aplyment e", Long.class)).thenReturn(query);
//        when(query.getSingleResult()).thenReturn(5L);

        int count = employeeDAO.count();

        assertEquals(5, count);
        verify(entityManager, times(1)).close();
    }
}
