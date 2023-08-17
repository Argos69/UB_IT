#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Процедура ОтразитьРасценкиПоказателейЭффективности(ДополнительныеСвойства, Движения, Отказ) Экспорт
	
	Таблица = ДополнительныеСвойства.ТаблицыДляДвижений.ТаблицаРасценкиПоказателейЭффективности;
	
	Если Отказ Или Таблица.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ДвиженияРасценкиПоказателейЭффективности = Движения.УБ_РасценкиПоказателейЭффективности;
	ДвиженияРасценкиПоказателейЭффективности.Записывать = Истина;
	ДвиженияРасценкиПоказателейЭффективности.Загрузить(Таблица);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли