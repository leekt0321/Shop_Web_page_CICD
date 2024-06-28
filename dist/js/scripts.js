/*!
* Start Bootstrap - Shop Homepage v5.0.6 (https://startbootstrap.com/template/shop-homepage)
* Copyright 2013-2024 Start Bootstrap
* Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-shop-homepage/blob/master/LICENSE)
*/
// This file is intentionally blank
// Use this file to add JavaScript to your project
document.addEventListener('DOMContentLoaded', (event) => {
    console.log('DOM fully loaded and parsed');

    // 버튼 클릭 이벤트 리스너 추가
    var navigateButton = document.getElementById('navigateButton');
    if (navigateButton) {
        navigateButton.addEventListener('click', function() {
            window.location.href = '/app';  // /app 경로로 이동
        });
    }
});
