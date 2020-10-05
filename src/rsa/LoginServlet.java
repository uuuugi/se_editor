package rsa;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.math.BigInteger;
import java.security.PrivateKey;
import javax.crypto.Cipher;
import javax.servlet.http.HttpSession;
import java.util.Base64;

import member.*;
/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        String securedUsername = request.getParameter("securedUsername");
        String securedPassword = request.getParameter("securedPassword");
        memberDAO dao = new memberDAO();
        memberVO vo = new memberVO();         
         
        HttpSession session = request.getSession();
        PrivateKey privateKey = (PrivateKey) session.getAttribute("__rsaPrivateKey__");
        session.removeAttribute("__rsaPrivateKey__"); // 키의 재사용을 막는다. 항상 새로운 키를 받도록 강제.
 
        if (privateKey == null) {
            throw new RuntimeException("암호화 비밀키 정보를 찾을 수 없습니다.");
        }
        try {
        	
            vo.setId(decryptRsa(privateKey, securedUsername));
            vo.setPw(decryptRsa(privateKey, securedPassword));
            
            String loginResult = dao.dologin(vo);
            
        	if("user".equals(loginResult)){
        		session.setAttribute("id", vo.getId());
        	}else if("master".equals(loginResult)){
        		session.setAttribute("id", vo.getId());
        		session.setAttribute("authority", loginResult);
        	}
        	else if("pwMiss".equals(loginResult)){
        		request.setAttribute("err", "pwMiss");
        	}else if("idMiss".equals(loginResult)){
        		request.setAttribute("err", "idMiss");
        	}
            
            request.getRequestDispatcher("doLogin.jsp").forward(request, response);
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage(), ex);
        }
         
    }
 
    private String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA");
        byte[] encryptedBytes = hexToByteArray(securedValue);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
        return decryptedValue;
    }
 
   
     // 16진 문자열을 byte 배열로 변환한다.
     
    public static byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) {
            return new byte[]{};
        }
 
        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte)Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }
 
    
    //BigInteger를 사용해 hex를 byte[] 로 바꿀 경우 음수 영역의 값을 제대로 변환하지 못하는 문제가 있다.
   
    @Deprecated
    public static byte[] hexToByteArrayBI(String hexString) {
        return new BigInteger(hexString, 16).toByteArray();
    }
 
        public static String base64Encode(byte[] data) throws Exception {
        String encoded = Base64.getEncoder().encodeToString(data);
        return encoded;
    }
 
    public static byte[] base64Decode(String encryptedData) throws Exception {
        byte[] decoded = Base64.getDecoder().decode(encryptedData);
        return decoded;
    }
 
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
 
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
 
 
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
