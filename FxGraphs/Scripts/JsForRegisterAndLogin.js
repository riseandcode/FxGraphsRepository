function CheckLoginParametersAndSubmit() {
        var un = $("#textboxlog").val();
        var pass = $("#textboxlog2").val();
        var errorMessage = "";
        if (un == "") {
            errorMessage += "Вы забыли указать логин\n";
        }
        if (pass == "") {
            errorMessage += "Вы забыли указать пароль\n";
        }

        if (errorMessage == "") {
            $.ajax(
                {
                    url: '@Url.Action("CheckLogin")',
                    type: 'POST',
                    data: JSON.stringify({ "userName": un, "password": pass }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        if (data == "false") {
                            alert("Неправильное имя пользователя или пароль");
                        } else {
                            
                            $.post("@Url.Action("Login", "Home")",
                            {
                                userName:  $("#textboxlog").val(),
                                password : $("#textboxlog2").val()
                            },
                            function (data, status, xhr)
                            {
                                if(data.Success)
                                {
                                    window.location = "/Home/Account";
                                }
                                else
                                {
                                    
                                }

                            });


                            //$("form:first").submit();
                        }
                    },
                    error: function () {
                        alert('На сервере произошла ошибка');
                    }
                });
        } else {
            errorMessage = "Исправте пожалуйста следующие ошибки:\n" + errorMessage;
            alert(errorMessage);
        }
        return false;
    }

     $(document).ready(function () {
    debugger;
        $('#textboxreg').keypress(function (e) {
            if (e.which == 13) {
                jQuery(this).blur();
                jQuery('#textboxreg1').focus();
            }
        });

        $('#textboxreg1').keypress(function (e) {
            if (e.which == 13) {
                jQuery(this).blur();
                jQuery('#textboxreg2').focus();
            }
        });
        
         $('#textboxreg2').keypress(function (e) {
            if (e.which == 13) {
                jQuery(this).blur();
                jQuery('#textboxreg3').focus();
            }
        }); 
         
         $('#textboxreg3').keypress(function (e) {
            if (e.which == 13) {
                jQuery(this).blur();
                CheckValidityAndThenSubmit();
            }
        }); 

        /*hack for function not found in java scrpt*/
         $('#textboxlog2').keypress(function (e) {
            if (e.which == 13) {
                jQuery(this).blur();
                CheckLoginParametersAndSubmit();
                jQuery('#regbutton').focus();
            }
        });

        $('#textboxlog').keypress(function (e) {
            if (e.which == 13) {
            
                jQuery(this).blur();
                jQuery('#textboxlog2').focus();
            }
        });




    });
     
    function CheckAvailabilityUserName() {
          var un = $("#textboxreg").val();
        
         $.ajax(
                {
                    url: '@Url.Action("CheckAvailabilityUserName")',
                    type: 'POST',
                    data: JSON.stringify({ "userName": un}),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        if (data == "false") {
                            alert("Такое имя уже используется");
                        } else {
                            CheckUserMail();
                        }
                    },
                    error: function () {
                        alert('На сервере произошла ошибка');
                    }
                });
     }
    

    function CheckUserMail() {
        
        var um = $("#textboxreg1").val();
         $.ajax(
                {
                    url: '@Url.Action("CheckAvailabilityUserMail")',
                    type: 'POST',
                    data: JSON.stringify({ "userMail": um}),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        if (data == "false") {
                            alert("Такой мейл уже используется");
                        } else {
                            Submit();
                        }
                    },
                    error: function () {
                        alert('На сервере произошла ошибка');
                    }
                });
    }
    
    function Submit() {
         $.post("@Url.Action("Register", "Home")",
                            {
                                userName:  $("#textboxreg").val(),
                                email : $("#textboxreg1").val(),
                                password : $("#textboxreg2").val(),
                                confirmPassword :  $("#textboxreg3").val()

                            },
                            function (data, status, xhr)
                            {
                                if(data.Success)
                                {
                                    alert("Регистрация прошла успешно!");
                                    window.location = "/Home";
                                }
                                else
                                {
                                    alert("Регистрация не была успешной");
                                }

                            });


        
        // $("form:first").submit();
    }


    function CheckValidityAndThenSubmit() {
        var login = $("#textboxreg").val();
        var email = $("#textboxreg1").val();
        var password = $("#textboxreg2").val();
        var confirmPassword = $("#textboxreg3").val();
        var errorMessage = "";
        if (login == "") {
            errorMessage += "Вы забыли указать логин\n";
        }
        if (email == "") {
            errorMessage += "Вы забыли указать почту\n";
        }
        if (password == "") {
            errorMessage += "Вы забыли указать пароль\n";
        }
        if (confirmPassword == "") {
            errorMessage += "Вы забыли указать повторение пароля\n";
        }
        if (password != confirmPassword) {
            errorMessage += "Пароли не совпадают\n";
        }
        if(!checkEmail(email)) {
            errorMessage += "Неверный формат електронной почты\n";
        }
        if(password.length < 6) {
            errorMessage += "Минимальная длинна пароля 6 символов\n";
        }


        if (errorMessage == "") {
            CheckAvailabilityUserName();
        } else {
            errorMessage = "Исправте пожалуйста следующие ошибки:\n" + errorMessage;
            alert(errorMessage);
        }
    }
    
    function checkEmail(email) {
        var filter = @Html.Raw(ViewData["emailValidator"].ToString());
        if (!filter.test(email)) {
            return false;
        } else {
            return true;
        }
    }