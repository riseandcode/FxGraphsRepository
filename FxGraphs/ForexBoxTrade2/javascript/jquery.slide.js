            $(document).ready(function() {

                //�������� ���������� ���������� � ������������ ������ ������
                $(".paging").show();
                $(".paging a:first").addClass("active");

                //������������ ������ �����������, �������� �����������
                var imageWidth = $(".window").width();
                var imageSum = $(".image_reel img").size();
                var imageReelWidth = imageWidth * imageSum;

                //��������� ����������� ��� ����� ������
                $(".image_reel").css({'width' : imageReelWidth});

                //������� �������� � ���������� ���������
                rotate = function(){
                    var triggerID = $active.attr("rel") - 1; //�������� ���������� 
                    var image_reelPosition = triggerID * imageWidth; //���������� ���������� ����� �������������

                    $(".paging a").removeClass('active'); //��������� ��� �������� ������
                    $active.addClass('active'); //��������� ����� - active (the $active is declared in the rotateSwitch function)

                    //������� ��������
                    $(".image_reel").animate({
                        left: -image_reelPosition
                    }, 400 );

                };

                //�������� � ������������� �������
                rotateSwitch = function(){
                    play = setInterval(function(){ //������������� ������ - ��� ����� ����������� ������ 7 ������
                        $active = $('.paging a.active').next();
                        if ( $active.length === 0) { //���� ��������� ��������� �����...
                            $active = $('.paging a:first'); //������������ � �������
                        }
                        rotate(); //��������� ������� � ���������� ���������
                    }, 7500); //������ �������� � ������������� (7 ������)
                };

                rotateSwitch(); //��������� ������� ������

                //��� ���������
                $(".image_reel a").hover(function() {
                    clearInterval(play); //������������� ��������
                }, function() {
                    rotateSwitch(); //���������� ��������
                });

                //��� �������
                $(".paging a").click(function() {
                    $active = $(this); //������������� ��������
                    //����� �������
                    clearInterval(play); //������������� ��������
                    rotate(); //��������� ��������

                    return false; //�� ��������� �������� �� ������
                });

            });