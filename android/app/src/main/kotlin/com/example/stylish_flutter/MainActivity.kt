package com.example.stylish_flutter

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

class MainActivity: FlutterActivity() {

  private val CHANNEL = "TestMethodChannel"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
       if (call.method == "getTestPlatformString") {

        val testPlatformString = getTestPlatformString()

        result.success(testPlatformString)
        
      } else {
        result.notImplemented()
      }
    }
  }

  private fun getTestPlatformString(): String {

    return "This is「Android」Test Method Channel String"
  }
}
