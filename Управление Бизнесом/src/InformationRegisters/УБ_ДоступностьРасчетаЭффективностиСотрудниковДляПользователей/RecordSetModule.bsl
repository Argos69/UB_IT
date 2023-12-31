#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ЭтотОбъект.Отбор.ИдентификаторЗаписи.Использование = Ложь;
	
	Для Каждого Запись Из ЭтотОбъект Цикл
		СписокРеквизитов = "Сотрудник, Подразделение";
		УБ_ОбщегоНазначения.УстановитьТипЗначенияСвязанныхРеквизитовПоУмолчанию(Запись, СписокРеквизитов);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.
						|en = 'Invalid object call on the client.''");
#КонецЕсли