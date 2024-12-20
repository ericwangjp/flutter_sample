package com.example.flutter_sample

import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.content.res.AssetManager
import android.os.Bundle
import android.os.Environment
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterShellArgs
import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import java.io.IOException


class MainActivity : FlutterActivity() {
    private val TAG = "Flutter MainActivity"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.e(TAG, "onCreate: android main app start")
    }

    override fun onStart() {
        super.onStart()
        Log.e(TAG, "onStart: android - flutter")
    }

    override fun onResume() {
        super.onResume()
        Log.e(TAG, "onResume: android - flutter")
    }

    override fun onPause() {
        super.onPause()
        Log.e(TAG, "onPause: android - flutter")
    }

    override fun onStop() {
        super.onStop()
        Log.e(TAG, "onStop: android - flutter")
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.e(TAG, "onDestroy: android - flutter")
    }

//    override fun getFlutterShellArgs(): FlutterShellArgs {
//        copyLibAndWrite(this,"hotlibapp.so")
//        val flutterShellArgs =  super.getFlutterShellArgs()
//        val dir = this.getDir("libs",Activity.MODE_PRIVATE)
//        val libPath = "${dir.absolutePath+ File.separator}hotlibapp.so"
//        val libFile = File(libPath)
//        if (libFile.exists()){
//            //如果有hotlibapp文件 ,配置进去,没有则作用默认的
//            flutterShellArgs.add("--aot-shared-library-name=$libPath")
//        }
//        return flutterShellArgs
//    }
//
//    // 作用:  在手机根目录找 hotlibapp.so 文件 , 如果有则复制到 app libs 文件下, 没有则不做操作
//    private fun copyLibAndWrite(context: Context, fileName: String) {
//        try {
//            val path = Environment.getExternalStorageDirectory().absolutePath
//            val destFile2 = File("$path/$fileName")
//            if (destFile2.exists()) {
//                val dir = context.getDir("libs", MODE_PRIVATE)
//                val destFile = File(dir.absolutePath + File.separator + fileName)
//                if (destFile.exists()) {
//                    destFile.delete()
//                }
//                destFile.createNewFile()
//                val fis = FileInputStream(destFile2)
//                val fos = FileOutputStream(destFile)
//                val buffer = ByteArray(fis.available())
//                var byteCount: Int
//                while (fis.read(buffer).also { byteCount = it } != -1) {
//                    fos.write(buffer, 0, byteCount)
//                }
//                fos.flush()
//                fis.close()
//                fos.close()
//                destFile2.delete() //复制完后删除这个文件
//            }
//        } catch (e: IOException) {
//            e.printStackTrace()
//        }
//    }

//    private var asset: AssetManager? = null
//    private lateinit var amOrigin: AssetManager
//
//
//    override fun getAssets(): AssetManager {
//        if (null == asset && File(this.filesDir.absolutePath + "/app-release-1.apk").exists()) {
//            //从新的flutter工程构造一个assetManager对象给flutter。app-release-1.apk中包含了新的资源和代码
//            val info = packageManager.getPackageArchiveInfo(
//                this.filesDir.absolutePath + "/app-release-1.apk",
//                PackageManager.MATCH_UNINSTALLED_PACKAGES or PackageManager.GET_ACTIVITIES
//            )?.applicationInfo
//            info?.publicSourceDir = this.filesDir.absolutePath + "/app-release-1.apk"
//            asset = packageManager.getResourcesForApplication(info).assets
//        }
//
//        if (!::amOrigin.isInitialized) {
//            amOrigin = super.getAssets()
//        }
//
//        return asset ?: amOrigin
//    }

}
