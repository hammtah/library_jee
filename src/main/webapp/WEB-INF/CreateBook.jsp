<%--
  Created by IntelliJ IDEA.
  User: taha
  Date: 1/8/26
  Time: 11:52 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Book • Library</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        :root {
            --bg: #F4F1EA;
            --surface: #ffffff;
            --surface-muted: #EEEAE2;
            --text: #382110;
            --text-muted: #636363;
            --text-light: #666666;
            --border: #DCD6CC;
            --primary: #382110;
            --primary-hover: #58371F;
            --focus: #8B7355;
            --danger: #dc2626;
            --shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 4px 12px rgba(0, 0, 0, 0.15);
            --radius: 8px;
            --radius-sm: 6px;
        }

        * { box-sizing: border-box; }
        html, body { height: 100%; }
        body {
            margin: 0;
            font-family: "Merriweather", Georgia, "Times New Roman", serif;
            color: var(--text);
            background-color: var(--bg);
            line-height: 1.6;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 24px 16px 60px;
        }

        .page-header {
            position: sticky;
            top: 0;
            z-index: 1000;
            background: var(--bg);
            padding: 24px 0 16px;
            margin-bottom: 32px;
            border-bottom: 2px solid var(--border);
        }
        .page-header-inner {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 16px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            flex-wrap: wrap;
        }
        .page-title {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .page-title h1 {
            margin: 0;
            font-size: 32px;
            font-weight: bold;
            color: var(--text);
            text-align: center;
        }
        .breadcrumb {
            font-size: 14px;
            color: var(--text-muted);
            font-style: italic;
        }
        .actions {
            display: flex;
            gap: 12px;
        }
        .btn {
            appearance: none;
            border: 1px solid var(--border);
            background: var(--surface);
            color: var(--text);
            padding: 8px 16px;
            border-radius: var(--radius-sm);
            font-weight: bold;
            cursor: pointer;
            transition: all .2s ease;
            font-family: inherit;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }
        .btn:hover { 
            box-shadow: var(--shadow-hover); 
            transform: translateY(-1px);
            background-color: var(--surface-muted);
        }
        .btn:focus-visible { 
            outline: 2px solid var(--focus); 
            outline-offset: 2px; 
        }
        .btn.secondary {
            background: var(--surface-muted);
            border-color: var(--border);
        }
        .btn.primary {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }
        .btn.primary:hover { 
            background: var(--primary-hover); 
            border-color: var(--primary-hover); 
        }

        .card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 340px 1fr;
            gap: 0;
        }
        @media (max-width: 900px) {
            .form-grid { grid-template-columns: 1fr; }
        }

        .panel {
            padding: 24px;
            background: var(--surface-muted);
            border-right: 1px solid var(--border);
        }
        .cover-section-title {
            font-size: 18px;
            font-weight: bold;
            color: var(--text);
            margin-bottom: 16px;
            text-align: center;
        }
        .cover-uploader {
            position: relative;
            border: 2px dashed var(--border);
            border-radius: var(--radius);
            background: var(--surface);
            padding: 20px;
            text-align: center;
            transition: border-color .2s ease, background-color .2s ease;
        }
        .cover-uploader:hover {
            border-color: var(--focus);
            background-color: #fafafa;
        }
        .cover-preview {
            aspect-ratio: 2/3;
            width: 100%;
            max-width: 240px;
            margin: 0 auto 16px;
            border-radius: var(--radius);
            overflow: hidden;
            background: linear-gradient(135deg, var(--surface-muted), #f8f8f8);
            display: grid;
            place-items: center;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
        }
        .cover-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none;
        }
        .cover-placeholder {
            color: var(--text-muted);
            font-size: 13px;
            display: grid;
            place-items: center;
            gap: 12px;
            padding: 16px;
            text-align: center;
        }
        .helper {
            font-size: 12px;
            color: var(--text-light);
            margin-top: 12px;
            font-style: italic;
        }

        .form {
            padding: 24px;
        }
        .form-title {
            font-size: 24px;
            font-weight: bold;
            color: var(--text);
            margin-bottom: 24px;
            text-align: center;
        }
        .section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-bottom: 20px;
        }
        .section.full {
            grid-template-columns: 1fr;
        }
        .field {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        label {
            font-size: 14px;
            font-weight: bold;
            color: var(--text);
            letter-spacing: 0.3px;
        }
        input[type="text"],
        input[type="number"],
        input[type="url"],
        textarea {
            width: 100%;
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            background: white;
            padding: 12px 14px;
            font-size: 14px;
            color: var(--text);
            transition: border-color .2s ease, box-shadow .2s ease;
            font-family: inherit;
        }
        textarea {
            min-height: 120px;
            resize: vertical;
            line-height: 1.5;
        }
        input::placeholder, textarea::placeholder { 
            color: var(--text-muted); 
            font-style: italic;
        }
        input:focus, textarea:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(56, 33, 16, 0.1);
        }
        .inline {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .footer-actions {
            display: flex;
            justify-content: center;
            gap: 16px;
            padding: 20px 24px;
            border-top: 1px solid var(--border);
            background: linear-gradient(180deg, rgba(255,255,255,0.9), var(--surface-muted));
        }

        .required { color: var(--danger); margin-left: 4px; }
        .counter { 
            color: var(--text-light); 
            font-size: 12px; 
            margin-left: auto;
            font-style: italic;
        }
        .hint { 
            color: var(--text-light); 
            font-size: 12px; 
            font-style: italic;
        }

        .toast {
            position: fixed; 
            right: 20px; 
            bottom: 20px;
            background: var(--text); 
            color: white;
            padding: 12px 18px; 
            border-radius: var(--radius);
            box-shadow: var(--shadow-hover);
            opacity: 0; 
            transform: translateY(12px);
            transition: opacity .3s ease, transform .3s ease;
            pointer-events: none;
            font-family: inherit;
        }
        .toast.show { opacity: 1; transform: translateY(0); }

        @media (max-width: 768px) {
            .page-header-inner {
                flex-direction: column;
                align-items: stretch;
                text-align: center;
            }
            .actions {
                justify-content: center;
            }
            .panel {
                border-right: none;
                border-bottom: 1px solid var(--border);
            }
        }
    </style>
</head>
<body>
<header class="page-header">
    <div class="page-header-inner">
        <div class="page-title">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <path d="M4 19.5v-15A2.5 2.5 0 0 1 6.5 2H20v20H6.5a2.5 2.5 0 0 1 0-5H20"/>
                <path d="M9 10h6"/>
                <path d="M9 14h6"/>
            </svg>
            <h1>Add a New Book</h1>
        </div>
<%--        <div class="breadcrumb">Home › Library › Add New Book</div>--%>
        <div class="actions">
            <a href="javascript:history.back()" class="btn secondary">Cancel</a>
            <button form="createBookForm" type="submit" class="btn primary">Save Book</button>
        </div>
    </div>
</header>

<main class="container">
    <form id="createBookForm"
          class="card"
          action="${pageContext.request.contextPath}/create"
          method="post"
          novalidate>

        <!-- utility default for nb -->
        <input type="hidden" name="nb" value="0"/>

        <div class="form-grid">
            <!-- LEFT: Cover URL and preview -->
            <aside class="panel">
                <h3 class="cover-section-title">Book Cover</h3>
                <div class="field">
<%--                    <label for="imgUrl">Cover Image URL</label>--%>
                    <div class="cover-uploader" aria-label="Book cover URL and preview">
                        <div class="cover-preview" id="coverPreview">
                            <img id="coverImg" alt="Book cover preview">
                            <div class="cover-placeholder" id="coverPlaceholder">
                                <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <path d="M4 19.5v-15A2.5 2.5 0 0 1 6.5 2H20v20H6.5a2.5 2.5 0 0 1 0-5H20"/>
                                    <path d="M9 10h6"/>
                                    <path d="M9 14h6"/>
                                </svg>
                                <div>Your book cover will appear here</div>
                                <div class="helper">Paste a direct link to see a preview of your book cover</div>
                            </div>
                        </div>
                        <input id="imgUrl" name="img" type="url" placeholder="https://example.com/book-cover.jpg">
                    </div>
                </div>
            </aside>

            <!-- RIGHT: Details -->
            <section class="form">
                <h3 class="form-title"> Book Details</h3>
                <div class="section">
                    <div class="field">
                        <label for="title">Book Title <span class="required">*</span></label>
                        <input id="title" name="title" type="text" placeholder="Enter the full title of the book" required>
                    </div>
                    <div class="field">
                        <label for="author">Author <span class="required">*</span></label>
                        <input id="author" name="author" type="text" placeholder="Author's full name" required>
                    </div>
                </div>

                <div class="section">
                    <div class="field">
                        <label for="isbn">ISBN</label>
                        <input id="isbn" name="isbn" type="text" placeholder="978-0123456789">
                    </div>
                    <div class="field">
                        <label for="genre">Genre</label>
                        <input id="genre" name="genre" type="text" placeholder="Fiction, Mystery, Romance, etc.">
                    </div>
                </div>

                <div class="section">
                    <div class="field">
                        <label for="year">Publication Year</label>
                        <input id="year" name="year" type="number" step="1" min="1000" max="2030" placeholder="2024">
                    </div>
                    <div class="field">
                        <label for="price">Price ($)</label>
                        <input id="price" name="price" type="number" step="0.01" min="0" placeholder="19.99">
                    </div>
                </div>

                <div class="section full">
                    <div class="field">
                        <div class="inline">
                            <label for="description"> Book Description</label>
                            <span class="counter" id="descCounter">0 / 2000</span>
                        </div>
                        <textarea id="description" name="description" maxlength="2000" placeholder="Write a compelling description or synopsis of the book. What's it about? What makes it special?"></textarea>
                    </div>
                </div>

                <div class="section">
                    <div class="field">
                        <label for="stock">Stock Quantity</label>
                        <input id="stock" name="stock" type="number" step="1" min="0" placeholder="0">
<%--                        <div class="hint">How many copies are available?</div>--%>
                    </div>
                </div>

<%--                <div class="footer-actions">--%>
<%--                    <a href="javascript:history.back()" class="btn secondary">← Cancel</a>--%>
<%--                    <button type="submit" class="btn primary">Save Book to Library</button>--%>
<%--                </div>--%>
            </section>
        </div>
    </form>
</main>

<div id="toast" class="toast" role="status" aria-live="polite"></div>

<script>
(function () {
    const $$ = (s, r = document) => r.querySelector(s);

    // Cover image URL preview logic
    const imgInput = $$('#imgUrl');
    const coverImg = $$('#coverImg');
    const coverPlaceholder = $$('#coverPlaceholder');

    function updateCoverFromUrl() {
        const url = (imgInput.value || '').trim();
        if (url) {
            coverImg.src = url;
            coverImg.onload = () => {
                coverImg.style.display = 'block';
                coverPlaceholder.style.display = 'none';
            };
            coverImg.onerror = () => {
                coverImg.style.display = 'none';
                coverPlaceholder.style.display = 'grid';
                toast('Unable to load image from URL.');
            };
        } else {
            coverImg.removeAttribute('src');
            coverImg.style.display = 'none';
            coverPlaceholder.style.display = 'grid';
        }
    }
    imgInput.addEventListener('input', updateCoverFromUrl);

    // Description counter
    const desc = $$('#description');
    const counter = $$('#descCounter');
    const max = parseInt(desc.getAttribute('maxlength') || '2000', 10);
    function updateCounter() {
        counter.textContent = (desc.value.length || 0) + ' / ' + max;
    }
    desc.addEventListener('input', updateCounter);
    updateCounter();

    // Basic client-side validation UX
    $$('#createBookForm').addEventListener('submit', (e) => {
        const form = e.target;
        const required = form.querySelectorAll('[required]');
        let ok = true;
        required.forEach(input => {
            if (!input.value.trim()) {
                ok = false;
                input.focus();
                input.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        });
        if (!ok) {
            e.preventDefault();
            toast('Please fill in the required fields.');
        }
    });

    // Toast helper
    const toastBox = $$('#toast');
    let toastTimer;
    function toast(msg) {
        toastBox.textContent = msg;
        toastBox.classList.add('show');
        clearTimeout(toastTimer);
        toastTimer = setTimeout(() => toastBox.classList.remove('show'), 2200);
    }
})();
</script>
</body>
</html>
