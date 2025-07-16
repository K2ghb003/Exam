<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">クラス編集</c:param>

  <c:param name="scripts">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
  </c:param>

  <c:param name="content">
    <section class="container mt-5">
      <h2 class="mb-4">クラス編集</h2>

      <!-- エラーメッセージ表示 -->
      <!-- <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
      </c:if> -->

      <form action="ClassEditExecute.action" method="post">

        <!-- 現在のクラス番号（hiddenでも渡す） -->
        <div class="form-group mb-3">
          <label>現在のクラス番号：</label>
          <input type="text" class="form-control" value="${classnum.class_num}" readonly>
          <input type="hidden" name="class_num" value="${classnum.class_num}">
        </div>

        <!-- 新しいクラス番号 -->
        <div class="form-group mb-3">
          <label for="new_class_num">新しいクラス番号：</label>
          <input type="text" class="form-control" id="new_class_num" name="new_class_num" value="" required>
        </div>

        <!-- ボタン -->
        <div class="form-group">
          <button type="submit" class="btn btn-primary">更新</button>
          <a href="ClassList.action" class="btn btn-secondary">戻る</a>
        </div>
      </form>
    </section>
  </c:param>
</c:import>
