package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Subject;
import bean.TestListSubject;

public class TestListSubjectDao extends Dao {

	private final String baseSql = "SELECT * FROM test";

	// postfilter
    public List<TestListSubject> postFilter(ResultSet rSet) throws Exception {
        List<TestListSubject> list = new ArrayList<>();
        while (rSet.next()) {
            TestListSubject item = new TestListSubject();
            item.setNum(rSet.getInt("no"));
            item.setPoint(rSet.getInt("point"));
            list.add(item);
        }
        return list;
    }

	/**
	 * getメソッド 成績を指定して成績インスタンスを1件取得する
	 *
	 * @param id:String
	 *            成績
	 * @return 成績クラスのインスタンス 存在しない場合はnull
	 * @throws Exception
	 */
	public List<TestListSubject> filtter(int entYaer, String classNum, Subject subject, School school) throws Exception {
		// 成績インスタンスを初期化
		TestListSubject test = new TestListSubject();
		// コネクションを確立
		Connection connection = getConnection();
		// プリペアードステートメント
		PreparedStatement statement = null;

//		subject.getCD();

		try {
			// プリペアードステートメントにSQL文をセット
			statement = connection.prepareStatement("select * from Test where STUDENT_NO like ?");
			// プリペアードステートメントに成績をバインド
			statement.setString(1, "%" + subject.getCd() + "%" );
			// プリペアードステートメントを実行
			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				// リザルトセットが存在する場合
				// 成績インスタンスに検索結果をセット
				test.setSubjectName(subject.getName());
				test.setSubjectCd(subject.getCd());
				test.setNum(resultSet.getInt("num"));
				test.setPoint(resultSet.getInt("point"));
			} else {
				// リザルトセットが存在しない場合
				// 成績インスタンスにnullをセット
				test = null;
			}
		} catch (Exception e) {
			throw e;
		} finally {
			// プリペアードステートメントを閉じる
			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException sqle) {
					throw sqle;
				}
			}
			// コネクションを閉じる
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException sqle) {
					throw sqle;
				}
			}
		}

		return test;
	}

	/**
	 * loginメソッド 成績とパスワードで認証する
	 *
	 * @param id:String
	 *            成績
	 * @param password:String
	 *            パスワード
	 * @return 認証成功:成績クラスのインスタンス, 認証失敗:null
	 * @throws Exception
	 */

}
