package www;

import java.io.BufferedInputStream;
import java.sql.*;
import java.util.*;

public class CommentMgr {

	private DBConnectionMgr pool;
	private static final String  SAVEFOLDER = "C:/jsp/swuapp/homepage/WebContent/www/fileupload";
	private static final String ENCTYPE = "euc-kr";
	private static int MAXSIZE = 5*1024*1024;
	
	public CommentMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insertComment(int num, String text, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert comment values(null, ?, ?, ?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, text);
			pstmt.setString(3, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public void deleteComment(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from comment where num=?;";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public Vector<CommentBean> getComments(int bnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		Vector<CommentBean> vlist=new Vector<CommentBean>();
		
		try {
			con = pool.getConnection();
			sql = "select * from comment where bnum=?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				CommentBean bean=new CommentBean();
				bean.setNum(rs.getInt("num"));
				bean.setBnum(rs.getInt("bnum"));
				bean.setText(rs.getString("text"));
				bean.setId(rs.getString("id"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return vlist;
	}
}
