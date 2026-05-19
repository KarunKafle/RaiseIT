package com.raiseit.model;

import java.sql.Timestamp;

/**
 * Represents a contact inquiry submitted from the public form.
 */
public class ContactInquiry {
    /** The unique ID of the inquiry. */
    private int id;
    /** The name provided by the sender. */
    private String name;
    /** The email address of the sender. */
    private String email;
    /** The phone number provided by the sender. */
    private String phone;
    /** The message content submitted by the sender. */
    private String message;
    /** The time when the inquiry was submitted. */
    private Timestamp submittedAt;

    public ContactInquiry() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public Timestamp getSubmittedAt() { return submittedAt; }
    public void setSubmittedAt(Timestamp submittedAt) { this.submittedAt = submittedAt; }
}
