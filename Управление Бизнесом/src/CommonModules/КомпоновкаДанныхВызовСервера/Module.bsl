////////////////////////////////////////////////////////////////////////////////
// Варианты отчетов - Форма отчета УТ (вызов сервера, переопределяемый)
// 
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает структуру параметров и отборов расшифровки
// Параметры:
//   Расшифровка            - ИдентификаторРасшифровкиКомпоновкиДанных - значение, полученное из отчета при расшифровке.
//   АдресДанныхРасшифровки - Строка - адрес, указывающий на значение во временном хранилище.
//   СписокПараметров       - Массив - содержит имена параметров и полей, используемых при расшифровке
//   ПоляРасшифровки        - Строка - содержит имена полей, используемых при расшифровке.
//
// Возвращаемое значение:
//   Структура - в качестве ключа возвращается имя параметра или отбора для отчета-приемника,
//               а в качестве значения - значение параметра или отбора.
//
Функция ПараметрыФормыРасшифровки(Расшифровка, АдресДанныхРасшифровки, СписокПараметров, ПоляРасшифровки) Экспорт

	ПараметрыФормыРасшифровки = Новый Структура;
	
	ДанныеРасшифровки = ПолучитьИзВременногоХранилища(АдресДанныхРасшифровки);
	
	ПроверкаПолейРасшифровки = Новый ТаблицаЗначений;
	ПроверкаПолейРасшифровки.Колонки.Добавить("Значение");
	ПроверкаПолейРасшифровки.Колонки.Добавить("ИмяПоля");
	ПроверкаПолейРасшифровки.Колонки.Добавить("Иерархия", Новый ОписаниеТипов("Булево"));
	
	ДобавитьРодителей(ДанныеРасшифровки.Элементы[Расшифровка], ПроверкаПолейРасшифровки);
	
	Для каждого ДанныеПоля Из ПроверкаПолейРасшифровки Цикл
		ИмяПоля = СтрЗаменить(ДанныеПоля.ИмяПоля, ".", "_");
		Если ПоляРасшифровки.Найти(ИмяПоля) = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		Если НЕ ПараметрыФормыРасшифровки.Свойство(ИмяПоля) Тогда
			
			Если ДанныеПоля.Иерархия Тогда
				ЗначениеРасшифровки = Новый Структура;
				ЗначениеРасшифровки.Вставить("ВидСравнения", ВидСравненияКомпоновкиДанных.ВИерархии);
				ЗначениеРасшифровки.Вставить("ПравоеЗначение", ДанныеПоля.Значение);
				ПараметрыФормыРасшифровки.Вставить(ИмяПоля, ЗначениеРасшифровки);
			Иначе
				ПараметрыФормыРасшифровки.Вставить(ИмяПоля, ДанныеПоля.Значение);
			КонецЕсли;
		ИначеЕсли НЕ ПараметрыФормыРасшифровки.Свойство(ИмяПоля + "_Родитель") Тогда
			Если ДанныеПоля.Значение = Null Тогда
				Продолжить;
			КонецЕсли;
			ЗначениеРасшифровки = Новый Структура;
			ЗначениеРасшифровки.Вставить("ВидСравнения", ВидСравненияКомпоновкиДанных.ВИерархии);
			ЗначениеРасшифровки.Вставить("ПравоеЗначение", ДанныеПоля.Значение);
			ПараметрыФормыРасшифровки.Вставить(ИмяПоля + "_Родитель", ЗначениеРасшифровки);
		КонецЕсли;
	КонецЦикла;
	
	Для каждого ИмяПараметра Из СписокПараметров Цикл
		ЗначениеПараметра = ДанныеРасшифровки.Настройки.ПараметрыДанных.Элементы.Найти(ИмяПараметра);
		Если ЗначениеПараметра = Неопределено ИЛИ НЕ ЗначениеПараметра.Использование Тогда
			Продолжить;
		КонецЕсли;
		ПараметрыФормыРасшифровки.Вставить(ИмяПараметра, ЗначениеПараметра.Значение);
	КонецЦикла; 
	
	ПараметрыФормыРасшифровки.Вставить("Отбор", ДанныеРасшифровки.Настройки.Отбор);
	
	Если ПараметрыФормыРасшифровки.Количество() <> 0 Тогда
		Возврат ПараметрыФормыРасшифровки;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДобавитьРодителей(ЭлементРасшифровки, ПроверкаПолейРасшифровки)
	
	Если ТипЗнч(ЭлементРасшифровки) = Тип("ЭлементРасшифровкиКомпоновкиДанныхПоля") Тогда
		Для каждого Поле Из ЭлементРасшифровки.ПолучитьПоля() Цикл
			Отбор = Новый Структура("Значение, ИмяПоля, Иерархия", Поле.Значение, Поле.Поле, Поле.Иерархия);
			НайденныеСтроки = ПроверкаПолейРасшифровки.НайтиСтроки(Отбор);
			
			Если НайденныеСтроки.Количество() = 0 Тогда
				НовоеПоле = ПроверкаПолейРасшифровки.Добавить();
				НовоеПоле.Значение = Поле.Значение;
				НовоеПоле.ИмяПоля = Поле.Поле;
				НовоеПоле.Иерархия = Поле.Иерархия;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	Для каждого Родитель Из ЭлементРасшифровки.ПолучитьРодителей() Цикл
		ДобавитьРодителей(Родитель, ПроверкаПолейРасшифровки);
	КонецЦикла;
	
КонецФункции

#КонецОбласти