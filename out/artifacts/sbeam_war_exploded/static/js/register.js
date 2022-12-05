var pw1 = document.getElementById('pw1');
var pw2 = document.getElementById('pw2');

var btn = document.getElementById('finish');
var form = document.getElementById('form');

var name = document.getElementById('name');

btn.onclick = function () {

    if(pw1.value === pw2.value && name.value !== null){
        form.submit();
    }

    if (pw1.value !== pw2.value) {
        alert('两次输入的密码不相同');
    }
}