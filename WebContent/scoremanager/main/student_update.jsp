<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>
  <c:param name="content">
    <h2>学生情報変更</h2>

    <form action="StudentUpdateExecute.action" method="post">
      <table>
        <tr><th>入学年度</th><td>${student.entYear}</td></tr>
        <tr><th>学生番号</th><td>${student.no}<input type="hidden" name="no" value="${student.no}"/></td></tr>
        <tr>
          <th>氏名</th>
          <td>
            <input type="text" name="name" value="${student.name}" />
            <c:if test="${not empty errors.name}">
              <span style="color:red">${errors.name}</span>
            </c:if>
          </td>
        </tr>
        <tr>
          <th>クラス</th>
          <td>
            <select name="classNum">
              <option value="">--</option>
              <c:forEach var="c" items="${classNumList}">
                <option value="${c}" <c:if test="${student.classNum == c}">selected</c:if>>${c}</option>
              </c:forEach>
            </select>
          </td>
        </tr>
        <tr>
          <th>在学中</th>
          <td>
            <input type="checkbox" name="isAttend" value="true" <c:if test="${student.attend}">checked</c:if>> 在学中
          </td>
        </tr>
      </table>

      <button type="submit">変更</button>
      <a href="StudentList.action">戻る</a>
    </form>
  </c:param>
</c:import>
