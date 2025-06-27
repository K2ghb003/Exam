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

    // --- フィルター：school のみ ---
    public List<Student> filter(School school) throws Exception {
        String sql = baseSql + " ORDER BY ent_year, no";
        try (Connection con = getConnection()) {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, school.getCd());
            ResultSet rs = st.executeQuery();
            return postFilter(rs, school);
        }
    }

    // --- フィルター：school + isAttend ---
    public List<Student> filter(School school, boolean isAttend) throws Exception {
        String sql = baseSql + " AND is_attend = ? ORDER BY ent_year, no";
        try (Connection con = getConnection()) {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, school.getCd());
            st.setBoolean(2, isAttend);
            ResultSet rs = st.executeQuery();
            return postFilter(rs, school);
        }
    }

    // --- フィルター：school + entYear + isAttend ---
    public List<Student> filter(School school, int entYear, boolean isAttend) throws Exception {
        String sql = baseSql + " AND ent_year = ? AND is_attend = ? ORDER BY ent_year, no";
        try (Connection con = getConnection()) {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, school.getCd());
            st.setInt(2, entYear);
            st.setBoolean(3, isAttend);
            ResultSet rs = st.executeQuery();
            return postFilter(rs, school);
        }
    }

    // --- フィルター：school + entYear + classNum + isAttend ---
    public List<Student> filter(School school, int entYear, String classNum, boolean isAttend) throws Exception {
        String sql = baseSql + " AND ent_year = ? AND class_num = ? AND is_attend = ? ORDER BY ent_year, no";
        try (Connection con = getConnection()) {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, school.getCd());
            st.setInt(2, entYear);
            st.setString(3, classNum);
            st.setBoolean(4, isAttend);
            ResultSet rs = st.executeQuery();
            return postFilter(rs, school);
        }
    }

    // --- 共通処理：ResultSet から List<Student> に変換 ---
    private List<Student> postFilter(ResultSet rs, School school) throws Exception {
        List<Student> list = new ArrayList<>();
        while (rs.next()) {
            list.add(mapResultSetToStudent(rs, school));
        }
        rs.close();
        return list;
    }

    // --- 学生1人取得 ---
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

    // --- 学生の保存（新規 or 更新）---
    public boolean save(Student student) throws Exception {
        try (Connection con = getConnection()) {
            // 存在チェック
            String checkSql = "SELECT COUNT(*) FROM student WHERE no = ?";
            PreparedStatement checkSt = con.prepareStatement(checkSql);
            checkSt.setString(1, student.getNo());
            ResultSet rs = checkSt.executeQuery();

            boolean exists = rs.next() && rs.getInt(1) > 0;
            rs.close();
            checkSt.close();

            if (exists) {
                // 更新（ent_year は更新しない）
                String updateSql = "UPDATE student SET name = ?, class_num = ?, is_attend = ?, school_cd = ? WHERE no = ?";
                PreparedStatement updateSt = con.prepareStatement(updateSql);
                updateSt.setString(1, student.getName());
                updateSt.setString(2, student.getClassNum());
                updateSt.setBoolean(3, student.isAttend());
                updateSt.setString(4, student.getSchool().getCd());
                updateSt.setString(5, student.getNo());

                int result = updateSt.executeUpdate();
                updateSt.close();
                return result == 1;
            } else {
                // 新規登録
                String insertSql = "INSERT INTO student (no, name, ent_year, class_num, is_attend, school_cd) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement insertSt = con.prepareStatement(insertSql);
                insertSt.setString(1, student.getNo());
                insertSt.setString(2, student.getName());
                insertSt.setInt(3, student.getEntYear());
                insertSt.setString(4, student.getClassNum());
                insertSt.setBoolean(5, student.isAttend());
                insertSt.setString(6, student.getSchool().getCd());

                int result = insertSt.executeUpdate();
                insertSt.close();
                return result == 1;
            }
        }
    }

    // --- 入学年度一覧の取得 ---
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

    // --- 結果セットをStudentオブジェクトへ変換 ---
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
