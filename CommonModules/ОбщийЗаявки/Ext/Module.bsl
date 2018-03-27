﻿
Функция ПреобразоватьТекстЗаявки(ТекстЗаявки) Экспорт	
	НайтиКомНач = Найти(ТекстЗаявки,"<!--");
	НайтиКомКон = Найти(ТекстЗаявки, "-->");	
	Пока НайтиКомНач <> 0 ИЛИ НайтиКомКон <> 0 Цикл 
		ТекстЗаявки = СокрЛП(Лев(ТекстЗаявки,НайтиКомНач-1)) + СокрЛП(Прав(ТекстЗаявки, СтрДлина(ТекстЗаявки) - НайтиКомКон-2));
		НайтиКомНач = Найти(ТекстЗаявки,"<!--");
		НайтиКомКон = Найти(ТекстЗаявки, "-->");	
	КонецЦикла;
	Возврат СтрЗаменить(ТекстЗаявки, "<meta http-equiv=""Content-Type"" content=""text/html; charset=koi8-r"">","<meta charset=""utf-8"">");	
КонецФункции

Функция ПреобразоватьТемуЗаявки(ТемаЗаявки) Экспорт
	Возврат СтрЗаменить(ТемаЗаявки, "FW:", "");
КонецФункции

Функция НайтиИнициатораЗаявки(ТекстЗаявки) Экспорт
	Замена = "From:</span></b><span style=""mso-fareast-language:RU"">";
	левИнициатор = Найти(ТекстЗаявки,Замена);
	правИнициатор = Прав(ТекстЗаявки, СтрДлина(ТекстЗаявки)-левИнициатор+1);
	br = Найти(правИнициатор, "<br>");
	Инициатор = СокрЛП(СтрЗаменить(Лев(правИнициатор,br-1),Замена,""));
	спрИнициатор = Справочники.Пользователи.НайтиПоНаименованию(Инициатор);
	Если спрИнициатор = Справочники.Пользователи.ПустаяСсылка() Тогда 
		спрИнициатор = СоздатьПользователя(Инициатор);	
	КонецЕсли;
	Возврат спрИнициатор;	
КонецФункции

Функция СоздатьПользователя(ФИО) Экспорт
	НовыйПользователь = Справочники.Пользователи.СоздатьЭлемент();
	НовыйПользователь.Наименование = ФИО;
	НовыйПользователь.Записать();
	Возврат НовыйПользователь;
КонецФункции

Функция ПолучитьПоследнююПриоритет() Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	Заявки.Приоритет КАК Приоритет
		|ИЗ
		|	Документ.Заявки КАК Заявки
		|ГДЕ
		|	Заявки.Приоритет <> 0
		|
		|УПОРЯДОЧИТЬ ПО
		|	Приоритет УБЫВ";
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда 
		Возврат 0;
	Иначе
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		Если ВыборкаДетальныеЗаписи.Следующий() Тогда
			Возврат ВыборкаДетальныеЗаписи.Приоритет;		
		КонецЕсли;
	КонецЕсли;
КонецФункции




