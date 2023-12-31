Процедура СобратьФактПоПоказателям() Экспорт
    Предыдущаяпоказатель = Неопределено;
	ПредыдущееНазначение = Неопределено;
	НарастающийИтог = 0;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	УБ_ПланПоПоказателям.показатель КАК показатель,
		|	УБ_ПланПоПоказателям.Назначение КАК Назначение,
		|	УБ_ПланПоПоказателям.ДатаНачала КАК ДатаНачала,
		|	УБ_ПланПоПоказателям.ДатаОкончания КАК ДатаОкончания,
		|	УБ_ПланПоПоказателям.ТекущееЗначение КАК ТекущееЗначение,
		|	УБ_ПланПоПоказателям.Регистратор.Организация КАК Организация,
		|	УБ_ПланПоПоказателям.ДатаНачалаНарастающего КАК ДатаНачалаНарастающего,
		|	УБ_ПланПоПоказателям.ДатаОкончанияНарастающего КАК ДатаОкончанияНарастающего
		|ИЗ
		|	РегистрСведений.УБ_ПланПоПоказателям КАК УБ_ПланПоПоказателям
		|ГДЕ
		|	УБ_ПланПоПоказателям.показатель.ВариантРасчетаЗначенияФакта = &ВариантРасчетаЗначенияФакта
		|
		|УПОРЯДОЧИТЬ ПО
		|	показатель,
		|	Назначение";
	                                                                                       
	Запрос.УстановитьПараметр("ВариантРасчетаЗначенияФакта", Перечисления.УБ_ВариантыРасчетаЗначенийПоказателя.ИзСхемыПоказателя);

	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		ПараметрыРасчета = Новый Структура;
		ПараметрыРасчета.Вставить("Организация", Выборка.Организация);
		ПараметрыРасчета.Вставить("Подразделение", Неопределено);
		ПараметрыРасчета.Вставить("Сотрудник", Выборка.Назначение);
		
		Если Строка(ТипЗнч(Выборка.Назначение)) = "Сотрудник" Тогда
			ПараметрыРасчета.Вставить("ФизическоеЛицо", Выборка.Назначение.ФизическоеЛицо);
		КонецЕсли;
		ПараметрыРасчета.Вставить("НачалоПериода", Выборка.ДатаНачала);
		ПараметрыРасчета.Вставить("КонецПериода", КонецДня(Выборка.ДатаОкончания));
			
		ДанныеПоказателя = УБ_РасчетПоказателейЭффективности.РассчитатьЗначенияПоказателяЭффективности(Выборка.показатель, ПараметрыРасчета); 
		
		Если Предыдущаяпоказатель <> Выборка.показатель ИЛИ ПредыдущееНазначение <> Выборка.Назначение Тогда
			НарастающийИтог = 0;
		КонецЕсли;
		
		Предыдущаяпоказатель = Выборка.показатель;
		ПредыдущееНазначение = Выборка.Назначение;
		НарастающийИтог = НарастающийИтог + ДанныеПоказателя[0].Факт; 
		 
		Запись = РегистрыСведений.УБ_ФактПоПоказателям.СоздатьМенеджерЗаписи();
		Запись.ДатаНачала = Выборка.ДатаНачала;
		Запись.ДатаОкончания = Выборка.ДатаОкончания;
		Запись.ДатаНачалаНарастающего = Выборка.ДатаНачалаНарастающего;
		Запись.ДатаОкончанияНарастающего = Выборка.ДатаОкончанияНарастающего; 
		Запись.ТекущееЗначение = ДанныеПоказателя[0].Факт;    
		Запись.Назначение = Выборка.Назначение;  
		Запись.показатель = Выборка.показатель;
		Запись.НарастающийИтог = НарастающийИтог;
		Запись.Записать();
		
	КонецЦикла;		

КонецПроцедуры