# Gatekeeper

## Co jsme splnili

* Všechny body zadání
* Jde vytvářet projekty a úkoly
* Administrátoři mohou spravovat všechny uživatele, přidávat nové a měnit jim role (vyřešeno pomocí cancancan)
* Každý může upravovat svůj profil a resetovat heslo
* Projekt nelze smazat, pokud obsahuje úkoly
* Úkol má při vytvoření status `created`, podporuje více příloh s popisky (Active Storage, Stimulus) a popisek úlohy má rich text area
* Při vytvoření úkolu přijde e-mail uživateli, kterému je úkol přiřazen
* Při vytvoření projektu přijde notifikace všem přihlášeným uživatelům (Action Cable)
* V menu je pro mobilní zobrazení toggle a pro avatara taky toggle (Stimulus)
* API endpoint pro zobrazení všech úkolů (autentizace pomocí Bearer tokenu)

## Jak projekt rozjet a kde se nachází

Projekt je nasazen pomocí Kamalu a běží na:

```
https://gatekeeper.stormlab.cz
```

### Požadavky a konfigurace

1. Zkopírujte soubor `.env.example` do `.env` a vyplňte potřebné proměnné

### Spuštění projektu

```bash
docker compose build
docker compose up
docker compose exec rails rails db:drop db:create db:migrate db:seed
```

## Jak spustit testy

Pro spuštění testů použijte následující příkaz:

```bash
docker compose exec rails bundle exec rspec
```