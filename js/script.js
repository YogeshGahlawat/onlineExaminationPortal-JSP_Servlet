// function to hide the navigation panal
function hideMenu(){
    document.getElementById("menu").style.display="none";
}

// function to show the navigation panal
function showMenu(){
    document.getElementById("menu").style.display="flex";
}

// enable the admin/user profile fields
function enable(){
    document.getElementById("email").disabled = false;
    document.getElementById("password").disabled = false;
    document.getElementById("btn1").disabled = true;
    document.getElementById("btn2").disabled = false;
    document.getElementById("btn3").disabled = false;
}

// diable the admin/user profile fields
function disable(){
    document.getElementById("email").disabled = true;
    document.getElementById("password").disabled = true;
    document.getElementById("btn1").disabled = false;
    document.getElementById("btn2").disabled = true;
    document.getElementById("btn3").disabled = true;
}

// function to validateMail
function validateMail(){
    let mail = document.getElementById("email");

    if(mail.value == ""){
        alert("EMAIL FIELD MUST NOT BE EMPTY");
    }
}

// function to validateMail
function validatePassword(){
    let password = document.getElementById("password");

    if(password.value == ""){
        alert("PASSWORD FIELD MUST NOT BE EMPTY");
    }
}

// function to validateMail
function validateID(){
	let id = document.getElementById("id");

    if(id.value == "" || id.value == 0){
        alert("ID FIELD MUST NOT BE EMPTY");
    }
}

// function to validateMail
function validateName(){
    let name = document.getElementById("name");

    if(name.value == ""){
        alert("NAME FIELD MUST NOT BE EMPTY");
    }
}

// function to validate login credentials
function validateLogin(){
	let id = document.getElementById("id");
    let password = document.getElementById("password");

	if(id.value == 0 || id.value == "" || password.value == ""){
        alert("FIELDS MUST NOT BE EMPTY");
	}
}

// next function to switch to next question
function next(){

    var firstForm, lastForm, form;
    firstForm = Document.getElementById("firstForm");
    lastForm = Document.getElementById("lastForm");
    form = Document.getElementById("form");

    firstForm.style.left="-100%";
    form.style.left="0";
    lastForm.style.left="0";
}

// next function to switch to next question
function previous(){

    var firstForm, lastForm, form;
    firstForm = Document.getElementById("firstForm");
    lastForm = Document.getElementById("lastForm");
    form = Document.getElementById("form");

    firstForm.style.left="0";
    form.style.left="100%";
    lastForm.style.left="100%";
}