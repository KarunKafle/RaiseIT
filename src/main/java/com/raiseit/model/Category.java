package com.raiseit.model;

/**
 * Represents a complaint category in the system.
 */
public class Category {
    /** The unique ID of the category. */
    private int id;
    /** The display name of the category. */
    private String name;
    /** The ID of the department that owns this category. */
    private int departmentId;
    /** The name of the department for display. */
    private String departmentName;

    public Category() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getDepartmentId() { return departmentId; }
    public void setDepartmentId(int departmentId) { this.departmentId = departmentId; }

    public String getDepartmentName() { return departmentName; }
    public void setDepartmentName(String departmentName) { this.departmentName = departmentName; }
}
