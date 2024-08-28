// 카카오 맵 초기화
var container = document.getElementById('map');
var options = {
    center: new kakao.maps.LatLng(37.5665, 126.9780), // 서울 중심 좌표로 설정 예시
    level: 10 // 지도 레벨 설정
};
var map = new kakao.maps.Map(container, options);

// 윈도우 리사이즈 시 맵 크기 재조정
window.addEventListener('resize', function() {
    map.relayout();
});

// 드롭다운 관련 코드
window.onload = () => {
    document.querySelector('.dropbtn_click').onclick = () => {
        dropdown();
    };

    var fastfoodItems = document.querySelectorAll('.fastfood');
    fastfoodItems.forEach(item => {
        item.onclick = () => {
            showMenu(item.innerText);
        };
    });

    dropdown = () => {
        var v = document.querySelector('.dropdown-content');
        var dropbtn = document.querySelector('.dropbtn');
        v.classList.toggle('show');
        dropbtn.style.borderColor = 'rgb(94, 94, 94)';
    };

    showMenu = (value) => {
        var dropbtn_icon = document.querySelector('.dropbtn_icon');
        var dropbtn_content = document.querySelector('.dropbtn_content');
        var dropbtn_click = document.querySelector('.dropbtn_click');
        var dropbtn = document.querySelector('.dropbtn');

        dropbtn_icon.innerText = '';
        dropbtn_content.innerText = value;
        dropbtn_content.style.color = '#252525';
        dropbtn.style.borderColor = '#3992a8';
    };
};

// 클릭 시 드롭다운 닫기
window.onclick = (e) => {
    if (!e.target.matches('.dropbtn_click')) {
        var dropdowns = document.getElementsByClassName("dropdown-content");

        for (var i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                openDropdown.classList.remove('show');
            }
        }
    }
};
