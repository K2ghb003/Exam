package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import bean.School;
import bean.Subject;
import bean.TestListSubject;

public class TestListSubjectDao extends Dao {

	private final String baseSql = "SELECT * FROM test left join student on test.school_cd = student.school_cd and test.student_no = student.no WHERE true";

	// postfilter
    public List<TestListSubject> postFilter(ResultSet rSet) throws Exception {
        List<TestListSubject> list = new ArrayList<>();
        while (rSet.next()) {
            TestListSubject item = new TestListSubject();
            item.setEntYear(rSet.getInt("ent_year"));
            item.setStudentNo(rSet.getString("student_no"));
            item.setStudentName(rSet.getString("name"));
            item.setClassNum(rSet.getString("class_num"));
            item.putPoint(rSet.getInt("no"), rSet.getInt("point"));
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
    public List<TestListSubject> filter(int entYear, String classNum, Subject subject, School school)
            throws Exception {

        StringBuilder sql = new StringBuilder(baseSql);
        if (entYear >= 0)       sql.append(" AND ent_year = ?");
        if (classNum != null)   sql.append(" AND test.class_num = ?");
        if (subject != null)    sql.append(" AND subject_cd = ?");
        if (school != null)     sql.append(" AND test.school_cd = ?");
        sql.append(" ORDER BY student_no, no");

        try (Connection conn = getConnection();
             PreparedStatement st = conn.prepareStatement(sql.toString())) {

            int idx = 1;
            if (entYear >= 0)      st.setInt(idx++, entYear);
            if (classNum != null)  st.setString(idx++, classNum);
            if (subject != null)   st.setString(idx++, subject.getCd());
            if (school != null)    st.setString(idx++, school.getCd());

            ResultSet rs = st.executeQuery();

            // Map<学生番号, TestListSubject> で一度まとめる
            Map<String, TestListSubject> map = new LinkedHashMap<>();
            while (rs.next()) {
                String stuNo = rs.getString("student_no");
                TestListSubject ts = map.get(stuNo);
                if (ts == null) {
                    ts = new TestListSubject();
                    ts.setEntYear(rs.getInt("ent_year"));
                    ts.setStudentNo(stuNo);
                    ts.setStudentName(rs.getString("name"));
                    ts.setClassNum(rs.getString("class_num"));
                    map.put(stuNo, ts);
                }
                // no=1,2… という評価項目ごとのポイントを put
                ts.putPoint(rs.getInt("no"), rs.getInt("point"));
            }
            return new ArrayList<>(map.values());
        }
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
