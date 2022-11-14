## Usage

Make sure to run the database build command during app cold start and `await` the result.  
This ensures that a SQLite database will be created before any DB operation is applied.

```
final database = await $FloorAppDatabase.databaseBuilder('db_name.db').build();
```

See [floor docs](https://pub.dev/packages/floor#6-use-the-generated-code) for more details.

## Why `floor`?

`floor` generates boilerplate code related to interacting with a SQLite database e.g. DB creation, migration, queries and data serialization & deserialization.
