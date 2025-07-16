package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.ClassNum;
import bean.School;

public class ClassNumDao extends Dao {

    // クラス一覧を学校単位で取得
    public List<String> filter(School school) throws Exception {
        List<String> list = new ArrayList<>();

        Connection con = getConnection();
        String sql = "SELECT class_num FROM class_num WHERE school_cd = ? ORDER BY class_num";

        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, school.getCd());

        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            list.add(rs.getString("class_num"));
        }

        rs.close();
        st.close();
        con.close();

        return list;
    }

    // クラス取得（単体）
    public ClassNum get(String classNum, School school) throws Exception {
        ClassNum class_num = null;

        Connection con = getConnection();
        String sql = "SELECT class_num, school_cd FROM class_num WHERE school_cd = ? AND class_num = ?";

        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, school.getCd());
        st.setString(2, classNum);

        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            class_num = new ClassNum();
            class_num.setClass_num(rs.getString("class_num"));
            class_num.setSchool(school);
        }

        rs.close();
        st.close();
        con.close();

        return class_num;
    }

    // クラスの追加
    public boolean save(ClassNum classNum) throws Exception {
        Connection con = getConnection();
        String sql = "INSERT INTO class_num (school_cd, class_num) VALUES (?, ?)";

        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, classNum.getSchool().getCd());
        st.setString(2, classNum.getClass_num());

        int line = st.executeUpdate();

        st.close();
        con.close();

        return line == 1;
    }

    // クラス番号の更新（class_numを変更）
    public boolean save(ClassNum classNum, String newClassNum) throws Exception {
        Connection con = getConnection();
        String sql = "UPDATE class_num SET class_num = ? WHERE school_cd = ? AND class_num = ?";

        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, newClassNum);
        st.setString(2, classNum.getSchool().getCd());
        st.setString(3, classNum.getClass_num());

        int line = st.executeUpdate();

        st.close();
        con.close();

        return line == 1;
    }

    // クラスの削除（事前に使用状況を確認する必要あり）
    public boolean delete(String classNum, School school) throws Exception {
        Connection con = getConnection();
        String sql = "DELETE FROM class_num WHERE class_num = ? AND school_cd = ?";

        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, classNum);
        st.setString(2, school.getCd());

        int line = st.executeUpdate();

        st.close();
        con.close();

        return line == 1;
    }

    // クラスがstudentテーブルで使用されているかチェック
    public boolean isUsedClass(String classNum, School school) throws Exception {
        Connection con = getConnection();
        String sql = "SELECT COUNT(*) FROM student WHERE class_num = ? AND school_cd = ?";

        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, classNum);
        st.setString(2, school.getCd());

        ResultSet rs = st.executeQuery();
        rs.next();
        int count = rs.getInt(1);

        rs.close();
        st.close();
        con.close();

        return count > 0;
    }
}
