package com.example.balaji.android_assignment_4;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.w3c.dom.Text;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;


public class Main2Activity extends AppCompatActivity implements View.OnClickListener {
    EditText edit_search;
    Button button_search;
    TextView text_search;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);

        edit_search = (EditText) findViewById(R.id.search);
        button_search = (Button) findViewById(R.id.search_button);
        text_search = (TextView) findViewById(R.id.display_text);
        button_search.setOnClickListener(this);
    }



    @Override
    public void onClick(View v) {

        switch (v.getId()) {
            case R.id.search_button:

                new Thread(new Runnable() {
                    public void run() {

                        try {
                            URL url = new URL("http://54.183.57.169:8080/Project_Test_Android/test_servlet");
                            URLConnection connection = url.openConnection();

                            String inputString = edit_search.getText().toString();

                            Log.d("inputString", inputString);

                            connection.setDoOutput(true);
                            OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream());
                            out.write(inputString);
                            out.close();

                            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));

                            String returnString = "";
                            String str = "";

                            while ((returnString = in.readLine()) != null) {
                                str = str + returnString;
                            }
                            final String m = str;
                            final String[] opt_split_string = str.split(",");
                            in.close();

                            runOnUiThread(new Runnable() {
                                public void run() {
//                                    if (m.contains("true")) {
                                        String display_text="";
                                        for(int i=0;i<opt_split_string.length;i++){
                                            display_text = display_text + opt_split_string[i] + "\n";
                                        }

                                    text_search.setText(display_text);
//                                        Intent i = new Intent(Main2Activity.this,Main2Activity.class);
//                                        startActivity(i);
//                                    }else{
//                                        Toast.makeText(Main2Activity.this, "Incorrect username or password", Toast.LENGTH_LONG).show();
//                                    }

                                }
                            });

                        } catch (Exception e) {
                            Log.d("Exception", e.toString());
                        }

                    }
                }).start();

                break;
        }
    }

}

//    @Override
//    public void onClick(View v) {
//
//        switch (v.getId()) {
//            case R.id.search_button:
//
//                new Thread(new Runnable() {
//                    public void run() {
//
//                        try {
//                            URL url = new URL("http://54.183.57.169:8080/Project_Test_Android/test_servlet");
//                            URLConnection connection = url.openConnection();
//
//                            String inputString = edit_search.getText().toString();
//
//                            Log.d("inputString", inputString);
//
//                            connection.setDoOutput(true);
//                            OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream());
//                            out.write(inputString);
//                            out.close();
//
//                            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
//
//                            String returnString = "";
//                            String str = "";
//
//                            while ((returnString = in.readLine()) != null) {
//                                str = str + returnString;
//                            }
//                            final String m = str;
//                            in.close();
//
//
//                            runOnUiThread(new Runnable() {
//                                public void run() {
//                                    text_movie_list.setText(m);
//
//                                }
//                            });
//
//                        } catch (Exception e) {
//                            Log.d("Exception", e.toString());
//                        }
//
//                    }
//                }).start();
//
//                break;
//        }
//    }


