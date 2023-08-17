
#Область ПрограммныйИнтерфейс
// Возвращает идентификатор конфигурации.
Функция ИДКонфигурации() Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	Возврат ПолучитьИдентификаторКонфигурации();
	
КонецФункции

Функция ИспользоватьСправочникиКАУП() Экспорт
	
	Возврат Константы.УБ_ИспользоватьСправочникиКАУП.Получить();
	
КонецФункции

Функция ЭтоРозница() Экспорт
	
	Возврат ИДКонфигурации() = "Розница";
	
КонецФункции


////////////////////////////////////////////////////////////////////////////////
//
// Функция ИмяКонфигурации
//
// Описание:
//
//
// Параметры (название, тип, дифференцированное значение)
//
// Возвращаемое значение: 
//  


//
// Функция 
//
// Описание:
// Возвращает массив из пустых ссылок каждого типа,
// входящего в определяемый тип

// Параметры (название, тип, дифференцированное значение)
// Имя - Строка, имя определяемого типа в структуре метаданных

// Возвращаемое значение: 
// Массив
Функция МассивПустыхСсылокОпределяемогоТипа(Имя) Экспорт
	
	ОпределяемыйТип = Метаданные.ОпределяемыеТипы[Имя].Тип;
	ПустыеЗначения = Новый СписокЗначений;
	Для каждого ТипЗначения Из ОпределяемыйТип.Типы() Цикл
	   Значение = Новый(ТипЗначения);
	   ПустыеЗначения.Добавить(Значение);
	КонецЦикла;
	Если ОпределяемыйТип.Типы().Количество() > 1 Тогда
	   ПустыеЗначения.Добавить(Неопределено);
	КонецЕсли;

	Возврат ПустыеЗначения;

		
КонецФункции

//
// Функция 
//
// Описание:
// Возвращает массив из типов, 
// входящих в определяемый тип

// Параметры (название, тип, дифференцированное значение)
// Имя - Строка, имя определяемого типа в структуре метаданных

// Возвращаемое значение: 
// Массив
Функция МассивТиповОпределяемогоТипа(Имя) Экспорт
			
	ОпределяемыйТип = Метаданные.ОпределяемыеТипы[Имя].Тип;
	ПустыеЗначения = Новый СписокЗначений;
	Для каждого ТипЗначения Из ОпределяемыйТип.Типы() Цикл
		Если ТипЗначения = Тип("Строка") или ТипЗначения = Тип("СправочникСсылка.Организации") 
										 или ТипЗначения = Тип("СправочникСсылка.Проекты") 
										 или ТипЗначения = Тип("СправочникСсылка.УБ_Компании")
										 или ТипЗначения = Тип("СправочникСсылка.СтруктураПредприятия")Тогда
			ПустыеЗначения.Добавить(ТипЗначения);	
			Продолжить;
		КонецЕсли;
		Мета = Метаданные.НайтиПоТипу(ТипЗначения).Имя;
		
		Если УБ_ОбщегоНазначенияПовтИсп.ИспользоватьСправочникиКАУП() и Найти(Мета, "УБ")>0 Тогда
       		Продолжить;
		КонецЕсли;	
		Если НЕ УБ_ОбщегоНазначенияПовтИсп.ИспользоватьСправочникиКАУП() и НЕ Найти(Мета, "УБ") > 0 Тогда
       		Продолжить;
		КонецЕсли;	
	   ПустыеЗначения.Добавить(ТипЗначения);
	КонецЦикла;
	
	
	ПустыеЗначения.СортироватьПоПредставлению();
	Возврат ПустыеЗначения;

		
КонецФункции

Функция ЗначениеРеквизитаПоУмолчанию(ИмяРеквизита = "") Экспорт
	
	Возврат УБ_ОбщегоНазначения.ЗначениеРеквизитаПоУмолчанию(ИмяРеквизита);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
// Описание:
// Вовращает Массив значений справочника Сотрудники,
// отобранных по реквизиту Физическое лицо текущего пользователя
// Параметры:
// Пользователь - Неопределено - используется текущий пользователь
//				- СправочникСсылка.Пользователи - указанный авторизованный пользователь
// Возвращаемое значение: 
//  Массив - "СправочникСсылка.Сотрудники".
Функция ВсеСотрудникиПользователя(Пользователь = Неопределено) Экспорт
	Возврат УБ_КадровыйУчет.ВсеСотрудникиПользователя(Пользователь);
КонецФункции

#КонецОбласти