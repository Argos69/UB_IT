#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Процедура ЗаписатьНазначенныхРуководителейПодразделений(Таблица, Движения, Отказ) Экспорт
	
	Если Отказ Или Таблица.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ДвиженияНазначенныхРуководителейПодразделений = Движения.УБ_НазначенныеРуководителиПодразделений;
	ДвиженияНазначенныхРуководителейПодразделений.Записывать = Истина;
	ДвиженияНазначенныхРуководителейПодразделений.Загрузить(Таблица);
		
КонецПроцедуры

#КонецОбласти

#КонецЕсли