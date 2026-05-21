package com.raiseit.model;

/**
 * Represents a label and count used in reports.
 */
public class StatItem {
    /** The label for this statistic. */
    private String label;
    /** The count value for this statistic. */
    private int count;

    public StatItem() {}

    public StatItem(String label, int count) {
        this.label = label;
        this.count = count;
    }

    public String getLabel() { return label; }
    public void setLabel(String label) { this.label = label; }

    public int getCount() { return count; }
    public void setCount(int count) { this.count = count; }
}
