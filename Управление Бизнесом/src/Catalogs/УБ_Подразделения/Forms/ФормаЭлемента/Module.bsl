
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	Если Объект.Ссылка.Пустая() Тогда
		Объект.ДатаСоздания = ДатаСозданияПоУмолчанию(ТекущаяДатаСеанса());
	КонецЕсли;
	
	УстановитьДоступностьЭлементов(ЭтотОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;  
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
КонецПроцедуры       

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	// СтандартныеПодсистемы.УправлениеДоступом
	
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	
	// Конец СтандартныеПодсистемы.УправлениеДоступом
КонецПроцедуры



#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СформированоПриИзменении(Элемент)
	
	УстановитьДоступностьЭлементов(ЭтотОбъект);
	
	Если Не Объект.Сформировано Тогда
		Объект.ДатаСоздания = '00010101';
	ИначеЕсли Объект.ДатаСоздания = '00010101' Тогда
		Объект.ДатаСоздания = ДатаСозданияПоУмолчанию(ОбщегоНазначенияКлиент.ДатаСеанса());
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РасформированоПриИзменении(Элемент)
	
	УстановитьДоступностьЭлементов(ЭтотОбъект);
	
	Если Не Объект.Расформировано Тогда
		Объект.ДатаРасформирования = '00010101';
	ИначеЕсли Объект.ДатаРасформирования = '00010101' Тогда
		Объект.ДатаРасформирования = КонецМесяца(ОбщегоНазначенияКлиент.ДатаСеанса()) + 1;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьЭлементов(Форма)
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"ДатаСоздания",
		"Доступность",
		Форма.Объект.Сформировано);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"Расформировано",
		"Доступность",
		Форма.Объект.Сформировано);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"ДатаРасформирования",
		"Доступность",
		Форма.Объект.Расформировано);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ДатаСозданияПоУмолчанию(ДатаСеанса)
	
	Возврат НачалоГода(ДатаСеанса);
	
КонецФункции

#КонецОбласти

#Область ОбработчикиКомандФормы

#Область СтандартныеПодсистемы_ПодключаемыеКоманды

&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
#КонецОбласти

#КонецОбласти
