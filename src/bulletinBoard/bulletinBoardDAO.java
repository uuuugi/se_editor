package bulletinBoard;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class bulletinBoardDAO {
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
	
	public boolean insertPost(bulletinBoardVO vo) { // 게시글 저장
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

				String sql = "INSERT INTO board (id, Name, text) VALUES (?,?,?)";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, vo.getId());
				pstmt.setString(2, vo.getName());
				pstmt.setString(3, vo.getText());

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
	
	public ArrayList<forPostList> getPostList() { // PostName과 PostNum을담은 객체 arrayList를 반환
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<forPostList> postList = new ArrayList<forPostList>();
		
		try {
			conn = getConnection();

			String sql = "select name, num from board";
		      pstmt= conn.prepareStatement(sql);
		      
		      rs = pstmt.executeQuery();
		      
				while(rs.next()){
					forPostList tmp = new forPostList();
					tmp.setName(rs.getString("Name"));
					tmp.setNum(Integer.parseInt(rs.getString("num")));
					postList.add(tmp);
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

		return postList;
	}
	public bulletinBoardVO getPost(int num) { // PostName과 PostNum을담은 객체 arrayList를 반환
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		bulletinBoardVO vo = new bulletinBoardVO();
		
		try {
			conn = getConnection();

			String sql = "select id, name, text, star, num from board where num=?";
		      
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
		    rs = pstmt.executeQuery();
		      
				while(rs.next()){
					vo.setId(rs.getString("id"));
					vo.setName(rs.getString("name"));
					vo.setText(rs.getString("text"));
					vo.setNum(rs.getInt("num"));
					vo.setStar(rs.getInt("star"));
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
	
	public boolean deletePost(int num) {
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

				String sql = "delete from board where num=? ";
				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, num);

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
}
