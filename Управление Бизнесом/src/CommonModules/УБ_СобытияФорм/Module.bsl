
#Область ПрограммныйИнтерфейс

Функция ОпределитьПутьКДаннымГраницЭффективности(Элементы, ПрефиксКРеквизиту, ИспользоватьАбс) Экспорт
	Попытка
		Элементы.НегативноеОтклонениеНормыДо.ПутьКДанным = ПрефиксКРеквизиту + "НегативноеОтклонениеНормыДо";
		Элементы.НегативноеОтклонениеНормыДо.УстановитьДействие("ПриИзменении", "НегативноеОтклонениеНормыДоПриИзменении");
		
		Элементы.ПозитивноеОтклонениеНормыОт.ПутьКДанным = ПрефиксКРеквизиту + "ПозитивноеОтклонениеНормыОт";
		Элементы.ПозитивноеОтклонениеНормыОт.УстановитьДействие("ПриИзменении", "ПозитивноеОтклонениеНормыОтПриИзменении");
		
		Элементы.ПограничноеОтклонениеНормыОт.ПутьКДанным = ПрефиксКРеквизиту + "ПограничноеОтклонениеНормыОт";
		Элементы.ПограничноеОтклонениеНормыОт.УстановитьДействие("ПриИзменении", "ПограничноеОтклонениеНормыОтПриИзменении");
		
		Элементы.ПограничноеОтклонениеНормыДо.ПутьКДанным = ПрефиксКРеквизиту + "ПограничноеОтклонениеНормыДо";
		Элементы.ПограничноеОтклонениеНормыДо.УстановитьДействие("ПриИзменении", "ПограничноеОтклонениеНормыДоПриИзменении");
		
		Если ИспользоватьАбс Тогда
			Элементы.НегативноеОтклонениеНормыДоАбс.ПутьКДанным = ПрефиксКРеквизиту + "НегативноеОтклонениеНормыДоАбс";
			Элементы.НегативноеОтклонениеНормыДоАбс.УстановитьДействие("ПриИзменении", "НегативноеОтклонениеНормыДоАбсПриИзменении");
			
			Элементы.ПограничноеОтклонениеДиапазон.ПутьКДанным = ПрефиксКРеквизиту + "ПограничноеОтклонениеДиапазон";
			//Элементы.ПограничноеОтклонениеДиапазон.УстановитьДействие("ПриИзменении", "ПограничноеОтклонениеДиапазонПриИзменении");
			
			Элементы.ПозитивноеОтклонениеНормыОтАбс.ПутьКДанным = ПрефиксКРеквизиту + "ПозитивноеОтклонениеНормыОтАбс";
			Элементы.ПозитивноеОтклонениеНормыОтАбс.УстановитьДействие("ПриИзменении", "ПозитивноеОтклонениеНормыОтАбсПриИзменении");
		КонецЕсли;
		
	Исключение
		
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Выполнение операции ОпределитьПутьКДаннымГраницЭффективности'"),
    	УровеньЖурналаРегистрации.Ошибка,,,"ОпределитьПутьКДаннымГраницЭффективности какой-то реквизит не найден!" + Символы.ПС + 
    	ОбработкаОшибок.ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
    	ВызватьИсключение;
		
	КонецПопытки;
	
КонецФункции

Процедура СоздатьГраницыНормЭффективности(Форма)
	
	//Определение ПРЕФИКСА и ИСПОЛЬЗОВАНИЯ ABS
	Абс = Ложь;
	Если Форма.ИмяФормы = "Справочник.УБ_ПоказателиЭффективности.Форма.ФормаЭлемента" Тогда
		Префикс = "Объект.";
	Иначе
		Если Форма.ИмяФормы = "Документ.УБ_ПланированиеЦелейИПоказателей.Форма.ФормаРедактированияСтрокиПоказателя" Тогда
			Префикс = "";
			Абс = Истина;
		Иначе
			Если Форма.ИмяФормы = "Справочник.УБ_ТипыПоказателей.Форма.ФормаЭлемента" Тогда
				Префикс = "Объект.";
			Иначе
				Если Форма.ИмяФормы = "Документ.УБ_УтверждениеГрейда.Форма.ФормаПараметров" Тогда
					Префикс = "";
				Иначе
					Если Форма.ИмяФормы = "Обработка.УБ_ПанельАдминистрирования.Форма.НастройкиУБ" Тогда
						Префикс = "НаборКонстант.УБ_";
					//Иначе
					//	Если Форма.ИмяФормы = "НоваяФорма" Тогда
					//		Префикс = "ПутьДоРеквизита";
					//		Абс = Истина;
					//	КонецЕсли;
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	
	
	//Свойства ГраницыНормыЭффективностиПоказателей
	Форма.Элементы.ГраницыНормыЭффективностиПоказателей.ГоризонтальныйИнтервал = ИнтервалМеждуЭлементамиФормы.Двойной;
	Форма.Элементы.ГраницыНормыЭффективностиПоказателей.Группировка = ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда;
	Форма.Элементы.ГраницыНормыЭффективностиПоказателей.Заголовок = "Границы нормы эффективности показателей";
	Форма.Элементы.ГраницыНормыЭффективностиПоказателей.ОтображатьЗаголовок = Истина;
	Форма.Элементы.ГраницыНормыЭффективностиПоказателей.ОтображатьОтступСлева = Истина;
	Форма.Элементы.ГраницыНормыЭффективностиПоказателей.Отображение = ОтображениеОбычнойГруппы.СлабоеВыделение;
	Форма.Элементы.ГраницыНормыЭффективностиПоказателей.ОтображениеПодсказки = ОтображениеПодсказки.Кнопка;
	Форма.Элементы.ГраницыНормыЭффективностиПоказателей.ОтображениеУправления = ОтображениеУправленияОбычнойГруппы.Картинка;
	Форма.Элементы.ГраницыНормыЭффективностиПоказателей.Поведение = ПоведениеОбычнойГруппы.Свертываемая;
	Форма.Элементы.ГраницыНормыЭффективностиПоказателей.Подсказка = "Границы норм эффективности используются для отображения 
																	|индикации уровня выполнения показателя или цели в отчётах, 
																	|документах и дашбордах.";
	//Форма.Элементы.ГраницыНормыЭффективностиПоказателей.ЦветФона = ЦветаСтиля.
	
	//Описание свойств для групп ОТКЛОНЕНИЯ И ABS
	СтруктураОАбс = Новый Структура();
	СтруктураОАбс.Вставить("Группировка",ГруппировкаПодчиненныхЭлементовФормы.Вертикальная);
	СтруктураОАбс.Вставить("ОтображатьЗаголовок", Истина);
	СтруктураОАбс.Вставить("Отображение",ОтображениеОбычнойГруппы.СильноеВыделение);
	СтруктураОАбс.Вставить("ШрифтЗаголовка", Новый Шрифт(,,,Истина));
	
	//Создание групп ОТКЛОНЕНИЯ и ABS
	Отклонения = УБ_ДинамическоеФормированиеИнтерфейса.СздГруппаОбычная(Форма,"Отклонения","ГраницыНормыЭффективностиПоказателей","Отклонения",,,,СтруктураОАбс);
	Отклонения.Ширина = 41;
	АбсолютныеЗначения = УБ_ДинамическоеФормированиеИнтерфейса.СздГруппаОбычная(Форма,"АбсолютныеЗначения","ГраницыНормыЭффективностиПоказателей","Абсолютные значения",,,,СтруктураОАбс);
	
	//Описание свойств для групп Отклонений
	СтруктураОтклонений = Новый Структура();
	СтруктураОтклонений.Вставить("Группировка", ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда);
	СтруктураОтклонений.Вставить("ОтображатьЗаголовок", Ложь);
	СтруктураОтклонений.Вставить("ГоризонтальныйИнтервал", ИнтервалМеждуЭлементамиФормы.Нет);
	
	//Создание групп Отклонений
	НегативноеОтклонение = УБ_ДинамическоеФормированиеИнтерфейса.СздГруппаОбычная(Форма,"ГруппаНегативноеОтклонение","Отклонения","",,,,СтруктураОтклонений);
	ПограничноеОтклонение = УБ_ДинамическоеФормированиеИнтерфейса.СздГруппаОбычная(Форма,"ГруппаПограничноеОтклонение","Отклонения","",,,,СтруктураОтклонений);
	ПозитивноеОтклонение = УБ_ДинамическоеФормированиеИнтерфейса.СздГруппаОбычная(Форма,"ГруппаПозитивноеОтклонение","Отклонения","",,,,СтруктураОтклонений);
	
	//Заполнение Групп отклонений
	//Общие
	ШиринаНадписиЗона = 6;
	СтруктураНазванийЗон = Новый Структура();
	СтруктураНазванийЗон.Вставить("ГоризонтальноеПоложение", ГоризонтальноеПоложениеЭлемента.Центр);
	РамкаОдинарная = Новый Рамка(ТипРамкиЭлементаУправления.Одинарная,1);
	СтруктураНазванийЗон.Вставить("Рамка", РамкаОдинарная);
	СтруктураНазванийЗон.Вставить("Ширина", ШиринаНадписиЗона);
	
	Красная = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"Красная","ГруппаНегативноеОтклонение","Красная",Ложь);
	Желтая = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"Желтая","ГруппаПограничноеОтклонение","Желтая", Ложь);
	Зеленая = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"Зеленая","ГруппаПозитивноеОтклонение","Зеленая", Ложь);
	ЗаполнитьЗначенияСвойств(Красная,СтруктураНазванийЗон);
	ЗаполнитьЗначенияСвойств(Желтая,СтруктураНазванийЗон);
	ЗаполнитьЗначенияСвойств(Зеленая,СтруктураНазванийЗон);
	
	Красная.ЦветТекста = Новый Цвет(221, 0, 0);
	Красная.ЦветРамки = Новый Цвет(221, 0, 0);
	Желтая.ЦветТекста = Новый Цвет(255, 204, 0);
	Желтая.ЦветРамки = Новый Цвет(255, 204, 0);
	Зеленая.ЦветТекста = Новый Цвет(0, 128, 0);
	Зеленая.ЦветРамки = Новый Цвет(0, 128, 0);
		
		//зона (%):
	ЗонаК = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"ЗонаК", "ГруппаНегативноеОтклонение", " зона (%):",Ложь);
	ЗонаЖ = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"ЗонаЖ", "ГруппаПограничноеОтклонение", " зона (%) ",Ложь);
	ЗонаЗ = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"ЗонаЗ", "ГруппаПозитивноеОтклонение", " зона (%):",Ложь);
	
	//Негативное + Позитивное ОТКЛОНЕНИЯ
	ШиринаРазделителя1 = 8;
	КРазделитель1 = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"КРазделитель1","ГруппаНегативноеОтклонение","",Ложь);
	ЗРазделитель1 = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"ЗРазделитель1","ГруппаПозитивноеОтклонение","",Ложь);
	КРазделитель1.Ширина = ШиринаРазделителя1;
	ЗРазделитель1.Ширина = ШиринаРазделителя1;
	
	СтруктураПолейВвода = Новый Структура();
	СтруктураПолейВвода.Вставить("ПоложениеЗаголовка", ПоложениеЗаголовкаЭлементаФормы.Нет);
	СтруктураПолейВвода.Вставить("Ширина", 6);
	СтруктураПолейВвода.Вставить("ГоризонтальноеПоложение", ГоризонтальноеПоложениеЭлемента.Центр);
	НегативноеОтклонениеНормыДо = УБ_ДинамическоеФормированиеИнтерфейса.СздПоле(Форма,"НегативноеОтклонениеНормыДо","ГруппаНегативноеОтклонение"," ",1,,СтруктураПолейВвода);
	ПозитивноеОтклонениеНормыОт = УБ_ДинамическоеФормированиеИнтерфейса.СздПоле(Форма,"ПозитивноеОтклонениеНормыОт","ГруппаПозитивноеОтклонение"," ",1,,СтруктураПолейВвода);
	
	ШиринаРазделителя2 = 8;
	КРазделитель2 = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"КРазделитель2","ГруппаНегативноеОтклонение","",Ложь);
	ЗРазделитель2 = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"ЗРазделитель2","ГруппаПозитивноеОтклонение","",Ложь);
	КРазделитель2.Ширина = ШиринаРазделителя2;
	ЗРазделитель2.Ширина = ШиринаРазделителя2;
	
	СтруктураИндикаторов = Новый Структура();
	СтруктураИндикаторов.Вставить("ГоризонтальноеПоложение", ГоризонтальноеПоложениеЭлемента.Центр);
	СтруктураИндикаторов.Вставить("Ширина", 2);
	КИндикатор = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"КИндикатор", "ГруппаНегативноеОтклонение", "▲",Ложь);
	ЗИндикатор = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"ЗИндикатор", "ГруппаПозитивноеОтклонение", "▼",Ложь);
	ЗаполнитьЗначенияСвойств(КИндикатор,СтруктураИндикаторов);
	ЗаполнитьЗначенияСвойств(ЗИндикатор,СтруктураИндикаторов);
	КИндикатор.ЦветТекста = Новый Цвет(221, 0, 0);
	ЗИндикатор.ЦветТекста = Новый Цвет(0, 128, 0);
	
	//Пограничное ОТКЛОНЕНИЕ
	ЖОт = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"ЖОт","ГруппаПограничноеОтклонение"," от:",Ложь);
	ЖОт.Ширина = 2;
	ЖОт.ГоризонтальноеПоложение = ГоризонтальноеПоложениеЭлемента.Центр;
	
	СтруктураПогрПолейВвода = Новый Структура();
	СтруктураПогрПолейВвода.Вставить("ПоложениеЗаголовка", ПоложениеЗаголовкаЭлементаФормы.Нет);
	СтруктураПогрПолейВвода.Вставить("Ширина", 5);
	СтруктураПогрПолейВвода.Вставить("ГоризонтальноеПоложение", ГоризонтальноеПоложениеЭлемента.Центр);
	ПограничноеОтклонениеНормыОт = УБ_ДинамическоеФормированиеИнтерфейса.СздПоле(Форма,"ПограничноеОтклонениеНормыОт","ГруппаПограничноеОтклонение"," ",1,,СтруктураПогрПолейВвода);
	ПограничноеОтклонениеНормыДо = УБ_ДинамическоеФормированиеИнтерфейса.СздПоле(Форма,"ПограничноеОтклонениеНормыДо","ГруппаПограничноеОтклонение"," ",1,,СтруктураПогрПолейВвода);
	
	ЖДо = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"ЖДо","ГруппаПограничноеОтклонение","до:",Ложь,"ПограничноеОтклонениеНормыДо");
	ЖДо.Ширина = 5;
	ЖДо.ГоризонтальноеПоложение = ГоризонтальноеПоложениеЭлемента.Центр;
	
	ЖРазделитель = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"ЖРазделитель","ГруппаПограничноеОтклонение","",Ложь);
	ЖРазделитель.Ширина = 2;
	
	ЖИндикатор = УБ_ДинамическоеФормированиеИнтерфейса.СздДекорацияНадпись(Форма,"ЖИндикатор", "ГруппаПограничноеОтклонение", "━",Ложь);
	ЗаполнитьЗначенияСвойств(ЖИндикатор,СтруктураИндикаторов);
	ЖИндикатор.ЦветТекста = Новый Цвет(255, 204, 0);
	
	//ABS Поля
	СтруктураПолейВводаАбс = Новый Структура();
	СтруктураПолейВводаАбс.Вставить("ПоложениеЗаголовка", ПоложениеЗаголовкаЭлементаФормы.Нет);
	СтруктураПолейВводаАбс.Вставить("ГоризонтальноеПоложение", ГоризонтальноеПоложениеЭлемента.Центр);
	НегативноеОтклонениеНормыДоАбс = УБ_ДинамическоеФормированиеИнтерфейса.СздПоле(Форма,"НегативноеОтклонениеНормыДоАбс","АбсолютныеЗначения"," ",1,,СтруктураПолейВводаАбс);
	ПозитивноеОтклонениеНормыОтАбс = УБ_ДинамическоеФормированиеИнтерфейса.СздПоле(Форма,"ПозитивноеОтклонениеНормыОтАбс","АбсолютныеЗначения"," ",1,,СтруктураПолейВводаАбс);
	ПограничноеОтклонениеДиапазон = УБ_ДинамическоеФормированиеИнтерфейса.СздПоле(Форма,"ПограничноеОтклонениеДиапазон","АбсолютныеЗначения"," ",1,,СтруктураПолейВводаАбс,,ПозитивноеОтклонениеНормыОтАбс);
	ПограничноеОтклонениеДиапазон.ТолькоПросмотр = Истина;		
	
	//ПрописатьПути
	ОпределитьПутьКДаннымГраницЭффективности(Форма.Элементы, Префикс, Абс);
КонецПроцедуры

Процедура ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	Если РольДоступна("УБ_БазовыеПрава") Тогда
		Если УБ_ОбщегоНазначенияКлиентСерверПовтИсп.ФормаВходитСписокФормКадровыхДокументов(Форма.ИмяФормы) Тогда
			УБ_ДинамическоеФормированиеИнтерфейса.СоздатьРеквизит(Форма, "РольДоступнаПодразделениеРасш", Новый ОписаниеТипов("Булево"));
			Форма.РольДоступнаПодразделениеРасш = РольДоступна("УБ_ИспользованиеПодразделенияВКадровыхДокументахРасш")
													или РольДоступна("ПолныеПрава");
		КонецЕсли;
		
		// обязательно на форме должна быть группа "ГраницыНормыЭффективностиПоказателей", в которую будут размещены элементы
		Если  УБ_ОбщегоНазначения.ФормаВходитСписокФормСГраницамиЭффективности(Форма.ИмяФормы) Тогда
			Если Форма.Элементы.Найти("ГраницыНормыЭффективностиПоказателей") = Неопределено Тогда
				Возврат;
			КонецЕсли;				
			
			СоздатьГраницыНормЭффективности(Форма);
			
		КонецЕсли;	
		
		Если Форма.ИмяФормы = "Документ.ПриемНаРаботу.Форма.ФормаДокумента"
			Или Форма.ИмяФормы = "Документ.КадровыйПеревод.Форма.ФормаДокумента" Тогда
			
			КадровыеДокументыПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка);
			
		ИначеЕсли Форма.ИмяФормы = "Документ.ПриемНаРаботуСписком.Форма.ФормаДокумента"
			Или Форма.ИмяФормы = "Документ.КадровыйПереводСписком.Форма.ФормаДокумента" Тогда
			
			КадровыеДокументыСпискомПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка);
			
		ИначеЕсли Форма.ИмяФормы = "Документ.ДанныеДляРасчетаЗарплаты.Форма.ФормаДокумента" Тогда
			
			ДанныеДляРасчетаЗарплатыПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка); 
			
		ИначеЕсли Форма.ИмяФормы = "Справочник.ШтатноеРасписание.Форма.ФормаЭлемента" Тогда
			
			ДанныеШтатногоРасписанияПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка);
			
		КонецЕсли;    

		
		СтруктураСобытий = Новый Структура;
		СтруктураСвойств = Новый Структура;
		// установка стандартных отборов
		Если Не Форма.Элементы.Найти("Список") = Неопределено 
			  и Не Форма.Элементы.Найти("ГруппаБыстрыеОтборы") = Неопределено Тогда
			СтруктураСобытий.Вставить("ПриИзменении", "Подключаемый_ПриИзмененииЭлемента");
			СтруктураСвойств.Вставить("ПоложениеЗаголовка", ПоложениеЗаголовкаЭлементаФормы.Верх);
			СтруктураСвойств.Вставить("КнопкаВыпадающегоСписка", Истина);
			СтруктураСвойств.Вставить("КнопкаОчистки", Истина);
			СтруктураСвойств.Вставить("КнопкаОткрытия", Ложь);
			СтруктураСвойств.Вставить("ПодсказкаВвода", "Все");
			
			УБ_ДинамическоеФормированиеИнтерфейса.СоздатьРеквизит(Форма, "Организация", Новый ОписаниеТипов("СправочникСсылка.Организации"));
			ЭлементОрганизацияОтбор = УБ_ДинамическоеФормированиеИнтерфейса.СздПоле(Форма, 
																					"Организация", 
																					Форма.Элементы.ГруппаБыстрыеОтборы, 
																					"Организация", 
																					1, 
																					"Организация", 
																					СтруктураСвойств, 
																					СтруктураСобытий );
			УБ_ДинамическоеФормированиеИнтерфейса.СоздатьРеквизит(Форма, "Подразделение", Метаданные.ОпределяемыеТипы.УБ_Подразделения.Тип);
			ЭлементПодразделениеОтбор = УБ_ДинамическоеФормированиеИнтерфейса.СздПоле(Форма, 
																					"Подразделение", 
																					Форма.Элементы.ГруппаБыстрыеОтборы, 
																					"Подразделение", 
																					1, 
																					"Подразделение", 
																					СтруктураСвойств, 
																					СтруктураСобытий );
			НоваяСвязь = Новый СвязьПараметраВыбора("Отбор.Владелец", "Организация");
			НовыйМассив = Новый Массив();
			НовыйМассив.Добавить(НоваяСвязь);
			НовыеСвязи = Новый ФиксированныйМассив(НовыйМассив);
			ЭлементПодразделениеОтбор.СвязиПараметровВыбора = НовыеСвязи;
			Форма.Подразделение = УБ_ОбщегоНазначения.ЗначениеРеквизитаПоУмолчанию("Подразделение");
			
		КонецЕсли;
		
		Если Форма.ИмяФормы = "Документ.УБ_НазначениеРуководителя.Форма.ФормаСписка" Тогда
				УБ_ДинамическоеФормированиеИнтерфейса.СоздатьРеквизит(Форма, "Руководитель", Новый ОписаниеТипов(Метаданные.ОпределяемыеТипы.УБ_Сотрудники.Тип));
				ЭлементРуководительОтбор = УБ_ДинамическоеФормированиеИнтерфейса.СздПоле(Форма, 
																					"Руководитель", 
																					Форма.Элементы.ГруппаБыстрыеОтборы, 
																					"Руководитель", 
																					1, 
																					"Руководитель", 
																					СтруктураСвойств, 
																					СтруктураСобытий );      
				Форма.Руководитель = УБ_ОбщегоНазначения.ЗначениеРеквизитаПоУмолчанию("Сотрудник");
		
		КонецЕсли;
	КонецЕсли;		
	
КонецПроцедуры

Процедура ПриЧтенииНаСервере(Форма, ТекущийОбъект) Экспорт
	
	Если РольДоступна("УБ_БазовыеПрава") Тогда
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписьюНаСервере(Форма, Отказ, ТекущийОбъект, ПараметрыЗаписи) Экспорт
	
	Если РольДоступна("УБ_БазовыеПрава") Тогда
		Если Форма.ИмяФормы = "Документ.ПриемНаРаботу.Форма.ФормаДокумента"
			Или Форма.ИмяФормы = "Документ.КадровыйПеревод.Форма.ФормаДокумента" Тогда
			
			КадровыеДокументыПередЗаписьюНаСервере(Форма, Отказ, ТекущийОбъект, ПараметрыЗаписи);
			
		ИначеЕсли Форма.ИмяФормы = "Документ.ПриемНаРаботуСписком.Форма.ФормаДокумента"
			Или Форма.ИмяФормы = "Документ.КадровыйПереводСписком.Форма.ФормаДокумента" Тогда
			
			КадровыеДокументыСпискомПередЗаписьюНаСервере(Форма, Отказ, ТекущийОбъект, ПараметрыЗаписи);
			
		КонецЕсли;       
		
		Если УБ_ОбщегоНазначенияКлиентСерверПовтИсп.ФормаВходитСписокФормКадровыхДокументов(Форма.ИмяФормы)  Тогда
			//проверить соответствие подразделениия и организации (только шапку)
			Если ПараметрыЗаписи.РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
				Если  Не ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ТекущийОбъект.Подразделение, "Владелец") = ТекущийОбъект.Организация Тогда
					ОбщегоНазначения.СообщитьПользователю(НСтр("Выбранное подразделение не принадлежит организации."), , "Подразделение",, Отказ);	
				КонецЕсли
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;	
	
КонецПроцедуры

Процедура ПослеЗаписиНаСервере(Форма, ТекущийОбъект, ПараметрыЗаписи) Экспорт
	
	Если РольДоступна("УБ_БазовыеПрава") Тогда
		Если Форма.ИмяФормы = "Документ.ПриемНаРаботу.Форма.ФормаДокумента"
			Или Форма.ИмяФормы = "Документ.КадровыйПеревод.Форма.ФормаДокумента" Тогда
			
			КадровыеДокументыПослеЗаписиНаСервере(Форма, ТекущийОбъект, ПараметрыЗаписи);
			
		ИначеЕсли Форма.ИмяФормы = "Документ.ПриемНаРаботуСписком.Форма.ФормаДокумента"
			Или Форма.ИмяФормы = "Документ.КадровыйПереводСписком.Форма.ФормаДокумента" Тогда
			
			КадровыеДокументыСпискомПослеЗаписиНаСервере(Форма, ТекущийОбъект, ПараметрыЗаписи);
			
		КонецЕсли;
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ШтатноеРасписание

Процедура ДанныеШтатногоРасписанияПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка)
	
	Объект = Форма.Объект;
	Элементы = Форма.Элементы;
	
	МодельПланированияЭффективности = Новый РеквизитФормы("УБ_МодельПланированияЭффективности",
		Новый ОписаниеТипов("СправочникСсылка.УБ_МоделиПланированияЭффективности"),,, Истина);
	ДобавляемыеРеквизиты = Новый Массив;
	ДобавляемыеРеквизиты.Добавить(МодельПланированияЭффективности);	

	Форма.ИзменитьРеквизиты(ДобавляемыеРеквизиты);
	
	//ЭлементМодельПланирования = Элементы.Добавить("МодельПланированияЭффективности", Тип("ПолеФормы"), Форма);
	//ЭлементМодельПланирования.ПутьКДанным = "УБ_МодельПланированияЭффективности";
	//ЭлементМодельПланирования.Вид = ВидПоляФормы.ПолеНадписи;
	//ЭлементМодельПланирования.Заголовок = НСтр("ru = 'Модель планирования эффективности'"); 
	//ЭлементМодельПланирования.Гиперссылка = Истина;
	
	Команды = Форма.Команды;
	
	КомандаЗаполнитьПоказатели = Команды.Добавить("УБ_СоздатьНовуюМодельПланирования");
	КомандаЗаполнитьПоказатели.Действие = "УБ_Подключаемый_ВыполнитьПереопределяемуюКоманду";
	КомандаЗаполнитьПоказатели.Заголовок = НСтр("ru = 'Создать новую модель планирования'");
	КомандаЗаполнитьПоказатели.ИзменяетСохраняемыеДанные = Истина;
	
	ЭлементЗаполнитьПоказатели = Элементы.Добавить("УБ_СоздатьНовуюМодельПланирования",Тип("КнопкаФормы"),Элементы.ГруппаГрейд);
	ЭлементЗаполнитьПоказатели.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
	ЭлементЗаполнитьПоказатели.ИмяКоманды = "УБ_СоздатьНовуюМодельПланирования";
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	               |	УБ_МоделиПланированияЭффективности.Ссылка КАК Модель
	               |ИЗ
	               |	Справочник.УБ_МоделиПланированияЭффективности КАК УБ_МоделиПланированияЭффективности
	               |ГДЕ
	               |	УБ_МоделиПланированияЭффективности.ШтатноеРасписание = &ШтатноеРасписание";
	Запрос.УстановитьПараметр("ШтатноеРасписание", Объект.Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Форма["УБ_МодельПланированияЭффективности"] = Выборка.Модель;
		//Элементы["МодельПланированияЭффективности"].Видимость = Истина;
		Элементы["УБ_СоздатьНовуюМодельПланирования"].Видимость = Ложь;
	КонецЕсли;
	
	
	
	Состояние = Форма.Элементы.Добавить("МодельПланированияЭффективности", Тип("ДекорацияФормы"), Элементы.ГруппаГрейд);
	Состояние.Вид = ВидДекорацииФормы.Надпись;
	Состояние.УстановитьДействие("Нажатие", "Подключаемый_ПриНажатииНаСсылкуМодельПланированияЭффективности");
	Если ЗначениеЗаполнено(Форма["УБ_МодельПланированияЭффективности"]) Тогда
		Гиперссылка = Истина;
		Состояние.Заголовок = Строка(Форма["УБ_МодельПланированияЭффективности"]);
		Состояние.Гиперссылка = Гиперссылка;
	Иначе
		Состояние.Заголовок = "";
	КонецЕсли;
	
	//ЭлементМодельПланирования.УстановитьДействие("ПриИзменении", "Подключаемый_ПриИзмененииЭлемента");
	
КонецПроцедуры	

#КонецОбласти

#Область КадровыеДокументы

Процедура КадровыеДокументыПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка)
	
	Объект = Форма.Объект;
	Элементы = Форма.Элементы;
	
	МодельПланированияЭффективности = Новый РеквизитФормы("УБ_МодельПланированияЭффективности",
		Новый ОписаниеТипов("СправочникСсылка.УБ_МоделиПланированияЭффективности"),,, Истина);
	Грейд = Новый РеквизитФормы("УБ_Грейд", Новый ОписаниеТипов("СправочникСсылка.УБ_Грейды"),,, Истина);
	
	ДобавляемыеРеквизиты = Новый Массив;
	ДобавляемыеРеквизиты.Добавить(МодельПланированияЭффективности);
	ДобавляемыеРеквизиты.Добавить(Грейд);
	
	Форма.ИзменитьРеквизиты(ДобавляемыеРеквизиты);
	
	Если Форма.ИмяФормы = "Документ.ПриемНаРаботу.Форма.ФормаДокумента" Тогда
		ЭлементРодитель = Элементы.Найти("ГлавноеСтраницаГруппаЛевая");
	ИначеЕсли Форма.ИмяФормы = "Документ.КадровыйПеревод.Форма.ФормаДокумента" Тогда
		ЭлементРодитель = Элементы.Найти("ДолжностьГруппа");
	Иначе
		ЭлементРодитель = Неопределено;
	КонецЕсли;
	
	НоваяСвязь = Новый СвязьПараметраВыбора("Отбор.ШтатноеРасписание", "Объект.ДолжностьПоШтатномуРасписанию",
		РежимИзмененияСвязанногоЗначения.Очищать);
	
	НовыйМассив = Новый Массив;
	НовыйМассив.Добавить(НоваяСвязь);
	
	СвязиПараметровВыбора = Новый ФиксированныйМассив(НовыйМассив);;
	
	ЭлементМодельПланирования = Элементы.Добавить("УБ_МодельПланированияЭффективности", Тип("ПолеФормы"), ЭлементРодитель);
	ЭлементМодельПланирования.ПутьКДанным = "УБ_МодельПланированияЭффективности";
	ЭлементМодельПланирования.Вид = ВидПоляФормы.ПолеВвода;
	ЭлементМодельПланирования.Заголовок = НСтр("ru = 'Модель планирования эффективности'");
	ЭлементМодельПланирования.СвязиПараметровВыбора = СвязиПараметровВыбора;
	
	НоваяСвязь = Новый СвязьПараметраВыбора("Отбор.Владелец", "УБ_МодельПланированияЭффективности",
		РежимИзмененияСвязанногоЗначения.Очищать);
	
	НовыйМассив = Новый Массив;
	НовыйМассив.Добавить(НоваяСвязь);
	
	СвязиПараметровВыбора = Новый ФиксированныйМассив(НовыйМассив);
	
	ЭлементГрейд = Элементы.Добавить("УБ_Грейд", Тип("ПолеФормы"), ЭлементРодитель);
	ЭлементГрейд.ПутьКДанным = "УБ_Грейд";
	ЭлементГрейд.Вид = ВидПоляФормы.ПолеВвода;
	ЭлементГрейд.Заголовок = НСтр("ru = 'Грейд'");
	ЭлементГрейд.СвязиПараметровВыбора = СвязиПараметровВыбора;
	
	Если Не Объект.Ссылка.Пустая() Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	УБ_МоделиПланированияСотрудниковСрезПоследних.МодельПланированияЭффективности КАК МодельПланированияЭффективности,
		|	УБ_МоделиПланированияСотрудниковСрезПоследних.Грейд КАК Грейд
		|ИЗ
		|	РегистрСведений.УБ_МоделиПланированияСотрудников.СрезПоследних(
		|			,
		|			Сотрудник = &Сотрудник
		|				И КадровыйДокумент = &КадровыйДокумент) КАК УБ_МоделиПланированияСотрудниковСрезПоследних";
		
		Запрос.УстановитьПараметр("Период", Объект.Дата);
		Запрос.УстановитьПараметр("Сотрудник", Объект.Сотрудник);
		Запрос.УстановитьПараметр("КадровыйДокумент", Объект.Ссылка);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		Если Не РезультатЗапроса.Пустой() Тогда
			Выборка = РезультатЗапроса.Выбрать();
			Выборка.Следующий();
			
			Форма["УБ_МодельПланированияЭФфективности"] = Выборка.МодельПланированияЭффективности;
			Форма["УБ_Грейд"] = Выборка.Грейд;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура КадровыеДокументыПередЗаписьюНаСервере(Форма, Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	МоделиПланированияСотрудников = РегистрыСведений.УБ_МоделиПланированияСотрудников.ТаблицаМоделиПланированияСотрудников();
	
	Если ТипЗнч(Форма.Объект.Ссылка) = Тип("ДокументСсылка.КадровыйПеревод")
		Или ТипЗнч(Форма.Объект.Ссылка) = Тип("ДокументСсылка.КадровыйПереводСписком") Тогда
		Период = Форма.Объект.ДатаНачала;
	ИначеЕсли ТипЗнч(Форма.Объект.Ссылка) = Тип("ДокументСсылка.ПриемНаРаботу")
		Или ТипЗнч(Форма.Объект.Ссылка) = Тип("ДокументСсылка.ПриемНаРаботуСписком") Тогда
		Период = Форма.Объект.ДатаПриема;
	Иначе
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Форма["УБ_МодельПланированияЭффективности"])
		И ЗначениеЗаполнено(Форма["УБ_Грейд"]) Тогда
		НоваяСтрока = МоделиПланированияСотрудников.Добавить();
		НоваяСтрока.Период = Период;
		НоваяСтрока.Сотрудник = Форма.Объект.Сотрудник;
		НоваяСтрока.КадровыйДокумент = Форма.Объект.Ссылка;
		НоваяСтрока.Подразделение = Форма.Объект.Подразделение;
		НоваяСтрока.МодельПланированияЭффективности = Форма["УБ_МодельПланированияЭффективности"];
		НоваяСтрока.Грейд = Форма["УБ_Грейд"];
		
		ТекущийОбъект.ДополнительныеСвойства.Вставить("УБ_МоделиПланированияСотрудника", МоделиПланированияСотрудников);
	КонецЕсли;
	
КонецПроцедуры

Процедура КадровыеДокументыПослеЗаписиНаСервере(Форма, ТекущийОбъект, ПараметрыЗаписи)
	
КонецПроцедуры

Процедура ДобавитьГоловноеПодразделениеВОтбор(Параметры, ПараметрыПолученияДанных) Экспорт

	Если Параметры.Свойство("ИмяФормы") и УБ_ОбщегоНазначенияКлиентСерверПовтИсп.ФормаВходитСписокФормКадровыхДокументов(Параметры.ИмяФормы)  
		 и Не Параметры.РольДоступнаПодразделениеРасш Тогда
		//Дата = ?(РеквизитыОбъекта.Свойство("ДатаНачала"), РеквизитыОбъекта.ДатаНачала, Дата(1,1,1));
		//Дата = ?(РеквизитыОбъекта.Свойство("Дата"), РеквизитыОбъекта.Дата, Дата(1,1,1));
		ПараметрыПолученияДанных.Отбор.Вставить("ГоловноеПодразделение", УБ_КадровыйУчет.ПользовательРуководитПодразделениями(,,ПараметрыПолученияДанных));	
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область КадровыеДокументыСписком

Процедура КадровыеДокументыСпискомПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка)
	
	Объект = Форма.Объект;
	Элементы = Форма.Элементы;
	
	МодельПланированияЭффективности = Новый РеквизитФормы("УБ_МодельПланированияЭффективности",
		Новый ОписаниеТипов("СправочникСсылка.УБ_МоделиПланированияЭффективности"), "Объект.Сотрудники",, Истина);
	Грейд = Новый РеквизитФормы("УБ_Грейд", Новый ОписаниеТипов("СправочникСсылка.УБ_Грейды"), "Объект.Сотрудники",, Истина);
	
	ДобавляемыеРеквизиты = Новый Массив;
	ДобавляемыеРеквизиты.Добавить(МодельПланированияЭффективности);
	ДобавляемыеРеквизиты.Добавить(Грейд);
	
	Форма.ИзменитьРеквизиты(ДобавляемыеРеквизиты);
	
	ЭлементРодитель = Элементы.Найти("СотрудникиРеквизитыСтрокиГруппа");
	
	НоваяСвязь = Новый СвязьПараметраВыбора("Отбор.ШтатноеРасписание", "Элементы.Сотрудники.ТекущиеДанные.ДолжностьПоШтатномуРасписанию",
		РежимИзмененияСвязанногоЗначения.Очищать);
	
	НовыйМассив = Новый Массив;
	НовыйМассив.Добавить(НоваяСвязь);
	
	СвязиПараметровВыбора = Новый ФиксированныйМассив(НовыйМассив);
	
	ЭлементМодельПланирования = Элементы.Добавить("УБ_СотрудникиМодельПланированияЭффективности", Тип("ПолеФормы"), ЭлементРодитель);
	ЭлементМодельПланирования.ПутьКДанным = "Объект.Сотрудники.УБ_МодельПланированияЭффективности";
	ЭлементМодельПланирования.Вид = ВидПоляФормы.ПолеВвода;
	ЭлементМодельПланирования.Заголовок = НСтр("ru = 'Модель планирования эффективности'");
	ЭлементМодельПланирования.СвязиПараметровВыбора = СвязиПараметровВыбора;
	
	НоваяСвязь = Новый СвязьПараметраВыбора("Отбор.Владелец", "Элементы.Сотрудники.ТекущиеДанные..УБ_МодельПланированияЭффективности",
		РежимИзмененияСвязанногоЗначения.Очищать);
	
	НовыйМассив = Новый Массив;
	НовыйМассив.Добавить(НоваяСвязь);
	
	СвязиПараметровВыбора = Новый ФиксированныйМассив(НовыйМассив);
	
	ЭлементГрейд = Элементы.Добавить("УБ_СотрудникиГрейд", Тип("ПолеФормы"), ЭлементРодитель);
	ЭлементГрейд.ПутьКДанным = "Объект.Сотрудники.УБ_Грейд";
	ЭлементГрейд.Вид = ВидПоляФормы.ПолеВвода;
	ЭлементГрейд.Заголовок = НСтр("ru = 'Грейд'");
	ЭлементГрейд.СвязиПараметровВыбора = СвязиПараметровВыбора;
	
	Если Не Объект.Ссылка.Пустая() Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	УБ_МоделиПланированияСотрудниковСрезПоследних.Сотрудник КАК Сотрудник,
		|	УБ_МоделиПланированияСотрудниковСрезПоследних.МодельПланированияЭффективности КАК МодельПланированияЭффективности,
		|	УБ_МоделиПланированияСотрудниковСрезПоследних.Грейд КАК Грейд
		|ИЗ
		|	РегистрСведений.УБ_МоделиПланированияСотрудников.СрезПоследних(, КадровыйДокумент = &КадровыйДокумент) КАК УБ_МоделиПланированияСотрудниковСрезПоследних";	
		
		Запрос.УстановитьПараметр("Период", Объект.Дата);
		Запрос.УстановитьПараметр("КадровыйДокумент", Объект.Ссылка);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		Выборка = РезультатЗапроса.Выбрать();
		Пока Выборка.Следующий() Цикл
			
			ПараметрыОтбора = Новый Структура("Сотрудник", Выборка.Сотрудник);
			НайденныеСтроки = Форма.Объект.Сотрудники.НайтиСтроки(ПараметрыОтбора);
			Для Каждого НайденнаяСтрока Из НайденныеСтроки Цикл
				НайденнаяСтрока["УБ_МодельПланированияЭффективности"] = Выборка.МодельПланированияЭффективности;
				НайденнаяСтрока["УБ_Грейд"] = Выборка.Грейд;
			КонецЦикла;
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура КадровыеДокументыСпискомПередЗаписьюНаСервере(Форма, Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	МоделиПланированияСотрудников = РегистрыСведений.УБ_МоделиПланированияСотрудников.ТаблицаМоделиПланированияСотрудников();
	
	Если ТипЗнч(Форма.Объект.Ссылка) = Тип("ДокументСсылка.КадровыйПеревод")
		Или ТипЗнч(Форма.Объект.Ссылка) = Тип("ДокументСсылка.КадровыйПереводСписком") Тогда
		ИмяРеквизитаПериода = "ДатаНачала";
	ИначеЕсли ТипЗнч(Форма.Объект.Ссылка) = Тип("ДокументСсылка.ПриемНаРаботу")
		Или ТипЗнч(Форма.Объект.Ссылка) = Тип("ДокументСсылка.ПриемНаРаботуСписком") Тогда
		ИмяРеквизитаПериода = "ДатаПриема";
	Иначе
		Возврат;
	КонецЕсли;
	
	Для Каждого СтрокаСотрудника Из Форма.Объект.Сотрудники Цикл
		
		Если Не ЗначениеЗаполнено(СтрокаСотрудника["УБ_МодельПланированияЭффективности"])
			Или Не ЗначениеЗаполнено(СтрокаСотрудника["УБ_Грейд"]) Тогда
			Продолжить;
		КонецЕсли;
		
		НоваяСтрока = МоделиПланированияСотрудников.Добавить();
		НоваяСтрока.Период = СтрокаСотрудника[ИмяРеквизитаПериода];
		НоваяСтрока.Сотрудник = СтрокаСотрудника.Сотрудник;
		НоваяСтрока.КадровыйДокумент = Форма.Объект.Ссылка;
		НоваяСтрока.Подразделение = СтрокаСотрудника.Подразделение;
		НоваяСтрока.МодельПланированияЭффективности = СтрокаСотрудника["УБ_МодельПланированияЭффективности"];
		НоваяСтрока.Грейд = СтрокаСотрудника["УБ_Грейд"];
		
	КонецЦикла;
	
	Если МоделиПланированияСотрудников.Количество() Тогда
		ТекущийОбъект.ДополнительныеСвойства.Вставить("УБ_МоделиПланированияСотрудника", МоделиПланированияСотрудников);
	КонецЕсли;
	
КонецПроцедуры

Процедура КадровыеДокументыСпискомПослеЗаписиНаСервере(Форма, ТекущийОбъект, ПараметрыЗаписи)
КонецПроцедуры

#КонецОбласти

#Область ДанныеДляРасчетЗарплаты

Процедура ДанныеДляРасчетаЗарплатыПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка)
	
	Объект = Форма.Объект;
	Элементы = Форма.Элементы;
	Команды = Форма.Команды;
	
	ЭлементРодитель = Элементы.Найти("ДанныеСводно");
	
	КомандаЗаполнитьПоказатели = Команды.Добавить("УБ_ЗаполнитьПоказателиРасчетаЗарплаты");
	КомандаЗаполнитьПоказатели.Действие = "УБ_Подключаемый_ВыполнитьПереопределяемуюКоманду";
	КомандаЗаполнитьПоказатели.Заголовок = НСтр("ru = 'Заполнить показатели (УБ)'");
	КомандаЗаполнитьПоказатели.ИзменяетСохраняемыеДанные = Истина;
	
	ЭлементЗаполнитьПоказатели = Элементы.Добавить(
		"УБ_ЗаполнитьПоказателиРасчетаЗарплаты",
		Тип("КнопкаФормы"),
		?(ЭлементРодитель = Неопределено, Неопределено, ЭлементРодитель.КоманднаяПанель));
	ЭлементЗаполнитьПоказатели.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
	ЭлементЗаполнитьПоказатели.ИмяКоманды = "УБ_ЗаполнитьПоказателиРасчетаЗарплаты";
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

Процедура ОрганизацияПриИзменении(Форма) Экспорт
	
	МетаданныеОбъекта = Форма.Объект.Ссылка.Метаданные();
	Объект = Форма.Объект;
	
	Если ОбщегоНазначения.ЕстьРеквизитОбъекта("Подразделение", МетаданныеОбъекта) Тогда
		СписокСвязанныхРеквизитов = "Подразделение";
		УБ_ОбщегоНазначения.УстановитьТипЗначенияСвязанныхРеквизитовПоУмолчанию(Объект, СписокСвязанныхРеквизитов);
	КонецЕсли;

	//ТЧ опишем для каждой формы отдельно
	Если Форма.ИмяФормы = "Документ.Делегирование.Форма.ФормаДокумента" Тогда
			СписокСвязанныхРеквизитов = "Сотрудник";
			УБ_ОбщегоНазначения.УстановитьТипЗначенияСвязанныхРеквизитовПоУмолчанию(
				Объект,
				СписокСвязанныхРеквизитов,
				"ДелегируемыеСотрудники");       
	КонецЕсли;
	
КонецПроцедуры


#Область ОбработчикиСобытийЭлементовШапкиФормы

Процедура ПриИзмененииЭлемента(Форма, Элемент) Экспорт
	
	Если Элемент = "Организация" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Форма.Список,
																				"Организация",
																				Форма.Организация,
																				ВидСравненияКомпоновкиДанных.Равно,
																				,
																				ЗначениеЗаполнено(Форма.Организация));    
		
		СписокСвязанныхРеквизитов = "Подразделение";
		УБ_ОбщегоНазначения.УстановитьТипЗначенияСвязанныхРеквизитовПоУмолчанию(Форма, СписокСвязанныхРеквизитов);
	ИначеЕсли Элемент = "Подразделение" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Форма.Список,
																				"Подразделение",
																				Форма.Подразделение,
																				ВидСравненияКомпоновкиДанных.Равно,
																				,
																				ЗначениеЗаполнено(Форма.Подразделение));    
	ИначеЕсли Элемент = "Руководитель" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Форма.Список,
																				"Руководитель",
																				Форма.Руководитель,
																				ВидСравненияКомпоновкиДанных.Равно,
																				,
																				ЗначениеЗаполнено(Форма.Руководитель));    
		
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбщиеПоказателейИЦелей

&НаСервере 
Функция ВернутьЦветПерспективыССПДляЗаполнения(Перспектива) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	УБ_ПерспективыССП.ЦветИндекс КАК ЦветИндекс
		|ИЗ
		|	Справочник.УБ_ПерспективыССП КАК УБ_ПерспективыССП
		|ГДЕ
		|	УБ_ПерспективыССП.Ссылка = &Перспектива";
	
	Запрос.УстановитьПараметр("Перспектива", Перспектива);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Выборка.Следующий();
	ЦветКартинки = Выборка.ЦветИндекс;

	Возврат ЦветКартинки;
	
КонецФункции
#КонецОбласти