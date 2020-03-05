# shtrih-fr-driver
Реализация драйвера Штрих-м для ФР на python.
# Использование
Пример:
```python
from commands import Commands

device.connect()
device.first_require()
device.open_session()
device.operation_v2(3, 66, 'Выхухоль')
device.close_check_v2(1222.33, 'Строка')
device.close_session()
device.disconnect()
```
