# bibit_technical_test

This project is dedicated for solving Flutter Engineer Test Assignment at Stockbit & Bibit.id.

## Directory Structure

```
.
├── application 
└── analog_clock
```

- `application` contains the application entry point and other application logic.
- `analog_clock` contains code for clock hands and rotation logic.

## Installation

To install Flutter SDK as defined in `.fvm/fvm_config.json`, run `fvm install --force` in the root directory. Then, run `melos bootstrap` to link and fetch all packages.

```
$ fvm install 
$ melos bootstrap
```

If you do not have FVM or Melos installed on your machine, please refer to the [FVM official docs](https://fvm.app/) and [Melos official docs](https://melos.invertase.dev/). 

## Running the app

For VSCode users, you may copy the `launch.json.example` to quickly setup a launch config.

```bash
$ cp .vscode/launch.json.example .vscode/launch.json
```

Otherwise, you can do a `flutter run` inside the `application` directory.

```
$ cd application
$ flutter run
```
