package inquiry;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class inquiryDAO {
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
	
	public boolean insertInquiry(String id, String title, String text) { // 문의하기 저장
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

				String sql = "INSERT INTO inquiry (id, title, text) VALUES (?,?,?)";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, id);
				pstmt.setString(2, title);
				pstmt.setString(3, text);

				pstmt.executeUpdate();

				result = true;
			
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
	
	public inquiryVO getInquiry(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		inquiryVO vo = new inquiryVO();
		
		try {
			conn = getConnection();

			String sql = "select id, title, text, Num from inquiry where inquiryNum=?";
		      
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
		    rs = pstmt.executeQuery();
		      
				while(rs.next()){
					vo.setId(rs.getString("id"));
					vo.setTitle(rs.getString("title"));
					vo.setText(rs.getString("text"));
					vo.setNum(rs.getInt("inquiryNum"));
					}
			
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

		return vo;
	}
	
	public ArrayList<inquiryVO> getInquiryList() { 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<inquiryVO> inquiryList = new ArrayList<inquiryVO>();
		
		try {
			conn = getConnection();

			String sql = "select * from inquiry";
		      pstmt= conn.prepareStatement(sql);
		      
		      
		      rs = pstmt.executeQuery();
		      
				while(rs.next()){
					if(rs.getInt("comment")==1)
						continue;
					
					inquiryVO tmp = new inquiryVO();
					tmp.setId(rs.getString("id"));
					tmp.setTitle(rs.getString("title"));
					tmp.setText(rs.getString("text"));
					tmp.setNum(rs.getInt("inquiryNum"));
					tmp.setComment(rs.getInt("comment"));
					
					inquiryList.add(tmp);
					}
			
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

		return inquiryList;
	}
	
	public ArrayList<inquiryVO> getInquiryList(String id) { 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<inquiryVO> inquiryList = new ArrayList<inquiryVO>();
		
		try {
			conn = getConnection();

			String sql = "select * from inquiry where id=?";
		      pstmt= conn.prepareStatement(sql);
		      
		      pstmt.setString(1, id);
		      
		      rs = pstmt.executeQuery();
		      
				while(rs.next()){
					inquiryVO tmp = new inquiryVO();
					tmp.setId(rs.getString("id"));
					tmp.setTitle(rs.getString("title"));
					tmp.setText(rs.getString("text"));
					tmp.setNum(rs.getInt("inquiryNum"));
					tmp.setComment(rs.getInt("comment"));
					
					inquiryList.add(tmp);
					}
			
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

		return inquiryList;
	}
	
	public boolean insertInquiryComment(String id, String title, String text, int inquiryNum) { 
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

				String sql = "INSERT INTO inquiryComment (id, title, text, inquiryNum) VALUES (?,?,?,?)";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, id);
				pstmt.setString(2, title);
				pstmt.setString(3, text);
				pstmt.setInt(4, inquiryNum);

				pstmt.executeUpdate();
				
				sql = "update inquiry set comment=? where inquiryNum=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, 1);
				pstmt.setInt(2, inquiryNum);
				
				pstmt.executeUpdate();
				
				result = true;
			
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
	public inquiryCommentVO getInquiryComment(int inquiryNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		inquiryCommentVO vo = new inquiryCommentVO();
		
		try {
			conn = getConnection();

			String sql = "select id, title, text, inquiryNum from inquiryComment where inquiryNum=?";
		      
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, inquiryNum);
			
		    rs = pstmt.executeQuery();
		      
				while(rs.next()){
					vo.setId(rs.getString("id"));
					vo.setTitle(rs.getString("title"));
					vo.setText(rs.getString("text"));
					vo.setInquiryNum(rs.getInt("inquiryNum"));
					}
			
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

		return vo;
	}
}
