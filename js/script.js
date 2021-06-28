// navigation functions
// function to hide the navigation panal
function hideMenu(){
    document.getElementById("menu").style.display="none";
}

// function to show the navigation panal
function showMenu(){
    document.getElementById("menu").style.display="flex";
}

// function to validate the form data for admin login
function validateCredentials(){
    let id = document.getElementById("id").value;
    let password = document.getElementById("password").value;

    if(id <=0 && password === ""){
        alert("please provide the login credentials")
    } else if(id<=0){
        alert("please enter your valid login id")
    } else if( password === ""){
        alert("please enter your valid password")
    }
}

function validateMail(){
    let email = document.getElementById("email").value;
    
    if( email === ""){
        alert("please enter your valid email")
    }
}

function validatePassword(){
    let email = document.getElementById("email").value;
    
    if( email === ""){
        alert("please enter your valid password")
    } else if( email.length <6 || email.length >8){
        alert("password must be between 6 to 8 character long")
    }
}

// enable the admin profile fields
function enable(){
    document.getElementById("email").disabled = false;
    document.getElementById("password").disabled = false;
    document.getElementById("btn1").disabled = true;
    document.getElementById("btn2").disabled = false;
    document.getElementById("btn3").disabled = false;
}

// diable the admin profile fields
function disable(){
    document.getElementById("email").disabled = true;
    document.getElementById("password").disabled = true;
    document.getElementById("btn1").disabled = false;
    document.getElementById("btn2").disabled = true;
    document.getElementById("btn3").disabled = true;
}