package member;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import code.codeVO;

public class memberDAO {
	private Connection getConnection() throws SQLException {
	    Connection conn = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//드라이버 로딩
			String url = "jdbc:mysql://localhost/seEditor?serverTimezone=UTC";
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

	public void dbinsert(memberVO vo) {         // 회원가입시 정보를  db에 입력하기 위한 메소드
	      Connection conn=null;
	       PreparedStatement pstmt = null;
	       int rs = 0;
	       
	       try {
	         conn= getConnection();
	         
	         String sql = "insert into user values (?, ?, ?, ?, ?, ?);";
	         String sql2 = "insert into workspaceUserData values (?);";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1,vo.id);
	         pstmt.setString(2,vo.pw);
	         pstmt.setString(3,vo.name);
	         pstmt.setString(4,vo.mail);
	         pstmt.setString(5,vo.info);
	         pstmt.setString(6,"user");
	         
	         rs = pstmt.executeUpdate();
	         
	         pstmt.close();
	         
	         pstmt = conn.prepareStatement(sql2);
	         pstmt.setString(1,vo.id);
	         rs = pstmt.executeUpdate();
	         
	         
	         pstmt.close();
	         conn.close();
	         
	         
	      } catch (SQLException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	      }
	   }
	
	public int idCheck(String id){   // id를 db에서 확인하여 중복 체크하기 위한 메소드
        int rst = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
         conn = getConnection();
         String sql = "select * from user where user_id=?";
         ps = conn.prepareStatement(sql);
         ps.setString(1, id);
         rs = ps.executeQuery();
         if(rs.next()){
          rst = 1;
         }
        }catch(Exception e){
         e.printStackTrace();
        }
        return rst;
       }
	
	public String dologin(memberVO vo) {
			Connection conn=null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
			String result = "fail"; 
			
			try {
				conn= getConnection();
				
				String sql = "select user_pw , user_authority from user where user_id=?";
			    
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getId());
		        rs = pstmt.executeQuery();
				
				if (rs.next()) {
		        	result="pwMiss";//id 가 있다 (id 와 pw 가 일치하지 않을경우 변경되지 않고 반환됨)
		            String dbpw= rs.getString("user_pw");//db의 pw 저장
		            if(dbpw.equals(vo.getPw()))
		            	result=rs.getNString("user_authority");// 로그인 성공시 유저의 권한을 반환
		        } 
		        else 
		        	result = "idMiss"; //id가 존재하지 않음

				rs.close();
				pstmt.close();
				
			}
			catch(SQLException e) {
				System.out.println("오류: " + e);
			}
			
		return result;
	}

	public memberVO getMemberVO(String id) { // 사용자의 정보를 반환함
			memberVO user=new memberVO();
			Connection conn=null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
	       
	       try {
	         conn= getConnection();
	         
	         String sql = "select user_name, user_Email, user_introduce from user where user_id=?";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1,id);
	         
	         rs = pstmt.executeQuery();
	         
	         rs.next();
	         user.setName(rs.getString("user_name"));
	         user.setMail(rs.getString("user_Email"));
	         user.setInfo(rs.getString("user_introduce"));
	         
	         pstmt.close();
	         conn.close();
	         
	         
	      } catch (SQLException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	      }
	       return user;
	   }
	
	public boolean modifyUserInfo(memberVO vo) { // user의 정보를 수정하는 메소드
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();
			
			if(vo.getPw().isEmpty()==true)
			{
				String sql="UPDATE user SET user_name=?, user_email=?, user_introduce=? WHERE user_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getName());
				pstmt.setString(2, vo.getMail());
				pstmt.setString(3, vo.getInfo());
				pstmt.setString(4, vo.getId());
			}
			else
			{
				String sql="UPDATE user SET user_name=?, user_pw=?, user_email=?, user_introduce=? WHERE user_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getName());
				pstmt.setString(2, vo.getPw());
				pstmt.setString(3, vo.getMail());
				pstmt.setString(4, vo.getInfo());
				pstmt.setString(5, vo.getId());
			}
			pstmt.executeUpdate();
				
			result= true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return result;
	}
	
	public String findId(memberVO vo) { // name과 eamil을 받아 id를 반환, 일치하는 id가 없다면 fail이라는 문자열 반환
		String result="fail";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();

			String sql="select user_id from user where user_name=? and user_email=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getMail());
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
				result= rs.getString("user_id");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return result;
	}
	
	public boolean changePw(memberVO vo) { // pw를 바꾸는 메소드
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();

			String sql="UPDATE user SET user_pw=? WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getPw());
			pstmt.setString(2, vo.getId());
			pstmt.executeUpdate();
				
			result= true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return result;
	}
	public boolean checkIdnEmail(memberVO vo) { // user의 정보를 수정하는 메소드
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs;

		try {
			conn = getConnection();

			String sql="select user_id from user where user_id=? and user_email=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getMail());

			rs = pstmt.executeQuery();

			if(rs.next())
				result= true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return result;
	}
	
}