
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	СписокТипов = Список.КомпоновщикНастроек.Настройки.Выбор.ДоступныеПоляВыбора.НайтиПоле(Новый ПолеКомпоновкиДанных("Ссылка")).Тип;
	ПараметрыРазмещения = ПодключаемыеКоманды.ПараметрыРазмещения();
	ПараметрыРазмещения.Источники = СписокТипов;
	ПараметрыРазмещения.КоманднаяПанель = Элементы.ФормаКоманднаяПанель;
	
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект, ПараметрыРазмещения);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	УстановитьУсловноеОформление();
	УстановитьОтборСписка(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
    
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийФормыШапки

&НаСервере
Процедура ПоказыватьАрхивныеПриИзмененииНаСервере()
	УстановитьОтборСписка(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьАрхивныеПриИзменении(Элемент)
	ПоказыватьАрхивныеПриИзмененииНаСервере();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьОтборСписка(Форма)
	
	Список = Форма.Список;
	 	
	Если НЕ Форма.ПоказыватьАрхивныеГрейды Тогда 		
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "ВАрхиве", Ложь);
	Иначе
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбораДинамическогоСписка(Список, "ВАрхиве");
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	
	ЭлементОформления = УсловноеОформление.Элементы.Добавить();
	
	ОтборЭлемента = ЭлементОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Список.ВАрхиве");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;
	
	ОформляемоеПоле = ЭлементОформления.Поля.Элементы.Добавить();
	ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных("Список");
	ЗачеркнутыйШрифт = Новый Шрифт(,,,,, Истина);
	ЭлементОформления.Оформление.УстановитьЗначениеПараметра("Шрифт", ЗачеркнутыйШрифт);
	
КонецПроцедуры
	
#КонецОбласти

#Область ОбработчикиКомандФормы

#Область СтандартныеПодсистемы_ПодключаемыеКоманды

&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Элементы.Список);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Элементы.Список, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
КонецПроцедуры

#КонецОбласти

#КонецОбласти
