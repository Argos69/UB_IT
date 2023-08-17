#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	ИнициализироватьДокумент(ДанныеЗаполнения);
	
	ДатаНачала = ТекущаяДата();
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	УБ_ПроведениеСервер.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства);
	
	Документы.УБ_Делегирование.ИнициализироватьДанныеДокумента(Ссылка, ДополнительныеСвойства);
	
	УБ_ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	         	РегистрыСведений.УБ_ДелегированныеСотрудникиПодразделения.ЗаписатьДелегированныхСотрудниковПодразделения(

		ДополнительныеСвойства.ТаблицыДляДвижений.ТаблицаДелегированныеСотрудникиПодразделения, Движения, Отказ);
	
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
	
	Если ДелегироватьВсехСотрудников Тогда
		ДелегируемыеСотрудники.Очистить()	
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
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") и ДанныеЗаполнения.Свойство("ВидОперации") Тогда
		НоваяСтрока = ВидыОпераций.Добавить();
		НоваяСтрока.ВидОперации =  ДанныеЗаполнения.ВидОперации;
	КонецЕсли;
	
	Ответственный = Пользователи.ТекущийПользователь();
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли