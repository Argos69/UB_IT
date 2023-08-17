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
	ТекстЗапросаТаблицаНазначенныеРуководителиПодразделений(Запрос, ТекстыЗапроса, Регистры);
	
	УБ_ПроведениеСервер.ИнициализироватьТаблицыДляДвижений(Запрос, ТекстыЗапроса, ДополнительныеСвойства.ТаблицыДляДвижений, Истина);
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка)
	
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц();
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	
КонецПроцедуры

Функция ТекстЗапросаТаблицаНазначенныеРуководителиПодразделений(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "НазначенныеРуководителиПодразделений";
	
	Если Не УБ_ПроведениеСервер.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	ТекстЗапроса = 
		"ВЫБРАТЬ
		|	ДанныеДокумента.ДатаНазначения КАК Период,
		|	ДанныеДокумента.Подразделение КАК Подразделение,
		|	ДанныеДокумента.Руководитель КАК Пользователь,
		|	ДанныеДокумента.Организация КАК Организация,
		|	ДанныеДокумента.Руководитель.ФизическоеЛицо КАК ФизическоеЛицо,
		|	ДанныеДокумента.СотрудникРуководитель КАК Руководитель
		|ИЗ
		|	Документ.УБ_НазначениеРуководителя КАК ДанныеДокумента
		|ГДЕ
		|	ДанныеДокумента.Ссылка = &Ссылка";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли