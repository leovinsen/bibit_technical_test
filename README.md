# bibit_technical_test

This project is dedicated for solving Flutter Engineer Test Assignment at Stockbit & Bibit.id.

See the following [YouTube playlist](https://www.youtube.com/playlist?list=PLuIivo2SM9QZ-H_6auerE4ObEv6zlHTgj) for quick explanation of the app.

## Directory Structure

```
.
├── alarm
├── analog_clock
├── application
└── notification
```

- `application` contains the application entry point and other presentation layer logic.
- `analog_clock` contains code related to analog clock UI and its logic.
- `alarm` contains domain, data and repository layer code for an `alarm`.
- `notification` contains code related to creating a scheduled notification.

The project is structured in a way to promote separation of concern and reusability of each module.
In addition, by adopting a monorepo approach, later on we could easily set our CI/CD pipeline to run tests only for specific modules.

For more details on each module, see their respective READMEs.

- [application](/application/README.md)
- [alarm](/alarm/README.md)
- [analog_clock](/analog_clock/README.md)
- [notification](/notification/README.md)

## Installation

To install Flutter SDK as defined in `.fvm/fvm_config.json`, run `fvm install --force` in the root directory. Then, run `melos bootstrap` to link and fetch all packages.

```
$ fvm install 
$ melos bootstrap
```

If you do not have FVM or Melos installed on your machine, you can run the following commands:

```
$ dart pub global activate fvm 
$ dart pub global activate melos
```

For more information please refer to [FVM official docs](https://fvm.app/) and [Melos official docs](https://melos.invertase.dev/). 

## Running the app

For VSCode users, you may copy the `launch.json.example` to quickly setup a launch config.

```bash
$ cp .vscode/launch.json.example .vscode/launch.json
```

Otherwise, you could run `flutter run` inside the `application` directory.

```
$ cd application
$ flutter run
```

## Melos scripts

See [melos.yaml](/melos.yaml) for all 4 melos scripts.
