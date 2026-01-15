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
            --bg: #f8fafc;
            --surface: #ffffff;
            --surface-muted: #f3f4f6;
            --text: #111827;
            --text-muted: #6b7280;
            --border: #e5e7eb;
            --primary: #2e7d32;
            --primary-600: #256f2a;
            --primary-50: #ecfdf5;
            --focus: #34d399;
            --danger: #dc2626;
            --shadow: 0 10px 20px rgba(0,0,0,0.06), 0 6px 6px rgba(0,0,0,0.05);
            --radius: 14px;
            --radius-sm: 10px;
        }

        * { box-sizing: border-box; }
        html, body { height: 100%; }
        body {
            margin: 0;
            font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, "Apple Color Emoji", "Segoe UI Emoji";
            color: var(--text);
            background: linear-gradient(180deg, var(--bg), #ffffff);
        }

        .container {
            max-width: 1100px;
            margin: 32px auto;
            padding: 0 20px 60px;
        }

        .page-header {
            position: sticky;
            top: 0;
            z-index: 10;
            background: rgba(255,255,255,0.75);
            -webkit-backdrop-filter: blur(10px);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border);
        }
        .page-header-inner {
            max-width: 1100px;
            margin: 0 auto;
            padding: 14px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
        }
        .page-title {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .page-title h1 {
            margin: 0;
            font-size: 20px;
            letter-spacing: 0.2px;
        }
        .breadcrumb {
            font-size: 12px;
            color: var(--text-muted);
        }
        .actions {
            display: flex;
            gap: 10px;
        }
        .btn {
            appearance: none;
            border: 1px solid var(--border);
            background: var(--surface);
            color: var(--text);
            padding: 10px 14px;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all .15s ease;
        }
        .btn:hover { box-shadow: var(--shadow); transform: translateY(-1px); }
        .btn:focus-visible { outline: 3px solid var(--focus); outline-offset: 2px; }
        .btn.secondary {
            background: var(--surface-muted);
        }
        .btn.primary {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }
        .btn.primary:hover { background: var(--primary-600); border-color: var(--primary-600); }

        .card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 320px 1fr;
            gap: 22px;
            margin-top: 22px;
        }
        @media (max-width: 900px) {
            .form-grid { grid-template-columns: 1fr; }
        }

        .panel {
            padding: 18px;
        }
        .cover-uploader {
            position: relative;
            border: 2px dashed var(--border);
            border-radius: var(--radius-sm);
            background: var(--surface-muted);
            padding: 14px;
            text-align: center;
            transition: border-color .2s ease, background-color .2s ease;
        }
        .cover-preview {
            aspect-ratio: 2/3;
            width: 100%;
            max-width: 260px;
            margin: 8px auto 12px;
            border-radius: 10px;
            overflow: hidden;
            background: linear-gradient(135deg, #e5e7eb, #f3f4f6);
            display: grid;
            place-items: center;
            border: 1px solid var(--border);
        }
        .cover-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none;
        }
        .cover-placeholder {
            color: var(--text-muted);
            font-size: 12px;
            display: grid;
            place-items: center;
            gap: 8px;
            padding: 10px;
        }
        .helper {
            font-size: 12px;
            color: var(--text-muted);
            margin-top: 8px;
        }

        .form {
            padding: 18px;
        }
        .section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
            margin-bottom: 14px;
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
            font-size: 12px;
            font-weight: 700;
            color: var(--text);
            letter-spacing: 0.2px;
        }
        input[type="text"],
        input[type="number"],
        input[type="url"],
        textarea {
            width: 100%;
            border: 1px solid var(--border);
            border-radius: 10px;
            background: white;
            padding: 12px 12px;
            font-size: 14px;
            color: var(--text);
            transition: border-color .15s ease, box-shadow .15s ease;
        }
        textarea {
            min-height: 140px;
            resize: vertical;
            line-height: 1.5;
        }
        input::placeholder, textarea::placeholder { color: #9ca3af; }
        input:focus, textarea:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 4px rgba(52, 211, 153, 0.2);
        }
        .inline {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .footer-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            padding: 16px 18px;
            border-top: 1px solid var(--border);
            background: linear-gradient(180deg, rgba(255,255,255,0), rgba(255,255,255,0.9) 20%, #fff 60%);
            border-bottom-left-radius: var(--radius);
            border-bottom-right-radius: var(--radius);
            position: sticky;
            bottom: 0;
            z-index: 5;
        }

        .required { color: var(--danger); margin-left: 4px; }
        .counter { color: var(--text-muted); font-size: 12px; margin-left: auto; }
        .hint { color: var(--text-muted); font-size: 12px; }

        .toast {
            position: fixed; right: 16px; bottom: 16px;
            background: var(--text); color: #fff;
            padding: 10px 14px; border-radius: 10px;
            box-shadow: var(--shadow);
            opacity: 0; transform: translateY(8px);
            transition: opacity .2s ease, transform .2s ease;
            pointer-events: none;
        }
        .toast.show { opacity: 1; transform: translateY(0); }
    </style>
</head>
<body>
<header class="page-header">
    <div class="page-header-inner">
        <div class="page-title">
            <svg width="22" height="22" viewBox="0 0 24 24" class="icon" aria-hidden="true">
                <path d="M6 2h9a3 3 0 0 1 3 3v14.5a.5.5 0 0 1-.79.407L14 18.5l-3.21 1.407A.5.5 0 0 1 10 19.5V5a3 3 0 0 0-3-3Z"></path>
            </svg>
            <h1>Create a new book</h1>
        </div>
        <div class="breadcrumb">Library › Books › Create</div>
        <div class="actions">
            <a href="javascript:history.back()" class="btn secondary">Cancel</a>
            <button form="createBookForm" type="submit" class="btn primary">Save Book</button>
        </div>
    </div>
</header>

<main class="container">
    <form id="createBookForm"
          class="card"
          action="${pageContext.request.contextPath}/update"
          method="post"
          novalidate>

        <!-- utility default for nb -->
        <input type="hidden" name="nb" value="0"/>
        <input type="hidden" name="id" value="${b.id}"/>

        <div class="form-grid">
            <!-- LEFT: Cover URL and preview -->
            <aside class="panel">
                <div class="field">
                    <label for="imgUrl">Image URL</label>
                    <div class="cover-uploader" aria-label="Image URL and preview">
                        <div class="cover-preview" id="coverPreview">
                            <img id="coverImg" alt="Cover preview">
                            <div class="cover-placeholder" id="coverPlaceholder">
                                <svg width="42" height="42" viewBox="0 0 24 24" class="icon" aria-hidden="true">
                                    <path d="M21 19V5a2 2 0 0 0-2-2H5C3.9 3 3 3.9 3 5v14a2 2 0 0 0 2 2h14c1.1 0 2-.9 2-2zM8.5 13 11 16l3.5-4.5L19 18H5l3.5-5zM8 9a2 2 0 1 0 0-4 2 2 0 0 0 0 4z"></path>
                                </svg>
                                <div>Provide an image URL to preview.</div>
                                <div class="helper">Paste a direct link (http/https) to a JPG/PNG.</div>
                            </div>
                        </div>
                        <input id="imgUrl" name="img" type="url" placeholder="https://example.com/cover.jpg" value="${empty b.img ?'https://example.com/cover.jpg':b.img}">
                    </div>
                </div>
            </aside>

            <!-- RIGHT: Details -->
            <section class="form">
                <div class="section">
                    <div class="field">
                        <label for="title">Title <span class="required">*</span></label>
                        <input id="title" name="title" type="text" placeholder="The name of the book" required value="${b.title}">
                    </div>
                    <div class="field">
                        <label for="author">Author <span class="required">*</span></label>
                        <input id="author" name="author" type="text" placeholder="Author full name" required value="${b.author}">
                    </div>
                </div>

                <div class="section">
                    <div class="field">
                        <label for="isbn">ISBN</label>
                        <input id="isbn" name="isbn" type="text" placeholder="e.g., 978-..." value="${b.isbn}">
                    </div>
                    <div class="field">
                        <label for="genre">Genre</label>
                        <input id="genre" name="genre" type="text" placeholder="e.g., Fantasy" value="${b.genre}">
                    </div>
                </div>

                <div class="section">
                    <div class="field">
                        <label for="year">Year</label>
                        <input id="year" name="year" type="number" step="1" min="0" placeholder="e.g., 2020" value="${b.year}">
                    </div>
                    <div class="field">
                        <label for="price">Price</label>
                        <input id="price" name="price" type="number" step="0.01" min="0" placeholder="e.g., 19.99" value="${b.price}">
                    </div>
                </div>

                <div class="section full">
                    <div class="field">
                        <div class="inline">
                            <label for="description">Description</label>
                            <span class="counter" id="descCounter">0 / 2000</span>
                        </div>
                        <textarea id="description" name="description" maxlength="2000" placeholder="What is this book about? Add a synopsis..." >
                            ${b.description}
                        </textarea>
                    </div>
                </div>

                <div class="section">
                    <div class="field">
                        <label for="stock">Stock</label>
                        <input id="stock" name="stock" type="number" step="1" min="0" placeholder="e.g., 0" value="${b.stock}">
                    </div>
                </div>

                <div class="footer-actions">
                    <a href="javascript:history.back()" class="btn secondary">Cancel</a>
                    <button type="submit" class="btn primary">Update Book</button>
                </div>
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
