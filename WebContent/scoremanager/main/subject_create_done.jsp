<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">登録完了</c:param>
  <c:param name="scripts"></c:param>
  <c:param name="content">

    <style>
      h2 {
        background-color: #f1f1f1;
        padding: 10px;
        font-size: 22px;
        border-left: 5px solid #007bff;
        margin-bottom: 20px;
      }

	</style>

    <section>
      <h2>科目情報登録</h2>
      <p style="background-color:#80bd9e; text-align:center ">登録が完了しました</p>

      <p><a href="SubjectCreate.action">戻る</a>　　　　　<a href="SubjectList.action">科目一覧</a></p>
    </section>
  </c:param>
</c:import>
