<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">クラス編集</c:param>
  <c:param name="content">
    <h1>クラス編集</h1>

    <c:if test="${not empty error}">
      <div style="color: red; background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 10px; border-radius: 5px;">
        ${error}
      </div>
    </c:if>

    <form action="ClassEditExecute.action" method="post">
      <div>
        <label>現在のクラス番号：</label><br>
        <input type="text" name="old_class_num" value="${param.old_class_num != null ? param.old_class_num : old_class_num}" readonly />
      </div>
      <br>
      <div>
        <label>新しいクラス番号：</label><br>
        <input type="text" name="new_class_num" />
      </div>
      <br>
      <button type="submit">更新</button>
      <a href="ClassList.action"><button type="button">戻る</button></a>
    </form>
  </c:param>
</c:import>
