
#Область ПрограммныйИнтерфейс

#Область ПодготовкаИЗаписьДвиженийДокумента

// Процедура инициализирует общие структуры, используемые при проведении документов.
//  Вызывается из модуля документов при проведении.
//
// Параметры:
//  ДокументСсылка			 - ДокументСсылка - ссылка на документ
//  ДополнительныеСвойства	 - Структура - дополнительные свойства документа-объекта
//  РежимПроведения			 - РежимПроведенияДокумента - режим проведения.
//
Процедура ИнициализироватьДополнительныеСвойстваДляПроведения(ДокументСсылка, ДополнительныеСвойства, РежимПроведения = Неопределено) Экспорт

	// В структуре "ДополнительныеСвойства" создаются свойства с ключами "ТаблицыДляДвижений", "ДляПроведения".

	// "ТаблицыДляДвижений" - структура, которая будет содержать таблицы значений с данными для выполнения движений.
	ДополнительныеСвойства.Вставить("ТаблицыДляДвижений", Новый Структура);

	// "ДляПроведения" - структура, содержащая свойства и реквизиты документа, необходимые для проведения.
	ДополнительныеСвойства.Вставить("ДляПроведения", Новый Структура);
	
	// Структура, содержащая ключ с именем "МенеджерВременныхТаблиц", в значении которого хранится менеджер временных таблиц.
	// Содержит для каждой временной таблицы ключ (имя временной таблицы) и значение (признак наличия записей во временной таблице).
	ДополнительныеСвойства.ДляПроведения.Вставить("СтруктураВременныеТаблицы", Новый Структура("МенеджерВременныхТаблиц", Новый МенеджерВременныхТаблиц));
	ДополнительныеСвойства.ДляПроведения.Вставить("РежимПроведения",           РежимПроведения);
	ДополнительныеСвойства.ДляПроведения.Вставить("МетаданныеДокумента",       ДокументСсылка.Метаданные());
	ДополнительныеСвойства.ДляПроведения.Вставить("Ссылка",                    ДокументСсылка);
	
КонецПроцедуры

// Выполняет закрытие менеджера временных таблиц в структуре дополнительных свойств документа, используемых 
// при проведении.
//
// Параметры:
//	ДополнительныеСвойства - Структура - структура с дополнительными свойствами документа, используемыми
//		при проведении.
//
Процедура ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства) Экспорт
	
	ДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы.МенеджерВременныхТаблиц.Закрыть();
	
КонецПроцедуры

// Процедура выполняет подготовку наборов записей документа к записи движений.
//  1. Очищает наборы записей от "старых записей" (ситуация возможна только в толстом клиенте)
//  2. Взводит флаг записи у наборов, по которым документ имеет движения
//  Вызывается из модуля документов при проведении.
//
// Параметры:
//  Объект	 - ДокументОбъект - наборы записей которого нудно подготовить
//  ЭтоНовый - Булево - признак нового документа
//  ДвиженияМетаданные - свойство метаданных Движения.
//  ОтключитьПроверкуДатыЗапретаИзменения - Булево.
//
Процедура ПодготовитьНаборыЗаписейКРегистрацииДвижений(Объект, ЭтоНовый = Ложь, ДвиженияМетаданные = НеОпределено, ОтключитьПроверкуДатыЗапретаИзменения = Ложь) Экспорт
	Перем МетаданныеДвижения;
	
	Для Каждого НаборЗаписей Из Объект.Движения Цикл

		Если НаборЗаписей.Количество() > 0 Тогда
			НаборЗаписей.Очистить();
		КонецЕсли;

	КонецЦикла;
	
	Если Не ЭтоНовый Тогда
		
		Если Объект.ДополнительныеСвойства.Свойство("ДляПроведения")
		 И Объект.ДополнительныеСвойства.ДляПроведения.Свойство("МетаданныеДокумента") Тогда
			МетаданныеДвижения = Объект.ДополнительныеСвойства.ДляПроведения.МетаданныеДокумента.Движения;
		Иначе
			МетаданныеДвижения = Объект.Метаданные().Движения;
		КонецЕсли;
		
		МассивИменРегистров = ПолучитьИспользуемыеРегистры(Объект.Ссылка, МетаданныеДвижения);

		Для Каждого ИмяРегистра Из МассивИменРегистров Цикл
			Объект.Движения[ИмяРегистра].Записывать = Истина;
		КонецЦикла;

	КонецЕсли;
	
	Если ОтключитьПроверкуДатыЗапретаИзменения Тогда
		ОтключитьПроверкуДатыЗапретаИзменения(Объект.Движения, ОтключитьПроверкуДатыЗапретаИзменения);
	КонецЕсли;
	
КонецПроцедуры

// Процедура записывает движения документа. Дополнительно происходит копирование параметров
//  в модули наборов записей для выполнения регистрации изменений в движениях.
//  Процедура вызывается из модуля документов при проведении.
//
// Параметры:
//  Объект	 - ДокументОбъект - объект, для которого нужно записать движения.
//
Процедура ЗаписатьНаборыЗаписей(Объект) Экспорт
	
	Объект.Движения.Записать();
	
КонецПроцедуры

// Процедура компонует текст запроса, выполняет запрос и выгружает результаты запроса в таблицы.
//
// Параметры:
//  Запрос					 - Запрос	 - запрос, параметры которого предварительно установлены.
//  ТекстыЗапроса			 - СписокЗначений	 - в списке перечислены тексты запросов и их имена.
//  Таблицы					 - Структура		 - структура в которую будут помещены полученные таблицы для движений.
//  ДобавитьРазделитель		 - Булево			 - Истина, если нужно добавить разделитель ";" между запросами.
//  ДобавлятьСловоТаблица	 - Булево			 - Истина, если к имени таблицы движений нужно в начало добавить слово "Таблица".
//  ТолькоОтмеченные		 - Булево			 - признак пропуска инициализации таблицы движения.
//
Процедура ИнициализироватьТаблицыДляДвижений(Запрос, ТекстыЗапроса, Таблицы, ДобавитьРазделитель = Ложь, ДобавлятьСловоТаблица = Истина, ТолькоОтмеченные = Ложь) Экспорт
	
	ТаблицыЗапроса = ВыгрузитьРезультатыЗапроса(Запрос, ТекстыЗапроса,, ДобавитьРазделитель);
	
	// Помещение результатов запроса в таблицы
	Для Каждого ТекстЗапроса Из ТекстыЗапроса Цикл

		ИмяТаблицы = ТекстЗапроса.Представление;

		Если Не ПустаяСтрока(ИмяТаблицы) И (Не ТолькоОтмеченные Или ТекстЗапроса.Пометка) Тогда
		
			Если ДобавлятьСловоТаблица Тогда
				// Таблицы для проведения должны начинаться с "Таблица"
				Если НЕ СтрНачинаетсяС(ИмяТаблицы, "Таблица") Тогда
					ИмяТаблицы = "Таблица" + ИмяТаблицы;
				КонецЕсли;
			КонецЕсли;
			
			Таблицы.Вставить(ИмяТаблицы, ТаблицыЗапроса[ТекстЗапроса.Представление]);
			
		КонецЕсли;

	КонецЦикла;

КонецПроцедуры

// Проверяет наличие текста запроса для формирования указанной таблицы
//
// Параметры:
//  ИмяТаблицы		 - Строка		 - имя таблицы
//  ТекстыЗапроса	 - СписокЗначений	 - список значений, значениями которого являются блоки запроса,
//  	синонимами - имена таблиц в которые необходимо поместить
//  	результат выполнения каждого отдельного блока запроса.
// 
// Возвращаемое значение:
//  Булево - Истина, если текст запроса есть.
//
Функция ЕстьТаблицаЗапроса(ИмяТаблицы, ТекстыЗапроса) Экспорт

	Если ТекстыЗапроса = Неопределено Тогда
		Возврат Истина;
	КонецЕсли; 
	
	Для каждого ТекстЗапроса Из ТекстыЗапроса Цикл
		Если НРег(ТекстЗапроса.Представление) = НРег(ИмяТаблицы) Тогда
			Возврат Истина;
		КонецЕсли; 
	КонецЦикла; 
	
	Возврат Ложь;

КонецФункции

// Определяет необходимость подготовить таблицу для формирования движений
//
// Параметры:
//  ИмяРегистра	- Строка - имя регистра. Например "ТоварыНаСкладах"
//  Регистры	- Строка, Структура, Неопределено - список регистров, разделенных запятой, или структура, в ключах которой - имена регистров
//													Если неопределено - то всегда возвращается ИСТИНА.
// 
// Возвращаемое значение:
//   - Булево - Истина, если требуется инициализировать указанную таблицу.
//
Функция ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Экспорт

	Если ЗначениеЗаполнено(Регистры) Тогда
		
		Если ТипЗнч(Регистры) = Тип("Строка") Тогда
			МассивРегистров = Новый Структура(Регистры);
		Иначе
			МассивРегистров = Регистры;
		КонецЕсли;
		
		Если НЕ МассивРегистров.Свойство(ИмяРегистра) Тогда
			Возврат Ложь;
		КонецЕсли; 
		
	КонецЕсли; 
	
	Возврат Истина;

КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Формирует массив имен регистров, по которым документ имеет движения.
//  Вызывается при подготовке записей к регистрации движений.
//
// Параметры:
//  Регистратор					 - ДокументСсылка	 - ссылка на документ, для которого формируется список регистров
//  Движения					 - КоллекцияДвижений - движения документа
//  МассивИсключаемыхРегистров	 - Массив			 - исключаемые регистры.
// 
// Возвращаемое значение:
//  Массив - массив имен регистров, по которым документ имеет движения.
//
Функция ПолучитьИспользуемыеРегистры(Регистратор, Движения, МассивИсключаемыхРегистров = Неопределено) Экспорт

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", Регистратор);

	Результат = Новый Массив;
	МаксимумТаблицВЗапросе = 256;

	СчетчикТаблиц   = 0;
	СчетчикДвижений = 0;

	ВсегоДвижений = Движения.Количество();
	ТекстЗапроса  = "";
	Для Каждого Движение Из Движения Цикл

		СчетчикДвижений = СчетчикДвижений + 1;

		ПропуститьРегистр = МассивИсключаемыхРегистров <> Неопределено
							И МассивИсключаемыхРегистров.Найти(Движение.Имя) <> Неопределено;

		Если Не ПропуститьРегистр Тогда

			Если СчетчикТаблиц > 0 Тогда

				ТекстЗапроса = ТекстЗапроса + "
				|ОБЪЕДИНИТЬ ВСЕ
				|";

			КонецЕсли;

			СчетчикТаблиц = СчетчикТаблиц + 1;

			ТекстЗапроса = ТекстЗапроса + 
			"
			|ВЫБРАТЬ ПЕРВЫЕ 1
			|""" + Движение.Имя + """ КАК ИмяРегистра
			|
			|ИЗ " + Движение.ПолноеИмя() + "
			|
			|ГДЕ Регистратор = &Регистратор
			|";

		КонецЕсли;

		Если СчетчикТаблиц = МаксимумТаблицВЗапросе Или СчетчикДвижений = ВсегоДвижений Тогда

			Запрос.Текст  = ТекстЗапроса;
			ТекстЗапроса  = "";
			СчетчикТаблиц = 0;

			Если Результат.Количество() = 0 Тогда

				Результат = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("ИмяРегистра");

			Иначе

				Выборка = Запрос.Выполнить().Выбрать();
				Пока Выборка.Следующий() Цикл
					Результат.Добавить(Выборка.ИмяРегистра);
				КонецЦикла;

			КонецЕсли;
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;

КонецФункции

Процедура ОтключитьПроверкуДатыЗапретаИзменения(Движения, ОтключитьПроверкуДатыЗапретаИзменения) Экспорт
	
	Для Каждого НаборЗаписей Из Движения Цикл
		
		Если ОтключитьПроверкуДатыЗапретаИзменения Тогда
			НаборЗаписей.ДополнительныеСвойства.Вставить("ОтключитьПроверкуДатыЗапретаИзменения", Истина);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

// Формирует пакет запросов и возвращает результат каждого запроса
//
// Параметры:
//	Запрос			- Запрос - запрос, параметры которого предварительно установлены.
//	ТекстыЗапроса	- СписокЗначений - в списке перечислены тексты запросов и их имена.
//	ОбходРезультата - ОбходРезультатаЗапроса - вариант обхода результата запроса.
//	ДобавитьРазделитель - Булево - добавлять разделитель между запросами из ТекстыЗапроса
//	УничтожитьСозданныеВременныеТаблицы - Булево - добавить уничтожение временных таблиц, создаваемых в ТекстыЗапроса
//										Для уничтожения таблице должно быть присвоено имя в ТекстыЗапроса.
//
// Возвращаемое значение:
//   Структура   - структура в которую помещены полученные таблицы.
//
Функция ВыгрузитьРезультатыЗапроса(Запрос,
								 	ТекстыЗапроса,
									ОбходРезультата = Неопределено,
									ДобавитьРазделитель = Ложь,
									УничтожитьСозданныеВременныеТаблицы = Ложь) Экспорт

	Таблицы = Новый Структура;
	
	// Инициализация варианта обхода результата запроса.
	Если ОбходРезультата = Неопределено Тогда
		ОбходРезультата = ОбходРезультатаЗапроса.Прямой;
	КонецЕсли;
	
	МассивТекстовЗапросов 	 = Новый Массив;
	МассивУничтожаемыхТаблиц = Новый Массив;
	
	// Формирование текст запроса.
	Для Каждого ТекстЗапроса Из ТекстыЗапроса Цикл
		
		Если ЗначениеЗаполнено(ТекстЗапроса.Представление) Тогда
			МассивТекстовЗапросов.Добавить("// " + ТекстЗапроса.Представление);
		КонецЕсли; 
		
		МассивТекстовЗапросов.Добавить(ТекстЗапроса.Значение + ?(ДобавитьРазделитель, РазделительЗапросовВПакете(), ""));
		
		Если УничтожитьСозданныеВременныеТаблицы
		 И ЗначениеЗаполнено(ТекстЗапроса.Представление)
		 И СтрНайти(ВРег(ТекстЗапроса.Значение), "ПОМЕСТИТЬ") <> 0 Тогда
			МассивУничтожаемыхТаблиц.Добавить(ТекстЗапроса.Представление);
		КонецЕсли;
		
	КонецЦикла;
	
	Для Каждого ИмяУдаляемойТаблицы Из МассивУничтожаемыхТаблиц Цикл
		МассивТекстовЗапросов.Добавить("УНИЧТОЖИТЬ " + ИмяУдаляемойТаблицы + РазделительЗапросовВПакете());
	КонецЦикла;
	
	Если МассивТекстовЗапросов.Количество() > 0 Тогда
		
		// Выполнение запроса.
		Запрос.Текст = СтрСоединить(МассивТекстовЗапросов, Символы.ПС);
		Результаты = Запрос.ВыполнитьПакет();

		// Помещение результатов запроса в таблицы.
		Для Каждого ТекстЗапроса Из ТекстыЗапроса Цикл
			ИмяТаблицы = ТекстЗапроса.Представление;
			Если НЕ ПустаяСтрока(ИмяТаблицы) Тогда // имя таблицы
				Результат = Результаты[ТекстыЗапроса.Индекс(ТекстЗапроса)];
				Если Результат <> Неопределено Тогда
					ТаблицаЗапроса = Результат.Выгрузить(ОбходРезультата);
					Если Таблицы.Свойство(ТекстЗапроса.Представление) Тогда
						ОбъединитьТаблицыРезультатовЗапроса(ТаблицаЗапроса, Таблицы[ИмяТаблицы]);
					Иначе
						Таблицы.Вставить(ИмяТаблицы, ТаблицаЗапроса);
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;

		КонецЦикла;
		
	КонецЕсли;
	
	Возврат Таблицы;
	
КонецФункции

// Возвращает строку для вставки между запросами, объединяемыми в пакет
// 
// Возвращаемое значение:
//  Строка 
//
Функция РазделительЗапросовВПакете() Экспорт
	
	Возврат "
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|";
	
КонецФункции

// Выполняет добавление строк из таблицы источника в таблицу приемник с предварительной проверкой:
// - типов колонок
// - состава колонок
// При необходимости выполняет корректировку таблицы-приемника.
//
Процедура ОбъединитьТаблицыРезультатовЗапроса(ТаблицаИсточник, ТаблицаПриемник)
	
	КолонкиДляОбъединенияТипов = Новый Структура();
	КолонкиДляДобавления = Новый Структура();
	Для каждого КолонкаИсточника Из ТаблицаИсточник.Колонки Цикл
		КолонкаПриемника = ТаблицаПриемник.Колонки.Найти(КолонкаИсточника.Имя);
		Если КолонкаПриемника <> Неопределено Тогда
			
			КолонкаИсточникаТипы = КолонкаИсточника.ТипЗначения.Типы();
			ОтсутствующиеТипы = Новый Массив;
			
			// Проверим наличие типов входящих в описание источника в приемнике.
			// Если отсутствуют - объединим описания типов, пересоздадим колонки таблицы.
			Для каждого ТипКолонкиИсточника Из КолонкаИсточникаТипы Цикл
				Если НЕ КолонкаПриемника.ТипЗначения.СодержитТип(ТипКолонкиИсточника) Тогда
					ОтсутствующиеТипы.Добавить(ТипКолонкиИсточника);
				КонецЕсли;
			КонецЦикла;
			
			// Сравним квалификаторы примитивных типов источника и приемника.
			// Если в описании типов источника квалификаторы "более общие", то возьмем их.
			ИзменитьКвалификаторыЧисла = Ложь;
			КвалификаторыЧисла = КолонкаПриемника.ТипЗначения.КвалификаторыЧисла;
			Если КолонкаИсточника.ТипЗначения.СодержитТип(Тип("Число")) И КолонкаПриемника.ТипЗначения.СодержитТип(Тип("Число")) Тогда
				КвалификаторыЧислаИсточника = КолонкаИсточника.ТипЗначения.КвалификаторыЧисла;  
				Если КвалификаторыЧислаИсточника.Разрядность > КвалификаторыЧисла.Разрядность Тогда
					Разрядность = КвалификаторыЧислаИсточника.Разрядность;
					ИзменитьКвалификаторЧисла = Истина;
				Иначе
					Разрядность = КвалификаторыЧисла.Разрядность;
				КонецЕсли;
				Если КвалификаторыЧислаИсточника.РазрядностьДробнойЧасти > КвалификаторыЧисла.РазрядностьДробнойЧасти Тогда
					РазрядностьДробнойЧасти = КвалификаторыЧислаИсточника.РазрядностьДробнойЧасти;
					ИзменитьКвалификаторыЧисла = Истина;
				Иначе
					РазрядностьДробнойЧасти = КвалификаторыЧисла.РазрядностьДробнойЧасти;
				КонецЕсли;
				Если КвалификаторыЧислаИсточника.ДопустимыйЗнак <> КвалификаторыЧисла.ДопустимыйЗнак Тогда
					Знак = ДопустимыйЗнак.Любой;
					ИзменитьКвалификаторыЧисла = Истина;
				Иначе
					Знак = КвалификаторыЧисла.ДопустимыйЗнак;
				КонецЕсли;
				Если ИзменитьКвалификаторыЧисла Тогда
					КвалификаторыЧисла = Новый КвалификаторыЧисла(Разрядность, РазрядностьДробнойЧасти, Знак);
				КонецЕсли;
			КонецЕсли;
			
			ИзменитьКвалификаторыСтроки = Ложь;
			КвалификаторыСтроки = КолонкаПриемника.ТипЗначения.КвалификаторыСтроки;
			Если КолонкаИсточника.ТипЗначения.СодержитТип(Тип("Строка")) 
				 И КолонкаПриемника.ТипЗначения.СодержитТип(Тип("Строка")) Тогда
				КвалификаторыСтрокиИсточника = КолонкаИсточника.ТипЗначения.КвалификаторыСтроки;
				Если КвалификаторыСтроки.Длина <> 0 И КвалификаторыСтрокиИсточника.Длина > КвалификаторыСтроки.Длина Тогда
					ИзменитьКвалификаторЧисла = Истина;
					КвалификаторыСтроки = Новый КвалификаторыСтроки(КвалификаторыСтрокиИсточника.Длина);
				КонецЕсли; 
			КонецЕсли;
			
			ИзменитьКвалификаторыДаты = Ложь;
			КвалификаторыДаты = КолонкаПриемника.ТипЗначения.КвалификаторыДаты;
			Если КолонкаИсточника.ТипЗначения.СодержитТип(Тип("Дата")) 
				 И КолонкаПриемника.ТипЗначения.СодержитТип(Тип("Дата")) Тогда
				КвалификаторыДатыИсточника = КолонкаИсточника.ТипЗначения.КвалификаторыДаты;
				Если КвалификаторыДатыИсточника.ЧастиДаты <> КвалификаторыДаты.ЧастиДаты Тогда
					ИзменитьКвалификаторыДаты = Истина;
					КвалификаторыДаты = Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя);
				КонецЕсли; 
			КонецЕсли;
			
			ИзменитьКвалификаторыДвоичныхДанных = Ложь;
			КвалификаторыДвоичныхДанных = КолонкаПриемника.ТипЗначения.КвалификаторыДвоичныхДанных;
			Если КолонкаИсточника.ТипЗначения.СодержитТип(Тип("ДвоичныеДанные")) 
				 И КолонкаПриемника.ТипЗначения.СодержитТип(Тип("ДвоичныеДанные")) Тогда
				КвалификаторыДвоичныхДанныхИсточника = КолонкаИсточника.ТипЗначения.КвалификаторыДвоичныхДанных;
				Если КвалификаторыДвоичныхДанных.Длина <> 0 И КвалификаторыДвоичныхДанныхИсточника.Длина > КвалификаторыДвоичныхДанных.Длина Тогда
					ИзменитьКвалификаторыДвоичныхДанных = Истина;
					КвалификаторыДвоичныхДанных = Новый КвалификаторыДвоичныхДанных(КвалификаторыДвоичныхДанныхИсточника.Длина);
				КонецЕсли; 
			КонецЕсли;
			
			Если ОтсутствующиеТипы.Количество() > 0
				Или ИзменитьКвалификаторыЧисла 
				Или ИзменитьКвалификаторыСтроки 
				Или ИзменитьКвалификаторыДаты
				Или ИзменитьКвалификаторыДвоичныхДанных Тогда
				ОписаниеТиповОбъединение = Новый ОписаниеТипов(КолонкаПриемника.ТипЗначения, ОтсутствующиеТипы, , 
				                                               КвалификаторыЧисла, КвалификаторыСтроки, КвалификаторыДаты, КвалификаторыДвоичныхДанных);
				КолонкиДляОбъединенияТипов.Вставить(КолонкаПриемника.Имя, ОписаниеТиповОбъединение);
			КонецЕсли;
		Иначе
			КолонкиДляДобавления.Вставить(КолонкаИсточника.Имя, КолонкаИсточника.ТипЗначения)
		КонецЕсли;
	КонецЦикла;
	
	Для каждого Колонка Из КолонкиДляОбъединенияТипов Цикл
		ЗначенияВКолонке = ТаблицаПриемник.ВыгрузитьКолонку(Колонка.Ключ);
		ТаблицаПриемник.Колонки.Удалить(Колонка.Ключ);
		ТаблицаПриемник.Колонки.Добавить(Колонка.Ключ, Колонка.Значение);
		ТаблицаПриемник.ЗагрузитьКолонку(ЗначенияВКолонке, Колонка.Ключ);
	КонецЦикла;
	
	Для каждого Колонка Из КолонкиДляДобавления Цикл
		ТаблицаПриемник.Колонки.Добавить(Колонка.Ключ, Колонка.Значение);
	КонецЦикла;
	
	ОбщегоНазначенияКлиентСервер.ДополнитьТаблицу(ТаблицаИсточник, ТаблицаПриемник);
	
КонецПроцедуры

#КонецОбласти