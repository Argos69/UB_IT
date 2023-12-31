
#Область ПрограммныйИнтерфейс
// Возвращает список форм, в которых используется ограничение по выбору подразделения
// Возвращаемое значение:
// Массив
Функция ФормаВходитСписокФормКадровыхДокументов(ИмяФормы) Экспорт
	
	МассивФормПроверямыхДокументов = Новый Массив;
	МассивФормПроверямыхДокументов.Добавить("Документ.УБ_Делегирование.Форма.ФормаДокумента");
	МассивФормПроверямыхДокументов.Добавить("Документ.УБ_НазначениеНаДолжность.Форма.ФормаДокумента");
	МассивФормПроверямыхДокументов.Добавить("Документ.УБ_НазначениеРуководителя.Форма.ФормаДокумента");
	МассивФормПроверямыхДокументов.Добавить("Документ.УБ_ПланированиеЦелейИПоказателей.Форма.ФормаДокумента");
	МассивФормПроверямыхДокументов.Добавить("Документ.УБ_ПереводНаДолжность.Форма.ФормаДокумента");
	
	Возврат Не МассивФормПроверямыхДокументов.Найти(ИмяФормы) = Неопределено;
			
КонецФункции


#КонецОбласти
