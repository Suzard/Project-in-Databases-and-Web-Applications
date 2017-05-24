package com.example.balaji.myapplication;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private TextView mTextMessage;
    private EditText username, password;
    String user_name=null, pass_word=null;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        username = (EditText) findViewById(R.id.username);
        password = (EditText) findViewById(R.id.password);

        user_name = username.getText().toString();
        pass_word = password.getText().toString();
    }

    @Override
    public void onResume(){
        super.onResume();
        username = (EditText) findViewById(R.id.username);
        password = (EditText) findViewById(R.id.password);

        username.setText(user_name);
        password.setText(pass_word);
    }

    @Override
    public void onPause(){
        super.onPause();
        username = (EditText) findViewById(R.id.username);
        password = (EditText) findViewById(R.id.password);
    }

}
