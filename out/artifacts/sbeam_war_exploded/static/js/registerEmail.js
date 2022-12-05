var e1 = document.getElementById('e1');
var e2 = document.getElementById('e2');
var check = document.getElementById('check');
var btn = document.getElementById('finish');
var form = document.getElementById('form');
var select = document.getElementById('select');

function submitForm() {

    if (e1.value == null || e2.value == null){
        alert('电子邮箱不能为空');
    }

    if (e2.value !== e1.value) {
       alert('您需要输入相同的邮箱地址');
    }

    if (!check.checked){
        alert('您需要同意《Sbeam 用户协议》才能继续');
    }

    if(e2.value === e1.value && check.checked){
       form.submit();
    }
}

e1.onblur = function () {
    //判断这个文本框中输入的是不是邮箱
    var reg = /^[0-9a-zA-Z_.-]+[@][0-9a-zA-Z_.-]+([.][a-zA-Z]+){1,2}$/;
    if (reg.test(this.value)) {
        this.style.backgroundColor = "green";
    } else {
        this.style.backgroundColor = "red";
    }
}

e2.onblur = function () {
    //判断这个文本框中输入的是不是邮箱
    var reg = /^[0-9a-zA-Z_.-]+[@][0-9a-zA-Z_.-]+([.][a-zA-Z]+){1,2}$/;
    if (reg.test(this.value)) {
        this.style.backgroundColor = "green";
    } else {
        this.style.backgroundColor = "red";
    }
}
