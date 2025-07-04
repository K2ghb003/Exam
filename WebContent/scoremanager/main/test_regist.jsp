<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">成績登録</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section style="padding: 20px;">
            <h2 style="border-left: 6px solid #007bff; padding-left: 10px; font-size: 20px; margin-bottom: 20px;">成績管理</h2>

            <!-- 検索フォーム -->
            <form action="TestRegist.action" method="post" style="display: flex; gap: 10px; flex-wrap: wrap; margin-bottom: 20px; align-items: center;">
                <div>
                    <label>入学年度：</label><br>
                    <select name="entYear">
                        <option value="">--------</option>
                        <c:forEach var="year" items="${entYearList}">
                            <option value="${year}" <c:if test="${param.entYear == year}">selected</c:if>>${year}</option>
                        </c:forEach>
                    </select>
                </div>

                <div>
                    <label>クラス：</label><br>
                    <select name="classNum">
                        <option value="">--------</option>
                        <c:forEach var="cnum" items="${classNumList}">
                            <option value="${cnum}" <c:if test="${param.classNum == cnum}">selected</c:if>>${cnum}</option>
                        </c:forEach>
                    </select>
                </div>

                <div>
                    <label>科目：</label><br>
                    <select name="subjectCd">
                        <option value="">--------</option>
                        <c:forEach var="subject" items="${subjectList}">
                            <option value="${subject.cd}" <c:if test="${param.subjectCd == subject.cd}">selected</c:if>>${subject.name}</option>
                        </c:forEach>
                    </select>
                    <c:if test="${not empty param.entYear or not empty param.classNum or not empty param.subjectCd or not empty param.no}">
                        <c:if test="${not empty requestScope.subjectError}">
                            <div style="color: red; font-size: 0.9rem; margin-top: 4px;">科目を選択してください。</div>
                        </c:if>
                    </c:if>
                </div>

                <div>
                    <label>回数：</label><br>
                    <select name="no">
                        <option value="">--------</option>
                        <c:forEach begin="1" end="10" var="i">
                            <option value="${i}" <c:if test="${param.no == i}">selected</c:if>>${i}</option>
                        </c:forEach>
                    </select>
                    <c:if test="${not empty param.entYear or not empty param.classNum or not empty param.subjectCd or not empty param.no}">
                        <c:if test="${not empty requestScope.noError}">
                            <div style="color: red; font-size: 0.9rem; margin-top: 4px;">回数を選択してください。</div>
                        </c:if>
                    </c:if>
                </div>

                <div style="align-self: flex-end;">
                    <input type="submit" value="検索" style="padding: 6px 14px;">
                </div>
            </form>

            <!-- 成績入力テーブル -->
            <c:if test="${not empty studentList}">
                <form action="TestRegistExecute.action" method="post">
                    <input type="hidden" name="entYear" value="${param.entYear}">
                    <input type="hidden" name="classNum" value="${param.classNum}">
                    <input type="hidden" name="subjectCd" value="${param.subjectCd}">
                    <input type="hidden" name="no" value="${param.no}">

                    <table border="1" cellpadding="8" cellspacing="0" style="border-collapse: collapse; width: 100%;">
                        <thead style="background-color: #f0f8ff;">
                            <tr>
                                <th>学生番号</th>
                                <th>氏名</th>
                                <th>得点</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="student" items="${studentList}">
                                <tr>
                                    <td>${student.no}</td>
                                    <td>${student.name}</td>
                                    <td>
                                        <input type="hidden" name="studentNo" value="${student.no}">
                                        <input type="number" name="point"
                                               value="${pointMap[student.no] != null ? pointMap[student.no] : 0}"
                                               min="0" max="100" required style="width: 60px;">
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <br>
                    <input type="submit" value="登録" style="background-color: #007bff; color: white; padding: 8px 20px; border: none; border-radius: 4px;">
                </form>
            </c:if>
        </section>
    </c:param>
</c:import>
