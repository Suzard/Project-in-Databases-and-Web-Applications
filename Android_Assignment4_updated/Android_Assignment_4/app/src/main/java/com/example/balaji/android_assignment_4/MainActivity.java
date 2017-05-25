package com.example.balaji.android_assignment_4;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Button;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {
    EditText edit_username, edit_password;
    Button button_submit;
    SharedPreferences shared_preference;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        edit_username = (EditText) findViewById(R.id.username);
        edit_password = (EditText) findViewById(R.id.password);
        button_submit = (Button) findViewById(R.id.submit_button);

        shared_preference = getSharedPreferences("login_preference", Context.MODE_PRIVATE);

        button_submit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                SharedPreferences.Editor editor = shared_preference.edit();
                editor.putString("username", edit_username.getText().toString());
                editor.putString("password", edit_password.getText().toString());
                editor.apply();
                editor.commit();
            }
        });
    }

    @Override
    public void onResume() {
        super.onResume();
        get_shared_preference();
//        shared_preference = getSharedPreferences("login_preference", Context.MODE_PRIVATE);
//        edit_username.setText(shared_preference.getString("username", ""));
//        edit_password.setText(shared_preference.getString("password", ""));

    }

    @Override
    public void onPause() {
        super.onPause();
        get_shared_preference();
//        shared_preference = getSharedPreferences("login_preference", Context.MODE_PRIVATE);
//        edit_username.setText(shared_preference.getString("username", ""));
//        edit_password.setText(shared_preference.getString("password", ""));
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        get_shared_preference();
    }

    @Override
    public void onStop(){
        super.onStop();
        get_shared_preference();
    }
    
    public void get_shared_preference(){
        shared_preference = getSharedPreferences("login_preference",Context.MODE_PRIVATE);
        edit_username.setText(shared_preference.getString("username",""));
        edit_password.setText(shared_preference.getString("password",""));

    }
}

