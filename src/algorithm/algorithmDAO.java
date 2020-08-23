package algorithm;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class algorithmDAO {
	private Connection getConnection() throws SQLException {
	    Connection conn = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//드라이버 로딩
			String url = "jdbc:mysql://localhost/seeditor?serverTimezone=UTC";
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
	
	public ArrayList<algorithmVO> getAlgorithmList() { // algorithm 전체 불러오기
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<algorithmVO> algoritymList = new ArrayList<algorithmVO>();
		
		try {
			conn = getConnection();

			String sql = "select * from algorithm ;";
		      pstmt= conn.prepareStatement(sql);
		      
		      rs = pstmt.executeQuery();
		      
				while(rs.next()){
					algorithmVO tmp = new algorithmVO();
					tmp.setName(rs.getNString("name"));
					tmp.setNum(rs.getInt("algorithmNum"));
					
					algoritymList.add(tmp);
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

		return algoritymList;
	}
	
	public ArrayList<algorithmVO> getAlgorithmList(String category) { // algorithm 카테고리별로 불러오기
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<algorithmVO> algoritymList = new ArrayList<algorithmVO>();
		
		try {
			conn = getConnection();

			String sql = "select * from algorithm where category=?;";
		      pstmt= conn.prepareStatement(sql);
		      
		      pstmt.setNString(1, category);
		      
		      rs = pstmt.executeQuery();
		      
				while(rs.next()){
					algorithmVO tmp = new algorithmVO();
					tmp.setName(rs.getNString("name"));
					tmp.setNum(rs.getInt("algorithmNum"));
					
					algoritymList.add(tmp);
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

		return algoritymList;
	}
}
