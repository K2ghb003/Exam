<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">登録完了</c:param>
  <c:param name="scripts"></c:param>
  <c:param name="content">
    <section>
      <h2>科目の登録が完了しました。</h2>
      <p>登録された科目：<strong>${subject.name}</strong></p>
      <p><a href="SubjectCreate.action">戻る</a>　　　　　<a href="SubjectList.action">科目一覧</a></p>
    </section>
  </c:param>
</c:import>
