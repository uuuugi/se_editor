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

			String sql = "select name, postNum from board";
		      pstmt= conn.prepareStatement(sql);
		      
		      rs = pstmt.executeQuery();
		      
				while(rs.next()){
					forPostList tmp = new forPostList();
					tmp.setName(rs.getString("Name"));
					tmp.setNum(Integer.parseInt(rs.getString("postNum")));
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
	public ArrayList<forPostList> getPostList(String id, int n) { // PostName과 PostNum을담은 객체 arrayList를 반환
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<forPostList> postList = new ArrayList<forPostList>();
		
		try {
			conn = getConnection();

			String sql = "select name, postNum from board where id=?";
		      pstmt= conn.prepareStatement(sql);
		      
		      pstmt.setString(1, id);
		      rs = pstmt.executeQuery();
		      
				while(rs.next()){
					forPostList tmp = new forPostList();
					tmp.setName(rs.getString("Name"));
					tmp.setNum(Integer.parseInt(rs.getString("postNum")));
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
	public ArrayList<forPostList> getPostList(String title) { // PostName과 PostNum을담은 객체 arrayList를 반환
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<forPostList> postList = new ArrayList<forPostList>();
		
		try {
			conn = getConnection();

			String sql = "select name, postNum from board where name=?";
		      pstmt= conn.prepareStatement(sql);
		      
		      pstmt.setString(1, title);
		      rs = pstmt.executeQuery();
		      
				while(rs.next()){
					forPostList tmp = new forPostList();
					tmp.setName(rs.getString("Name"));
					tmp.setNum(Integer.parseInt(rs.getString("postNum")));
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

			String sql = "select id, name, text, star, postNum from board where postNum=?";
		      
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
		    rs = pstmt.executeQuery();
		      
				while(rs.next()){
					vo.setId(rs.getString("id"));
					vo.setName(rs.getString("name"));
					vo.setText(rs.getString("text"));
					vo.setNum(rs.getInt("postNum"));
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
	
	public boolean deletePost(int postNum) {
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

				String sql = "delete from board where postNum=? ";
				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, postNum);

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
	
	public boolean updatePost(int postNum, String text) {
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

				String sql = "UPDATE board SET text=? WHERE postNum=?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, text);
				pstmt.setInt(2, postNum);

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
	
	public int checkStar(int postNum, String id) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();

				String sql = "select id from star where postNum=? and id=?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, postNum);
				pstmt.setString(2, id);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()==false){
					sql = "insert into star(id, postNum) values(?,?)";
					result = 1;
				}
				else{
					sql = "delete from star where id=? and postNum=?";
					result = -1;
				}
				pstmt2 = conn.prepareStatement(sql);
				
				pstmt2.setString(1, id);
				pstmt2.setInt(2, postNum);
				pstmt2.executeUpdate();
			
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
	public int star(int postNum, String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result= 0;
		try {
			conn = getConnection();

				String sql = "select star from board where postNum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, postNum);
				
				rs = pstmt.executeQuery();
				rs.next();
				int star = rs.getInt("star");
				int checkStar=checkStar(postNum, id);
				result = checkStar;
				star +=checkStar;
				
				sql = "update board set star=? where Postnum=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, star);
				pstmt.setInt(2, postNum);
				pstmt.executeUpdate();
			
				
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
