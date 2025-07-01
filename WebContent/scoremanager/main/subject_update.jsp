<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.Subject" %>

<%
    Subject subject = (Subject) request.getAttribute("subject");
    request.setAttribute("cd", subject.getCd());  // EL式で使うために設定
    request.setAttribute("name", subject.getName());
%>

<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>

    <c:param name="scripts"></c:param>

    <c:param name="content">
        <section>
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">科目情報変更</h2>

            <form action="SubjectUpdateExecute.action" method="post" style="width: 100%;">
                <label>科目コード</label>
                <p>
                    <input type="text" name="cd" value="${cd}"
                           readonly
                           style="width: 100%; box-sizing: border-box; padding: 6px; font-size: 16px;">
                </p>

                <label>科目名</label>
                <p>
                    <input type="text" name="name" value="${name}"
                           required placeholder="科目名を入力してください" maxlength="20"
                           style="width: 100%; box-sizing: border-box; padding: 6px; font-size: 16px;">
                </p>

                <input type="submit"
                        style="background-color: #007bff; color: white; border: none;
                               padding: 6px 16px; border-radius: 4px; font-size: 16px;">
                    変更
                />

                <a href="SubjectList.action">戻る</a>
            </form>
        </section>
    </c:param>
</c:import>
