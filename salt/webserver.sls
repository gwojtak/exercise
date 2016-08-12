httpd:
  pkg.installed: []
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: httpd

/var/www/html/hadoop-services.html:
  file.managed:
    - source: salt://files/web/hadoop-services.html.jinja
    - template: jinja
    - user: root
    - gorup: root
    - mode: 0644
    - require:
      - pkg: httpd
