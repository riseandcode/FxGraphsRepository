// search index for WYSIWYG Web Builder
var database_length = 0;

function SearchPage(url, title, keywords, description)
{
   this.url = url;
   this.title = title;
   this.keywords = keywords;
   this.description = description;
   return this;
}

function SearchDatabase()
{
   database_length = 0;
   this[database_length++] = new SearchPage("home.html", "����������", "���������� ���������� ", "");
   this[database_length++] = new SearchPage("adviser.html", "����������", "���������� ���������� �� nbsp ��������� �������� ���� �������� �15 eurusd usdcad fbcobra ��� ����� usd cents ������� ����� ��������� �������� ����������� ������� ���� �� ����� ������ ���������� quot ��������� ��������� ��������������� ������������ ���� ��������� ���������� ������ ����� ���������� �� ��������� �������� ���� ���������� ������� ��� ������� ����� ", "");
   this[database_length++] = new SearchPage("help.html", "����������", "���������� forexboxinfo gmail com ", "");
   this[database_length++] = new SearchPage("faq.html", "����������", "���������� ������ �� ������ ���� ������? ����� ��� ��� ����� ������� ���� �� forex ��������� ��� ����� ������� �������� ���������� ���� �������� ��������� ��� �������� �� ��� ����� ������ �������������� �� ������ ������ ������� ������������������ ��� ����� ��������? ��� ��������� ������� �������������� ������ ��������� ������� ������� ������������� ��� �������� ����? ��� ����� ������ ������ ����� �������� �������� ������� quot ���������� �������� ����� ������� ������� �������� ����� ������� �� ���� ����� ��������� ��� ��� ����� �������� ����� ��������� �� �� ����������� �������� ������ ���������� ������? ���� ������ �������� �� �������� ����� ��������� ������ ���� �� �������� ������ �������� ��� ��������� ����� ����� ������� ���� �������� ���� ���� ����������� ���������� ���������� ����� ���������� ������ ��������� ", "");
   this[database_length++] = new SearchPage("faq2.html", "����������", "���������� ����� �� ������ ����������� ��������� �� ���� ���������? ���� ������ ������ �� �������� ��������� ���� �������� ��� ���� �������� ��� �������� �� ������� ��������� ��� ������ ��� �������� ���� ������� �������� �������� ��� ���������� ��������? ��� �� �������� ��� ���������� ��������� ������� ���������� ������ ���� �������������� ���������? �� �������� �� ������������ ���� ��������� ��� ����� ����������� ������� ����� ���� ��� �������� ����������� ������ ��� ������� ������ ������ ����� ������� ��������� �� ������� ����������� ��� ��������� �������� ������ ������? ��� �� ���� ���������� �������� ����� ����� ��� ������� ������������ ��� ���� ������ ��������� ���������? ��� ����� ������ ���� ���� �������� �������� ����������� ��������� ������ ����������� ��������� ������� �� ������ ������������ ������ ����� �� �������� ��� ������� ����� ������ ������������ ", "");
   this[database_length++] = new SearchPage("free.html", "����������", "���������� ������ ��� �������� ����������? ������ ���������� �������� �� ��������� ������ �������� ��������� ��������� ������ ����������? ��� ����� ������ ���� ����� �������� �������� �������� ����������� ��������� �� ����� ��������� ��������������� ������ ����� ��������� ������ ����� ����������� ��� ��������� ������� ������ �������� ���� ������ �������� �� ��������� ������ ������� ��������� ������� �������� �� ���� �� ��������� �������� ������� ��� �� ����� ������� ���� �������� ���� ����� ������ ������ ��������� ������ ������� ������ ������� ��������� ����� �������� ������ ������������ ��� ������ ����� �� �������� ������� �� �� ������������� �������� �� �������������� ���������� ���������� ��������� ������� ������������� ��������� ������� ��� ������ ������ ���������� quot ������ ��������� �������� ������ ����������� ������������ ����������� ��������� ��� ��������� ����������������� ������ ��������� ��� ���������� ��������� ��� �������������� ��� ������ ��� ��� ��������� ����������� ����������� ����� ������� �������� ���������� ���������� �������� �������� ������ ��������� ������������ ��������� ����������� ", "");
   this[database_length++] = new SearchPage("forex.html", "����������", "���������� ����� forex ��� ������������� �������� �� ����� ������ ��� ������ ������ ������ ������������ ���������� �������� ��� ��� ���� ������� ������� ������ ���� ��������� ������������ ������ ������ ����� �������� ������ ����� ��������� ��������� �� �������� ����� ����� ���� ������ ��������� ������ ��������� ������� ��������� ������ ����� ������� ���� ��� ���������� ���� ��������� ������������� ��� ����������� ���������� ��������� ������ ����� ���� ����� ������� ���������� �� ��������� ��� ���� ����� ������� ���������� �������� ������������ ����� ���������������� ����������� ��������� ������������� ������������ ��������� ������� �������������� ������ ����� ������ ����� ��� ������� ��� ���� ���������� ���� ����� �������� ��������� ���� ����� ��������� ������� �� ���������� ������ ����� ������� ���������� �������������� ��� ���������� ������ �������� ����� ������������ ������������� ��� �������� �������� ������ ��������� �� ��������? ������� ���������� ����� ���������� �������� �� ��������� ��������� ������� ����� ��������� ����� ����������� ����� forexbox ����� ������ �������� ����� ������������ ����� �������� ���� ���� ", "");
   this[database_length++] = new SearchPage("comment.html", "����������", "���������� ", "");
   this[database_length++] = new SearchPage("registration.html", "����������", "���������� ��� ����� ������ ����������� mail nbsp ����������� ������� �������� ", "");
   this[database_length++] = new SearchPage("login.html", "����������", "���������� ����� ������ ������� ����� ��������� ���� ������ ", "");
   this[database_length++] = new SearchPage("account.html", "����������", "���������� ����� �������� �������� ��������� ��� ���������� ��������� ����� ���� �������� ���� ������ �� ������������ �������� ����������� ��� �� ����� ����� �������� ������ ������������ ����� ��������� ", "");
   this[database_length++] = new SearchPage("open.html", "����������", "���������� ������� ����������� ��� ���������� ����� ��������� ", "");
   this[database_length++] = new SearchPage("activate.html", "����������", "���������� �� �� ������������ ������ ����� ������ ��� ��������� ", "");
   this[database_length++] = new SearchPage("download.html", "����������", "���������� �������� ����������� ��� ���� ����� ������� ����� ��������� ", "");
   this[database_length++] = new SearchPage("advisors.html", "����������", "���������� ��� ��������� ������� ����� ", "");
   this[database_length++] = new SearchPage("123.html", "���������� ��������", "���������� �������� nbsp ������� quot ��� ������� ����� ", "");
   this[database_length++] = new SearchPage("��������1.html", "���������� ��������", "���������� �������� �������� ���� ���������� ������� ��� ������� ����� ", "");
   return this;
}
