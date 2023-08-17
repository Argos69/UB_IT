#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Процедура ЗаписатьРуководителейПодразделений(ТаблицаРуководителиПодразделений) Экспорт
	
	Если ТаблицаРуководителиПодразделений.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	КадровыйДокумент = ТаблицаРуководителиПодразделений[0].КадровыйДокумент;
	
	НаборЗаписей = РегистрыСведений.удалитьУБ_РуководителиПодразделений.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.КадровыйДокумент.Установить(КадровыйДокумент);
	
	Для Каждого СтрокаРуководителиПодразделений Из ТаблицаРуководителиПодразделений Цикл
		НоваяЗапись = НаборЗаписей.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяЗапись, СтрокаРуководителиПодразделений);
	КонецЦикла;
	
	НаборЗаписей.Записать();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли