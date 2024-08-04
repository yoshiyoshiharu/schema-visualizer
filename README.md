# SchemaVisualizer
This is a SPA like Application to display DB schema information for each of your products.

## Screen capture
https://github.com/yoshiyoshiharu/schema-visualizer/assets/54305137/52eb9308-80da-4174-bd12-93cb788aad5f

## Features
- Google login
- Search tables and columns
- Show table's schema information
- Save a memo for each columns
- Insert schema information from the database

## Support database adapter
- PostgreSQL
- MySQL


## Usage
1. Create product records with names and environment prefixes.
2. Add environment variables which key is `{environment prefix}_DATABASE_URL` and value is database connection string.
3. Run `rake tables:sync` to insert schema information from the database.

## For developers

### setup
```
.scripts/setup.sh
```

### start
```
.scripts/start.sh
```

### test
```
.scripts/test.sh
```

### lint
```
./scripts/lint.sh
````

### fix
```
./scripts/fix.sh
```
