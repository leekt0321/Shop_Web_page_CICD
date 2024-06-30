// This file is intentionally blank
// Use this file to add JavaScript to your project
document.addEventListener('DOMContentLoaded', (event) => {
    console.log('DOM fully loaded and parsed');

    // 버튼 클릭 이벤트 리스너 추가
    var navigateButton = document.getElementById('navigateButton');
    if (navigateButton) {
        navigateButton.addEventListener('click', function() {
            window.location.href = '/login';  // /login 경로로 이동
        });
    }

    var alluserButton = document.getElementById('alluserButton');
    if (alluserButton) {
        alluserButton.addEventListener('click', function() {
            window.location.href = '/user';  // /user 경로로 이동
        });
    }
	

});
