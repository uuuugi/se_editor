package member;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class memberDAO {
	private Connection getConnection() throws SQLException {
	    Connection conn = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//드라이버 로딩
			String url = "jdbc:mysql://localhost/fuck?serverTimezone=UTC";
			//DB url 설정 및 시간설정
			//?serverTimezone=UTC시간설정부분
			conn = DriverManager.getConnection(url, "root", "1324");
			//DB url +id + pw
		}
		catch(ClassNotFoundException e){
            System.out.println("드라이버 로딩 실패");
        }
        catch(SQLException e){
            System.out.println("오류: " + e);
        }
		return conn;
	}

	public int dologin(memberVO vo) {
			Connection conn=null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
			int result = -1; 
			
			try {
				conn= getConnection();
				
				String sql = "select user_pw from user where user_id=?";
			    
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getId());
		        rs = pstmt.executeQuery();
				
				if (rs.next()) {
		        	result=0;//id 가 있다 (id 와 pw 가 일치하지 않을경우 변경되지 않고 반환됨)
		            String dbpw= rs.getString("user_pw");//db의 pw 저장
		            if(dbpw.equals(vo.getPw()))
		           	result=1;// 로그인 성공
		        } 
		        else 
		        	result = -1; //id가 존재하지 않음

				rs.close();
				pstmt.close();
				
			}
			catch(SQLException e) {
				System.out.println("오류: " + e);
			}
			
		return result;
	}

}
