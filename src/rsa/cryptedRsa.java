package rsa;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class cryptedRsa {
	/**
	 * 복호화를 위한 클래스
	 * @param privateKey	개인 키값
	 * @param securedValue 	해석할 문자
	 * @return
	 * @throws Exception
	 */
	public static String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception{
		System.out.println("will decrypt : "+ securedValue);
		Cipher cipher = Cipher.getInstance("RSA");
		byte[] encryptedBytes = hexToByteArray(securedValue);
		cipher.init(Cipher.DECRYPT_MODE, privateKey);
		byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
		String decryptedValue = new String(decryptedBytes,"utf-8");
		return decryptedValue;
	}
	/**
	 * 16진 문자열을 byte 배열로 변환
	 * @param hex
	 * @return
	 */
	public static byte[] hexToByteArray(String hex) {
		if(hex == null || hex.length()%2 !=0) {
			System.out.println("값이 없습니다.");
		}
		
		byte[] bytes = new byte[hex.length()/2];
		for(int i=0;i<hex.length();i+=2) {
			byte value = (byte)Integer.parseInt(hex.substring(i,i+2),16);
			bytes[(int)Math.floor(i/2)] = value;
		}
		return bytes;
	}
	/**
	 * 암호화를 위한 키값 생성
	 * @param request
	 * @param response
	 * @param path
	 * @throws NoSuchAlgorithmException
	 */
	@SuppressWarnings("unused")
	public static void encryptRsa(HttpServletRequest request, HttpServletResponse response, String path) throws NoSuchAlgorithmException{
		KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
		generator.initialize(2048);

		KeyPair keypair = generator.genKeyPair();
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");

		PublicKey publicKey = keypair.getPublic();
		PrivateKey privateKey = keypair.getPrivate();

		//세션에 개인키 등록
		HttpSession session = request.getSession();
		session.setAttribute("_rsaPrivateKey_", privateKey);

		String publicKeyModulus = "";
		String publicKeyExponent = "";
		PublicKey publicK = keypair.getPublic();

		try {
			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec)keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			publicKeyModulus = publicSpec.getModulus().toString(16);
			publicKeyExponent = publicSpec.getPublicExponent().toString(16);
			
			request.setAttribute("publicKeyModulus", publicKeyModulus);
			request.setAttribute("publicKeyExponent", publicKeyExponent);
			
			request.getRequestDispatcher(path).forward(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
