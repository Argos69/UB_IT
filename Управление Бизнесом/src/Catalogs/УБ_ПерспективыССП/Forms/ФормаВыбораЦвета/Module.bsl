
#Область ОбработчикиСобытийФормы

&НаСервере
// Процедура - обработчик события формы "ПриСозданииНаСервере".
//
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	СписокЦветов = ПолучитьСписокЦветов();
	ТаблицаЗнач = РеквизитФормыВЗначение("Список");
	Для Каждого Цв Из СписокЦветов Цикл
		НоваяСтрока = ТаблицаЗнач.Добавить();
		НоваяСтрока.Картинка 		= Цв.Ключ;
		НоваяСтрока.Представление 	= Цв.Значение.Представление;
		НоваяСтрока.Красный 		= Цв.Значение.Цвет.Красный;	
		НоваяСтрока.Зеленый 		= Цв.Значение.Цвет.Зеленый;
		НоваяСтрока.Синий  			= Цв.Значение.Цвет.Синий;
	КонецЦикла;
	ТаблицаЗнач.Сортировать("Картинка");
	ЗначениеВРеквизитФормы(ТаблицаЗнач, "Список");
	Элементы.Список.ТекущаяСтрока =  Список.Индекс(Список.НайтиСтроки(Новый Структура("Картинка", Параметры.ТекущийЦвет))[0]);  
КонецПроцедуры 

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
// Процедура - обработчик события "Выбор" таблицы формы "Список".
//
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Закрыть(Список.НайтиСтроки(Новый Структура("Картинка", Элемент.ТекущиеДанные.Картинка)));
КонецПроцедуры 
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
// Функция возвращает соответствие ключ-значение.
// Ключ - номер картинки в коллекции.
// Структура{
// Представление - наименование цвета.
// Цвет - значение типа Цвет
// }
Функция ПолучитьСписокЦветов() Экспорт

	СоответствиеЦвет = Новый Соответствие;
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Красный'"));
	сЦвет.Вставить("Цвет",Новый Цвет(255,136,124));
	СоответствиеЦвет.Вставить(0,сЦвет); 
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Оранжевый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(255,184,120));
	СоответствиеЦвет.Вставить(1,сЦвет); 	
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Персиковый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(251,215,91));
	СоответствиеЦвет.Вставить(2,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Желтый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(255,250,130));
	СоответствиеЦвет.Вставить(3,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Зеленый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(122,231,191));
	СоответствиеЦвет.Вставить(4,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Сине-зеленый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(70,214,219));
	СоответствиеЦвет.Вставить(5,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Оливковый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(197,210,169));
	СоответствиеЦвет.Вставить(6,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Синий'"));
	сЦвет.Вставить("Цвет",Новый Цвет(164,189,252));
	СоответствиеЦвет.Вставить(7,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Лиловый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(219,173,255));
	СоответствиеЦвет.Вставить(8,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Бордовый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(212,164,186));
	СоответствиеЦвет.Вставить(9,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Стальной'"));
	сЦвет.Вставить("Цвет",Новый Цвет(216,218,229));
	СоответствиеЦвет.Вставить(10,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Темно-стальной'"));
	сЦвет.Вставить("Цвет",Новый Цвет(97,111,140));
	СоответствиеЦвет.Вставить(11,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Светло-серый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(225,225,225));
	СоответствиеЦвет.Вставить(12,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Темно-серый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(104,104,104));
	СоответствиеЦвет.Вставить(13,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Черный'"));
	сЦвет.Вставить("Цвет",Новый Цвет(46,46,46));
	СоответствиеЦвет.Вставить(14,сЦвет);

	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Темно-красный'"));
	сЦвет.Вставить("Цвет",Новый Цвет(220,33,39));
	СоответствиеЦвет.Вставить(15,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Темно-оранжевый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(206,93,17));
	СоответствиеЦвет.Вставить(16,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Темно-персиковый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(192,145,32));
	СоответствиеЦвет.Вставить(17,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Темно-желтый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(175,170,0));
	СоответствиеЦвет.Вставить(18,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Темно-зеленый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(81,183,73));
	СоответствиеЦвет.Вставить(19,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Темно-бирюзовый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(53,149,119));
	СоответствиеЦвет.Вставить(20,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Картинка",21);
	сЦвет.Вставить("Представление",НСтр("ru='Темно-оливковый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(114,130,71));
	СоответствиеЦвет.Вставить(21,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Темно-синий'"));
	сЦвет.Вставить("Цвет",Новый Цвет(52,103,184));
	СоответствиеЦвет.Вставить(22,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Темно-лиловый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(91,61,160));
	СоответствиеЦвет.Вставить(23,сЦвет);
	
	сЦвет = Новый Структура;
	сЦвет.Вставить("Представление",НСтр("ru='Темно-бордовый'"));
	сЦвет.Вставить("Цвет",Новый Цвет(147,67,108));
	СоответствиеЦвет.Вставить(24,сЦвет);
	
	Возврат СоответствиеЦвет;
	
КонецФункции // ПолучитьСписокЦветов()

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
// Процедура - обработчик команды формы "Выбрать".
//
Процедура Выбрать(Команда)
	Закрыть(Список.НайтиСтроки(Новый Структура("Картинка", Элементы.Список.ТекущиеДанные.Картинка)));
КонецПроцедуры

#КонецОбласти



