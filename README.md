# Qrop

A crop planning and recordkeeping free software Available on GNU/Linux, Windows
and Mac and Android.

**Warning:** this is alpha software with known bugs. It runs, and work at least
some of the times, but use at your own risk.

![Screenshot of Qrop](qrop.png)

## ✨ Features

### Plan your season

Define your crop plan: plantings, crop, varieties, bed lengths, spacings,
expected yields... Autogenerate sowing and planting tasks and get seed
quantities, flats to start. Visualize each season of your plan. Easily create,
duplicate, delete, batch-edit, sort and filter successions.

### Keep track of your tasks

Get a week-to-week list of your tasks: sowing, planting, weeding, pruning,
irrigating... Quickly filter overdue, due and done tasks. Track your labor cost
by task.

### Manage your field map and crop rotations

Define your crop map: drag n' drop your plantings on your crop map. Get the crop
history of every single bed to ensure good rotations.

### Take notes and photos

Write notes, take photos and link them to your plantings. In a near future, it
will also be possible to take notes for tasks and locations.

### Track your harvests and crop yields

Keep track of each harvest and get real-time crop yields (planned).

### Seeds and transplants list

Qrop autogenerates a list of the seeds and transplants to buy based on your crop
plan.

## Planned features

 - Charts and analytics

## Getting started

### GNU/Linux (AppImage)

We only provide AppImages. Download the latest version at
https://github.com/andreh11/qrop/releases. Then open a console in the right
folder and type:

```shell
chmod u+x Qrop-x86_64.AppImage
./Qrop-x86_64.AppImage
```

to launch the AppImage. It has been tested with Ubuntu 16.04 and Fedora 29, but
may not work on other distributions or versions.

### Windows

Download the right Zip file for you architecture:

 - https://ah.ouvaton.org/qrop/qrop-0.1.2-x86.zip (32 bit)
 - https://ah.ouvaton.org/qrop/qrop-0.1.2-amd64.zip (64 bit)

Unzip it, open the folder and click on "desktop" to launch the application.

There is no installer yet, but this will be provided as soon as possible.

### OS X

Not tested yet, please contact us if you own a Mac and would like to try Qrop!

### Android

Qrop should compile and run on Android, but we haven't tested it yet. The user
interface should be usable on tablets, but do not expect to run it on
smartphone. If you would like to use Qrop on smartphone and you are willing to
help us to design a nice user interface, please contact us!

## Built With

* C++, QML and Javascript
* Qt5
* SQLite

## Contributing

Please read the [contribution guide](CONTRIBUTING.md) for details of our code of
conduct, and the process for submitting bug reports and merge requests to us.

## Authors

See [AUTHORS](AUTHORS).

## License

This project Free Software, licensed under the GNU General Public License v3. See
[LICENSE](LICENSE) for more details.
