package com.raiseit.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Handles basic password hashing and checking for user accounts.
 * It uses SHA-256 to turn a plain password into a stored string.
 */
public class PasswordUtil {

    /**
     * Hashes a plain text password using SHA-256.
     * @param password the plain password to hash
     * @return the hashed password as a hex string
     */
    public static String hash(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Checks if a plain password matches a stored hash.
     * @param plainPassword the plain password to check
     * @param hashedPassword the stored hash to compare with
     * @return true if the passwords match, false otherwise
     */
    public static boolean verify(String plainPassword, String hashedPassword) {
        return hash(plainPassword).equals(hashedPassword);
    }
}
