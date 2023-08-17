#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// СтандартныеПодсистемы.ВерсионированияОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
// Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированияОбъектов

Функция АдресаСхемыКомпоновкиДанныхИНастроекВоВременномХранилище(ПоказательЭффективности) Экспорт
	
	Адреса = Новый Структура("СхемаКомпоновкиДанных, НастройкиКомпоновкиДанных");
	
	Если ТипЗнч(ПоказательЭффективности) = Тип("ДанныеФормыСтруктура") Тогда
		ПоказательЭффективностиСсылка = ПоказательЭффективности.Ссылка;
	Иначе
		ПоказательЭффективностиСсылка = ПоказательЭффективности;
	КонецЕсли;
	
	СхемаКомпоновкиДанных = ПоказательЭффективностиСсылка.ХранилищеСхемыКомпоновкиДанных.Получить();
	
	Если СхемаКомпоновкиДанных = Неопределено И ПустаяСтрока(ПоказательЭффективности.СхемаКомпоновкиДанных) Тогда
		СхемаКомпоновкиДанных = Справочники.УБ_ПоказателиЭффективности.ПолучитьМакет("ШаблоннаяСхемаКомпоновкиДанных");
	ИначеЕсли СхемаКомпоновкиДанных = Неопределено
		И Не ПустаяСтрока(ПоказательЭффективности.СхемаКомпоновкиДанных) Тогда
		СхемаКомпоновкиДанных = Справочники.УБ_ПоказателиЭффективности.ПолучитьМакет(ПоказательЭффективности.СхемаКомпоновкиДанных);
	КонецЕсли;
	
	Адреса.СхемаКомпоновкиДанных = ПоместитьВоВременноеХранилище(СхемаКомпоновкиДанных, Новый УникальныйИдентификатор);
	
	Возврат Адреса;
		
КонецФункции

Функция ШаблоныСхемыКомпоновкиДанных() Экспорт
	
	Шаблоны = Новый Массив;
	
	Для Каждого Макет Из Метаданные.Справочники.УБ_ПоказателиЭффективности.Макеты Цикл
		Если Макет.ТипМакета <> Метаданные.СвойстваОбъектов.ТипМакета.СхемаКомпоновкиДанных
			Или Макет.Имя = "ШаблоннаяСхемаКомпоновкиДанных" Тогда
			Продолжить;
		КонецЕсли;
		
		Шаблоны.Добавить(Новый Структура("Имя, Синоним", Макет.Имя, Макет.Синоним));
	КонецЦикла;
	
	Возврат Шаблоны;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбновлениеИнформационнойБазы

Процедура ПриДобавленииОбработчиковОбновления(Обработчики) Экспорт
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "Справочники.УБ_ПоказателиЭффективности.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Версия = "1.0.1.7";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Комментарий = НСтр("ru = 'Заполнение идентификаторов и периодичности расчета показателей эффективности'");
	
	//ИТС++ ШОО 21.10.2021
	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "Справочники.УБ_ПоказателиЭффективности.ОбработатьДанныеДляПереходаНаНовуюВерсию1_02_1";
	Обработчик.Версия = "1.0.2.1";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Комментарий = НСтр("ru = 'Перенос признака ""Архивный"" в реквизит ""СостояниеПоказателя""'");
	//ИТС-- ШОО 21.10.2021
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	//Если Параметры.Версия ="1.0.1.7";

	//	
	//КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПоказателиЭффективности.Ссылка КАК Ссылка,
		|	ПоказателиЭффективности.Наименование КАК Наименование
		|ИЗ
		|	Справочник.УБ_ПоказателиЭффективности КАК ПоказателиЭффективности
		|ГДЕ
		|	НЕ ПоказателиЭффективности.ПометкаУдаления
		|	И НЕ ПоказателиЭффективности.ЭтоГруппа
		|	И (ПоказателиЭффективности.Идентификатор = """"
		|			ИЛИ ПоказателиЭффективности.ПериодичностьРасчета = ЗНАЧЕНИЕ(Перечисление.УБ_ПериодичностьРасчета.ПустаяСсылка))";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		
		НачатьТранзакцию();
		
		Попытка
			
			Блокировка = Новый БлокировкаДанных;
			ЭлементБлокировки = Блокировка.Добавить("Справочник.УБ_ПоказателиЭффективности");
			ЭлементБлокировки.УстановитьЗначение("Ссылка", Выборка.Ссылка);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;;
			Блокировка.Заблокировать();
			
			СправочникОбъект = Выборка.Ссылка.ПолучитьОбъект();
			Если СправочникОбъект = Неопределено Тогда
				ОтменитьТранзакцию();
				Продолжить;
			КонецЕсли;
			
			Если Не ЗначениеЗаполнено(СправочникОбъект.Идентификатор) Тогда
				Идентификатор = ИдентификаторПоПредставлению(Выборка.Наименование);
				СправочникОбъект.Идентификатор = СформироватьИдентификаторПоказателя(Идентификатор, Выборка.Ссылка);
			КонецЕсли;
			
			Если Не ЗначениеЗаполнено(СправочникОбъект.ПериодичностьРасчета) Тогда
				СправочникОбъект.ПериодичностьРасчета = Перечисления.УБ_ПериодичностьРасчета.Месяц;
			КонецЕсли;
			
			ОбновлениеИнформационнойБазы.ЗаписатьДанные(СправочникОбъект);
			ЗафиксироватьТранзакцию();
			
		Исключение
			
			ОтменитьТранзакцию();
			
			ТекстСообщения = НСтр("ru = 'Не удалось обработать справочник: %1 по причине: %2'");
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				ТекстСообщения,
				Выборка.Ссылка,
				ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			
			ЗаписьЖурналаРегистрации(НСтр("ru = 'Обновление информационной базы'"),
				УровеньЖурналаРегистрации.Предупреждение,
				Выборка.Ссылка.Метаданные(),
				Выборка.Ссылка,
				ТекстСообщения);
			
			ВызватьИсключение;
			
		КонецПопытки;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию1_02_1(Параметры) Экспорт
	
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПоказателиЭффективности.Ссылка КАК Ссылка,
		|	ПоказателиЭффективности.Наименование КАК Наименование
		|ИЗ
		|	Справочник.УБ_ПоказателиЭффективности КАК ПоказателиЭффективности
		|ГДЕ
		|	НЕ ПоказателиЭффективности.ПометкаУдаления
		|	И НЕ ПоказателиЭффективности.ЭтоГруппа
		|	И (ПоказателиЭффективности.СостояниеПоказателя = ЗНАЧЕНИЕ(Перечисление.УБ_СостоянияПоказателейЭффективности.ПустаяСсылка))";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Планируется = Перечисления.УБ_СостоянияПоказателейЭффективности.Планируется;
	Архивный	= Перечисления.УБ_СостоянияПоказателейЭффективности.Архивный;
	
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		
		НачатьТранзакцию();
		
		Попытка
			
			Блокировка = Новый БлокировкаДанных;
			ЭлементБлокировки = Блокировка.Добавить("Справочник.УБ_ПоказателиЭффективности");
			ЭлементБлокировки.УстановитьЗначение("Ссылка", Выборка.Ссылка);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;;
			Блокировка.Заблокировать();
			
			СправочникОбъект = Выборка.Ссылка.ПолучитьОбъект();
			Если СправочникОбъект = Неопределено Тогда
				ОтменитьТранзакцию();
				Продолжить;
			КонецЕсли;
			
			СправочникОбъект.СостояниеПоказателя = ?(СправочникОбъект.ВАрхиве, Архивный, Планируется); 

			ОбновлениеИнформационнойБазы.ЗаписатьДанные(СправочникОбъект);
			ЗафиксироватьТранзакцию();
			
		Исключение
			
			ОтменитьТранзакцию();
			
			ТекстСообщения = НСтр("ru = 'Не удалось обработать справочник: %1 по причине: %2'");
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				ТекстСообщения,
				Выборка.Ссылка,
				ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			
			ЗаписьЖурналаРегистрации(НСтр("ru = 'Обновление информационной базы'"),
				УровеньЖурналаРегистрации.Предупреждение,
				Выборка.Ссылка.Метаданные(),
				Выборка.Ссылка,
				ТекстСообщения);
			
			ВызватьИсключение;
			
		КонецПопытки;
		
	КонецЦикла;
	
КонецПроцедуры


#КонецОбласти

Функция ИдентификаторПоПредставлению(Знач Представление)
	
	Идентификатор = "";
	БылРазделитель = Ложь;
	Для НомерСимвола = 1 По СтрДлина(Представление) Цикл
		Символ = Сред(Представление, НомерСимвола, 1);
		Если СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(Символ)
			И ПустаяСтрока(Идентификатор) Тогда
			Продолжить;
		КонецЕсли;
		Если СтроковыеФункцииКлиентСервер.ЭтоРазделительСлов(КодСимвола(Символ)) Тогда
			БылРазделитель = Истина; 
		Иначе
			Если БылРазделитель Тогда
				БылРазделитель = Ложь;
				Символ = ВРег(Символ);
			КонецЕсли;
			Идентификатор = Идентификатор + Символ;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Идентификатор;
	
КонецФункции

Функция СформироватьИдентификаторПоказателя(Идентификатор, Ссылка)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПоказателиЭффективности.Идентификатор КАК Идентификатор
		|ИЗ
		|	Справочник.УБ_ПоказателиЭффективности КАК ПоказателиЭффективности
		|ГДЕ
		|	ПОДСТРОКА(ПоказателиЭффективности.Идентификатор, 1, &КоличествоСимволов) = &Идентификатор
		|	И ПоказателиЭффективности.Ссылка <> &Ссылка";
	
	Запрос.УстановитьПараметр("Идентификатор", Идентификатор);
	Запрос.УстановитьПараметр("КоличествоСимволов", СтрДлина(Идентификатор));
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Идентификатор;
	КонецЕсли;
	
	ТекущиеИдентфикаторы = РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("Идентификатор");
	
	Счетчик = 1;
	Пока Истина Цикл
		НовыйИдентификатор = Идентификатор + Счетчик;
		Если ТекущиеИдентфикаторы.Найти(НовыйИдентификатор) = Неопределено Тогда
			Возврат НовыйИдентификатор;
		КонецЕсли;
		Счетчик = Счетчик + 1;
	КонецЦикла;
	
КонецФункции

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	перем СписокДопустимых;
	перем МассивИсключений;
	
	СтандартнаяОбработка = Ложь;
	ДанныеВыбора = Новый СписокЗначений;
	
	Если Параметры.Свойство("СтрокаПоиска") И Не ПустаяСтрока(Параметры.СтрокаПоиска) Тогда
		СтрокаПоиска = Параметры.СтрокаПоиска;
	Иначе
		СтрокаПоиска = "";
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст =      
	
	 "ВЫБРАТЬ ПЕРВЫЕ 50
	 |	УБ_ПоказателиЭффективности.Ссылка КАК Ссылка,
	 |	ПРЕДСТАВЛЕНИЕ(УБ_ПоказателиЭффективности.Ссылка) КАК Представление,
	 |	УБ_ПоказателиЭффективности.Наименование КАК Наименование,
	 |	УБ_ПоказателиЭффективности.Код КАК Код,
	 |	УБ_ПоказателиЭффективности.ПометкаУдаления КАК ПометкаУдаления
	 |ИЗ
	 |	Справочник.УБ_ПоказателиЭффективности КАК УБ_ПоказателиЭффективности
	 |ГДЕ
	 |	&УсловиеОтбора
	 |	И &УсловиеИсключений
	 |	И НЕ УБ_ПоказателиЭффективности.ЭтоГруппа
	 |	И (&УсловияОтбораПоНаименованию ИЛИ &УсловияОтбораПоКоду)";
	      
	
	
	Если Параметры.Отбор.Свойство("СписокДопустимых", СписокДопустимых) Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&УсловиеОтбора",?(ЗначениеЗаполнено(СписокДопустимых),"УБ_ПоказателиЭффективности.ПринадлежностьПоказателя В (&СписокДопустимых)","Истина"));
		Запрос.УстановитьПараметр("СписокДопустимых", СписокДопустимых); 
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&УсловиеОтбора", "ИСТИНА = ИСТИНА");
	КонецЕсли;
	
	Если Параметры.Отбор.Свойство("МассивИсключений", МассивИсключений) Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&УсловиеИсключений",?(ЗначениеЗаполнено(МассивИсключений),"НЕ УБ_ПоказателиЭффективности.Ссылка В (&МассивИсключений)","Истина"));
		Запрос.УстановитьПараметр("МассивИсключений", МассивИсключений);
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "И &УсловиеИсключений", "");		
	КонецЕсли;
	
	Запрос.Текст = Запрос.Текст + "
		|
		|УПОРЯДОЧИТЬ ПО
		|	УБ_ПоказателиЭффективности.Наименование";
	
	УБ_ОбщегоНазначения.СкорректироватьТекстЗапросаПодТекущуюКонфигурацию(Запрос.Текст);
	
	Если Не ПустаяСтрока(СтрокаПоиска) Тогда
		
		Запрос.УстановитьПараметр("СтрокаПоиска", СтрокаПоиска + "%");
		Запрос.УстановитьПараметр("СтрокаПоискаПоКоду", "%" + СтрокаПоиска + "%");
		
		Запрос.Текст = СтрЗаменить(Запрос.Текст,
			"&УсловияОтбораПоНаименованию",
			"УБ_ПоказателиЭффективности.Наименование ПОДОБНО &СтрокаПоиска");
		Запрос.Текст = СтрЗаменить(Запрос.Текст,
			"&УсловияОтбораПоКоду",
			"УБ_ПоказателиЭффективности.Код ПОДОБНО &СтрокаПоискаПоКоду");
		
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&УсловияОтбораПоНаименованию", "ИСТИНА");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&УсловияОтбораПоКоду", "ИСТИНА");
	КонецЕсли;
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ДлинаСтрокиПоиска = СтрДлина(СтрокаПоиска);
	
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		
		Если Не ПустаяСтрока(СтрокаПоиска) И Не СтрНачинаетсяС(ВРег(Выборка.Представление), ВРег(СтрокаПоиска)) Тогда
			
			ПредставлениеМодели = "(" + Выборка.Код + ") " + Выборка.Представление;
			
			ПозицияСтрокиПоиска = СтрНайти(ВРег(ПредставлениеМодели), ВРег(СтрокаПоиска));
			Представление = Новый ФорматированнаяСтрока(
				Лев(ПредставлениеМодели, ПозицияСтрокиПоиска - 1),
				Новый ФорматированнаяСтрока(
					Сред(ПредставлениеМодели, ПозицияСтрокиПоиска, ДлинаСтрокиПоиска),
					Новый Шрифт( , , Истина),
					WebЦвета.Зеленый),
				Сред(ПредставлениеМодели, ПозицияСтрокиПоиска + ДлинаСтрокиПоиска));
			
		Иначе
			
			ПредставлениеМодели = Выборка.Представление + " (" + Выборка.Код + ")";
			
			Представление = Новый ФорматированнаяСтрока(
				Новый ФорматированнаяСтрока(
					Лев(ПредставлениеМодели, ДлинаСтрокиПоиска),
					Новый Шрифт( , , Истина),
					WebЦвета.Зеленый),
				Сред(ПредставлениеМодели, ДлинаСтрокиПоиска + 1));
			
		КонецЕсли;
		
		ЗначениеВыбора = Новый Структура;
		ЗначениеВыбора.Вставить("Значение", Выборка.Ссылка);
		ЗначениеВыбора.Вставить("ПометкаУдаления", Выборка.ПометкаУдаления);
		ЗначениеВыбора.Вставить("Предупреждение", "");
		
		ДанныеВыбора.Добавить(ЗначениеВыбора, Представление, Выборка.ПометкаУдаления);
		
	КонецЦикла;
КонецПроцедуры

#КонецОбласти


#КонецЕсли