#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Проведение

Процедура ИнициализироватьДанныеДокумента(ДокументСсылка, ДополнительныеСвойства, Регистры = Неопределено) Экспорт
	
	Запрос = Новый Запрос;
	ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка);
	
	ТекстыЗапроса = Новый СписокЗначений;
	ТекстЗапросаТаблицаЗначенияШкалыПоказателей(Запрос, ТекстыЗапроса, Регистры);
	
	УБ_ПроведениеСервер.ИнициализироватьТаблицыДляДвижений(Запрос, ТекстыЗапроса, ДополнительныеСвойства.ТаблицыДляДвижений, Истина);
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка)
	
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ДанныеДокумента.Ссылка КАК Ссылка,
		|	ДанныеДокумента.Дата КАК Период,
		|	ДанныеДокумента.ШкалаПоказателей КАК ШкалаПоказателей
		|ИЗ
		|	Документ.УБ_УстановкаЗначенийШкалыПоказателей КАК ДанныеДокумента
		|ГДЕ
		|	ДанныеДокумента.Ссылка = &Ссылка";
	Реквизиты = Запрос.Выполнить().Выбрать();
	Реквизиты.Следующий();
	
	Запрос.УстановитьПараметр("Ссылка", Реквизиты.Ссылка);
	Запрос.УстановитьПараметр("Период", Реквизиты.Период);
	Запрос.УстановитьПараметр("ШкалаПоказателей", Реквизиты.ШкалаПоказателей);
	
КонецПроцедуры

Функция ТекстЗапросаТаблицаЗначенияШкалыПоказателей(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ЗначенияШкалыПоказателей";
	
	Если Не УБ_ПроведениеСервер.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	&Период КАК Период,
	|	&ШкалаПоказателей КАК ШкалаПоказателей,
	|	&Ссылка КАК УстановкаЗначенийШкалыПоказателей";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

#КонецОбласти

#Область Печать

Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
КонецПроцедуры

Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли