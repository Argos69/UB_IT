#Область ОбслуживаниеФорм

Процедура УстановитьДоступностьЭлементов(Форма, ТекущиеДанные = Неопределено) Экспорт
	
	МожноЗаполнятьТЧ = ЗначениеЗаполнено(Форма.Объект.Подразделение)
					 и ЗначениеЗаполнено(Форма.Объект.ДатаНачала)
					 и ЗначениеЗаполнено(Форма.Объект.ДатаОкончания);

	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"ГруппаНазначенияИПоказатели",
		"Доступность",
		МожноЗаполнятьТЧ); 
		
		
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"ПоказателиПоПериодам",
		"ИзменятьСоставСтрок",
		ТекущиеДанные.ПериодичностьПланирования = ПредопределенноеЗначение("Перечисление.УБ_ПериодыРасчетаМоделиПланирования.Произвольный")); 


	Если Форма.ИмяФормы = "Документ.УБ_ПланированиеЦелейИПоказателей.Форма.СводнаяТаблица" Тогда	
		//для формы Сводной таблицы колонка нужна, если хотя бы одна показатель с нарастающим итогом	
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ПоказателиПоПериодамНарастающийИтог",
			"Видимость",
			Форма.Объект.ПоказателиПоПериодам.Итог("НарастающийИтог")<>0);                                 
	Иначе
		//для формы Документа колонку можно оставить, но сделать ее недоступной в зависимости от Показателя и закрасить	
		//для формы Сводной таблицы колонка нужна, если хотя бы одна показатель с нарастающим итогом	
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ПоказателиПоПериодамНарастающийИтог",
			"Видимость",
			ТекущиеДанные.СчитатьНарастающийИтог);                                 
	КонецЕсли;
		
	
	ПроизвольныеПериоды = ТекущиеДанные.ПериодичностьПланирования = ПредопределенноеЗначение("Перечисление.УБ_ПериодыРасчетаМоделиПланирования.Произвольный");
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"ПоказателиПоПериодамДатаНачала",
		"Доступность",
		ПроизвольныеПериоды);

	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"ПоказателиПоПериодамДатаОкончания",
		"ТолькоПросмотр",
		НЕ ПроизвольныеПериоды);
	
	
КонецПроцедуры

Процедура СчитатьНарастающийИтогПриИзменении(Форма) Экспорт     
	ТекущиеДанные =  Форма.Элементы.Показатели.ТекущиеДанные;
	УБ_ПланированиеПоказателейКлиент.УстановитьДоступностьЭлементов(Форма, ТекущиеДанные);
	СчитатьНарастающийИтог = ТекущиеДанные.СчитатьНарастающийИтог;
	расчНарастающийИтог = 0;               
	СтруктураПоиска = Новый Структура;   
	ИмяРеквизитаСвязи = "КлючСвязиСПериодом";
	СтруктураПоиска.Вставить(ИмяРеквизитаСвязи, ТекущиеДанные[ИмяРеквизитаСвязи]);
	
	ИзменяемыеСтроки = Форма.Объект.ПоказателиПоПериодам.НайтиСтроки(СтруктураПоиска);
	Для каждого СтрокаТаблицы Из ИзменяемыеСтроки Цикл
		СтрокаТаблицы.НарастающийИтог = ?(СчитатьНарастающийИтог, расчНарастающийИтог+СтрокаТаблицы.ТекущееЗначение, 0);
		расчНарастающийИтог = СтрокаТаблицы.НарастающийИтог;
	КонецЦикла;    
	
	УБ_ПланированиеПоказателейКлиент.ВывестиВПодвалИтогСОтбором(Форма, Форма.Объект.ПоказателиПоПериодам, Форма.Элементы.ПоказателиПоПериодам);
КонецПроцедуры

Процедура ЕдиноеЗначениеНарастающийИтогПриИзменении(ТекущиеДанные, ПоказателиПоПериодам) Экспорт

	Строки = ПоказателиПоПериодам.НайтиСтроки(Новый Структура("КлючСвязиСПериодом", ТекущиеДанные.КлючСвязиСПериодом));
	расчНарастающийИтог = 0;
	Если ТекущиеДанные.ЕдиноеЗначениеПоказателя Тогда
		Для каждого Строка Из Строки Цикл
			Строка.ТекущееЗначение = ТекущиеДанные.Значение;			
			Строка.НарастающийИтог = ?(ТекущиеДанные.СчитатьНарастающийИтог, расчНарастающийИтог+ТекущиеДанные.Значение, 0);
			расчНарастающийИтог = Строка.НарастающийИтог;
		КонецЦикла;
	Иначе	
		Значение = ТекущиеДанные.Значение / Строки.Количество();
		Для каждого Строка Из Строки Цикл
			Строка.ТекущееЗначение = Значение;			
			Строка.НарастающийИтог = ?(ТекущиеДанные.СчитатьНарастающийИтог, расчНарастающийИтог+Значение, 0);
			расчНарастающийИтог = Строка.НарастающийИтог;
		КонецЦикла;		
	КонецЕсли;
	
КонецПроцедуры

Процедура ВывестиВПодвалИтогСОтбором(Форма, ТабличнаяЧасть, ТабличнаяЧастьЭлементФормы) Экспорт

	Всего = 0;
	СтрокиПоказателиПоПериодам = УБ_ТабличныеЧастиКлиентСервер.СтрокиПоКлючуСвязи(ТабличнаяЧасть, ТабличнаяЧастьЭлементФормы.ОтборСтрок["КлючСвязиСПериодом"], "КлючСвязиСПериодом" );
    Для Каждого Строка Из СтрокиПоказателиПоПериодам Цикл
           Всего = ?(Строка.ТекущееЗначение = Неопределено, 0, Строка.ТекущееЗначение) + Всего;
    КонецЦикла;
    Форма.ТекущееЗначениеИтогСОтбором = Всего;
 		
 КонецПроцедуры
 
Функция   СтруктураПараметровКомпоновкиФормыВыбора() Экспорт
	 
	 Структура = Новый Структура();
	 Структура.Вставить("Источник");
	 Структура.Вставить("ИсточникИмяФормы");
	 Структура.Вставить("Дата");
	 Структура.Вставить("ДатаКадровыхДанных");
	 Структура.Вставить("Назначение");
	 Структура.Вставить("ТекущееНазначение");
	 Структура.Вставить("МассивИсключений");
	 Структура.Вставить("ЭтоПодбор", Ложь);
	 Структура.Вставить("КлючСвязи", Неопределено);
	 Структура.Вставить("АдресВХранилище ");
	 
	 Возврат Структура;	
	 
 КонецФункции
 
Процедура показательНачалоВыбора(Параметры, СтандартнаяОбработка = Истина) Экспорт
	
	СтандартнаяОбработка = Ложь;
	Отбор = Новый Структура;      
	
	НастройкиКомпоновки = Новый НастройкиКомпоновкиДанных;
	ЗаполнитьНастройкиКомпоновкиФормыВыбора(НастройкиКомпоновки, Параметры);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ФиксированныеНастройки", НастройкиКомпоновки);
	ПараметрыФормы.Вставить("ОтключитьИерархию", Истина);
	ПараметрыФормы.Вставить("АдресВХранилище", Параметры.АдресВХранилище);
	ПараметрыФормы.Вставить("КлючСвязи", Параметры.КлючСвязи);	
	ПараметрыФормы.Вставить("Период", Параметры.Дата);
	Если Параметры.ЭтоПодбор Тогда
		ПараметрыФормы.Вставить("ЗакрыватьПриВыборе", Ложь);
		ПараметрыФормы.Вставить("РежимВыбора", Истина);

		ОткрытьФорму(
		"Справочник.УБ_ПоказателиЭффективности.Форма.ФормаПодбора", 
		ПараметрыФормы, 
		Параметры.Источник
		, , , , ,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца
		);
	Иначе
		
		ОткрытьФорму("Справочник.УБ_ПоказателиЭффективности.Форма.ФормаПодбора", ПараметрыФормы, Параметры.Источник,,,,,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	КонецЕсли;
	
	
	
КонецПроцедуры     
	
Процедура ЗаполнитьНастройкиКомпоновкиФормыВыбора(НастройкиКомпоновки, Параметры) Экспорт
	
	перем МассивИсключений;
	
	ЭтоСотрудник = Параметры.ТекущееНазначение = "Сотрудник";
	Если ЭтоСотрудник Тогда
		Параметры.Вставить("ПодразделениеСотрудника", УБ_КадровыйУчетВызовСервера.КадровыеДанныеСотрудниковЗначениеРеквизита(Параметры.Назначение,, "Подразделение"));
	КонецЕсли;

	// оставляем только нужные параметры, т.к. среди них есть несерализируемые
	ПараметрыОпределенияПринадлежности = Новый Структура("Назначение, ТекущееНазначение");
	ЗаполнитьЗначенияСвойств(ПараметрыОпределенияПринадлежности, Параметры);
	Если Параметры.Свойство("ДатаКадровыхДанных") Тогда
		ДопустимаяПринадлежностьПоказателя = УБ_ПланированиеПоказателейКлиент.ОпределитьДопустимуюПринадлежностьПоказателя(Параметры.ДатаКадровыхДанных, ПараметрыОпределенияПринадлежности);	
	Иначе
		ДопустимаяПринадлежностьПоказателя = УБ_ПланированиеПоказателейКлиент.ОпределитьДопустимуюПринадлежностьПоказателя(Параметры.Дата, ПараметрыОпределенияПринадлежности);	
	КонецЕсли;
	
	Гр_Отбора = НастройкиКомпоновки.Отбор.Элементы.Добавить(Тип("ГруппаЭлементовОтбораКомпоновкиДанных")); 
	Гр_Отбора.ТипГруппы = ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ; 
	
	СостояниеЭлементОтбора = Гр_Отбора.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	СостояниеЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("СостояниеПоказателя");
	
	СостояниеЭлементОтбора.Использование = Истина;

	
	Если Параметры.ИсточникИмяФормы = "Документ.УБ_УстановкаФактаПоказателей.Форма.ФормаДокумента" Тогда 
		// TODO !!! это не работает
		//НовЭлементОтбора = Гр_Отбора.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		//НовЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ВариантРасчетаЗначенияФакта");
		//НовЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
		//НовЭлементОтбора.Использование = Истина;
		//НовЭлементОтбора.ПравоеЗначение = ПредопределенноеЗначение("Перечисление.УБ_ВариантыРасчетаЗначенийПоказателя.ИзДокументаУстановкиФакта");
		СостояниеЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
		СостояниеЭлементОтбора.ПравоеЗначение = ПредопределенноеЗначение("Перечисление.УБ_СостоянияПоказателейЭффективности.Действует");	
	Иначе		 
		СостояниеЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно;
		СостояниеЭлементОтбора.ПравоеЗначение = ПредопределенноеЗначение("Перечисление.УБ_СостоянияПоказателейЭффективности.Архивный");	
	КонецЕсли;
	
	
	Если Параметры.Свойство("МассивИсключений", МассивИсключений) и НЕ МассивИсключений = Неопределено Тогда
		НовЭлементОтбора = Гр_Отбора.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		НовЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Ссылка");
		НовЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НеВСписке;
	    НовЭлементОтбора.Использование = Истина;
	    НовЭлементОтбора.ПравоеЗначение =  МассивИсключений;	       
	КонецЕсли;  
	
	НовЭлементОтбора = Гр_Отбора.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	НовЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ПринадлежностьПоказателя");
	НовЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
	НовЭлементОтбора.Использование = Истина;
	НовЭлементОтбора.ПравоеЗначение = ДопустимаяПринадлежностьПоказателя;	 
	
	//////////////////////////////////
	Если ЭтоСотрудник Тогда
		Гр_ОтбораПоНижестоящим = Гр_Отбора.Элементы.Добавить(Тип("ГруппаЭлементовОтбораКомпоновкиДанных")); 
		Гр_ОтбораПоНижестоящим.ТипГруппы = ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИЛИ; 
		
		//или это подразделение, и тогда флаг должен быть взведен
		Гр_ОтбораПоНижестоящим_влож = Гр_ОтбораПоНижестоящим.Элементы.Добавить(Тип("ГруппаЭлементовОтбораКомпоновкиДанных")); 
		Гр_ОтбораПоНижестоящим_влож.ТипГруппы = ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ; 

		НовЭлементОтбора = Гр_ОтбораПоНижестоящим_влож.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		НовЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("УчаствуютНижестоящиеПодразделения");
		НовЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
		НовЭлементОтбора.Использование = Истина;
		НовЭлементОтбора.ПравоеЗначение = Истина;	   

		НовЭлементОтбора = Гр_ОтбораПоНижестоящим_влож.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));       
		НовЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ПринадлежностьПоказателяТип");   //- подразделение
		НовЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено;
		НовЭлементОтбора.Использование = Истина;
		
		//или это не подразделение
		НовЭлементОтбора = Гр_ОтбораПоНижестоящим.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));       
		НовЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ПринадлежностьПоказателяТип");  
		НовЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;
		НовЭлементОтбора.Использование = Истина;
		
		НовЭлементОтбора = Гр_ОтбораПоНижестоящим.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));       
		НовЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ПринадлежностьПоказателя");  
		НовЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
		НовЭлементОтбора.Использование = Истина;
		НовЭлементОтбора.ПравоеЗначение = Параметры.ПодразделениеСотрудника;
	КонецЕсли;
	/////////////////////////////////////////////


	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
//
// Процедура 
//
// Описание:
// Переопределяет выбор типа назначения из списка - подменяет тип "Справочник.УБ_Компании" на предопределенное значение
//
// Параметры (название, тип, дифференцированное значение)
//
Процедура НазначениеНачалоВыбора(Форма, Источник, ИмяОпределяемогоТипа = "УБ_НазначенияПоказателей", СтандартнаяОбработка) Экспорт

	СтандартнаяОбработка = Ложь;  
	МассивТипов = УБ_ОбщегоНазначенияПовтИсп.МассивТиповОпределяемогоТипа(ИмяОпределяемогоТипа);
	ДопПараметр = Новый Структура("Форма, Источник", Форма, Источник);
	ОписаниеОповещения = Новый ОписаниеОповещения("ОткрытьФормуВыбораНазначения", ЭтотОбъект, ДопПараметр);
	Форма.ПоказатьВыборИзСписка(ОписаниеОповещения, МассивТипов); 
		
КонецПроцедуры //НазначениеНачалоВыбора 

Процедура ОткрытьФормуВыбораНазначения(Результат, ДополнительныеПараметры) Экспорт

	перем Организация;
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;    

	Если Результат.Значение = Тип("СправочникСсылка.УБ_Компании") Тогда
		ДополнительныеПараметры.Форма.ОбработкаВыбораНазначения(УБ_ОбщегоНазначенияКлиент.ЗначениеРеквизитаПоУмолчанию("Компания"), ДополнительныеПараметры.Источник);
	Иначе
		Отбор = Новый Структура;  
		ДополнительныеПараметры.Форма.Объект.Свойство("Организация", Организация);
		УБ_ПланированиеПоказателейСервер.ЗаполнитьОтбор(Отбор, Результат.Значение, Организация);          
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Отбор", Отбор);
		ПараметрыФормы.Вставить("РежимВыбора", Истина);
		ИмяФормыВыбора = УБ_ОбщегоНазначенияКлиентВызовСервера.ПолучитьИмяФормыВыбораПоСсылке(Новый (Результат.Значение)); 
		ОписаниеОповещения = Новый ОписаниеОповещения("ОбработкаВыбораНазначения", ДополнительныеПараметры.Форма, ДополнительныеПараметры.Источник);
		ОткрытьФорму(ИмяФормыВыбора, ПараметрыФормы, ДополнительныеПараметры.Форма,,,,ОписаниеОповещения); 
	КонецЕсли;
		
КонецПроцедуры       


//Заполняет служебное поле "НазначениеТип" для упрощения определения типа Назначения
Процедура УстановитьОграничениеТипаНазначения(ТекущееНазначение, Назначение, ПолеЗначения) Экспорт
	ПолеЗначения = УБ_ОбщегоНазначенияКлиент.ЗначениеРеквизитаПоУмолчанию(ТекущееНазначение);   //пустая ссылка на объект нужного типа   или "строка"
КонецПроцедуры

Процедура УстановитьОграничениеТипаЗначения(Назначение, ПолеЗначения) Экспорт
	УБ_ПланированиеПоказателейСервер.УстановитьОграничениеТипаЗначения(Назначение, ПолеЗначения) ;
	//ТипЗначенияПоказателя = УБ_ОбщегоНазначенияКлиентВызовСервера.ЗначениеРеквизитаОбъекта(Назначение, "ТипЗначенияПоказателя"); 
	//Если ТипЗначенияПоказателя = "Строка" и НЕ ТипЗнч(ПолеЗначения) = Тип("Строка") Тогда
	//	ПолеЗначения= "";
	//ИначеЕсли  ТипЗначенияПоказателя= "Число" и НЕ ТипЗнч(ПолеЗначения) = Тип("Число") Тогда
	//	ПолеЗначения = 0;
	//ИначеЕсли ТипЗначенияПоказателя = "Булево" и НЕ ТипЗнч(ПолеЗначения) = Тип("Булево") Тогда
	//	ПолеЗначения = Ложь;
	//КонецЕсли;
КонецПроцедуры
   
////////////////////////////////////////////////////////////////////////////////
//
// Процедура ОпределитьТекущееНазначение
//
// Описание: устанавливает значение реквизита формы в зависимости от типа назначения, с которым ведется работа в данный момент
//
//
// Параметры (название, тип, дифференцированное значение)
//
Процедура ОпределитьТекущееНазначение(Форма, Назначение) Экспорт
    Если ТипЗнч(Назначение) = ТипЗнч(УБ_ОбщегоНазначенияКлиент.ЗначениеРеквизитаПоУмолчанию("Подразделение")) Тогда
		Форма.ТекущееНазначение	= "Подразделение";
	ИначеЕсли ТипЗнч(Назначение) = ТипЗнч(УБ_ОбщегоНазначенияКлиент.ЗначениеРеквизитаПоУмолчанию("Организация")) Тогда
		Форма.ТекущееНазначение	= "Организация";
	ИначеЕсли ТипЗнч(Назначение) = ТипЗнч(УБ_ОбщегоНазначенияКлиент.ЗначениеРеквизитаПоУмолчанию("Должность")) Тогда
		Форма.ТекущееНазначение	= "Должность";
	ИначеЕсли ТипЗнч(Назначение) = ТипЗнч(УБ_ОбщегоНазначенияКлиент.ЗначениеРеквизитаПоУмолчанию("Проект")) Тогда
		Форма.ТекущееНазначение	= "Проект";
	ИначеЕсли ТипЗнч(Назначение) = ТипЗнч(УБ_ОбщегоНазначенияКлиент.ЗначениеРеквизитаПоУмолчанию("Сотрудник")) Тогда
		Форма.ТекущееНазначение	= "Сотрудник";
	Иначе
		Форма.ТекущееНазначение	= ТипЗнч(УБ_ОбщегоНазначенияКлиент.ЗначениеРеквизитаПоУмолчанию("Компания"));
	КонецЕсли; 
КонецПроцедуры //ОпределитьТекущееНазначение

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ОпределитьДопустимуюПринадлежностьПоказателя(Дата, Параметры) Экспорт
                                                         	
	Возврат УБ_ПланированиеПоказателейСервер.ОпределитьДопустимуюПринадлежностьПоказателя(Дата, Параметры);
	
КонецФункции    
 
////////////////////////////////////////////////////////////////////////////////
//
// Процедура НазначениеТип
//
// Описание:проверяет, возможно ли использовать показатель для назначения
//
//
// Параметры (название, тип, дифференцированное значение)
// показатель - СправочникСсылка.УБ_ПоказателиЭффективности 
// Назначение - значение из определяемого Типа УБ_НазначенияПоказателей
// ПолеЭлемента - поле Показателя   
// ДопустимаяПринадлежностьПоказателя - Массив, хранится в реквизите формы-источника события
Процедура ПроверитьСоответствиеПоказателяНазначению(Параметры, ДатаДок = Неопределено) Экспорт
	
	Если Параметры.показатель.Пустая() Тогда
		Возврат;		
	КонецЕсли;  
	//Если Форма.ИмяФормы = "Документ.УБ_УстановкаФактаПоказателей.Форма.ФормаДокумента" Тогда
	//	//в этот документ могут попасть только Показатели факт по которым устанавливается вручную
	//КонецЕсли;
	Если ДатаДок = Неопределено Тогда
		ДатаДок = ТекущаяДата();
	КонецЕсли;
	ДопустимаяПринадлежностьПоказателя = ОпределитьДопустимуюПринадлежностьПоказателя(ДатаДок, Параметры); 
	Если ДопустимаяПринадлежностьПоказателя.Найти(УБ_ОбщегоНазначенияКлиентВызовСервера.ЗначениеРеквизитаОбъекта(Параметры.показатель, "ПринадлежностьПоказателя")) = Неопределено Тогда
		Параметры.показатель = ПредопределенноеЗначение("Справочник.УБ_ПоказателиЭффективности.ПустаяСсылка");
	КонецЕсли;
    
КонецПроцедуры//ПроверитьСоответствиеПоказателяНазначению

Процедура ЗаполнитьПоНастройкам(Объект, КлючСвязи = Неопределено)  Экспорт  
	мОбъект = Объект;    
	УБ_ПланированиеПоказателейСервер.ЗаполнитьПоНастройкамНаСервере(мОбъект, КлючСвязи);
    КопироватьДанныеФормы(мОбъект, Объект);
КонецПроцедуры          


#КонецОбласти

