package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Student;

public class StudentDao extends Dao {

    private final String baseSql = "SELECT * FROM student WHERE school_cd = ?";

    // 学生一覧の絞り込み取得
    public List<Student> filter(School school, Integer entYear, String classNum, Boolean isAttend) throws Exception {
        List<Student> list = new ArrayList<>();

        try (Connection con = getConnection()) {
            StringBuilder sql = new StringBuilder(baseSql);

            if (entYear != null) {
                sql.append(" AND ent_year = ?");
            }
            if (classNum != null && !classNum.isEmpty()) {
                sql.append(" AND class_num = ?");
            }
            if (isAttend != null) {
                sql.append(" AND is_attend = ?");
            }

            sql.append(" ORDER BY ent_year, no");

            PreparedStatement st = con.prepareStatement(sql.toString());

            int idx = 1;
            st.setString(idx++, school.getCd());
            if (entYear != null) {
                st.setInt(idx++, entYear);
            }
            if (classNum != null && !classNum.isEmpty()) {
                st.setString(idx++, classNum);
            }
            if (isAttend != null) {
                st.setBoolean(idx++, isAttend);
            }

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                list.add(mapResultSetToStudent(rs, school));
            }

            rs.close();
            st.close();
        }

        return list;
    }

    // 学生1人取得
    public Student get(String no) throws Exception {
        Student student = null;

        try (Connection con = getConnection()) {
            String sql = "SELECT * FROM student WHERE no = ?";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, no);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                School school = new School();
                school.setCd(rs.getString("school_cd"));
                student = mapResultSetToStudent(rs, school);
            }

            rs.close();
            st.close();
        }

        return student;
    }

    // 学生を新規登録
    public boolean save(Student student) throws Exception {
        try (Connection con = getConnection()) {
            String sql = "INSERT INTO student (no, name, ent_year, class_num, is_attend, school_cd) " +
                         "VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, student.getNo());
            st.setString(2, student.getName());
            st.setInt(3, student.getEntYear());
            st.setString(4, student.getClassNum());
            st.setBoolean(5, student.isAttend());
            st.setString(6, student.getSchool().getCd());

            int result = st.executeUpdate();
            st.close();

            return result == 1;
        }
    }

    // 学生情報を更新
    public boolean update(Student student) throws Exception {
        try (Connection con = getConnection()) {
            String sql = "UPDATE student SET name = ?, ent_year = ?, class_num = ?, is_attend = ?, school_cd = ? WHERE no = ?";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, student.getName());
            st.setInt(2, student.getEntYear());
            st.setString(3, student.getClassNum());
            st.setBoolean(4, student.isAttend());
            st.setString(5, student.getSchool().getCd());
            st.setString(6, student.getNo());

            int result = st.executeUpdate();
            st.close();

            return result == 1;
        }
    }

    // 入学年度一覧の取得
    public List<Integer> getEntYearList(School school) throws Exception {
        List<Integer> list = new ArrayList<>();

        try (Connection con = getConnection()) {
            String sql = "SELECT DISTINCT ent_year FROM student WHERE school_cd = ? ORDER BY ent_year";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, school.getCd());
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                list.add(rs.getInt("ent_year"));
            }

            rs.close();
            st.close();
        }

        return list;
    }

    // 結果セットをStudentオブジェクトへ変換
    private Student mapResultSetToStudent(ResultSet rs, School school) throws Exception {
        Student s = new Student();
        s.setNo(rs.getString("no"));
        s.setName(rs.getString("name"));
        s.setEntYear(rs.getInt("ent_year"));
        s.setClassNum(rs.getString("class_num"));
        s.setAttend(rs.getBoolean("is_attend"));
        s.setSchool(school);
        return s;
    }
}
