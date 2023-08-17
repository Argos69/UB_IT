
&НаКлиенте
Процедура ТаблицаФормулФормулаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	РедактируемоеПоле = Элементы.ТаблицаФормул.ТекущиеДанные;	
	ПараметрыФормы = Новый Структура;
	Если СписокДоступныхПоказателей.Количество() <> 0 тогда
		ПараметрыФормы.Вставить("СписокДоступныхПоказателей",СписокДоступныхПоказателей);
	КонецЕсли;	
	ПараметрыФормы.Вставить("Формула", РедактируемоеПоле.Формула);
	ПараметрыФормы.Вставить("НаименованиеПоказателя", Строка(Показатель));
	ПараметрыФормы.Вставить("ПоказательЭффективности", Показатель);
	
	
	Оповещение = Новый ОписаниеОповещения("ЗафиксироватьФормулуРасчетаЗавершение", ЭтотОбъект,РедактируемоеПоле.Ячейка);
	ОткрытьФорму("ОбщаяФорма.УБ_РедактированиеФормулыПоказателВУтвержденииММ", ПараметрыФормы, ЭтотОбъект,,,,
		Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры
	
&НаКлиенте
Процедура ЗафиксироватьФормулуРасчетаЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого СтрокаТЧ Из ТаблицаФормул Цикл
	    Если СтрокаТЧ.Ячейка = ДополнительныеПараметры Тогда
			СтрокаТЧ.Формула = Результат.Формула;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры	

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Показатель = Параметры.ПоказательЭффективности;
	Если Параметры.Свойство("МассивФормул") И Параметры.Свойство("МассивЯчеек") Тогда
		ЗаполнитьТаблицуФормул();
	КонецЕсли;
	
	Если Параметры.Свойство("СписокДоступныхПоказателей") Тогда
		СписокДоступныхПоказателей.ЗагрузитьЗначения(Параметры.СписокДоступныхПоказателей);
	КонецЕсли;	
	
	ЗаполнитьДоступныеЗначенияВыбора();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДоступныеЗначенияВыбора()
	
	Элементы.ТаблицаФормулЯчейка.СписокВыбора.Очистить();
	Отбор = Новый Структура;
	Отбор.Вставить("Ячейка","План");
	Найденные = ТаблицаФормул.НайтиСтроки(Отбор);
	Если Найденные.Количество()=0 Тогда
		Элементы.ТаблицаФормулЯчейка.СписокВыбора.Добавить("План");
	КонецЕсли;	
	Отбор = Новый Структура;
	Отбор.Вставить("Ячейка","Факт");
	Найденные = ТаблицаФормул.НайтиСтроки(Отбор);
	Если Найденные.Количество()=0 Тогда
		Элементы.ТаблицаФормулЯчейка.СписокВыбора.Добавить("Факт");
	КонецЕсли;
	Отбор = Новый Структура;
	Отбор.Вставить("Ячейка","Сумма");
	Найденные = ТаблицаФормул.НайтиСтроки(Отбор);
	Если Найденные.Количество()=0 Тогда
		Элементы.ТаблицаФормулЯчейка.СписокВыбора.Добавить("Сумма");
	КонецЕсли;
	Отбор = Новый Структура;
	Отбор.Вставить("Ячейка","Эффективность");
	Найденные = ТаблицаФормул.НайтиСтроки(Отбор);
	Если Найденные.Количество()=0 Тогда
		Элементы.ТаблицаФормулЯчейка.СписокВыбора.Добавить("Эффективность");
	КонецЕсли;
	
КонецПроцедуры	

&НаКлиенте
Процедура ВыбратьИЗакрыть(Команда)
	
	Результаты = РезультатыРедактирования();
	
	Если Результаты = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Модифицированность = Ложь;
	Закрыть(Результаты);	
	
КонецПроцедуры

&НаСервере
Функция РезультатыРедактирования()
	
	РезультатыПодбора = Новый Структура;
	МассивФормул = Новый Массив;
	МассивЯчеек = Новый Массив;
	
	Для каждого СтрокаТЧ Из ТаблицаФормул Цикл
		Отказ = Ложь;
		МассивЯчеек.Добавить(СтрокаТЧ.Ячейка);	
		ПараметрыВыполненияФормулы = УБ_РасчетПоказателейЭффективности.ПараметрыВыполненияФормулы(СтрокаТЧ.Формула, Истина);
		Если ПараметрыВыполненияФормулы = Неопределено Тогда
			 МассивФормул.Добавить("");
		Иначе
			//ПроверитьЗацикливаниеПоказателейФормулы(Показатель,
			//	ПараметрыВыполненияФормулы.ПоказателиФормулы,
			//	Отказ);
		КонецЕсли;
		
		Если Не Отказ Тогда
			МассивФормул.Добавить(СтрокаТЧ.Формула);
		Иначе
			МассивФормул.Добавить("");
		КонецЕсли;
	КонецЦикла; 
	РезультатыПодбора.Вставить("МассивФормул",МассивФормул);
	РезультатыПодбора.Вставить("МассивЯчеек",МассивЯчеек);
	Возврат РезультатыПодбора;
	
КонецФункции

&НаСервереБезКонтекста
Процедура ПроверитьЗацикливаниеПоказателейФормулы(ЦелевойПоказатель, Знач ПоказателиФормулы, Отказ)
	
	Счетчик = 0;
	Пока Счетчик < ПоказателиФормулы.Количество() Цикл
		
		Показатель = ПоказателиФормулы[Счетчик];
		
		Если Показатель = ЦелевойПоказатель Тогда
			ТекстСообщения = НСтр("ru = 'Обнаружено зацикливание показателя в формуле'");
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,,, Отказ);
			Прервать;
		КонецЕсли;
		
		Если Не Показатель.ИспользоватьФормулу Тогда
			Счетчик = Счетчик + 1;
			Продолжить;
		КонецЕсли;
		
		ПараметрыВыполненияФормулы = УБ_РасчетПоказателейЭффективности.ПараметрыВыполненияФормулы(
			Показатель.ФормулаРасчета, Ложь);
		Если ПараметрыВыполненияФормулы <> Неопределено Тогда
			
			Для Каждого ЭлементПоказатель Из ПараметрыВыполненияФормулы.ПоказателиФормулы Цикл
				Если ПоказателиФормулы.Найти(ЭлементПоказатель) = Неопределено Тогда
					ПоказателиФормулы.Добавить(ЭлементПоказатель);
				КонецЕсли;
			КонецЦикла;
			
		Иначе
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Ошибка при получении параметров формулы для показателя ""%1""'"),
				Показатель.Идентификатор);
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,,, Отказ);
		КонецЕсли;
		
		ОбщегоНазначенияКлиентСервер.УдалитьВсеВхожденияЗначенияИзМассива(ПоказателиФормулы, Показатель);
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуФормул()
	
	Номер = 0;
	Пока Номер<Параметры.МассивФормул.Количество() Цикл
		НоваяСтрока = ТаблицаФормул.Добавить();
		НоваяСтрока.Формула = Параметры.МассивФормул[Номер];
		НоваяСтрока.Ячейка = Параметры.МассивЯчеек[Номер];
		Номер = Номер+1;
	КонецЦикла;	
	
КонецПроцедуры	

&НаКлиенте
Процедура ТаблицаФормулПриИзменении(Элемент)
	ЗаполнитьДоступныеЗначенияВыбора();
КонецПроцедуры

