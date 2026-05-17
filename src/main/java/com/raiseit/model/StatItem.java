package com.raiseit.model;

public class StatItem {
    private String label;
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
