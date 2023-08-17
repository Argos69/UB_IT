#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Настройки общей формы отчета подсистемы "Варианты отчетов".
//
// Параметры:
//   Форма - УправляемаяФорма, Неопределено - Форма отчета или форма настроек отчета.
//       Неопределено когда вызов без контекста.
//   КлючВарианта - Строка, Неопределено - Имя предопределенного
//       или уникальный идентификатор пользовательского варианта отчета.
//       Неопределено когда вызов без контекста.
//   Настройки - Структура - Настройки общей формы отчета (для изменения).
//       См. возвращаемое значение ОтчетыКлиентСервер.ПолучитьНастройкиОтчетаПоУмолчанию().
//
Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	
	Настройки.События.ПриСозданииНаСервере = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

// Вызывается в обработчике одноименного события формы отчета после выполнения кода формы.
//
// Параметры:
//   Форма - УправляемаяФорма - Форма отчета.
//   Отказ - Булево - Признак отказа от создания формы.
//      См. описание одноименного параметра "УправляемаяФорма.ПриСозданииНаСервере" в синтакс-помощнике.
//   СтандартнаяОбработка - Булево - Признак выполнения стандартной (системной) обработки события.
//      См. описание одноименного параметра "УправляемаяФорма.ПриСозданииНаСервере" в синтакс-помощнике.
//
// См. также:
//   Процедура для вывода добавленных команд в форму: ОтчетыСервер.ВывестиКоманду().
//   Глобальный обработчик этого события: ОтчетыПереопределяемый.ПриСозданииНаСервере().
//
// Пример добавления команды:
//    Команда = Форма.Команды.Добавить("<ИмяКоманды>");
//    Команда.Действие  = "Подключаемый_Команда";
//    Команда.Заголовок = НСтр("ru = '<Представление команды...>'");
//    ОтчетыСервер.ВывестиКоманду(Форма, Команда, "<ВидГруппы>");
// Обработчик команды пишется в процедуре ОтчетыКлиентПереопределяемый.ОбработчикКоманды.
//
Процедура ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	Параметры = Форма.Параметры;
	Если Параметры.Свойство("ПараметрКоманды") Тогда
		СформироватьПараметрыОтчета(Параметры.ПараметрКоманды, Форма.ФормаПараметры, Параметры);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура СформироватьПараметрыОтчета(ПараметрКоманды, ПараметрыФормы, Параметры)
	
	Период = Новый СтандартныйПериод;
	Период.ДатаНачала = НачалоМесяца(ДобавитьМесяц(ПараметрКоманды.НачалоПериода, -2));
	Период.ДатаОкончания = КонецМесяца(ПараметрКоманды.КонецПериода);
	
	ПараметрыФормы.Отбор.Вставить("Сотрудник", ПараметрКоманды.Сотрудник);
	ПараметрыФормы.Отбор.Вставить("Подразделение", ПараметрКоманды.Подразделение);
	ПараметрыФормы.Отбор.Вставить("Период", Период);
	
	ПараметрыФормы.КлючНазначенияИспользования = ПараметрКоманды;
	Параметры.КлючНазначенияИспользования = ПараметрКоманды;
	
КонецПроцедуры

#КонецОбласти

#Область Инициализация

УБ_ОбщегоНазначения.СкорректироватьТекстЗапросаПодТекущуюКонфигурацию(СхемаКомпоновкиДанных.НаборыДанных.НаборДанных1.Запрос);

#КонецОбласти

#КонецЕсли