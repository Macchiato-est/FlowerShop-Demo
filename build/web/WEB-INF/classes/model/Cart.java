/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author 06052
 */


import java.util.*;

public class Cart {

    private Map<Integer, CartItem> items = new LinkedHashMap<>();

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public void add(Product p, int qty) {
        if (qty < 1) qty = 1;

        CartItem existing = items.get(p.getId());
        if (existing == null) {
            items.put(p.getId(), new CartItem(p, qty));
        } else {
            existing.setQty(existing.getQty() + qty);
        }
    }

    public void update(int productId, int qty) {
        CartItem ci = items.get(productId);
        if (ci == null) return;

        if (qty <= 0) items.remove(productId);
        else ci.setQty(qty);
    }

    public void remove(int productId) {
        items.remove(productId);
    }

    public void clear() {
        items.clear();
    }

    public int getTotalItems() {
        return items.values().stream()
                .mapToInt(CartItem::getQty)
                .sum();
    }

    public double getTotalAmount() {
        return items.values().stream()
                .mapToDouble(CartItem::getLineTotal)
                .sum();
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }
}