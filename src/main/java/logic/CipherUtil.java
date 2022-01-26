package logic;

import java.security.Key;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Component;

@Component
public class CipherUtil {
	private static byte[] randomKey;
	//초기화 벡터.
	//CBC 모드 : 블럭암호화시 앞 블럭의 암호문이 뒤의 블럭의 암호화시 삽입됨.
	//패딩방법 : 마지막블럭의 
	private  byte[] iv = new byte[] {
				(byte) 0x8E, 0x12, 0x39, (byte) 0x9C,
					   0x07, 0x72, 0x6F, (byte) 0x5A,
				(byte) 0x8E, 0x12, 0x39, (byte) 0x9C,
				 	   0x07, 0x72, 0x6F, (byte) 0x5A};
	static Cipher cipher; //암호화 객체로 - 암호화 객체와 복호화 객체가 같아야함.
	static {
		try {
			cipher = cipher.getInstance("AES/CBC/PKCS5Padding"); //암호화 알고리즘/블럭암호화모드/패딩방법
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	//고정키값 암호화
	public String encrypt(String plain, String key) {
		byte[] cipherMsg = new byte[1024];
		try {
			Key genKey = new SecretKeySpec(makeKey(key),"AES");
			AlgorithmParameterSpec paramSpec = new IvParameterSpec(iv); //초기화 블럭 설정.
			
			//AES 알고리즘. CBC모드, PKCS5Padding, 암호화모드, 키 설정, 초기화 벡터
			cipher.init(Cipher.ENCRYPT_MODE, genKey,paramSpec);
			cipherMsg = cipher.doFinal(plain.getBytes());//암호화실행.
		}catch(Exception e) {
			e.printStackTrace();
		}
		return byteToHex(cipherMsg).trim(); //16진수코드값의 문자열 리턴.
	}
	//고정키값 복호화
	public String descrypt(String cipherMsg, String key) {
		byte[] plainMsg = new byte[1024];
		try {
			Key genKey = new SecretKeySpec(makeKey(key),"AES"); //키 설정
			AlgorithmParameterSpec paramSpec = new IvParameterSpec(iv); //초기화 블럭 설정
			
			//AES 알고리즘. CBC모드, PKCS5Padding, 암호화모드, 키 설정, 초기화 벡터
			cipher.init(Cipher.DECRYPT_MODE, genKey,paramSpec);
			plainMsg = cipher.doFinal(hexToByte(cipherMsg.trim()));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return new String(plainMsg).trim();
	}
	
	//128비트 = 16바이트
	public byte[] makeKey(String key) {
		//key : abc1234567
		int len = key.length();
		char ch = 'A';
		for(int i=len;i<16;i++)
			key+=ch++;
		return key.substring(0,16).getBytes();
	}
	
	public String makehash(String plain) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		byte[] pbyte = plain.getBytes();
		byte[] hash = md.digest(pbyte);
		return byteToHex(hash);
	}

	public String byteToHex(byte[] hash) {
		if(hash==null) return null;
		String str = "";
		for(byte b : hash) str+=String.format("%02X", b);
		return str;
	}
	
	//16진수로 나열된 문자열값을 byte[] 배열로 리턴.
	public static byte[] hexToByte(String str) {
			if(str == null || str.length() < 2)
				return null;
			int len = str.length() / 2;
			byte[] buf = new byte[len];
			for(int i = 0; i< len; i++) {
				buf[i] = (byte) Integer.parseInt(str.substring(i * 2, i * 2 + 2),16);
			}
			return buf;
	}
	
	
}
