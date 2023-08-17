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
	
	ГлавныйУзел = Константы.ГлавныйУзел.Получить();
	
	Если Не ЗначениеЗаполнено(ГлавныйУзел) Тогда
		ВызватьИсключение НСтр("ru = 'Главный узел не сохранен.'");
	КонецЕсли;
	
	Если ПланыОбмена.ГлавныйУзел() <> Неопределено Тогда
		ВызватьИсключение НСтр("ru = 'Главный узел установлен.'");
	КонецЕсли;
	
	Элементы.ТекстПредупреждения.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		Элементы.ТекстПредупреждения.Заголовок, Строка(ГлавныйУзел));
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Восстановить(Команда)
	
	ВосстановитьНаСервере();
	
	Закрыть(Новый Структура("Отказ", Ложь));
	
КонецПроцедуры

&НаКлиенте
Процедура Отключить(Команда)
	
	ОтключитьНаСервере();
	
	Закрыть(Новый Структура("Отказ", Ложь));
	
КонецПроцедуры

&НаКлиенте
Процедура ЗавершитьРаботу(Команда)
	
	Закрыть(Новый Структура("Отказ", Истина));
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Процедура ОтключитьНаСервере()
	
	НачатьТранзакцию();
	Попытка
		ГлавныйУзел = Константы.ГлавныйУзел.Получить();
		
		ГлавныйУзелМенеджер = Константы.ГлавныйУзел.СоздатьМенеджерЗначения();
		ГлавныйУзелМенеджер.Значение = Неопределено;
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(ГлавныйУзелМенеджер);
		
		ЭтоАвтономноеРабочееМесто = Константы.ЭтоАвтономноеРабочееМесто.СоздатьМенеджерЗначения();
		ЭтоАвтономноеРабочееМесто.Прочитать();
		Если ЭтоАвтономноеРабочееМесто.Значение Тогда
			ЭтоАвтономноеРабочееМесто.Значение = Ложь;
			ОбновлениеИнформационнойБазы.ЗаписатьДанные(ЭтоАвтономноеРабочееМесто);
			
			НеИспользоватьРазделениеПоОбластямДанных = Константы.НеИспользоватьРазделениеПоОбластямДанных.СоздатьМенеджерЗначения();
			НеИспользоватьРазделениеПоОбластямДанных.Прочитать();
			Если Не Константы.ИспользоватьРазделениеПоОбластямДанных.Получить()
				И Не НеИспользоватьРазделениеПоОбластямДанных.Значение Тогда
				НеИспользоватьРазделениеПоОбластямДанных.Значение = Истина;
				ОбновлениеИнформационнойБазы.ЗаписатьДанные(НеИспользоватьРазделениеПоОбластямДанных);
			КонецЕсли;
			
		КонецЕсли;
		
		Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ОбменДанными") Тогда
			МодульОбменДаннымиСервер = ОбщегоНазначения.ОбщийМодуль("ОбменДаннымиСервер");
			МодульОбменДаннымиСервер.УдалитьНастройкиСинхронизацииСГлавнымУзломРИБ(ГлавныйУзел);
		КонецЕсли;
		
		СтандартныеПодсистемыСервер.ВосстановитьПредопределенныеЭлементы();
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ВосстановитьНаСервере()
	
	ГлавныйУзел = Константы.ГлавныйУзел.Получить();
	
	ПланыОбмена.УстановитьГлавныйУзел(ГлавныйУзел);
	
КонецПроцедуры

#КонецОбласти
