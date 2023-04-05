package com.example.huo_la_la

import android.app.Application
import android.content.Context
import android.os.Bundle
import com.baidu.mapapi.SDKInitializer
import com.baidu.mapapi.base.BmfMapApplication
import com.baidu.mapapi.common.BaiduMapSDKException
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(saveInstanceState: Bundle?) {
        super.onCreate(saveInstanceState)

        // 初始化sdk
        SDKInitializer.setAgreePrivacy(applicationContext, true)
        SDKInitializer.initialize(applicationContext)
    }
}
