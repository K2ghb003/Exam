package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Subject;

public class SubjectDao extends Dao {
	/**
	 * getメソッド 学校コードを指定して学校インスタンスを１件取得する
	 *
	 * @param cd:String
	 *            学校コード
	 * @return 学校クラスのインスタンス 存在しない場合はnull
	 * @throws Exception
	 */
	public Subject get(String cd, School school) throws Exception {
		// 学校インスタンスを初期化
		Subject subject = new Subject();
		// データベースへのコネクションを確率
		Connection connection = getConnection();
		// プリペアードステートメント
		PreparedStatement statement = null;

		try {
			// プリペアードステートメントにSQL文をセット
			statement = connection.prepareStatement("select * from subject where cd = ?");
			// プリペアードステートメントに学校コードをバインド
			statement.setString(1, cd);
			// プリペアードステートメントを実行
			ResultSet rSet = statement.executeQuery();

			if (rSet.next()) {
				// リザルトセットが存在する場合
				// 学校インスタンスに学校コードと学校名をセット
				subject.setCd(rSet.getString("cd"));
				subject.setName(rSet.getString("name"));
				subject.setSchool(school);
//				System.out.println("YES");
			} else {
				// 存在しない場合
				// 学校インスタンスにnullをセット
				subject = null;
//				System.out.println("NO");
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
		return subject;
	}

	public List<Subject> filter(School school) throws Exception {
		// 学校インスタンスを初期化

		// データベースへのコネクションを確率
		Connection connection = getConnection();
		// プリペアードステートメント
		PreparedStatement statement = null;

		List<Subject> list = new ArrayList<Subject>();

		try {
			// プリペアードステートメントにSQL文をセット
			statement = connection.prepareStatement("SELECT * FROM SUBJECT WHERE SCHOOL_CD = ?");
			// プリペアードステートメントに学校コードをバインド
			statement.setString(1, school.getCd());
			// プリペアードステートメントを実行
			ResultSet rSet = statement.executeQuery();

			while (rSet.next()) {
				// リザルトセットが存在する場合
				Subject subject = new Subject();
				// 学校インスタンスに学校コードと学校名をセット
				subject.setCd(rSet.getString("cd"));
				subject.setName(rSet.getString("name"));
				subject.setSchool(school);
//				System.out.println(subject.getCd());
//
				list.add(subject);
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
		return list;
	}

	public boolean save(Subject subject) throws Exception {
		// データベースへのコネクションを確率
		Connection connection = getConnection();
		// プリペアードステートメント
		PreparedStatement statement = null;

		try {
			// プリペアードステートメントにSQL文をセット
			statement = connection.prepareStatement("select cd from subject where cd=?");
			// プリペアードステートメントに学校コードをバインド
			statement.setString(1, subject.getCd());
			// プリペアードステートメントを実行
			ResultSet rSet = statement.executeQuery();



			if (rSet.next()) {
				boolean bool = false;
				try {
					// プリペアードステートメントにSQL文をセット
					statement = connection.prepareStatement("update subject set name=? where cd=?");
					// プリペアードステートメントに学校コードをバインド
					statement.setString(1, subject.getName());
					statement.setString(2, subject.getCd());
					// プリペアードステートメントを実行
					int line = statement.executeUpdate();



					if (line>0) {
						// ラインに値が存在する場合
						bool = true;

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
				return bool;
			} else{
				boolean success = false;
				try {
					statement = connection.prepareStatement("INSERT INTO subject (cd, name, school_cd) VALUES (?, ?, ?)");

					statement.setString(1, subject.getCd());
					statement.setString(2, subject.getName());
					statement.setString(3, subject.getSchool().getCd());

					int rows = statement.executeUpdate();
					success = (rows > 0);

				} catch (SQLException e) {
					e.printStackTrace();  // エラー内容をTomcatログに出力
					success = false;
				} finally {
					if (statement != null) try { statement.close(); } catch (SQLException e) { throw e; }
					if (connection != null) try { connection.close(); } catch (SQLException e) { throw e; }
				}

				return success;
			}
		} catch (Exception e) {
			throw e;
		}
	}


	public boolean delete(Subject subject) throws Exception {
		// データベースへのコネクションを確率
		Connection connection = getConnection();
		// プリペアードステートメント
		PreparedStatement statement = null;

		boolean bool = false;

		try {
			// プリペアードステートメントにSQL文をセット
			statement = connection.prepareStatement("delete from subject where cd=?");
			// プリペアードステートメントに学校コードをバインド
			statement.setString(1, subject.getCd());
			// プリペアードステートメントを実行
			int line = statement.executeUpdate();



			if (line>0) {
				// ラインに値が存在する場合
				bool = true;

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
		return bool;
	}
}
