#Область ОбработчикиСобытий

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		Если ДанныеЗаполнения.Свойство("Владелец") Тогда
			ШтатноеРасписание = ДанныеЗаполнения.Владелец;
			Наименование = ДанныеЗаполнения.Владелец.Должность;
		КонецЕсли;
	КонецЕсли;
		
КонецПроцедуры

#КонецЕсли

Процедура ПередЗаписью(Отказ)
	
	ПроверкаНаДублированиеМоделейСДаннымШтатнымРасписанием(Отказ);

КонецПроцедуры 

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПроверкаНаДублированиеМоделейСДаннымШтатнымРасписанием(Отказ)
	
	Если ПометкаУдаления Тогда
		Возврат;
	КонецЕсли;  
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	УБ_МоделиПланированияЭффективности.Ссылка КАК Ссылка,
		|	Представление(УБ_МоделиПланированияЭффективности.ШтатноеРасписание) КАК ШтатноеРасписание,
		|	Представление(УБ_МоделиПланированияЭффективности.Ссылка) КАК ПредставлениеМодели
		|ИЗ
		|	Справочник.УБ_МоделиПланированияЭффективности КАК УБ_МоделиПланированияЭффективности
		|ГДЕ
		|	УБ_МоделиПланированияЭффективности.ШтатноеРасписание = &ШтатноеРасписание
		|	И УБ_МоделиПланированияЭффективности.Ссылка <> &МодельПланированияЭффективности
		|	И НЕ УБ_МоделиПланированияЭффективности.ПометкаУдаления";
	
	Запрос.УстановитьПараметр("ШтатноеРасписание", ШтатноеРасписание);
	Запрос.УстановитьПараметр("МодельПланированияЭффективности", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	
	Если Выборка.Следующий() Тогда
		ОбщегоНазначения.СообщитьПользователю(СтрШаблон("Штатное расписание ""%1"" используется в модели планирования ""%2""", Выборка.ШтатноеРасписание, Выборка.ПредставлениеМодели)
												,,,,Отказ);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

