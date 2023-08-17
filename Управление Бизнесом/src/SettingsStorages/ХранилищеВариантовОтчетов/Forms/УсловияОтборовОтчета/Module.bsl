///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	ЗакрыватьПриВыборе = Ложь;
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Параметры, "НастройкиОтчета, КомпоновщикНастроек");
	КомпоновщикНастроек.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(НастройкиОтчета.АдресСхемы));
	
	ТипФормыВладельца = ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(
		Параметры, "ТипФормыВладельца", ТипФормыОтчета.Основная);
	
	ОбновитьОтборы(ТипФормыВладельца);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОтборыТаблица

&НаКлиенте
Процедура ОтборыПриАктивизацииСтроки(Элемент)
	Список = Элементы.ОтборыВидСравнения.СписокВыбора;
	Список.Очистить();
	
	Строка = Элемент.ТекущиеДанные;
	Если Строка = Неопределено
		Или Строка.ДоступныеВидыСравнения = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	Для Каждого ВидыСравнения Из Строка.ДоступныеВидыСравнения Цикл 
		ЗаполнитьЗначенияСвойств(Список.Добавить(), ВидыСравнения);
	КонецЦикла;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	ВыбратьИЗакрыть();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()
	УсловноеОформление.Элементы.Очистить();
	
	// ПредставлениеПользовательскойНастройки - НеЗаполнено.
	// Представление - Заполнено.
	//
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Отборы.ПредставлениеПользовательскойНастройки");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Отборы.Представление");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", Новый ПолеКомпоновкиДанных("Отборы.Представление"));
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ОтборыПредставлениеПользовательскойНастройки.Имя);
	
	// ПредставлениеПользовательскойНастройки - НеЗаполнено.
	// Представление - НеЗаполнено.
	// Заголовок - Заполнено.
	//
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Отборы.ПредставлениеПользовательскойНастройки");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Отборы.Представление");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Отборы.Заголовок");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", Новый ПолеКомпоновкиДанных("Отборы.Заголовок"));
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ОтборыПредставлениеПользовательскойНастройки.Имя);
КонецПроцедуры

&НаСервере
Процедура ОбновитьОтборы(ТипФормыВладельца)
	Строки = Отборы.ПолучитьЭлементы();
	
	ДопустимыеРежимыОтображения = Новый Массив;
	ДопустимыеРежимыОтображения.Добавить(РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Авто);
	ДопустимыеРежимыОтображения.Добавить(РежимОтображенияЭлементаНастройкиКомпоновкиДанных.БыстрыйДоступ);
	Если ТипФормыВладельца = ТипФормыОтчета.Настройка Тогда 
		ДопустимыеРежимыОтображения.Добавить(РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Обычный);
	КонецЕсли;
	
	ПользовательскиеНастройки = КомпоновщикНастроек.ПользовательскиеНастройки;
	Для Каждого ЭлементПользовательскойНастройки Из ПользовательскиеНастройки.Элементы Цикл 
		Если ТипЗнч(ЭлементПользовательскойНастройки) <> Тип("ЭлементОтбораКомпоновкиДанных")
			Или ТипЗнч(ЭлементПользовательскойНастройки.ПравоеЗначение) = Тип("СтандартныйПериод") Тогда 
			Продолжить;
		КонецЕсли;
		
		ЭлементНастройки = ОтчетыКлиентСервер.ПолучитьОбъектПоПользовательскомуИдентификатору(
			КомпоновщикНастроек.Настройки,
			ЭлементПользовательскойНастройки.ИдентификаторПользовательскойНастройки,,
			ПользовательскиеНастройки);
		
		Если ДопустимыеРежимыОтображения.Найти(ЭлементНастройки.РежимОтображения) = Неопределено Тогда 
			Продолжить;
		КонецЕсли;
		
		ОписаниеНастройки = ОтчетыКлиентСервер.НайтиДоступнуюНастройку(КомпоновщикНастроек.Настройки, ЭлементНастройки);
		Если ОписаниеНастройки = Неопределено Тогда 
			Продолжить;
		КонецЕсли;
		
		Строка = Строки.Добавить();
		ЗаполнитьЗначенияСвойств(Строка, ОписаниеНастройки);
		ЗаполнитьЗначенияСвойств(Строка, ЭлементНастройки, "Представление, ПредставлениеПользовательскойНастройки");
		
		Строка.ВидСравнения = ЭлементПользовательскойНастройки.ВидСравнения;
		
		ДоступныеВидыСравнения = ОписаниеНастройки.ДоступныеВидыСравнения;
		Если ДоступныеВидыСравнения <> Неопределено
			И ДоступныеВидыСравнения.Количество() > 0
			И ДоступныеВидыСравнения.НайтиПоЗначению(Строка.ВидСравнения) = Неопределено Тогда 
			Строка.ВидСравнения = ДоступныеВидыСравнения[0].Значение;
		КонецЕсли;
		
		Строка.Идентификатор = ПользовательскиеНастройки.ПолучитьИдентификаторПоОбъекту(ЭлементПользовательскойНастройки);
		Строка.ИсходныйВидСравнения = Строка.ВидСравнения;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьИЗакрыть()
	УсловияОтборов = Новый Соответствие;
	
	Строки = Отборы.ПолучитьЭлементы();
	Для Каждого Строка Из Строки Цикл
		Если Строка.ИсходныйВидСравнения <> Строка.ВидСравнения Тогда
			УсловияОтборов.Вставить(Строка.Идентификатор, Строка.ВидСравнения);
		КонецЕсли;
	КонецЦикла;
	
	Закрыть(УсловияОтборов);
КонецПроцедуры

#КонецОбласти
