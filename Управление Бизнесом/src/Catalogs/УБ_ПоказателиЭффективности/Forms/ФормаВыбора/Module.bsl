
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.ДополнительныеПараметры.Свойство("ИспользоватьОтборДляВыбранныхТипов") Тогда
		Элементы.ДляВыбранныхТипов.Видимость = Параметры.ДополнительныеПараметры.ИспользоватьОтборДляВыбранныхТипов;
		СписокТипов.ЗагрузитьЗначения(Параметры.ДополнительныеПараметры.СписокТипов);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ДляВыбранныхТиповПриИзмененииНаСервере()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список,
		"ТипПоказателя",
		СписокТипов,
		ВидСравненияКомпоновкиДанных.ВСписке,
		,
		ДляВыбранныхТипов);
	
КонецПроцедуры

&НаКлиенте
Процедура ДляВыбранныхТиповПриИзменении(Элемент)
	ДляВыбранныхТиповПриИзмененииНаСервере();
КонецПроцедуры


