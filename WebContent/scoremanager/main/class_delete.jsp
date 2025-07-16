<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">クラス削除確認</c:param>
  <c:param name="scripts"></c:param>
  <c:param name="content">
    <div class="content">
      <h2>クラス削除確認</h2>

      <c:if test="${not empty error}">
        <div style="background-color: #f8d7da; padding: 1em; margin-bottom: 1em; border: 1px solid #f5c2c7; color: #842029;">
          ${error}
        </div>
      </c:if>

      <p>以下のクラスを削除してもよろしいですか？</p>
      <p><strong>クラス番号：</strong> ${class_num}</p>

      <form action="ClassDeleteExecute.action" method="post">
        <input type="hidden" name="class_num" value="${class_num}" />
        <button type="submit" style="background-color: #dc3545; color: white; padding: 0.5em 1em;">削除</button>
        <a href="ClassList.action" style="margin-left: 1em; padding: 0.5em 1em; background-color: #6c757d; color: white; text-decoration: none;">キャンセル</a>
      </form>
    </div>
  </c:param>
</c:import>
