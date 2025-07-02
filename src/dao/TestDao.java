package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Test;

public class TestDao extends Dao {

    // 基本SQL
    public final String baseSql = "SELECT * FROM test WHERE school_cd = ?";

    // 1件取得
    public Test get(Student student, Subject subject, School school, int no) throws Exception {
        Test result = null;

        String sql = baseSql + " AND student_no = ? AND subject_cd = ? AND no = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, school.getCd());
            st.setString(2, student.getNo());
            st.setString(3, subject.getCd());
            st.setInt(4, no);

            ResultSet rs = st.executeQuery();
            List<Test> list = postFilter(rs, school);

            if (!list.isEmpty()) {
                result = list.get(0);
            }
            rs.close();
        }

        return result;
    }

    // ResultSet → Testオブジェクトのリストに変換
    private List<Test> postFilter(ResultSet rSet, School school) throws Exception {
        List<Test> list = new ArrayList<>();

        while (rSet.next()) {
            Test t = new Test();

            t.setSchool(school);
            t.setNo(rSet.getInt("no"));
            t.setPoint(rSet.getInt("point"));
            t.setClassNum(rSet.getString("class_num"));

            Student s = new Student();
            s.setNo(rSet.getString("student_no"));
            t.setStudent(s);

            Subject subj = new Subject();
            subj.setCd(rSet.getString("subject_cd"));
            t.setSubject(subj);

            list.add(t);
        }

        return list;
    }

    // 成績登録画面向けのフィルター
    public List<Test> filter(int entYear, String classNum, Subject subject, int num, School school) throws Exception {
        List<Test> list = new ArrayList<>();

        String sql = baseSql + " AND ent_year = ? AND class_num = ? AND subject_cd = ? AND no = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, school.getCd());
            st.setInt(2, entYear);
            st.setString(3, classNum);
            st.setString(4, subject.getCd());
            st.setInt(5, num);

            ResultSet rs = st.executeQuery();
            list = postFilter(rs, school);
            rs.close();
        }

        return list;
    }

    // 科目と回数で検索
    public List<Test> filter(School school, Subject subject, int no) throws Exception {
        List<Test> list = new ArrayList<>();

        String sql = baseSql + " AND subject_cd = ? AND no = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, school.getCd());
            st.setString(2, subject.getCd());
            st.setInt(3, no);

            ResultSet rs = st.executeQuery();
            list = postFilter(rs, school);
            rs.close();
        }

        return list;
    }

    // 成績リスト保存
    public boolean save(List<Test> list) throws Exception {
        try (Connection con = getConnection()) {
            for (Test t : list) {
                if (!save(t, con)) {
                    return false;
                }
            }
        }
        return true;
    }

    // 個別保存（内部用）
    private boolean save(Test test, Connection con) throws Exception {
        String updateSql = "UPDATE test SET point = ? WHERE school_cd = ? AND student_no = ? AND subject_cd = ? AND no = ?";
        String insertSql = "INSERT INTO test (school_cd, student_no, class_num, subject_cd, no, point) VALUES (?, ?, ?, ?, ?, ?)";

        // UPDATE
        try (PreparedStatement st = con.prepareStatement(updateSql)) {
            st.setInt(1, test.getPoint());
            st.setString(2, test.getSchool().getCd());
            st.setString(3, test.getStudent().getNo());
            st.setString(4, test.getSubject().getCd());
            st.setInt(5, test.getNo());

            if (st.executeUpdate() > 0) {
                return true;
            }
        }

        // INSERT
        try (PreparedStatement st = con.prepareStatement(insertSql)) {
            st.setString(1, test.getSchool().getCd());
            st.setString(2, test.getStudent().getNo());
            st.setString(3, test.getClassNum());
            st.setString(4, test.getSubject().getCd());
            st.setInt(5, test.getNo());
            st.setInt(6, test.getPoint());

            return st.executeUpdate() > 0;
        }
    }

    // 🔧 外部から使える saveOrUpdate メソッドを追加
    public boolean saveOrUpdate(Test test) throws Exception {
        try (Connection con = getConnection()) {
            return save(test, con);
        }
    }
}
