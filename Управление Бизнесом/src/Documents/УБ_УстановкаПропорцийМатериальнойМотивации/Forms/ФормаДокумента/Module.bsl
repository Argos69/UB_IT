
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПодсистемы.КадровыйУчет") Тогда
		Элементы.МатериальнаяМотивацияПодборСотрудников.Видимость = Истина;
	Иначе
		Элементы.МатериальнаяМотивацияПодборСотрудников.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	ОрганизацияПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаУстановкиМотивацииПриИзменении(Элемент)
	
	ДатаУстановкиМотивацииПриИзмененииНаСервере();
	
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытийТаблицыФормыМатериальнаяМотивация


&НаКлиенте
Процедура МатериальнаяМотивацияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	ОбработкаПодбораСотрудниковНаСервере(ВыбранноеЗначение);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПодборСотрудников(Команда)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЗарплатаКадрыПодсистемы.КадровыйУчет") Тогда
		
		МодульКадровыйУчетКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("КадровыйУчетКлиент");
		
		ПараметрыОткрытия = Неопределено;
		
		МодульКадровыйУчетКлиент.ВыбратьСотрудниковРаботающихВПериодеПоПараметрамОткрытияФормыСписка(
			Элементы.МатериальнаяМотивация,
			Объект.Организация,
			,
			НачалоМесяца(Объект.ДатаУстановкиМотивации),
			КонецМесяца(Объект.ДатаУстановкиМотивации),
			,
			АдресСпискаПодобранныхСотрудников(Объект.МатериальнаяМотивация),
			ПараметрыОткрытия);
		
	КонецЕсли;
	
КонецПроцедуры


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОрганизацияПриИзмененииНаСервере()
	
	СписокСвязанныхРеквизитов = "Сотрудник";
	УБ_ОбщегоНазначения.УстановитьТипЗначенияСвязанныхРеквизитовПоУмолчанию(
		Объект,
		СписокСвязанныхРеквизитов,
		"МатериальнаяМотивация");
	
КонецПроцедуры

&НаСервере
Процедура ДатаУстановкиМотивацииПриИзмененииНаСервере()
	
	СписокСвязанныхРеквизитов = "Сотрудник";
	УБ_ОбщегоНазначения.УстановитьТипЗначенияСвязанныхРеквизитовПоУмолчанию(
		Объект,
		СписокСвязанныхРеквизитов,
		"МатериальнаяМотивация");
	
КонецПроцедуры

&НаСервере
Функция АдресСпискаПодобранныхСотрудников(Знач ТаблицаСотрудников)
	
	Возврат ПоместитьВоВременноеХранилище(ТаблицаСотрудников.Выгрузить(, "Сотрудник").ВыгрузитьКолонку("Сотрудник"), УникальныйИдентификатор);
	
КонецФункции

&НаСервере
Процедура ОбработкаПодбораСотрудниковНаСервере(ВыбранноеЗначение)
	
	Если ТипЗнч(ВыбранноеЗначение) <> Тип("Массив") Тогда
		ВыбранныеСотрудники = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ВыбранноеЗначение);
	Иначе
		ВыбранныеСотрудники = ОбщегоНазначенияКлиентСервер.СвернутьМассив(ВыбранноеЗначение);
	КонецЕсли;
	
	Для Каждого Сотрудник Из ВыбранныеСотрудники Цикл
		
		СтрокиПоСотруднику = Объект.МатериальнаяМотивация.НайтиСтроки(Новый Структура("Сотрудник", Сотрудник));
		Если СтрокиПоСотруднику.Количество() = 0 Тогда
			НоваяСтрока = Объект.МатериальнаяМотивация.Добавить();
			НоваяСтрока.Сотрудник = Сотрудник;
			
			Модифицированность = Истина;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти