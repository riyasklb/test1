package com.example.test1

import android.media.AudioManager
import android.media.MediaPlayer
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.IOException

class MainActivity : FlutterActivity() {
    private val CHANNEL = "calls"
    private lateinit var player: MediaPlayer

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        player = MediaPlayer().apply {
            setAudioStreamType(AudioManager.STREAM_MUSIC)
            try {
                setDataSource("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3")
                prepareAsync()
            } catch (e: IOException) {
                e.printStackTrace()
            }

            setOnPreparedListener {
                it.start()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getSessionID" -> result.success(player.audioSessionId)
                "playSong" -> {
                    player.prepareAsync() // Ensure media player is prepared
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }
}
