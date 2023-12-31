
Процедура СоздатьИЗаполнитьДокументыВФоне(СтруктураПараметров, АдресРезультата) Экспорт

	Если ЗначениеЗаполнено(СтруктураПараметров.Организация) И ЗначениеЗаполнено(СтруктураПараметров.ПериодФормирования) Тогда
		Для каждого Строка из СтруктураПараметров.Сотрудники Цикл
			Если Не ЗначениеЗаполнено(Строка.ДокументРЭ) Тогда	
				Строка.ДокументРЭ = СоздатьДокументРЭ(Строка.Сотрудник, СтруктураПараметров);
				ЗаполнитьДокументРЭ(Строка.ДокументРЭ);
				Строка.ДокументРЭСтрокой = Истина;
	        КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	ПоместитьВоВременноеХранилище(СтруктураПараметров,АдресРезультата);
	
КонецПроцедуры

Функция СоздатьДокументРЭ(Сотрудник, СтруктураПараметров)

	ДокументРЭ = Документы.УБ_РасчетЭффективностиСотрудников.СоздатьДокумент();
	ДокументРЭ.Сотрудник = Сотрудник;
	ДокументРЭ.ПериодРасчета = СтруктураПараметров.ПериодФормирования;
	ДокументРЭ.Организация = СтруктураПараметров.Организация;
	ДокументРЭ.Подразделение = СтруктураПараметров.Подразделение;
	ДокументРЭ.НачалоПериода = НачалоМесяца(СтруктураПараметров.ПериодФормирования);
	ДокументРЭ.КонецПериода = КонецМесяца(СтруктураПараметров.ПериодФормирования);
	ДокументРЭ.Дата = ТекущаяДата();
	ДокументРЭ.Записать();
	
	Возврат ДокументРЭ.Ссылка;
	
КонецФункции

Процедура ЗаполнитьДокументРЭ(ДокументРЭ)
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Организация", ДокументРЭ.Организация);
	СтруктураПараметров.Вставить("Подразделение", ДокументРЭ.Подразделение);
	СтруктураПараметров.Вставить("Сотрудники", ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ДокументРЭ.Сотрудник));
	СтруктураПараметров.Вставить("МесяцНачисления", ДокументРЭ.НачалоПериода);
	СтруктураПараметров.Вставить("ДокументРЭ", ДокументРЭ);
	
	СтруктураРезультата = Документы.УБ_РасчетЭффективностиСотрудников.ПодготовитьДанныеНачисленийГрупповогоСоздания(СтруктураПараметров);
	
	СтруктураПараметров.Вставить("СтруктураРезультата",СтруктураРезультата);
	
	ПриЗавершенииОперацииЗаполненияНачислений(СтруктураПараметров);
	
КонецПроцедуры 

Процедура ПриЗавершенииОперацииЗаполненияНачислений(ДополнительныеПараметры)
	
	ДополнительныеПараметры.Вставить("СохранятьИсправления", Ложь);
	ДополнительныеПараметры.Вставить("ТекстОповещения");
	ДополнительныеПараметры.Вставить("ПояснениеОповещения");
	ДополнительныеПараметры.Вставить("ЕстьДанныеДляЗаполнения", Ложь);
	
	ПриЗавершенииОперацииЗаполненияНачисленийНаСервере(ДополнительныеПараметры,ДополнительныеПараметры.ДокументРЭ);
		
КонецПроцедуры

Процедура ПриЗавершенииОперацииЗаполненияНачисленийНаСервере(Результат, ДокументРЭ)
	
	ДокументРЭОбъект = ДокументРЭ.ПолучитьОбъект();
	Документы.УБ_РасчетЭффективностиСотрудников.ЗаполнениеПослеВыполненияДлительнойОперацииГрупповогоСоздания(ДокументРЭОбъект, Результат);
	ДокументРЭОбъект.Записать(РежимЗаписиДокумента.Проведение);
	
КонецПроцедуры

Процедура СоздатьИЗаполнитьДокументыИЗадачиВФоне(СтруктураПараметров, АдресРезультата) Экспорт

	Если ЗначениеЗаполнено(СтруктураПараметров.Организация) И ЗначениеЗаполнено(СтруктураПараметров.ПериодФормирования) Тогда

		Для каждого Строка из СтруктураПараметров.Сотрудники Цикл
			Если Не ЗначениеЗаполнено(Строка.ДокументРЭ) Тогда 
				Строка.ДокументРЭ = СоздатьДокументРЭ(Строка.Сотрудник, СтруктураПараметров);
				ЗаполнитьДокументРЭ(Строка.ДокументРЭ);
				Строка.ДокументРЭСтрокой = Истина;
			КонецЕсли;
			Если Не ЗначениеЗаполнено(Строка.Задача) И Строка.СоздаватьЗадачу Тогда
				Если Строка.Исполнитель = "Руководитель" Тогда
					Если Не СтруктураПараметров.ЗадачаРуководителя Тогда
						Строка.Задача = СоздатьЗадачиИсполнителяРаспределение(Строка.Сотрудник, Строка.Исполнитель, Строка.ДокументРЭ,СтруктураПараметров);
					КонецЕсли;
				Иначе
					Строка.Задача = СоздатьЗадачиИсполнителяРаспределение(Строка.Сотрудник, Строка.Исполнитель, Строка.ДокументРЭ,СтруктураПараметров);
				КонецЕсли;
				Строка.ЗадачаСтрокой = Истина;
			КонецЕсли;	
		КонецЦикла;	
	КонецЕсли;
	
КонецПроцедуры	

&НаСервере
Функция СоздатьЗадачиИсполнителяРаспределение(Сотрудник, Исполнитель, ДокументРЭ,СтруктураПараметров)
	
	Если Константы.УБ_ИспользоватьСправочникиКАУП.Получить() Тогда
		Возврат СоздатьЗадачиИсполнителяКАУП(Сотрудник, Исполнитель, ДокументРЭ,СтруктураПараметров);
	Иначе
		Возврат СоздатьЗадачиИсполнителяУБ(Сотрудник, Исполнитель, ДокументРЭ,СтруктураПараметров);
	КонецЕсли;	
	
КонецФункции
	
&НаСервере
Функция СоздатьЗадачиИсполнителяУБ(Сотрудник, Исполнитель, ДокументРЭ,СтруктураПараметров)
	
	ИсполнительЗадачи = ОпределитьИсполнителя(Сотрудник, Исполнитель,СтруктураПараметров);
	Если ЗначениеЗаполнено(ИсполнительЗадачи) Тогда
		РольИсполнителя = Справочники.УБ_РолиИсполнителей.ИсполнительЗадачи;
	
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ Ссылка ИЗ Справочник.УБ_ГруппыИсполнителейЗадач ГДЕ РольИсполнителя = &Роль И ОсновнойОбъектАдресации = &Объект";
		Запрос.УстановитьПараметр("Роль", РольИсполнителя);
		Запрос.УстановитьПараметр("Объект", СтруктураПараметров.Организация);
		Выборка = Запрос.Выполнить().Выбрать();
		Если Выборка.Следующий() Тогда
			ГруппаИсполнителейСсылка = Выборка.Ссылка;
		Иначе
			ГруппаИсполнителейОбъект = Справочники.УБ_ГруппыИсполнителейЗадач.СоздатьЭлемент();
			ГруппаИсполнителейОбъект.Наименование = НСтр("ru = 'Группа исполнителей задач организации'");
			ГруппаИсполнителейОбъект.РольИсполнителя = РольИсполнителя;
			ГруппаИсполнителейОбъект.ОсновнойОбъектАдресации = СтруктураПараметров.Организация;
			ГруппаИсполнителейОбъект.Записать();
			ГруппаИсполнителейСсылка = ГруппаИсполнителейОбъект.Ссылка;
		КонецЕсли;
		
		ВажностьОбычная = Перечисления.УБ_ВариантыВажностиЗадачи.Обычная;
		СостояниеАктивен = Перечисления.УБ_СостоянияБизнесПроцессов.Активен;
		
		Наименование = НСтр("ru = 'Задание на заполнение документа РЭ'");
		БПЗаданиеОбъект = БизнесПроцессы.УБ_Задание.СоздатьБизнесПроцесс();
		БПЗаданиеОбъект.Наименование = Наименование;
		БПЗаданиеОбъект.Важность                = ВажностьОбычная;
		БПЗаданиеОбъект.Дата                    = ТекущаяДата();
		БПЗаданиеОбъект.Автор                   = СтруктураПараметров.ТекущийПользователь;
		БПЗаданиеОбъект.АвторСтрокой            = Строка(СтруктураПараметров.ТекущийПользователь);
		БПЗаданиеОбъект.Исполнитель             = ИсполнительЗадачи;
		БПЗаданиеОбъект.Предмет                 = ДокументРЭ;
		БПЗаданиеОбъект.ОсновнойОбъектАдресации = СтруктураПараметров.Организация;
		БПЗаданиеОбъект.СрокИсполнения          = РассчитатьДату(СтруктураПараметров);
		БПЗаданиеОбъект.Состояние               = СостояниеАктивен;
		БПЗаданиеОбъект.Стартован               = Истина;
		БПЗаданиеОбъект.НаПроверке              = Истина;
		БПЗаданиеОбъект.НомерИтерации           = 1;
		БПЗаданиеОбъект.Проверяющий             = ?(ЗначениеЗаполнено(СтруктураПараметров.КонтролирующееЛицо), СтруктураПараметров.КонтролирующееЛицо,СтруктураПараметров.ТекущийПользователь);
		БПЗаданиеОбъект.Записать();
		БПЗаданиеСсылка = БПЗаданиеОбъект.Ссылка;
		
		Наименование = НСтр("ru = 'Заполнить документ(ы) РЭ'");
		ЗадачаИсполнителяОбъект = Задачи.УБ_ЗадачаИсполнителя.СоздатьЗадачу();
		ЗадачаИсполнителяОбъект.Наименование = Наименование;
		ЗадачаИсполнителяОбъект.Дата                    = ТекущаяДата();
		ЗадачаИсполнителяОбъект.БизнесПроцесс           = БПЗаданиеСсылка;
		ЗадачаИсполнителяОбъект.Важность                = ВажностьОбычная;
		ЗадачаИсполнителяОбъект.Описание                = "Заполнить документ(ы) РЭ";
		ЗадачаИсполнителяОбъект.Предмет                 = ДокументРЭ;
		ЗадачаИсполнителяОбъект.ПредметСтрокой          = Строка(ДокументРЭ);
		ЗадачаИсполнителяОбъект.Автор                   = СтруктураПараметров.ТекущийПользователь;
		ЗадачаИсполнителяОбъект.АвторСтрокой            = Строка(СтруктураПараметров.ТекущийПользователь);
		ЗадачаИсполнителяОбъект.ТочкаМаршрута           = БизнесПроцессы.УБ_Задание.ТочкиМаршрута.Выполнить;
		ЗадачаИсполнителяОбъект.ГруппаИсполнителейЗадач = ГруппаИсполнителейСсылка;
		ЗадачаИсполнителяОбъект.ОсновнойОбъектАдресации = СтруктураПараметров.Организация;
		ЗадачаИсполнителяОбъект.РольИсполнителя         = РольИсполнителя;
		ЗадачаИсполнителяОбъект.СостояниеБизнесПроцесса = СостояниеАктивен;
		ЗадачаИсполнителяОбъект.СрокИсполнения          = РассчитатьДату(СтруктураПараметров);
		ЗадачаИсполнителяОбъект.Записать();
		Возврат ЗадачаИсполнителяОбъект.Ссылка;
	Иначе
		Возврат Неопределено;
	КонецЕсли;	
	
КонецФункции

&НаСервере
Функция СоздатьЗадачиИсполнителяКАУП(Сотрудник, Исполнитель, ДокументРЭ,СтруктураПараметров)
	
	ИсполнительЗадачи = ОпределитьИсполнителя(Сотрудник, Исполнитель, СтруктураПараметров);
	Если ЗначениеЗаполнено(ИсполнительЗадачи) Тогда
		
		ВажностьОбычная = Перечисления.ВариантыВажностиЗадачи.Обычная;
		СостояниеАктивен = Перечисления.СостоянияБизнесПроцессов.Активен;
		
		Наименование = НСтр("ru = 'Задание на заполнение документа РЭ'");
		БПЗаданиеОбъект = БизнесПроцессы.CRM_БизнесПроцесс.СоздатьБизнесПроцесс();
		БПЗаданиеОбъект.Наименование = Наименование;
		БПЗаданиеОбъект.Важность                = ВажностьОбычная;
		БПЗаданиеОбъект.Дата                    = ТекущаяДата();
		БПЗаданиеОбъект.Автор                   = СтруктураПараметров.ТекущийПользователь;
		БПЗаданиеОбъект.АвторСтрокой            = Строка(СтруктураПараметров.ТекущийПользователь);
		БПЗаданиеОбъект.Исполнитель             = ИсполнительЗадачи;
		БПЗаданиеОбъект.Предмет                 = ДокументРЭ;
		БПЗаданиеОбъект.ОсновнойОбъектАдресации = СтруктураПараметров.Организация;
		БПЗаданиеОбъект.СрокИсполнения          = РассчитатьДату(СтруктураПараметров);
		БПЗаданиеОбъект.Состояние               = СостояниеАктивен;
		БПЗаданиеОбъект.Стартован               = Истина;
		БПЗаданиеОбъект.НаПроверке              = Истина;
		БПЗаданиеОбъект.НомерИтерации           = 1;
		БПЗаданиеОбъект.Проверяющий             = ?(ЗначениеЗаполнено(СтруктураПараметров.КонтролирующееЛицо), СтруктураПараметров.КонтролирующееЛицо,СтруктураПараметров.ТекущийПользователь);
		БПЗаданиеОбъект.Записать();
		БПЗаданиеСсылка = БПЗаданиеОбъект.Ссылка;
		
		Наименование = НСтр("ru = 'Заполнить документ(ы) РЭ'");
		ЗадачаИсполнителяОбъект = Задачи.ЗадачаИсполнителя.СоздатьЗадачу();
		ЗадачаИсполнителяОбъект.Наименование = Наименование;
		ЗадачаИсполнителяОбъект.Дата                    = ТекущаяДата();
		ЗадачаИсполнителяОбъект.БизнесПроцесс           = БПЗаданиеСсылка;
		ЗадачаИсполнителяОбъект.Важность                = ВажностьОбычная;
		ЗадачаИсполнителяОбъект.Исполнитель             = ИсполнительЗадачи;
		ЗадачаИсполнителяОбъект.Описание                = "Заполнить документ(ы) РЭ";
		ЗадачаИсполнителяОбъект.Предмет                 = ДокументРЭ;
		ЗадачаИсполнителяОбъект.ПредметСтрокой          = Строка(ДокументРЭ);
		ЗадачаИсполнителяОбъект.Автор                   = СтруктураПараметров.ТекущийПользователь;
		ЗадачаИсполнителяОбъект.АвторСтрокой            = Строка(СтруктураПараметров.ТекущийПользователь);
		ЗадачаИсполнителяОбъект.ТочкаМаршрута           = БизнесПроцессы.CRM_БизнесПроцесс.ТочкиМаршрута.Старт;
		ЗадачаИсполнителяОбъект.ОсновнойОбъектАдресации = СтруктураПараметров.Организация;
		ЗадачаИсполнителяОбъект.СостояниеБизнесПроцесса = СостояниеАктивен;
		ЗадачаИсполнителяОбъект.СрокИсполнения          = РассчитатьДату(СтруктураПараметров);
		ЗадачаИсполнителяОбъект.Записать();
		Возврат ЗадачаИсполнителяОбъект.Ссылка;
	Иначе
		Возврат Неопределено;
	КонецЕсли;	
	
КонецФункции

&НаСервере
Функция РассчитатьДату(СтруктураПараметров)

	ДатаОкончанияЗаполнения = Константы.УБ_ДатаОкончанияЗаполненияРЭ.Получить();
	ДатаСтрокой = Строка(СтруктураПараметров.ПериодФормирования);
	Если ДатаОкончанияЗаполнения = 0 Тогда
		ДатаИсполнения = "01" + Сред(ДатаСтрокой,3,СтрДлина(ДатаСтрокой)-2);
	Иначе
		ДеньСтрокой = Формат(ДатаОкончанияЗаполнения, "ЧЦ=2; ЧВН=");
	   	ДатаИсполнения = ДеньСтрокой + Сред(ДатаСтрокой,3,СтрДлина(ДатаСтрокой)-2);
		ДатаИсполнения = ДобавитьМесяц(ДатаИсполнения,1);
	КонецЕсли;
	Возврат НачалоДня(ДатаИсполнения)+18*60*60;
КонецФункции	

&НаСервере
Функция ОпределитьИсполнителя(Сотрудник, Исполнитель,СтруктураПараметров)

	Если Исполнитель = "Руководитель" Тогда
		СтруктураПараметров.ЗадачаРуководителя = Истина;
		Возврат НайтиПользователяУСотрудника(СтруктураПараметров.Руководитель);
	ИначеЕсли Исполнитель = "Зам.Руководитель" Тогда
		Возврат НайтиПользователяУСотрудника(СтруктураПараметров.Зам_Руководителя);
	ИначеЕсли Исполнитель = "Контролирующее лицо" Тогда
		Возврат СтруктураПараметров.КонтролирующееЛицо;
	ИначеЕсли Исполнитель = "Сотрудник" Тогда
		Возврат НайтиПользователяУСотрудника(Сотрудник);
	КонецЕсли;
	
КонецФункции

&НаСервере
Функция НайтиПользователяУСотрудника(Сотрудник)

	ФизическоеЛицо = Сотрудник.ФизическоеЛицо;
	Если ЗначениеЗаполнено(ФизическоеЛицо) Тогда
		Пользователь = Справочники.Пользователи.НайтиПоРеквизиту("ФизическоеЛицо",ФизическоеЛицо);
		Если ЗначениеЗаполнено(Пользователь) Тогда
			Возврат Пользователь;
		Иначе
			Сообщить("К сотруднику " + Строка(Сотрудник) + " не привязан пользователь");
			Возврат Неопределено;
		КонецЕсли;	
	Иначе
		Сообщить("У сотрудника " + Строка(Сотрудник) + " незаполнено физ. лицо");
		Возврат Неопределено;
	КонецЕсли;
	
	
КонецФункции	




