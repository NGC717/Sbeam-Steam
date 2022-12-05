var btns = [
    document.getElementById('btn1'),
    document.getElementById('btn2'),
    document.getElementById('btn3'),
    document.getElementById('btn4'),
    document.getElementById('btn5'),
    document.getElementById('btn6')
]

for (let i = 0; i < 6; i++) {
    btns[i].onmouseover = function () {
        btns[i].style.borderColor = '#2e6da4';
    }

    btns[i].onmouseleave = function () {
        btns[i].style.borderColor = 'transparent';
    }
};

var shop = document.getElementById('btn1');

shop.onmouseover = function () {


}