#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	ИнициализироватьДокумент(ДанныеЗаполнения);
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	Движения.УБ_ПропорцииМатериальнойМотивации.Записывать = Истина;
	
	Для Каждого СтрокаТЧ Из МатериальнаяМотивация Цикл
		
		НоваяСтрока = Движения.УБ_ПропорцииМатериальнойМотивации.Добавить();
		НоваяСтрока.Период = ДатаУстановкиМотивации;
		ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаТЧ);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	ИнициализироватьДокумент();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ИнициализацияИЗаполнение

Процедура ИнициализироватьДокумент(ДанныеЗаполнения = Неопределено)
	
	Ответственный = Пользователи.ТекущийПользователь();
	ДатаУстановкиМотивации = НачалоМесяца(ТекущаяДата());
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли