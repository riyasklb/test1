package com.example.test1

import android.media.AudioManager
import android.media.MediaPlayer
import android.media.audiofx.Visualizer
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.IOException

class MainActivity : FlutterActivity() {
    private val CHANNEL = "calls"
    private lateinit var player: MediaPlayer
    private var visualizer: Visualizer? = null

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
                "getSessionID" -> {
                    val sessionId = player.audioSessionId
                    if (sessionId == -1) {
                        result.error("INVALID_SESSION_ID", "Audio session ID is invalid", null)
                        return@setMethodCallHandler
                    }
                    result.success(sessionId)
                    setupVisualizer(sessionId)
                }
                "playSong" -> {
                    if (!player.isPlaying) {
                        player.start()
                    }
                    result.success(null)
                }
                "pauseSong" -> {
                    if (player.isPlaying) {
                        player.pause()
                    }
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun setupVisualizer(sessionId: Int) {
        try {
            visualizer?.release()
            visualizer = Visualizer(sessionId).apply {
                captureSize = Visualizer.getCaptureSizeRange()[1]
                setDataCaptureListener(object : Visualizer.OnDataCaptureListener {
                    override fun onWaveFormDataCapture(visualizer: Visualizer, waveform: ByteArray, samplingRate: Int) {
                        val waveformData = waveform.map { it.toInt() and 0xFF }
                        sendDataToFlutter("onWaveformVisualization", waveformData)
                    }

                    override fun onFftDataCapture(visualizer: Visualizer, fft: ByteArray, samplingRate: Int) {
                        val fftData = fft.map { it.toInt() and 0xFF }
                        sendDataToFlutter("onFftVisualization", fftData)
                    }
                }, Visualizer.getMaxCaptureRate() / 2, true, true)
                enabled = true
            }
        } catch (e: Exception) {
            Log.e("VisualizerError", "Error initializing Visualizer", e)
            sendDataToFlutter("visualizerError", listOf())
        }
    }

    private fun sendDataToFlutter(method: String, data: List<Int>) {
        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger ?: return, CHANNEL)
            .invokeMethod(method, mapOf("fft" to data))
    }

    override fun onDestroy() {
        super.onDestroy()
        player.release()
        visualizer?.release()
    }
}
