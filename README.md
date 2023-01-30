# 🚀 Практика по модулю С4

---

### 🖊️ Задание С 4.6.1  

Задание выполенено на основе практики С4.3 данного модуля. Шиппер - filebeat, фильтрация логов - Logstash  

Конфиг fluent доступен по [ссылке](https://github.com/SergeyErshov/c4-practice/blob/main/ansible/config/td-agent.conf)
Конфиг logstash - [здесь](https://github.com/SergeyErshov/c4-practice/blob/main/ansible/config/test1.conf)
Используемый ansible-playbook - [этот](https://github.com/SergeyErshov/c4-practice/blob/main/ansible/elk.yml)

Скрин из kibana: ![Filebeat-logstash-elasticsearch-kibana](https://drive.google.com/file/d/1MH92pPSCWUeV82AOB2QUtoSQedOegnq3/view?usp=sharing "Скриншот из kibana - filebeat")

### 🖊️ Задание С 4.6.2  

#### варинат 1 - тупиковый (то, что обсуждали в Slack)   

Шиппер - rsyslog, актуальная версия 8.22 на текущий момент. Продукты стека ELK версии 8.6.1 - актуальная версия на текущий момент  

Конфиг rsyslog доступен по [ссылке](https://github.com/SergeyErshov/c4-practice/blob/main/ansible/config/nginx_rsyslog.conf)  

Связка оказалась не рабочей на текущий момент, при попытке пуша логов в elasticsearch возникает ошибка rsyslog:  

```
Jan 29 13:04:38 fhmsd1dfm1cv7vqfj545 rsyslogd: omelasticsearch: error in elasticsearch reply: bulkmode insert does not return array, reply is: {"error":{"root_cause":[{"type":"illegal_argument_exception","reason":"Action/metadata line [1] contains an unknown parameter [_type]"}],"type":"illegal_argument_exception","reason":"Action/metadata line [1] contains an unknown parameter [_type]"},"status":400} [v8.2212.0 try https://www.rsyslog.com/e/2218 ]
Jan 29 13:11:33 fhmsd1dfm1cv7vqfj545 rsyslogd:  message repeated 91 times: [omelasticsearch: error in elasticsearch reply: bulkmode insert does not return array, reply is: {"error":{"root_cause":[{"type":"illegal_argument_exception","reason":"Action/metadata line [1] contains an unknown parameter [_type]"}],"type":"illegal_argument_exception","reason":"Action/metadata line [1] contains an unknown parameter [_type]"},"status":400} [v8.2212.0 try https://www.rsyslog.com/e/2218 ]]
```  

Подобная проблема была описана в [gitgub](https://github.com/rsyslog/rsyslog/issues/4884) и закрыта, так как, по утверждениям вендора, была исправлена [здесь](https://github.com/rsyslog/rsyslog/pull/4808)  

Вероятно либо проблему не исправили до конца, либо я что-то делаю не так. Все осложняется тем, что я не встречал в Интернете подобной связки, которую бы реализовали на стеке ELK версии выше 7.X  

При выполнении задания использовались следующие материалы:

| ресурс | ссылка |
| ------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| Официальная документация по модулю omelasticsearch | [ссылка](https://www.rsyslog.com/doc/v8-stable/configuration/modules/omelasticsearch.html) |
| один из блогов | [ссылка](https://luvpreetsingh.github.io/nginx-to-rsyslog/) |
| случай из реальной практики | [ссылка](https://www.casp.ru/%D0%9D%D0%B0%D1%81%D1%82%D1%80%D0%BE%D0%B9%D0%BA%D0%B0-rsyslog-storage/) |  

#### варинат 2 - успешный

Шиппер - td-agent с модулем fluent-plugin-elasticsearch

Конфиг [nginx](https://github.com/SergeyErshov/c4-practice/blob/main/ansible/config/for_ngx/nginx.conf), конфиг [td-agent](https://github.com/SergeyErshov/c4-practice/blob/main/ansible/config/for_ngx/td-agent.conf)  

для выполнения задачи использвался [playbook](https://github.com/SergeyErshov/c4-practice/blob/main/ansible/fluent-ngx.yml)  

Скрин из kibana: ![nginx-fluent-elasticsearch-kibana](https://drive.google.com/file/d/1H-RcstI-XYrpJgF7WQW5pXE2EOt7cuz1/view?usp=sharing "Скриншот из kibana - nginx_access")

---




