package jd.com.stream_notifications;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.Notification;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.service.notification.NotificationListenerService;
import android.service.notification.StatusBarNotification;

/**
 * Notification listening service. Intercepts notifications if permission is given to do so.
 */
@TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
@SuppressLint({"OverrideAbstract", "Registered"})
public class NotificationListener extends NotificationListenerService {

    public static String NOTIFICATION_INTENT = "notification_event";
    public static String NOTIFICATION_PACKAGE_NAME = "package_name";
    public static String NOTIFICATION_PACKAGE_MESSAGE = "package_message";

    @TargetApi(Build.VERSION_CODES.KITKAT)
    @Override
    public void onNotificationPosted(StatusBarNotification sbn) {
        // Retrieve package name to set as title.
        String packageName = sbn.getPackageName();
        // Retrieve extra object from notification to extract payload.
        Bundle extras = sbn.getNotification().extras;
        String packageMessage = extras.getCharSequence(Notification.EXTRA_TEXT).toString();
        // Pass data from one activity to another.
        Intent intent = new Intent(NOTIFICATION_INTENT);
        intent.putExtra(NOTIFICATION_PACKAGE_NAME, packageName);
        intent.putExtra(NOTIFICATION_PACKAGE_MESSAGE, sbn.getNotification().tickerText.toString());
        sendBroadcast(intent);
    }
}