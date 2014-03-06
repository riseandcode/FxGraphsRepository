            $(document).ready(function() {

                //Показать управление страницами и активировать первую ссылку
                $(".paging").show();
                $(".paging a:first").addClass("active");

                //Определяется размер изображений, вращение изображений
                var imageWidth = $(".window").width();
                var imageSum = $(".image_reel img").size();
                var imageReelWidth = imageWidth * imageSum;

                //Настройка изображения под новый размер
                $(".image_reel").css({'width' : imageReelWidth});

                //Функции слайдера и страничной навигации
                rotate = function(){
                    var triggerID = $active.attr("rel") - 1; //Получаем количество 
                    var image_reelPosition = triggerID * imageWidth; //Определяем расстояние между изображениями

                    $(".paging a").removeClass('active'); //Удаляются все активные классы
                    $active.addClass('active'); //Добавляем класс - active (the $active is declared in the rotateSwitch function)

                    //Слайдер Анимация
                    $(".image_reel").animate({
                        left: -image_reelPosition
                    }, 400 );

                };

                //Вращение и синхронизация событий
                rotateSwitch = function(){
                    play = setInterval(function(){ //Устанавливаем таймер - это будет повторяться каждые 7 секунд
                        $active = $('.paging a.active').next();
                        if ( $active.length === 0) { //Если навигация достигает конца...
                            $active = $('.paging a:first'); //возвращаемся к первому
                        }
                        rotate(); //Запускаем слайдер и страничную навигацию
                    }, 7500); //Таймер скорости в миллисекундах (7 секунд)
                };

                rotateSwitch(); //Выполняем функцию запуск

                //При наведении
                $(".image_reel a").hover(function() {
                    clearInterval(play); //Останавливаем вращение
                }, function() {
                    rotateSwitch(); //Продолжаем вращение
                });

                //При нажатии
                $(".paging a").click(function() {
                    $active = $(this); //Останавливаем вращение
                    //Сброс таймера
                    clearInterval(play); //Останавливаем вращение
                    rotate(); //Запускаем вращения

                    return false; //Не допускаем перехода по ссылке
                });

            });