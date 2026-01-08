<%--
  Created by IntelliJ IDEA.
  User: taha
  Date: 12/25/25
  Time: 9:53 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Booki</title>
    <style>
        body {
            font-family: "Merriweather", Georgia, "Times New Roman", serif;
            max-width: 1200px;
            margin: 0 auto;
            padding: 16px;
            background-color: #F4F1EA;
        }

        h1 {
            color: #382110;
            text-align: center;
            margin-bottom: 24px;
        }

        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
            gap: 16px;
            padding: 8px;
        }

        .book-card {
            background: white;
            border-radius: 8px;
            padding: 12px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .book-cover {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 6px;
            margin-bottom: 8px;
            background-color: #EEEAE2;
        }

        .book-title {
            font-size: 16px;
            font-weight: bold;
            color: #382110;
            margin-bottom: 6px;
        }

        .book-author {
            color: #636363;
            font-style: italic;
            margin-bottom: 6px;
        }

        .book-description {
            color: #333333;
            font-size: 13px;
            margin-bottom: 10px;
            line-height: 1.4;
        }

        .book-details {
            color: #666666;
            font-size: 12px;
            margin-bottom: 10px;
        }

        .add-to-cart {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        input[type="number"] {
            width: 48px;
            padding: 4px;
            border: 1px solid #DCD6CC;
            border-radius: 3px;
        }

        input[type="submit"] {
            background-color: #382110;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 3px;
            cursor: pointer;
            font-size: 13px;
        }

        input[type="submit"]:hover {
            background-color: #58371F;
        }

        .cart {
            position: fixed;
            top: 1rem;
            right: 2rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
            border-radius: 10px;
            padding: 4px;
        }
        .cart:hover {
            cursor: pointer;
            background-color: #EEEAE2;
        }
        .cart svg {
            width: 32px;
            height: 32px;
            color: #382110;
        }
        .cart-link {
            display: block;
            color: #382110;
            text-decoration: none;
            font-weight: 700;
            font-size: 14px;
        }


        .cart-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<h1>Buy your preferred book! :)</h1>
<div class="book-grid">
    <c:forEach items="${books}" var="book">
        <div class="book-card">
            <c:set var="imgUrl" value="" />
            <c:choose>
                <c:when test="${not empty book.img}">
                    <c:set var="imgUrl" value="${book.img}" />
                </c:when>
<%--                <c:when test="${not empty book.coverUrl}">--%>
<%--                    <c:set var="imgUrl" value="${book.coverUrl}" />--%>
<%--                </c:when>--%>
<%--                <c:when test="${not empty book.coverImageUrl}">--%>
<%--                    <c:set var="imgUrl" value="${book.coverImageUrl}" />--%>
<%--                </c:when>--%>
<%--                <c:when test="${not empty book.image}">--%>
<%--                    <c:set var="imgUrl" value="${book.image}" />--%>
<%--                </c:when>--%>
<%--                <c:when test="${not empty book.cover}">--%>
<%--                    <c:set var="imgUrl" value="${book.cover}" />--%>
<%--                </c:when>--%>
            </c:choose>

            <c:choose>
                <c:when test="${not empty imgUrl}">
                    <img class="book-cover" src="${imgUrl}" alt="${book.title} cover" loading="lazy" onerror="this.onerror=null;this.src='https://placehold.co/300x450?text=No+Cover';" />
                </c:when>
                <c:otherwise>
                    <img class="book-cover" src="https://placehold.co/300x450?text=No+Cover" alt="No cover available" loading="lazy" />
                </c:otherwise>
            </c:choose>

            <div class="book-title">${book.title}</div>
            <div class="book-author">by ${book.author}</div>
            <div class="book-description">${book.description}</div>
            <div class="book-details">
                Genre: ${book.genre} | Year: ${book.year} | Price: $${book.price}
            </div>
            <form class="add-to-cart" action="<%=request.getContextPath()%>/cart" method="post">
                <input type="number" name="nb" min="1" value="1">
                <input type="hidden" name="isbn" value="${book.isbn}">
                <input type="submit" value="Add to cart">
            </form>
        </div>
    </c:forEach>
</div>

<a class="cart" href="<%=request.getContextPath()%>/cart" >
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
        <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2"/>
    </svg>
    <span class="cart-link">Go To Cart</span>
</a>

</body>
</html>