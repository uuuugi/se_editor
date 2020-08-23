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
	
	public algorithmVO getAlgorithm(int num) { // algorithm 내용 불러오기
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		algorithmVO vo = new algorithmVO();
		
		try {
			conn = getConnection();

			String sql = "select * from algorithm where algorithmNum=?;";
		      pstmt= conn.prepareStatement(sql);
		      
		      pstmt.setInt(1, num);
		      
		      rs = pstmt.executeQuery();
		      
				if(rs.next()){
					
					vo.setName(rs.getString("name"));
					vo.setExplanation(rs.getString("explanation"));
					vo.setInput(rs.getString("input"));
					vo.setOutput(rs.getString("output"));
					
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
	
	public int doesUserTry(String id, int num) { // user가 해당 알고리즘을 시도했는지 결과 확인
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = -1;
		
		try {
			conn = getConnection();

			String sql = "select * from user_algorithm_data where id=? and algorithmNum=?;";
		      pstmt= conn.prepareStatement(sql);
		      
		      pstmt.setString(1, id);
		      pstmt.setInt(2, num);
		      
		      rs = pstmt.executeQuery();
		      
				if(rs.next()){
					result = rs.getInt("result");
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

		return result;
	}
	
	public ArrayList<userAlgorithmCodeVO> getAlgorithmCodeList(String id, int num) { // user가 작성한 algorithmCode 불러오기
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<userAlgorithmCodeVO> algoritymCodeList = new ArrayList<userAlgorithmCodeVO>();
		
		try {
			conn = getConnection();

			String sql = "select * from user_algorithm_code where id=? and algorithmNum=?;";
		      pstmt= conn.prepareStatement(sql);
		      
		      pstmt.setNString(1, id);
		      pstmt.setInt(2, num);
		      
		      rs = pstmt.executeQuery();
		      
				while(rs.next()){
					userAlgorithmCodeVO tmp = new userAlgorithmCodeVO();
					tmp.setCodeNum(rs.getInt("codeNum"));
					tmp.setCode(rs.getString("code"));
					tmp.setCodeType(rs.getNString("codeType"));
					tmp.setResult(rs.getInt("result"));
					algoritymCodeList.add(tmp);
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

		return algoritymCodeList;
	}
	
	public userAlgorithmCodeVO getAlgorithmCode(String id, int codeNum) { // algorithm 내용 불러오기
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		userAlgorithmCodeVO vo = new userAlgorithmCodeVO();
		
		try {
			conn = getConnection();

			String sql = "select * from user_algorithm_code where id=? and codeNum=?;";
		      pstmt= conn.prepareStatement(sql);
		      
		      pstmt.setString(1, id);
		      pstmt.setInt(2, codeNum);
		      
		      rs = pstmt.executeQuery();
		      
				if(rs.next()){
					vo.setCodeType(rs.getString("codeType"));
					vo.setCode(rs.getNString("code"));
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
