#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Процедура ОтразитьДанныеИтоговыхНачисленийРасчетаЭффективностиСотрудников(ДополнительныеСвойства, Движения, Отказ) Экспорт
	
	Таблица = ДополнительныеСвойства.ТаблицыДляДвижений.ТаблицаДанныеИтоговыхНачисленийРасчетаЭффективностиСотрудников;
	
	Если Отказ Или Таблица.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ДвиженияДанныеИтоговыхНачисленийРасчетаЭффективностиСотрудников = Движения.УБ_ДанныеИтоговыхНачисленийРасчетаЭффективностиСотрудников;
	ДвиженияДанныеИтоговыхНачисленийРасчетаЭффективностиСотрудников.Записывать = Истина;
	ДвиженияДанныеИтоговыхНачисленийРасчетаЭффективностиСотрудников.Загрузить(Таблица);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли