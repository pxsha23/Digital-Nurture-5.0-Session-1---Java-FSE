# Difference between JPA, Hibernate and Spring Data JPA

## JPA (Java Persistence API)
- JPA is a **specification** (JSR 338), not an implementation
- It defines HOW Java objects should be mapped to database tables
- It does NOT contain actual code to connect to a database
- Think of it as a "rulebook" — it tells you what to do, not how

## Hibernate
- Hibernate is an **implementation** of JPA
- It is an ORM (Object Relational Mapping) tool
- It does the actual work of connecting to the database
- Hibernate translates Java objects into SQL queries
- Code example:
  - Need to manually manage Session, Transaction, commit, rollback

## Spring Data JPA
- Spring Data JPA is an **abstraction on top of JPA/Hibernate**
- It removes boilerplate code (no need to write Session, Transaction manually)
- Just extend JpaRepository and methods like save(), findAll(), deleteById() 
  are available automatically
- Spring manages transactions via @Transactional

## Comparison

| Feature | JPA | Hibernate | Spring Data JPA |
|---|---|---|---|
| Type | Specification | Implementation | Abstraction |
| Has actual DB code? | No | Yes | No (uses Hibernate) |
| Boilerplate code | High | High | Very Low |
| Transaction management | Manual | Manual | Automatic |
| Repository support | No | No | Yes (JpaRepository) |

## Code Comparison

### Hibernate (manual, lots of code)
```java
Session session = factory.openSession();
Transaction tx = session.beginTransaction();
session.save(employee);
tx.commit();
session.close();
```

### Spring Data JPA (clean, no boilerplate)
```java
// Repository
public interface EmployeeRepository extends JpaRepository<Employee, Integer> {}

// Service
@Transactional
public void addEmployee(Employee employee) {
    employeeRepository.save(employee);
}
```
