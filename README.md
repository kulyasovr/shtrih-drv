# shtrih-drv
Реализация драйвера Штрих-м для ФР на python.
# Использование
Пример:
```python
import shtrih_drv

device = shtrih_drv.Commands()

device.connect_tcp('192.168.137.111', 7778)
device.first_require()

device.open_check()
device.operation_v2(1, 10.16, 'Товар')
device.close_check_v2(100.33, 'Подпись')
```
