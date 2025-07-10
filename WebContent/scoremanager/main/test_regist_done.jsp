<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">成績管理</c:param>
  <c:param name="scripts"></c:param>
  <c:param name="content">
    <section style="padding: 20px;">
      <!-- ① タイトル -->
      <h2 style="margin-bottom: 20px;">成績管理</h2>

      <!-- ② 登録完了メッセージ -->
      <div style="background-color: #a6d8a8; color: #000; padding: 12px 16px; border-radius: 6px; width: fit-content; min-width: 200px;">
        登録が完了しました
      </div>

      <!-- 間隔 -->
      <div style="height: 30px;"></div>

      <!-- ③ 戻るボタン -->
      <a href="TestRegist.action" style="margin-right: 30px; text-decoration: underline; color: #0000cc;">戻る</a>

      <!-- ④ 成績参照リンク -->
      <a href="TestList.action" style="text-decoration: underline; color: #0000cc;">成績参照</a>
    </section>
  </c:param>
</c:import>
