<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>
  <c:param name="scripts"></c:param>
  <c:param name="content">
    <section class="me-4">
      <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">学生情報登録</h2>

      <p class="alert alert-success px-4 py-3" role="alert" style="background-color: #d4edda; border-color: #c3e6cb; color: #155724;">
        登録が完了しました
      </p>

      <div style="margin-left: 1rem; margin-top: 1rem;">
        <a href="StudentCreate.action" style="margin-right: 1.5rem; color: #007bff; text-decoration: none;">戻る</a>
        <a href="StudentList.action" style="color: #007bff; text-decoration: none;">学生一覧</a>
      </div>
    </section>
  </c:param>
</c:import>
