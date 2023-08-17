#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого Запись Из ЭтотОбъект Цикл
		СписокРеквизитов = "Подразделение, Сотрудник";
		УБ_ОбщегоНазначения.УстановитьТипЗначенияСвязанныхРеквизитовПоУмолчанию(Запись, СписокРеквизитов);
	КонецЦикла;
	
	КонтрольИзмененийПередЗаписью();
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	КонтрольИзмененийПриЗаписи();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс
// Параметры:
// ВидОперации - Строка, совпадает с нужным значением перечисления УБ_ВидыОперацийДелегирования, например ПодсистемаМотивации
Функция ТаблицаИзменившихсяДанныхНабора() Экспорт
	
	КэшТаблицаИзменившихсяДанных = Неопределено;
	
	Если ДополнительныеСвойства.Свойство("КэшТаблицаИзменившихсяДанных", КэшТаблицаИзменившихсяДанных) Тогда    
		Возврат КэшТаблицаИзменившихсяДанных.Скопировать();
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура КонтрольИзмененийПередЗаписью()
	
	Если ДополнительныеСвойства.Свойство("КэшТаблицаИзменившихсяДанных") Тогда
		ДополнительныеСвойства.Удалить("КэшТаблицаИзменившихсяДанных");
	КонецЕсли;
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	ДополнительныеСвойства.Вставить("МенеджерВременныхТаблицИзмененияРегистра", МенеджерВременныхТаблиц);
	
	СоздатьВТСтарыйНаборЗаписей(МенеджерВременныхТаблиц, ИмяВТСтарыйНаборРегистра(Метаданные().Имя));
	
КонецПроцедуры

Процедура КонтрольИзмененийПриЗаписи()
	
	Запрос = ЗапросВТИзмененияВНаборе(Метаданные().Имя, ЭтотОбъект.Отбор.Регистратор.Значение);
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблицИзмененияРегистра;
	КэшТаблицаИзменившихсяДанных = Запрос.Выполнить().Выгрузить();
	ДополнительныеСвойства.Вставить("КэшТаблицаИзменившихсяДанных", КэшТаблицаИзменившихсяДанных);
	
КонецПроцедуры

Процедура СоздатьВТСтарыйНаборЗаписей(МенеджерВременныхТаблиц, ИмяВТРезультат = "ВТСтарыйНаборЗаписей")
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	*
		|ПОМЕСТИТЬ ВТСтарыйНаборЗаписей
		|ИЗ
		|	РегистрСведений.УБ_ДелегированныеСотрудникиПодразделения КАК РегистрСведений
		|ГДЕ
		|	РегистрСведений.Регистратор = &Регистратор";
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "ВТСтарыйНаборЗаписей", ИмяВТРезультат);
	
	Запрос.УстановитьПараметр("Регистратор", ЭтотОбъект.Отбор.Регистратор.Значение);
	РезультатЗапроса = Запрос.Выполнить();
	
	ДополнительныеСвойства.Вставить("ЭтоНовыйНабор", РезультатЗапроса.Пустой());
	
КонецПроцедуры

Функция ЗапросВТИзмененияВНаборе(ИмяРегистра, РегистраторТекущегоНабора)
	
	ТекстЗапроса = 
		"ВЫБРАТЬ
		|	ВложенныйЗапрос.Период,
		|	ВложенныйЗапрос._Измерения,
		|	&ИзменившиесяРесурсы,
		|	&СтарыеЗначенияРесурсов,
		|	&НовыеЗначенияРесурсов,
		|	ВложенныйЗапрос._Реквизиты,
		|	ВЫБОР
		|		КОГДА СУММА(ВложенныйЗапрос.ФлагИзменений) = 1
		|			ТОГДА ИСТИНА
		|		ИНАЧЕ ЛОЖЬ
		|	КОНЕЦ КАК Удаление,
		|	ВЫБОР
		|		КОГДА СУММА(ВложенныйЗапрос.ФлагИзменений) = -1
		|			ТОГДА ИСТИНА
		|		ИНАЧЕ ЛОЖЬ
		|	КОНЕЦ КАК Добавление
		|ИЗ
		|	(ВЫБРАТЬ
		|		СтарыйНабор.Период КАК Период,
		|		СтарыйНабор._Измерения КАК _Измерения,
		|		СтарыйНабор._Ресурсы КАК _Ресурсы,
		|		СтарыйНабор._Реквизиты КАК _Реквизиты,
		|		1 КАК ФлагИзменений,
		|		ЛОЖЬ КАК НовыйНабор
		|	ИЗ
		|		&СтарыйНабор КАК СтарыйНабор
		|	
		|	ОБЪЕДИНИТЬ ВСЕ
		|	
		|	ВЫБРАТЬ
		|		НовыйНабор.Период,
		|		НовыйНабор._Измерения,
		|		НовыйНабор._Ресурсы,
		|		НовыйНабор._Реквизиты,
		|		-1,
		|		ИСТИНА
		|	ИЗ
		|		&ТаблицаРегистра КАК НовыйНабор
		|	ГДЕ
		|		НовыйНабор.Регистратор = &Регистратор) КАК ВложенныйЗапрос
		|
		|СГРУППИРОВАТЬ ПО
		|	ВложенныйЗапрос.Период,
		|	ВложенныйЗапрос._Измерения
		|
		|ИМЕЮЩИЕ
		|	(СУММА(ВложенныйЗапрос.ФлагИзменений) <> 0
		|		ИЛИ &УсловиеИзменившиесяРесурсы)";
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&СтарыйНабор", ИмяВТСтарыйНаборРегистра(ИмяРегистра));
	
	ОписаниеРегистра = ОписаниеРегистра(ИмяРегистра, Истина);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ТаблицаРегистра", "РегистрСведений." + ИмяРегистра);
	Если ОписаниеРегистра.Свойство("Периодичность")
		И ОписаниеРегистра.Периодичность = Метаданные.СвойстваОбъектов.ПериодичностьРегистраСведений.Непериодический Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "СтарыйНабор.Период", "ДАТАВРЕМЯ(1, 1, 1)");
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "НовыйНабор.Период", "ДАТАВРЕМЯ(1, 1, 1)");
	КонецЕсли;
	
	РазделительПолейЗапроса = "," + Символы.ПС;
	
	ПоляИзмеренияСтарогоНабораЗапроса = Новый Массив;
	ПоляИзмеренияНовогоНабораЗапроса = Новый Массив;
	ПоляИзмеренияВнешнегоЗапроса = Новый Массив;
	
	ПоляРеквизитовСтарогоНабораЗапроса = Новый Массив;
	ПоляРеквизитовНовогоНабораЗапроса = Новый Массив;
	ПоляРеквизитовВнешнегоЗапроса = Новый Массив;
	
	Для Каждого Измерение Из ОписаниеРегистра.Измерения Цикл
		ПоляИзмеренияСтарогоНабораЗапроса.Добавить("СтарыйНабор." + Измерение + " КАК " + Измерение);
		ПоляИзмеренияНовогоНабораЗапроса.Добавить("НовыйНабор." + Измерение + " КАК " + Измерение);
		ПоляИзмеренияВнешнегоЗапроса.Добавить("ВложенныйЗапрос." + Измерение);
	КонецЦикла;
	
	Для Каждого Реквизит Из ОписаниеРегистра.Реквизиты Цикл
		ПоляРеквизитовСтарогоНабораЗапроса.Добавить("СтарыйНабор." + Реквизит + " КАК " + Реквизит);
		ПоляРеквизитовНовогоНабораЗапроса.Добавить("НовыйНабор." + Реквизит + " КАК " + Реквизит);
		ПоляРеквизитовВнешнегоЗапроса.Добавить("МАКСИМУМ(ВложенныйЗапрос." + Реквизит + ") КАК " + Реквизит);
	КонецЦикла;
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "СтарыйНабор._Измерения КАК _Измерения",
		СтрСоединить(ПоляИзмеренияСтарогоНабораЗапроса, РазделительПолейЗапроса));
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "НовыйНабор._Измерения",
		СтрСоединить(ПоляИзмеренияНовогоНабораЗапроса, РазделительПолейЗапроса));
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ВложенныйЗапрос._Измерения",
		СтрСоединить(ПоляИзмеренияВнешнегоЗапроса, РазделительПолейЗапроса));
	
	Если ОписаниеРегистра.Реквизиты.Количество() Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "СтарыйНабор._Реквизиты КАК _Реквизиты",
			СтрСоединить(ПоляРеквизитовСтарогоНабораЗапроса, РазделительПолейЗапроса));
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "НовыйНабор._Реквизиты",
			СтрСоединить(ПоляРеквизитовНовогоНабораЗапроса, РазделительПолейЗапроса));
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ВложенныйЗапрос._Реквизиты",
			СтрСоединить(ПоляРеквизитовВнешнегоЗапроса, РазделительПолейЗапроса));
	Иначе
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "СтарыйНабор._Реквизиты КАК _Реквизиты,", "");
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "НовыйНабор._Реквизиты,", "");
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ВложенныйЗапрос._Реквизиты,", "");
	КонецЕсли;
	
	ПоляРесурсыСтарогоНабора = Новый Массив;
	ПоляРесурсыНовогоНаборы = Новый Массив;
	ПоляСтарыеЗначенияРесурсов = Новый Массив;
	ПоляНовыеЗначенияРесурсов = Новый Массив;	
	ПоляИзменившиесяРесурсы = Новый Массив;
	ЧастиУсловияИзменившиесяРесурсы = Новый Массив;
	
	ШаблонПоляИзменениеРесурса = 
	"	ВЫБОР
	|		КОГДА МАКСИМУМ(ВложенныйЗапрос._Ресурс) <> МИНИМУМ(ВложенныйЗапрос._Ресурс)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ИзменилсяРесурс_Ресурс";
	
	ШаблонУсловияИзмененияРесурса = 
	"	ВЫБОР
	|		КОГДА МАКСИМУМ(ВложенныйЗапрос._Ресурс) <> МИНИМУМ(ВложенныйЗапрос._Ресурс)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ";
	
	ШаблонПоляСтарогоЗначенияРесурса = 
	"	МАКСИМУМ(ВЫБОР
	|				КОГДА НЕ ВложенныйЗапрос.НовыйНабор  
	|					ТОГДА ВложенныйЗапрос._Ресурс
	|				ИНАЧЕ НЕОПРЕДЕЛЕНО
	|			КОНЕЦ) КАК СтароеЗначение_Ресурс";
	
	ШаблонПоляНовогоЗначенияРесурса = 
	"	МАКСИМУМ(ВЫБОР
	|				КОГДА ВложенныйЗапрос.НовыйНабор
	|					ТОГДА ВложенныйЗапрос._Ресурс
	|				ИНАЧЕ НЕОПРЕДЕЛЕНО
	|			КОНЕЦ) КАК НовоеЗначение_Ресурс";

	
	Для Каждого Ресурс Из ОписаниеРегистра.Ресурсы Цикл
		ПоляРесурсыСтарогоНабора.Добавить("СтарыйНабор." + Ресурс + " КАК " + Ресурс);
		ПоляРесурсыНовогоНаборы.Добавить("НовыйНабор." + Ресурс);
		
		ТекстПоляИзменившиесяРесурсы = СтрЗаменить(ШаблонПоляИзменениеРесурса, "_Ресурс", Ресурс);
		ПоляИзменившиесяРесурсы.Добавить(ТекстПоляИзменившиесяРесурсы);
		
		ТекстУсловияИзменившиесяРесурсы = СтрЗаменить(ШаблонУсловияИзмененияРесурса, "_Ресурс", Ресурс);
		ЧастиУсловияИзменившиесяРесурсы.Добавить(ТекстУсловияИзменившиесяРесурсы);
		
		ТекстПоляСтароеЗначениеРесурса = СтрЗаменить(ШаблонПоляСтарогоЗначенияРесурса, "_Ресурс", Ресурс);
		ПоляСтарыеЗначенияРесурсов.Добавить(ТекстПоляСтароеЗначениеРесурса);
		
		ТекстПоляНовоеЗначениеРесурса = СтрЗаменить(ШаблонПоляНовогоЗначенияРесурса, "_Ресурс", Ресурс);
		ПоляНовыеЗначенияРесурсов.Добавить(ТекстПоляНовоеЗначениеРесурса);
	КонецЦикла;
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "СтарыйНабор._Ресурсы КАК _Ресурсы", СтрСоединить(ПоляРесурсыСтарогоНабора, РазделительПолейЗапроса));
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "НовыйНабор._Ресурсы", СтрСоединить(ПоляРесурсыНовогоНаборы, РазделительПолейЗапроса));
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ИзменившиесяРесурсы", СтрСоединить(ПоляИзменившиесяРесурсы, РазделительПолейЗапроса));	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&СтарыеЗначенияРесурсов", СтрСоединить(ПоляСтарыеЗначенияРесурсов, РазделительПолейЗапроса));
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&НовыеЗначенияРесурсов", СтрСоединить(ПоляНовыеЗначенияРесурсов, РазделительПолейЗапроса));
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&УсловиеИзменившиесяРесурсы", СтрСоединить(ЧастиУсловияИзменившиесяРесурсы, " ИЛИ "));
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	Запрос.УстановитьПараметр("Регистратор", РегистраторТекущегоНабора);
	
	Возврат Запрос;
	
КонецФункции

Функция ИмяВТСтарыйНаборРегистра(ИмяРегистра)
	
	Возврат "ВТ" + ИмяРегистра + "СтарыйНабор";
	
КонецФункции

Функция ОписаниеРегистра(Знач ИмяРегистра, Знач ИсключатьНеИспользуемые = Истина)
	
	МетаданныеРегистра = Метаданные();
	
	Измерения = Новый Массив;
	Для Каждого Измерение Из МетаданныеРегистра.Измерения Цикл
		Если ИсключатьНеИспользуемые И СтрНайти(ВРег(Измерение.Имя), ВРег("Удалить")) = 1 Тогда
			Продолжить;
		КонецЕсли;
		Измерения.Добавить(Измерение.Имя);
	КонецЦикла;
	
	Ресурсы = Новый Массив;
	Для Каждого Ресурс Из МетаданныеРегистра.Ресурсы Цикл
		Если ИсключатьНеИспользуемые И СтрНайти(ВРег(Ресурс.Имя), ВРег("Удалить")) = 1 Тогда
			Продолжить;
		КонецЕсли;
		Ресурсы.Добавить(Ресурс.Имя);
	КонецЦикла;
	
	Реквизиты = Новый Массив;
	Для Каждого Реквизит Из МетаданныеРегистра.Реквизиты Цикл
		Если ИсключатьНеИспользуемые И СтрНайти(ВРег(Реквизит.Имя), ВРег("Удалить")) = 1 Тогда
			Продолжить;
		КонецЕсли;
		Реквизиты.Добавить(Реквизит.Имя);
	КонецЦикла;
	
	СтандартныеРеквизиты = Новый Массив;
	Для Каждого СтандартныйРеквизит Из МетаданныеРегистра.СтандартныеРеквизиты Цикл
		Если СтандартныйРеквизит.Имя <> "Период" Тогда
			СтандартныеРеквизиты.Добавить(СтандартныйРеквизит.Имя);
		КонецЕсли;
	КонецЦикла;
	
	СтруктураОписанияРегистра = Новый Структура;
	СтруктураОписанияРегистра.Вставить("ИмяРегистра", ИмяРегистра);
	СтруктураОписанияРегистра.Вставить("Измерения", Измерения);
	СтруктураОписанияРегистра.Вставить("Ресурсы", Ресурсы);
	СтруктураОписанияРегистра.Вставить("Реквизиты", Реквизиты);
	СтруктураОписанияРегистра.Вставить("СтандартныеРеквизиты", СтандартныеРеквизиты);
	СтруктураОписанияРегистра.Вставить("Периодичность", МетаданныеРегистра.ПериодичностьРегистраСведений);
	
	Возврат СтруктураОписанияРегистра;
	
КонецФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.
						|en = 'Invalid object call on the client.''");
#КонецЕсли	