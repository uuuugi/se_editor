package code;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class codeDAO {

	private Connection getConnection() throws SQLException {
		Connection conn = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 드라이버 로딩
			String url = "jdbc:mysql://localhost/seEditor?serverTimezone=UTC";
			// DB url 설정 및 시간설정
			// ?serverTimezone=UTC시간설정부분
			conn = DriverManager.getConnection(url, "root", "1324");
			// DB url +id + pw
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패");
		} catch (SQLException e) {
			System.out.println("오류: " + e);
		}
		return conn;
	}

	public boolean insertCode(codeVO vo) {
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

				String sql = "INSERT INTO workspace (user_id, codeName, codeType, code) VALUES (?,?,?,?)";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, vo.getUser_id());
				pstmt.setString(2, vo.getCodeName());
				pstmt.setString(3, vo.getCodeType());
				pstmt.setString(4, vo.getCode());

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
	
	public String getCode(String id, String codeName) {
		String code = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();

				String sql = "SELECT code FROM workspace WHERE user_id=? AND codeName=?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, id);
				pstmt.setString(2, codeName);
				rs = pstmt.executeQuery();
				if(rs.next())
					code = rs.getString("code");
			
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

		return code;
	}
	
	public String getCodeType(String id, String codeName) {
		String codeType = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();

				String sql = "SELECT codetype FROM workspace WHERE user_id=? AND codeName=?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, id);
				pstmt.setString(2, codeName);
				rs = pstmt.executeQuery();
				if(rs.next())
					codeType = rs.getString("codetype");
			
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

		return codeType;
	}
	
	public ArrayList<String> getCodeListC(String user_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> codeList = new ArrayList<String>();
		
		try {
			conn = getConnection();

			String sql = "select codeName from workspace where user_id=? AND codeType=?;";
		      pstmt= conn.prepareStatement(sql);
		      pstmt.setString(1, user_id);
		      pstmt.setString(2, "c");
		      
		      rs = pstmt.executeQuery();
		      
				while(rs.next()){
					codeList.add(rs.getString("codeName"));
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

		return codeList;
	}
	
	public ArrayList<String> getCodeListJava(String user_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> codeList = new ArrayList<String>();
		
		try {
			conn = getConnection();

			String sql = "select codeName from workspace where user_id=? AND codeType=?;";
		      pstmt= conn.prepareStatement(sql);
		      pstmt.setString(1, user_id);
		      pstmt.setString(2, "java");
		      
		      rs = pstmt.executeQuery();
		      
				while(rs.next()){
					codeList.add(rs.getString("codeName"));
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

		return codeList;
	}
	
	public ArrayList<String> getCodeListPython(String user_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> codeList = new ArrayList<String>();
		
		try {
			conn = getConnection();

			String sql = "select codeName from workspace where user_id=? AND codeType=?;";
		      pstmt= conn.prepareStatement(sql);
		      pstmt.setString(1, user_id);
		      pstmt.setString(2, "python");
		      
		      rs = pstmt.executeQuery();
		      
				while(rs.next()){
					codeList.add(rs.getString("codeName"));
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

		return codeList;
	}
	
	public ArrayList<String> getCodeListJavascript(String user_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> codeList = new ArrayList<String>();
		
		try {
			conn = getConnection();

			String sql = "select codeName from workspace where user_id=? AND codeType=?;";
		      pstmt= conn.prepareStatement(sql);
		      pstmt.setString(1, user_id);
		      pstmt.setString(2, "javaScript");
		      
		      rs = pstmt.executeQuery();
		      
				while(rs.next()){
					codeList.add(rs.getString("codeName"));
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

		return codeList;
	}
	
	public boolean updateCode(codeVO vo) {
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

			String sql="UPDATE workspace SET code=?, codeType=? WHERE user_id=? AND codeName=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getCode());
			pstmt.setString(2, vo.getCodeType());
			pstmt.setString(3, vo.getUser_id());
			pstmt.setString(4, vo.getCodeName());
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
	
	public String codeNameCheck(String id, String codeName) { // db의 코드이름과 입력받은 코드이름이 같은지 확인하는 함수 같으면 flase 중복이 없으면 true
																// 리턴
		String result = "true";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();

			String sql = "select codeName from workspace where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			while (rs.next()) {// db에 있는 코드이름과 현재 입력받은 코드 이름이 같은지 확인
				String dbCodeName = rs.getString("codeName");
				if (dbCodeName.equals(codeName)) {
					result = "false";// 중복됨
					break;
				}
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
}
