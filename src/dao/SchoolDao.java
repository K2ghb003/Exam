package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;

public class SchoolDao extends Dao {

    /**
     * 学校コードを指定して、1件の学校情報を取得する
     */
    public School get(String cd) throws Exception {
        School school = null;

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement("SELECT * FROM school WHERE cd = ?")) {

            st.setString(1, cd);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    school = new School();
                    school.setCd(rs.getString("cd"));
                    school.setName(rs.getString("name"));
                }
            }
        }

        return school;
    }

    /**
     * 全ての学校情報を取得する
     */
    public List<School> getAll() throws Exception {
        List<School> list = new ArrayList<>();

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement("SELECT * FROM school ORDER BY cd");
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                School school = new School();
                school.setCd(rs.getString("cd"));
                school.setName(rs.getString("name"));
                list.add(school);
            }
        }

        return list;
    }

    /**
     * 学校の登録または更新
     * 存在すれば UPDATE、存在しなければ INSERT
     */
    public boolean save(School school, String mode, String old_cd) throws Exception {
        try (Connection con = getConnection()) {
            // 既に存在するかチェック
//            String checkSql = "SELECT COUNT(*) FROM school WHERE cd = ?";
//            try (PreparedStatement checkSt = con.prepareStatement(checkSql)) {
//                checkSt.setString(1, school.getCd());
//                ResultSet rs = checkSt.executeQuery();
//                rs.next();
//                int count = rs.getInt(1);
//                rs.close();

//                if (count > 0) {
//        	System.out.println("UPDATE SCHOOL SET CD = "+school.getCd()+", NAME = "+school.getName()+" WHERE CD = "+old_cd);
                if ("update".equals(mode)) {
                    // 存在する → UPDATE
                    String updateSql = "UPDATE SCHOOL SET CD = ?, NAME = ? WHERE CD = ?";
                    try (PreparedStatement updateSt = con.prepareStatement(updateSql)) {
                    	updateSt.setString(1, school.getCd());
                    	updateSt.setString(2, school.getName());
                        updateSt.setString(3, old_cd);
                        return updateSt.executeUpdate() == 1;
                    }
                } else {
                    // 存在しない → INSERT
                    String insertSql = "INSERT INTO school (cd, name) VALUES (?, ?)";
                    try (PreparedStatement insertSt = con.prepareStatement(insertSql)) {
                        insertSt.setString(1, school.getCd());
                        insertSt.setString(2, school.getName());
                        return insertSt.executeUpdate() == 1;
                    }
                }
            }
        }
//    }

    /**
     * 学校の削除
     */
    public boolean delete(String cd) throws Exception {
        String sql = "DELETE FROM school WHERE cd = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, cd);
            int line = st.executeUpdate();
            return line == 1;
        }
    }

    /**
     * 学校が使用中か確認（studentテーブルに存在するかチェック）
     */
    public boolean isUsedSchool(String cd) throws Exception {
        String sql = "SELECT COUNT(*) FROM student WHERE school_cd = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, cd);
            try (ResultSet rs = st.executeQuery()) {
                rs.next();
                int count = rs.getInt(1);
                return count > 0;
            }
        }
    }
}
