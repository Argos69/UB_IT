
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПерезаполнитьРегистр(Команда)
	
	ПерезаполнитьРегистрНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПерезаполнитьРегистрНаСервере()
	
	УБ_ДоступностьРасчетаЭффективностиСотрудниковДляПользователей.ПерезаполнитьДанныеРегистра();
	Элементы.Список.Обновить();
	
КонецПроцедуры

#КонецОбласти
