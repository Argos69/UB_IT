#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	ИнициализироватьДокумент(ДанныеЗаполнения);
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	УБ_ПроведениеСервер.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства);
	
	Документы.УБ_НазначениеНаДолжность.ИнициализироватьДанныеДокумента(Ссылка, ДополнительныеСвойства);
	
	УБ_ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	УБ_КадровыйУчет.УБ_ОтменаПроведенияКадровыхДокументовОбработкаУдаленияПроведения(ЭтотОбъект, Отказ);
	
	РегистрыСведений.УБ_МоделиПланированияСотрудников.ЗаписатьМодельПланированияСотрудника(
		ДополнительныеСвойства.ТаблицыДляДвижений.ТаблицаМоделиПланированияСотрудников, Отказ);
	//РегистрыСведений.УБ_РуководителиПодразделений.ЗаписатьРуководителейПодразделений(
	//	ДополнительныеСвойства.ТаблицыДляДвижений.ТаблицаРуководителиПодразделений);
	Если Не ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПодсистемы") Тогда
		УБ_КадровыйУчет.СформироватьКадровыеДвижения(ЭтотОбъект, Движения,
			 ДополнительныеСвойства.ТаблицыДляДвижений.ТаблицаКадроваяИсторияСотрудников, Истина);
	КонецЕсли;
	
	УБ_ПроведениеСервер.ЗаписатьНаборыЗаписей(ЭтотОбъект);
	
	УБ_ПроведениеСервер.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);
	
КонецПроцедуры

Процедура ОбработкаУдаленияПроведения(Отказ)
	
	УБ_ПроведениеСервер.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства);
	
	УБ_ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	
	УБ_ПроведениеСервер.ЗаписатьНаборыЗаписей(ЭтотОбъект);
	
	УБ_ПроведениеСервер.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ДополнительныеСвойства.Вставить("ЭтоНовый", ЭтоНовый());
	ДополнительныеСвойства.Вставить("РежимЗаписи", РежимЗаписи);
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	ИнициализироватьДокумент();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ИнициализацияИЗаполнение

Процедура ИнициализироватьДокумент(ДанныеЗаполнения = Неопределено)
	
	Ответственный = Пользователи.ТекущийПользователь();
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли