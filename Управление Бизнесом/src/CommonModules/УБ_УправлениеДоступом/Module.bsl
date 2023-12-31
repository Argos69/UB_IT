
#Область ПрограммныйИнтерфейс

// Заполняет массив структур, которые будут использованы для начального заполнения и
// восстановления начального заполнения профилей.
//
// Параметры:
// ОписанияПрофилей	- Массив
//
Процедура ПриЗаполненииПоставляемыхПрофилейГруппДоступа(ОписанияПрофилей, ПараметрыОбновления) Экспорт
	
	ДобавитьПрофильИспользованиеРасчетаЭффективности(ОписанияПрофилей);
	ДобавитьПрофильИспользованиеПодсистемыПланированияПолный(ОписанияПрофилей);
	ДобавитьПрофильКадрыИРасчетЗарплаты(ОписанияПрофилей);
	ДобавитьПрофильПолныйДоступ(ОписанияПрофилей);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ДобавитьПрофильИспользованиеРасчетаЭффективности(ОписанияПрофилей)
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя = "УБ_ИспользованиеРасчетаЭффективности";
	ОписаниеПрофиля.Идентификатор = "c1df6b8e-448d-4be2-b89e-e693f1ece9ae";
	ОписаниеПрофиля.Наименование = НСтр("ru = 'Использование расчета эффективности (УБ)'");
	
	ДополнитьПрофильОбязательнымиРолями(ОписаниеПрофиля);
	
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеРасчетаЭффективностиСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеВерсийГрейдов");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДанныхДляПодбораСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДелегированныхСотрудниковПодразделений");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДоступностиРасчетаЭффективностиСотрудниковДляПользователей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеЗначенийШкалыПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеКадровойИсторииСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеКоэффициентовРаспределенияБезокладнойСистемыПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеМоделейПланированияСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеНазначенныхРуководителейПодразделений");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеПропорцийМатериальнойМотивации");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеРуководителейПодразделений");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСбораДанныхПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСмартЗадачМоделейПланированияЭффективности");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеФормулыПоказателейЭффективности");      
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеПодразделенийОрганизаций");
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПодсистемы.КадровыйУчет") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеДанныхСотрудников");
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыРасширеннаяПодсистемы.КадровыйУчетРасширенная") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеДанныхСотрудниковРасширенная");
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеДолжностей");
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ПодразделенияОрганизаций") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеПодразделенийОрганизации");
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыРасширеннаяПодсистемы.УправлениеШтатнымРасписанием") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеШтатногоРасписания");
	КонецЕсли;
	
	ОписаниеПрофиля.Описание = НСтр("ru = 'Профиль для сотрудников предприятия для использования документа ""Расчет эффективности сотрудников""'");
	
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
КонецПроцедуры

// Профиль только для полного использования подсистемы,
Процедура ДобавитьПрофильИспользованиеПодсистемыПланированияПолный(ОписанияПрофилей)
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя = "УБ_ИспользованиеПодсистемыПланированияПолный";
	ОписаниеПрофиля.Идентификатор = "c1df6b8e-448d-4be2-b89e-e693f1ece9bc";  
	ОписаниеПрофиля.Наименование = НСтр("ru = 'Использование подсистемы планирования (УБ)'");
	
	ДополнитьПрофильОбязательнымиРолями(ОписаниеПрофиля);
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеГоризонтыПланирования");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеПланированияПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеПоказателейЭффективности");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеПринадлежностиПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеПринадлежностиПоказателя");   //!!! две роли?
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеТиповПоказателей"); 
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеКадровойИсторииСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеПринадлежностиПоказателя");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеЗапланированныхПоказателей");      //регистр
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеПланированияПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеРуководителейПодразделений");              
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДанныхДляПодбораСотрудников");  
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДелегированныхСотрудниковПодразделений");  
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДоступностиРасчетаЭффективностиСотрудниковДляПользователей");  
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСбораДанныхПоказателей");  
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДолжностей");  
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСотрудников");  
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеПодразделенийОрганизаций");
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПодсистемы.КадровыйУчет") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеДанныхСотрудников");
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыРасширеннаяПодсистемы.КадровыйУчетРасширенная") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеДанныхСотрудниковРасширенная");
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеДолжностей");
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ПодразделенияОрганизаций") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеПодразделенийОрганизации");
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыРасширеннаяПодсистемы.УправлениеШтатнымРасписанием") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеШтатногоРасписания");
	КонецЕсли;

	// Виды доступа.	
	//ОписаниеПрофиля.ВидыДоступа.Добавить("УБ_Подразделения", "ВначалеВсеЗапрещены");
	ОписаниеПрофиля.ВидыДоступа.Добавить("УБ_Подразделения", "ВначалеВсеРазрешены");
	
	ОписаниеПрофиля.Описание = НСтр("ru = 'Профиль сотрудников предприятия для использования подсистемы ""Планирование целей и показателей""'");
	
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
КонецПроцедуры

Процедура ДобавитьПрофильКадрыИРасчетЗарплаты(ОписанияПрофилей)
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя = "УБ_КадрыИРасчетЗарплаты";
	ОписаниеПрофиля.Идентификатор = "a0f9219a-b333-4e45-9b5c-ce89b9f8e063";
	ОписаниеПрофиля.Наименование = НСтр("ru = 'Кадры и расчет зарплаты (УБ)'");
	
	ДополнитьПрофильОбязательнымиРолями(ОписаниеПрофиля);
	
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеКадровыхДокументов");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеКадровыхСведенийСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеМоделейПланированияЭффективности");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеРасчетаЭффективностиСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеВерсийГрейдов");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДанныхДляПодбораСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДанныхПоказателейРасчетаЗарплаты");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДелегированныхСотрудниковПодразделений");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДоступностиРасчетаЭффективностиСотрудниковДляПользователей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеЗначенийШкалыПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеКадровойИсторииСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеКоэффициентовРаспределенияБезокладнойСистемыПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеМоделейПланированияСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеНазначенныхРуководителейПодразделений");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеПропорцийМатериальнойМотивации");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеРасценокПоказателейЭффективности");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеРуководителейПодразделений");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСбораДанныхПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСмартЗадачМоделейПланированияЭффективности");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСоставаПоказателейМоделейПланирования");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСоставаСтандартовМоделейПланирования");                
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеПодразделенийОрганизаций");
	
	ОписаниеПрофиля.Описание = НСтр("ru = 'Профиль для руководителя подразделения'");
	
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
КонецПроцедуры

Процедура ДобавитьПрофильКадрыИРасчетЗарплатыРасширенный(ОписанияПрофилей)
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя = "УБ_КадрыИРасчетЗарплатыРасш";
	ОписаниеПрофиля.Идентификатор = "873cf4c4-bf21-4ab2-8fd9-31390e774179";
	ОписаниеПрофиля.Наименование = НСтр("ru = 'Кадры и расчет зарплаты расширенный (УБ)'");
	
	ДополнитьПрофильОбязательнымиРолями(ОписаниеПрофиля);
	
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеКадровыхДокументов");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеКадровыхСведенийСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеМоделейПланированияЭффективности");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеРасчетаЭффективностиСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеВерсийГрейдов");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДанныхДляПодбораСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДанныхПоказателейРасчетаЗарплаты");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДелегированныхСотрудниковПодразделений");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДоступностиРасчетаЭффективностиСотрудниковДляПользователей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеЗначенийШкалыПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеКадровойИсторииСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеКоэффициентовРаспределенияБезокладнойСистемыПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеМоделейПланированияСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеНазначенныхРуководителейПодразделений");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеПропорцийМатериальнойМотивации");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеРасценокПоказателейЭффективности");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеРуководителейПодразделений");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСбораДанныхПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСмартЗадачМоделейПланированияЭффективности");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСоставаПоказателейМоделейПланирования");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСоставаСтандартовМоделейПланирования");
	ОписаниеПрофиля.Роли.Добавить("УБ_ИспользованиеПодразделенияВКадровыхДокументахРасш");    
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеПодразделенийОрганизаций");
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ПодразделенияОрганизаций") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеПодразделенийОрганизации");
	КонецЕсли;
	
	ОписаниеПрофиля.Описание = НСтр("ru = 'Профиль для расчетчика зарплаты'");
	
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
КонецПроцедуры

Процедура ДобавитьПрофильПолныйДоступ(ОписанияПрофилей)
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя = "УБ_ПолныйДоступ";
	ОписаниеПрофиля.Идентификатор = "dfb088d6-00ae-418d-a63b-9c22e0a69e3d";
	ОписаниеПрофиля.Наименование = НСтр("ru = 'Полный доступ (УБ)'");
	
	ДополнитьПрофильОбязательнымиРолями(ОписаниеПрофиля);
	
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеВерсийГрейдов");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеВидовОценок");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеГрейдов");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеДелегирования");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеДолжностей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеКадровыхДокументов");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеКадровыхСведенийСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеМоделейПланированияЭффективности");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеНазначенийРуководителейПодразделений");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеПодразделений");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеПоказателейРасчетаЗарплаты");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеПоказателейЭффективности");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеПринадлежностиПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеПричинОтсутствия");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеРасчетаЭффективностиСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеСКДПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеСмартЗадач");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеСмартЗадачМоделейПланирования");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеСтандартов");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеТиповПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеУстановокЗначенийШкалыПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеУстановокПропорцийМатериальнойМотивации");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеУстановокФиксированныхПоказателейОрганизации");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеУтвержденийГрейда");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеШкалОценок");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеШкалПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ДобавлениеИзменениеШтатногоРасписания");
	ОписаниеПрофиля.Роли.Добавить("УБ_ИспользованиеОтчетаАнализЗаполненияМоделей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ИспользованиеОтчетаАнализСтандартов");
	ОписаниеПрофиля.Роли.Добавить("УБ_ИспользованиеОтчетаАнализЭффективности");
	ОписаниеПрофиля.Роли.Добавить("УБ_ИспользованиеОтчетаНазначенныеСотрудникамМодели");
	ОписаниеПрофиля.Роли.Добавить("УБ_ИспользованиеОтчетаОписаниеПоказателейЭффективностиСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ИспользованиеОтчетаПроверкаСостоянияСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ИспользованиеОтчетаСравнениеВерсийГрейда");
	ОписаниеПрофиля.Роли.Добавить("УБ_ИспользованиеОтчетаСравнениеВерсийГрейда");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеВерсийГрейдов");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДанныхДляПодбораСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДанныхПоказателейРасчетаЗарплаты");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДелегированныхСотрудниковПодразделений");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеДоступностиРасчетаЭффективностиСотрудниковДляПользователей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеЗначенийШкалыПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеКадровойИсторииСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеКоэффициентовРаспределенияБезокладнойСистемыПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеМоделейПланированияСотрудников");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеНазначенныхРуководителейПодразделений");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеПропорцийМатериальнойМотивации");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеРасценокПоказателейЭффективности");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеРуководителейПодразделений");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСбораДанныхПоказателей");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСмартЗадачМоделейПланированияЭффективности");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСоставаПоказателейМоделейПланирования");
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеСоставаСтандартовМоделейПланирования");       
	ОписаниеПрофиля.Роли.Добавить("УБ_ЧтениеПодразделенийОрганизаций");
	ОписаниеПрофиля.Роли.Добавить("УБ_ИспользованиеПодразделенияВКадровыхДокументахРасш");
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыРасширеннаяПодсистемы") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеДанныхДляРасчетаЗарплаты");
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПодсистемы.КадровыйУчет") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеДанныхСотрудников");
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыРасширеннаяПодсистемы.КадровыйУчетРасширенная") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеДанныхСотрудниковРасширенная");
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеДолжностей");
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ПодразделенияОрганизаций") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеПодразделенийОрганизации");
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыРасширеннаяПодсистемы.УправлениеШтатнымРасписанием") Тогда
		ОписаниеПрофиля.Роли.Добавить("ЧтениеШтатногоРасписания");
	КонецЕсли;
	
	ОписаниеПрофиля.Описание = НСтр("ru = 'Профиль для руководителей подразделений'");
	
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
КонецПроцедуры

Процедура ДополнитьПрофильОбязательнымиРолями(ОписаниеПрофиля)
	
	// Запуск 1С:Предприятия
	ОписаниеПрофиля.Роли.Добавить("ЗапускТонкогоКлиента");
	Если Не ОбщегоНазначения.РазделениеВключено() Тогда
		ОписаниеПрофиля.Роли.Добавить("ЗапускТолстогоКлиента");
	КонецЕсли;
	ОписаниеПрофиля.Роли.Добавить("ЗапускВебКлиента");
	ОписаниеПрофиля.Роли.Добавить("СохранениеДанныхПользователя");
	ОписаниеПрофиля.Роли.Добавить("ВыводНаПринтерФайлБуферОбмена");
	
	// Базовые права
	ОписаниеПрофиля.Роли.Добавить("УБ_БазовыеПрава");
	ОписаниеПрофиля.Роли.Добавить("БазовыеПраваБСП");
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПодсистемы") Тогда
		ОписаниеПрофиля.Роли.Добавить("БазовыеПраваЗарплатаКадрыРасширенная");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти