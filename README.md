# Helper recipes to build CAD tools

## Modules

Currently supported CAD modules are:

| Module	| Description	|
| ------------- | ------------- |
| ecpdap	| CMSIS-DAP utility for ECP5 FPGAs |
| nextpnr¹	| A portable FPGA place and route tool |
| prjtrellis	| A fully open-source flow tools and databases for ECP5 FPGAs |
| yosys		| Yosys Open SYnthesis Suite |

Notes:

1. To build nextpnr-ecp5, you need first install the ECP5 databases from
   prjtrellis.

## Examples

To build and install ecpdap utility, run the following commands:
```sh
$ make -f ecpdap.mk
$ tar xzf ecpdap-pack.tgz /
```

Note that by default modules are built with the PREFIX = $HOME/cad. You
can specify an alternative prefix by specifying it as a make command
argument.
