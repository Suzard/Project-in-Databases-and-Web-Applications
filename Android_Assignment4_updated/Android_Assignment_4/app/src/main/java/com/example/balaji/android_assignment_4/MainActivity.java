package com.example.balaji.android_assignment_4;
//
//import android.content.Context;
//import android.content.SharedPreferences;
//import android.os.Bundle;
//import android.support.design.widget.FloatingActionButton;
//import android.support.design.widget.Snackbar;
//import android.support.v7.app.AppCompatActivity;
//import android.support.v7.widget.Toolbar;
//import android.util.Log;
//import android.view.View;
//import android.view.Menu;
//import android.view.MenuItem;
//import android.widget.Button;
//import android.widget.EditText;
//import android.widget.Toast;
//
//import java.io.BufferedReader;
//import java.io.InputStreamReader;
//import java.io.OutputStreamWriter;
//import java.net.URL;
//import java.net.URLConnection;
//import java.security.SecureRandom;
//import java.security.cert.CertificateException;
//import java.security.cert.X509Certificate;
//
//import javax.net.ssl.HostnameVerifier;
//import javax.net.ssl.HttpsURLConnection;
//import javax.net.ssl.SSLContext;
//import javax.net.ssl.SSLSession;
//import javax.net.ssl.X509TrustManager;
//
//public class MainActivity extends AppCompatActivity {
//    EditText edit_username, edit_password;
//    Button button_submit;
//    SharedPreferences shared_preference;
//
//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_main);
//        edit_username = (EditText) findViewById(R.id.username);
//        edit_password = (EditText) findViewById(R.id.password);
//        button_submit = (Button) findViewById(R.id.submit_button);
//
//        shared_preference = getSharedPreferences("login_preference", Context.MODE_PRIVATE);
//
////        button_submit.setOnClickListener(new View.OnClickListener() {
////            @Override
////            public void onClick(View v) {
////
////                SharedPreferences.Editor editor = shared_preference.edit();
////                editor.putString("username", edit_username.getText().toString());
////                editor.putString("password", edit_password.getText().toString());
////                editor.apply();
////                editor.commit();
////            }
////        });
//    }
//
//    @Override
//    public void onResume() {
//        super.onResume();
//        get_shared_preference();
//
//    }
//
//    @Override
//    public void onPause() {
//        super.onPause();
//        get_shared_preference();
//
//    }
//
//    @Override
//    public void onBackPressed() {
//        super.onBackPressed();
//        get_shared_preference();
//    }
//
//    @Override
//    public void onStop(){
//        super.onStop();
//        get_shared_preference();
//    }
//
//    public void get_shared_preference(){
//        shared_preference = getSharedPreferences("login_preference",Context.MODE_PRIVATE);
//        edit_username.setText(shared_preference.getString("username",""));
//        edit_password.setText(shared_preference.getString("password",""));
//    }
//
//    public void submit_click(View view) {
//
//        Toast.makeText(MainActivity.this, "Went inside OnClick()",Toast.LENGTH_LONG);
//        Log.d("Went","Went inside OnClick()");
//
//        SharedPreferences.Editor editor = shared_preference.edit();
//        editor.putString("username", edit_username.getText().toString());
//        editor.putString("password", edit_password.getText().toString());
//        Log.d("Username",edit_username.getText().toString());
//        Log.d("Password",edit_password.getText().toString());
//        editor.apply();
//        editor.commit();
//
//
//        new Thread(new Runnable() {
//            @Override
//            public void run() {
//                try{
//                    Log.d("Thread","Went inside Thread");
//                    String final_input_string = "", tmp_input_string="";
//                    HttpsURLConnection.setDefaultHostnameVerifier(new HostnameVerifier(){
//                        public boolean verify(String hostname, SSLSession session) {
//                            return true;
//                        }});
//                    SSLContext context = SSLContext.getInstance("TLS");
//                    context.init(null, new X509TrustManager[]{new X509TrustManager(){
//                        public void checkClientTrusted(X509Certificate[] chain,
//                                                       String authType) throws CertificateException {}
//                        public void checkServerTrusted(X509Certificate[] chain,
//                                                       String authType) throws CertificateException {}
//                        public X509Certificate[] getAcceptedIssuers() {
//                            return new X509Certificate[0];
//                        }}}, new SecureRandom());
//                    HttpsURLConnection.setDefaultSSLSocketFactory(
//                            context.getSocketFactory());
//
//                    URL url = new URL("https://54.183.57.169:8443/Project2_updated/connection");
//                    URLConnection connection = url.openConnection();
//
//                    String input = edit_username.getText().toString() + " " + edit_password.getText().toString();
//                    connection.setDoOutput(true);
//
//                    OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream());
//                    out.write(input);
//                    out.close();
//
//                    BufferedReader input_reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
//
//                    while((tmp_input_string=input_reader.readLine())!=null){
//                        final_input_string = final_input_string + tmp_input_string;
//                    }
//                    input_reader.close();
//                    final String final_string1 = final_input_string;
//
//                    System.out.println("Final String : " + final_string1);
//                    Log.d("Final String",final_string1);
//                    runOnUiThread(new Runnable() {
//                        @Override
//                        public void run() {
//                            if(final_string1.contains("true")){
//                                Toast.makeText(MainActivity.this, "Correct credentials",Toast.LENGTH_LONG);
//                            }else{
//                                Toast.makeText(MainActivity.this, "Incorrect credentials",Toast.LENGTH_LONG);
//                            }
//                        }
//                    });
//
//
//
//                }catch(Exception e){
//                    e.printStackTrace();
//                }
//            }
//        }).start();
//    }
//
//}
//


//New Code

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.X509TrustManager;

public class MainActivity extends AppCompatActivity implements View.OnClickListener{
    EditText inputValue=null;
    Integer doubledValue =0;
    Button doubleMe;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        inputValue = (EditText) findViewById(R.id.username);
        doubleMe = (Button) findViewById(R.id.submit_button);

        doubleMe.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {

        switch (v.getId()){
            case R.id.submit_button:

                new Thread(new Runnable() {
                    public void run() {

                        try{
                            URL url = new URL("http://54.183.57.169:8080/Project_Test_Android/connection");
                            URLConnection connection = url.openConnection();

                            String inputString = inputValue.getText().toString();
                            //inputString = URLEncoder.encode(inputString, "UTF-8");

                            Log.d("inputString", inputString);

                            connection.setDoOutput(true);
                            OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream());
                            out.write(inputString);
                            out.close();

                            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));

                            String returnString="";
                            String str="";

                            while ((returnString = in.readLine()) != null)
                            {
                                str = str+returnString;
                            }
                            final String m = str;
                            in.close();

                            runOnUiThread(new Runnable() {
                                public void run() {
                                    if(m.contains("true")) Toast.makeText(MainActivity.this,"True",Toast.LENGTH_LONG).show();
                                    inputValue.setText(m);

                                }
                            });

                        }catch(Exception e)
                        {
                            Log.d("Exception",e.toString());
                        }

                    }
                }).start();

                break;
        }
    }

}
