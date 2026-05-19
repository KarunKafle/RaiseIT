package com.raiseit.model;

import java.sql.Timestamp;

/**
 * Represents a department that handles complaint categories.
 */
public class Department {
    /** The unique ID of the department. */
    private int id;
    /** The display name of the department. */
    private String name;
    /** The description of the department's scope. */
    private String description;
    /** The time when the department was created. */
    private Timestamp createdAt;

    public Department() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
