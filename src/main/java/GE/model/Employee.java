//package GE.model;
//import ge.gev2.enums.Role;
//import jakarta.persistence.Column;
//import jakarta.persistence.Entity;
//import jakarta.persistence.Table;
//
//import java.time.LocalDate;
//
//@Entity
//@Table(name = "employees")
//public class Employee  {
//    @Column(name = "date_of_birth", nullable = false)
//    private LocalDate dateOfBirth;
//
//    @Column(name = "social_nbr", unique = true, nullable = false)
//    private String socialNbr;
//
//    @Column(name = "date_of_joining", nullable = false)
//    private LocalDate dateOfJoining;
//
//    @Column(name = "salary", nullable = false)
//    private Long salary;
//
//    @Column(name = "child_nbr", nullable = false)
//    private int childNbr;
//
//    @Column(name = "leave_balance", nullable = false)
//    private Long leaveBalance;
//
//    @Column(name = "department", nullable = false)
//    private String department;
//
//    @Column(name = "post", nullable = false)
//    private String post;
//
//    public Employee(String name, String password, String email, String department,
//                    String position, Long leaveBalance, Role role, LocalDate dateOfBirth,
//                    String socialNumber, LocalDate dateOfJoining, Long salary, int childNumber) {
//        super(name, password, email, role);
//        this.dateOfBirth = dateOfBirth;
//        this.socialNbr = socialNumber;
//        this.dateOfJoining = dateOfJoining;
//        this.salary = salary;
//        this.childNbr = childNumber;
//        this.department = department;
//        this.post = position;
//        this.leaveBalance = leaveBalance;
//
//    }
//
//    public Employee() {
//
//    }
//
//    public LocalDate getDateOfBirth() {
//        return dateOfBirth;
//    }
//    public void setDateOfBirth(LocalDate dateOfBirth) {
//        this.dateOfBirth = dateOfBirth;
//    }
//    public String getSocial_nbr() {
//        return socialNbr;
//    }
//    public void setSocial_nbr(String social_nbr) {
//        this.socialNbr = social_nbr;
//    }
//    public LocalDate getDateOfJoining() {
//        return dateOfJoining;
//    }
//    public void setDateOfJoining(LocalDate dateOfJoining) {
//        this.dateOfJoining = dateOfJoining;
//    }
//    public Long getSalary() {
//        return salary;
//    }
//    public void setSalary(Long salary) {
//        this.salary = salary;
//    }
//    public int getChild_nbr() {
//        return childNbr;
//    }
//    public void setChild_nbr(int child_nbr) {
//        this.childNbr = child_nbr;
//    }
//    public Long getLeaveBalance() {
//        return leaveBalance;
//    }
//    public void setLeaveBalance(Long leaveBalance) {
//        this.leaveBalance = leaveBalance;
//    }
//    public String getDepartment() {
//        return department;
//    }
//    public void setDepartment(String department) {
//        this.department = department;
//    }
//    public String getPost() {
//        return post;
//    }
//    public void setPost(String post) {
//        this.post = post;
//    }
//
//
//
//}