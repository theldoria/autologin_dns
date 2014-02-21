autologin_dns
=============

Auto login to dns service.

Create config.yml with:

```yaml
---
user: your user name
password: your password
```

To select browser you can add the following to config.yml:

    browser: :internet_explorer

Browser can be `:internet_explorer`, `:firefox` or `:chrome`.


Internet Explorer
-----------------

Don't use it, install firefox instead :wink:.

Alternatively:
- Get IEDriverServer from http://code.google.com/p/selenium/downloads/list and make sure it is found in PATH.
- Add `browser: :internet_explorer` to `config.yml`.
- Make shure all zones are equally righted:
  - Registry key: HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones
    - Under keys 1-4 make each value named 2500 equal (e.g. set to 3; create it if not existing).
