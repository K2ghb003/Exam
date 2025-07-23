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
                list.add(postFilter(rs, school));
            }

            rs.close();
            st.close();
        }

        return list;
    }

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
                student = postFilter(rs, school);
            }

            rs.close();
            st.close();
        }

        return student;
    }

    public boolean save(Student student) throws Exception {
        try (Connection con = getConnection()) {
            String checkSql = "SELECT COUNT(*) FROM student WHERE no = ?";
            PreparedStatement checkSt = con.prepareStatement(checkSql);
            checkSt.setString(1, student.getNo());
            ResultSet rs = checkSt.executeQuery();

            boolean exists = false;
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
            rs.close();
            checkSt.close();

            if (exists) {
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

    public boolean promote(Student student) throws Exception {
        try (Connection con = getConnection()) {
            String checkSql = "SELECT COUNT(*) FROM student WHERE no = ? AND ent_year = ? AND school_cd = ?";
            PreparedStatement checkSt = con.prepareStatement(checkSql);
            checkSt.setString(1, student.getNo().trim());
            checkSt.setInt(2, student.getEntYear());
            checkSt.setString(3, student.getSchool().getCd());
            ResultSet rs = checkSt.executeQuery();

            boolean exists = false;
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
            rs.close();
            checkSt.close();

            if (exists) {
                return false;
            }

            String insertSql = "INSERT INTO student (no, name, ent_year, class_num, is_attend, school_cd) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement insertSt = con.prepareStatement(insertSql);
            insertSt.setString(1, student.getNo().trim());
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

    private Student postFilter(ResultSet rs, School school) throws Exception {
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