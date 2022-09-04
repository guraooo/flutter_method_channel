package com.example.flutter_methodchannel

import android.os.Build
import android.provider.Settings
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    companion object {
        private const val CHANNEL = "com.example.flutterMethodchannel/test"
        private const val METHOD_FETCH_DEVICE_NAME = "fetchDeviceName"
        private const val METHOD_CALCULATE = "calculate"
    }

    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { methodCall, result ->
            when (methodCall.method) {
                METHOD_FETCH_DEVICE_NAME -> {
                    val deviceName =
                        Settings.Global.getString(contentResolver, Settings.Global.DEVICE_NAME)
                    Log.d("MainActivity", "deviceName = $deviceName")
                    result.success(deviceName)
                }
                METHOD_CALCULATE -> {
                    val number: Int = methodCall.arguments<Int>() ?: 0
                    val calculated = number.times(number)
                    result.success(calculated)
                }
                else -> result.notImplemented()
            }
        }
    }
}
