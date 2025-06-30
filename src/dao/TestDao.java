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

    private final String baseSql = "SELECT * FROM test WHERE school_cd = ?";

    public List<Test> filter(School school, Subject subject, int no) throws Exception {
        List<Test> list = new ArrayList<>();

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(baseSql + " AND subject_cd = ? AND no = ?")) {

            st.setString(1, school.getCd());
            st.setString(2, subject.getCd());
            st.setInt(3, no);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Test t = new Test();

                t.setSchool(school);
                t.setNo(rs.getInt("no"));
                t.setPoint(rs.getInt("point"));
                t.setClassNum(rs.getString("class_num"));

                Student s = new Student();
                s.setNo(rs.getString("student_no"));
                t.setStudent(s);

                Subject subj = new Subject();
                subj.setCd(rs.getString("subject_cd"));
                t.setSubject(subj);

                list.add(t);
            }

            rs.close();
        }

        return list;
    }

    // 🔁 追加: INSERT or UPDATE（重複防止）
    public boolean saveOrUpdate(Test test) throws Exception {
        String updateSql = "UPDATE test SET point = ? WHERE school_cd = ? AND student_no = ? AND subject_cd = ? AND no = ?";
        String insertSql = "INSERT INTO test (school_cd, student_no, class_num, subject_cd, no, point) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = getConnection()) {
            // まずUPDATEを試す
            try (PreparedStatement st = con.prepareStatement(updateSql)) {
                st.setInt(1, test.getPoint());
                st.setString(2, test.getSchool().getCd());
                st.setString(3, test.getStudent().getNo());
                st.setString(4, test.getSubject().getCd());
                st.setInt(5, test.getNo());

                int updated = st.executeUpdate();
                if (updated > 0) return true;
            }

            // UPDATEされなければINSERT
            try (PreparedStatement st = con.prepareStatement(insertSql)) {
                st.setString(1, test.getSchool().getCd());
                st.setString(2, test.getStudent().getNo());
                st.setString(3, test.getClassNum());
                st.setString(4, test.getSubject().getCd());
                st.setInt(5, test.getNo());
                st.setInt(6, test.getPoint());

                int inserted = st.executeUpdate();
                return inserted > 0;
            }
        }
    }
}
