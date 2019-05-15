package com.example.flutterhotel

import android.os.Bundle
import com.example.asr_plugin.AsrPlugin
import com.example.asr_plugin.BlueToothPlugin

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        registerSelfPlugin()
        registerBlueToothPlugin()
    }

    private fun registerSelfPlugin() {
        AsrPlugin.registerWith(registrarFor("com.example.asr_plugin.AsrPlugin"))
    }

    private fun registerBlueToothPlugin() {
        BlueToothPlugin.registerWith(registrarFor("import com.example.asr_plugin.BlueToothPlugin"))
    }
}
