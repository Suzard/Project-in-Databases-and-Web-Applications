package package_test;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;

public class cart_main {
	public HashMap<Integer,ArrayList<Object>> cart=  (HashMap<Integer,ArrayList<Object>>)new LinkedHashMap<Integer,ArrayList<Object>>();
	
	public boolean contains_key(int id){
		System.out.println("Went" + id);
		if(cart.containsKey(id)) return true;
		return false;
	}
	
	public ArrayList<Object> return_value(int id){
		ArrayList<Object> list_values = (ArrayList<Object>) cart.get(id);
		return  list_values;
	}
	
	public void update(int id, int quantity,int check, String movie_name){
		int present_quantity=0;
		ArrayList<Object> local_cart_value_list = new ArrayList<Object>();
		if(quantity==0 && check==1) {
			cart.remove(id);

		}else{
			if(cart.containsKey(id)) {
				local_cart_value_list = (ArrayList<Object>) cart.get(id);
				present_quantity = (int) local_cart_value_list.get(1);
				local_cart_value_list.set(1, present_quantity+quantity);
				cart.put(id, local_cart_value_list);

			}else{
				local_cart_value_list.add(0, movie_name);
				local_cart_value_list.add(1, quantity);
				cart.put(id, local_cart_value_list);

			}
		}
	}
	
	public void put_value(int id, ArrayList<Object> list){
		cart.put(id, list);
	}
	
	public HashMap<Integer, ArrayList<Object>> map_get(){
		return cart;
	}
	
	public void remove(int id){
		cart.remove(id);
	}
}
