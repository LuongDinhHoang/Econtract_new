package com.bkav.econtract;

import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;

import androidx.activity.result.ActivityResult;
import androidx.activity.result.ActivityResultCallback;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import android.security.keystore.KeyGenParameterSpec;
import android.security.keystore.KeyPermanentlyInvalidatedException;
import android.security.keystore.KeyProperties;
import android.util.Log;

import androidx.biometric.BiometricPrompt;
import androidx.core.content.ContextCompat;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;


import android.widget.Toast;

import java.io.IOException;
import java.nio.charset.Charset;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;
import java.util.Arrays;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.Executor;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

//Bkav Nhungltk: biometric yeu cau hien thi tren fragment
public class MainActivity extends FlutterFragmentActivity {
    private static final String CHANNEL = "com.bkav.econtract.dev/bkav_channel";
    private MethodChannel channel;
    private static final String KEY_NAME = "Bkav";
    private Executor executor;
    public static String ID_CARD= "id_card";
    public static String FULL_NAME= "full_name";
    public static String GENDER= "gender";
    public static String NATION= "nation";
    public static String HOME_TOWN= "home_town";
    public static String PERMANENT_ADDRESS= "permanent_address";
    public static String EXPIRY= "expiry";
    public static String DATETIME_CREATE= "datetime_create";
    public static String TRANSACTIONID= "transactionId";
    public static String DAY_OF_BIRTH= "day_of_birth";
    public static String BASE64FRONT= "base64Front";
    public static String CATEGORYID= "category";
    public static String DAY_OF_ISSUE= "day_of_issue";
    public static String PLACE_OF_ISSUE= "place_of_issue";
    public static String DATETIME_CREATE_BACK= "datetime_create";
    public static String ETHNIC= "ethnic";
    public static String RELIGION= "religion";
    public static String TRANSACTIONID_BACK= "transactionId";
    public static String BASE64BACK= "base64Back";
    public static String RESULT= "result";
    public static String BASE64FACE= "base64Face";
    public static String TOKEN_KEY= "token_key";
    public static String TOKEN_ID= "token_id";
    public static String ACCESS_TOKEN= "accessToken";
    public static String TYPE_ID = "typeID";
    public static  String FACE_DETECT = "face_detect";

    private MethodChannel.Result result;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        executor = ContextCompat.getMainExecutor(this);
        new BiometricPrompt(MainActivity.this,
                executor, new BiometricPrompt.AuthenticationCallback() {
            @Override
            public void onAuthenticationError(int errorCode,
                                              @NonNull CharSequence errString) {
                super.onAuthenticationError(errorCode, errString);
            }

            @Override
            public void onAuthenticationSucceeded(
                    @NonNull BiometricPrompt.AuthenticationResult result) {
                // NullPointerException is unhandled; use Objects.requireNonNull().
                byte[] encryptedInfo = new byte[0];
                try {
                    encryptedInfo = Objects.requireNonNull(Objects.requireNonNull(result.getCryptoObject()).getCipher()).doFinal(
                            "ok".getBytes(Charset.defaultCharset()));
                } catch (BadPaddingException | IllegalBlockSizeException e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void onAuthenticationFailed() {
                super.onAuthenticationFailed();
            }
        });
    }
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        //BKAV HoangLD call native android
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                (call, result) -> {
                    this.result = result;
                    Map<String, String> dataSend =call.arguments();
                    String accessToken = dataSend.get("accessToken");
                    int typeId = -1;
                    try {
                        typeId = Integer.parseInt(dataSend.get("typeId"));
                    }catch(Exception e){

                    }

                    if(call.method.equals("getStatusBiometricAndroid")){
                        Cipher cipher = null;
                        try {
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                                cipher = getCipher();
                            }
                        } catch (NoSuchPaddingException | NoSuchAlgorithmException e) {
                            e.printStackTrace();
                        }
                        SecretKey secretKey = null;
                        try {
                            secretKey = getSecretKey();
                        } catch (UnrecoverableKeyException | NoSuchAlgorithmException | KeyStoreException e) {
                            e.printStackTrace();
                        }
                        if (secretKey == null){
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                                generateSecretKey(new KeyGenParameterSpec.Builder(
                                        KEY_NAME,
                                        KeyProperties.PURPOSE_ENCRYPT | KeyProperties.PURPOSE_DECRYPT)
                                        .setBlockModes(KeyProperties.BLOCK_MODE_CBC)
                                        .setEncryptionPaddings(KeyProperties.ENCRYPTION_PADDING_PKCS7)
                                        .setUserAuthenticationRequired(true)
                                        // Invalidate the keys if the user has registered a new biometric
                                        // credential, such as a new fingerprint. Can call this method only
                                        // on Android 7.0 (API level 24) or higher. The variable
                                        .setInvalidatedByBiometricEnrollment(true)
                                        .build());
                            }
                        }
                        try {
                            assert cipher != null;
                            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
                            result.success(false);
                        } catch (KeyPermanentlyInvalidatedException e) {
                            result.success(true);
                        } catch (InvalidKeyException e) {
                            result.success(true);
                            e.printStackTrace();
                        }

                    }
                    else if(call.method.equals("resetBiometricAndroid")){
                        generateSecretKey(new KeyGenParameterSpec.Builder(
                                KEY_NAME,
                                KeyProperties.PURPOSE_ENCRYPT | KeyProperties.PURPOSE_DECRYPT)
                                .setBlockModes(KeyProperties.BLOCK_MODE_CBC)
                                .setEncryptionPaddings(KeyProperties.ENCRYPTION_PADDING_PKCS7)
                                .setUserAuthenticationRequired(true)
                                // Invalidate the keys if the user has registered a new biometric
                                // credential, such as a new fingerprint. Can call this method only
                                // on Android 7.0 (API level 24) or higher. The variable
                                .setInvalidatedByBiometricEnrollment(true)
                                .build());
                    }else if(call.method.equals("dateCallBackAndroidEKYC")){
                        Intent intent = null;
                        try {
                            intent = new Intent(this, Class.forName("com.bkav.bkavekyc.activity.IdentityInfoActivity"));
                            intent.putExtra(ACCESS_TOKEN, accessToken);
//                            intent.putExtra("color", "#333333");
//                            intent.putExtra("titleSize", "22dp");
//                            intent.putExtra("contentSize", "22dp");
//                            intent.putExtra("colorBackground", "#333333");
                            intent.putExtra(TYPE_ID, typeId);
                            intent.putExtra(FACE_DETECT, true);
                            getResult.launch(intent);
                        } catch (ClassNotFoundException e) {
                            e.printStackTrace();
                        }
                        //result.success(transactionIdBack);
                    }



                }
        );
    }
    ActivityResultLauncher<Intent> getResult= registerForActivityResult(new ActivityResultContracts.StartActivityForResult(), new ActivityResultCallback<ActivityResult>() {
        @Override
        public void onActivityResult(ActivityResult resultCode) {
//            System.out.println("HanhNTHe ===================== onActivityResult ===============   resultCode " + resultCode );
            if(resultCode.getResultCode()== RESULT_OK){
                Intent data= resultCode.getData();
//                String cardID= data.getStringExtra(ID_CARD);
//                String fullName= data.getStringExtra(FULL_NAME);
//                String gender= data.getStringExtra(GENDER);
//                String nation= data.getStringExtra(NATION);
//                String homeTown= data.getStringExtra(HOME_TOWN);
//                String permanentAddress= data.getStringExtra(PERMANENT_ADDRESS);
//                String expiry= data.getStringExtra(EXPIRY);
//                String dateTimeCreate= data.getStringExtra(DATETIME_CREATE);
//                String transactionId= data.getStringExtra(TRANSACTIONID);
//                String dayOfBirth= data.getStringExtra(DAY_OF_BIRTH);
//                String categoryID= data.getStringExtra(CATEGORYID);
//                String daOfIssue= data.getStringExtra(DAY_OF_ISSUE);
//                String placeOfIssue= data.getStringExtra(PLACE_OF_ISSUE);
//                String dateTimeCreateBack= data.getStringExtra(DATETIME_CREATE_BACK);
//                String ethnic= data.getStringExtra(ETHNIC);
//                String religion= data.getStringExtra(RELIGION);
                String transactionIdBack= data.getStringExtra(TRANSACTIONID_BACK);
//                String resultAuthentication= data.getStringExtra(RESULT);
//                String pathFront= data.getStringExtra("SharedPreferencesKey.BASE64FRONT");
//                String pathBack= data.getStringExtra(SharedPreferencesKey.BASE64BACK);
//                String pathFace= data.getStringExtra(SharedPreferencesKey.BASE64FACE);
                result.success(transactionIdBack);
            }
        }
    });

    private void generateSecretKey(KeyGenParameterSpec keyGenParameterSpec) {
        KeyGenerator keyGenerator = null;
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                keyGenerator = KeyGenerator.getInstance(
                        KeyProperties.KEY_ALGORITHM_AES, "AndroidKeyStore");
            }
        } catch (NoSuchAlgorithmException | NoSuchProviderException e) {
            e.printStackTrace();
        }
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                assert keyGenerator != null;
                keyGenerator.init(keyGenParameterSpec);
            }
        } catch (InvalidAlgorithmParameterException e) {
            e.printStackTrace();
        }
        assert keyGenerator != null;
        keyGenerator.generateKey();
    }

    private SecretKey getSecretKey() throws UnrecoverableKeyException, KeyStoreException, NoSuchAlgorithmException {
        KeyStore keyStore = null;
        try {
            keyStore = KeyStore.getInstance("AndroidKeyStore");
        } catch (KeyStoreException e) {
            e.printStackTrace();
        }

        // Before the keystore can be accessed, it must be loaded.
        try {
            assert keyStore != null;
            keyStore.load(null);
        } catch (CertificateException | NoSuchAlgorithmException | IOException e) {
            e.printStackTrace();
        }
        return ((SecretKey) keyStore.getKey(KEY_NAME, null));
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    private Cipher getCipher() throws NoSuchPaddingException, NoSuchAlgorithmException {
        return Cipher.getInstance(KeyProperties.KEY_ALGORITHM_AES + "/"
                + KeyProperties.BLOCK_MODE_CBC + "/"
                + KeyProperties.ENCRYPTION_PADDING_PKCS7);
    }

}
