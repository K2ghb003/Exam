<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/common/base.jsp">
  <c:param name="title">学校削除確認</c:param>
  <c:param name="content">
    <section class="container mt-4">
      <h2>学校削除確認</h2>
      <p>以下の学校を削除しますか？</p>
      <p><strong>学校コード：</strong>${school.cd}</p>
      <p><strong>学校名：</strong>${school.name}</p>

      <form action="SchoolDeleteExecute.action" method="post">
        <input type="hidden" name="cd" value="${school.cd}">
        <button type="submit" class="btn btn-danger">削除する</button>
        <a href="SchoolList.action" class="btn btn-secondary">キャンセル</a>
      </form>
    </section>
  </c:param>
</c:import>
