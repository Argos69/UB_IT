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
	
	ПоказатьНастройкиВнешнихПользователей = Параметры.ПоказатьНастройкиВнешнихПользователей;
	
	ПредлагаемыеЗначенияНастроек = Новый Структура;
	ПредлагаемыеЗначенияНастроек.Вставить("МинимальнаяДлинаПароля", 8);
	ПредлагаемыеЗначенияНастроек.Вставить("МаксимальныйСрокДействияПароля", 30);
	ПредлагаемыеЗначенияНастроек.Вставить("МинимальныйСрокДействияПароля", 1);
	ПредлагаемыеЗначенияНастроек.Вставить("ЗапретитьПовторениеПароляСредиПоследних", 10);
	ПредлагаемыеЗначенияНастроек.Вставить("ПросрочкаРаботыВПрограммеДоЗапрещенияВхода", 45);
	
	Если ПоказатьНастройкиВнешнихПользователей Тогда
		СтандартныеПодсистемыСервер.УстановитьКлючНазначенияФормы(ЭтотОбъект, "ВнешниеПользователи");
		АвтоЗаголовок = Ложь;
		Заголовок = НСтр("ru = 'Настройки входа внешних пользователей'");
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, ПользователиСлужебный.НастройкиВхода().ВнешниеПользователи);
	Иначе
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, ПользователиСлужебный.НастройкиВхода().Пользователи);
	КонецЕсли;
	
	Для Каждого КлючИЗначение Из ПредлагаемыеЗначенияНастроек Цикл
		Если ЗначениеЗаполнено(ЭтотОбъект[КлючИЗначение.Ключ]) Тогда
			ЭтотОбъект[КлючИЗначение.Ключ + "Включить"] = Истина;
		Иначе
			ЭтотОбъект[КлючИЗначение.Ключ] = КлючИЗначение.Значение;
			Элементы[КлючИЗначение.Ключ].Доступность = Ложь;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПарольДолженОтвечатьТребованиямСложностиПриИзменении(Элемент)
	
	Если МинимальнаяДлинаПароля < 7 Тогда
		МинимальнаяДлинаПароля = 7;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура МинимальнаяДлинаПароляПриИзменении(Элемент)
	
	Если МинимальнаяДлинаПароля < 7
	  И ПарольДолженОтвечатьТребованиямСложности Тогда
		
		МинимальнаяДлинаПароля = 7;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкаВключитьПриИзменении(Элемент)
	
	ИмяНастройки = Лев(Элемент.Имя, СтрДлина(Элемент.Имя) - СтрДлина("Включить"));
	
	Если ЭтотОбъект[Элемент.Имя] = Ложь Тогда
		ЭтотОбъект[ИмяНастройки] = ПредлагаемыеЗначенияНастроек[ИмяНастройки];
	КонецЕсли;
	
	Элементы[ИмяНастройки].Доступность = ЭтотОбъект[Элемент.Имя];
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ЗаписатьНаСервере();
	Оповестить("Запись_НаборКонстант", Новый Структура, "НастройкиВходаПользователей");
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаписатьНаСервере()
	
	Блокировка = Новый БлокировкаДанных;
	Блокировка.Добавить("Константа.НастройкиВходаПользователей");
	
	НачатьТранзакцию();
	Попытка
		Блокировка.Заблокировать();
		НастройкиВхода = ПользователиСлужебный.НастройкиВхода();
		
		Если ПоказатьНастройкиВнешнихПользователей Тогда
			Настройки = НастройкиВхода.ВнешниеПользователи;
		Иначе
			Настройки = НастройкиВхода.Пользователи;
		КонецЕсли;
		
		Настройки.ПарольДолженОтвечатьТребованиямСложности = ПарольДолженОтвечатьТребованиямСложности;
		
		Если Не ЗначениеЗаполнено(ПросрочкаРаботыВПрограммеДоЗапрещенияВхода) Тогда
			Настройки.ПросрочкаРаботыВПрограммеДатаВключения = '00010101';
			
		ИначеЕсли Не ЗначениеЗаполнено(Настройки.ПросрочкаРаботыВПрограммеДатаВключения) Тогда
			Настройки.ПросрочкаРаботыВПрограммеДатаВключения = НачалоДня(ТекущаяДатаСеанса());
		КонецЕсли;
		
		Для Каждого КлючИЗначение Из ПредлагаемыеЗначенияНастроек Цикл
			Если ЭтотОбъект[КлючИЗначение.Ключ + "Включить"] Тогда
				Настройки[КлючИЗначение.Ключ] = ЭтотОбъект[КлючИЗначение.Ключ];
			Иначе
				Настройки[КлючИЗначение.Ключ] = 0;
			КонецЕсли;
		КонецЦикла;
		
		Константы.НастройкиВходаПользователей.Установить(Новый ХранилищеЗначения(НастройкиВхода));
		
		Если ЗначениеЗаполнено(НастройкиВхода.Пользователи.ПросрочкаРаботыВПрограммеДоЗапрещенияВхода)
		 Или ЗначениеЗаполнено(НастройкиВхода.ВнешниеПользователи.ПросрочкаРаботыВПрограммеДоЗапрещенияВхода) Тогда
			
			УстановитьПривилегированныйРежим(Истина);
			ПользователиСлужебный.ИзменитьЗаданиеКонтрольАктивностиПользователей(Истина);
			УстановитьПривилегированныйРежим(Ложь);
		КонецЕсли;
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
	ОбновитьПовторноИспользуемыеЗначения();
	
КонецПроцедуры

#КонецОбласти
