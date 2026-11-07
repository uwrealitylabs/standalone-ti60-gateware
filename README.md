# Standalone Ti60 Gateware
This repository holds the code written, imported, and integrated by UW Reality Lab's standalone-hardware gateware. This includes all RTL, embedded/firmware, software, and testing infrastructure.

## Directory structure
```
repo_root/
├── docs/                       # crchitecture specs, memory maps, and datasheets
│   ├── datasheets/             # datasheets
│   
├── hw/                         
│   ├── ip/                     # efinix/third-party IPs
│   └── top/                    
│       ├── main/               # primary active project - probably contributes
│       │   ├── rtl/            # top-level wrapper (top.sv), clock/reset gen
│       │   ├── constraints/    # pinout and timing constraints (.xdc, .sdc, .isf)
│       │   ├── tb/             # system-level integration testbenches
│       │   └── syn/            # project generation scripts (Tcl, XML project files)
│       └── example_module/     # set-aside designs & onboarding sandboxes
│           ├── rtl/
│           ├── constraints/
│           ├── tb/
│           └── syn/
├── sw/                         # co-simulation C/C++ firmware, drivers, memory hex generators
├── scripts/                    # global automation, CI runners, linter rules, Python tools
└── build/                      # EDA tool output, logs, bitstreams, sim binaries```

## Coding Style
### Naming conventions
- signals and variables name in `snake_case`
- constants and parameters in `UPPERCASE_SNAKE_CASE`
- module and file names in `snake_case` and must match
- ports name must have directional prefixes (`i_` for inputs, `o_` for outputs, `io_` for inout)
- for active low signals add an `_n` suffix to the end of signal

### Some guidelines
This is not strictly required but recommended for clarity:

- Guideline #1: When modeling sequential logic, use nonblocking assignments.
- Guideline #2: When modeling latches, use nonblocking assignments.
- Guideline #3: When modeling combinational logic with an always block, use blocking assignments.
- Guideline #4: When modeling both sequential and combinational logic within the same always block, use nonblocking assignments.
- Guideline #5: Do not mix blocking and nonblocking assignments in the same always block.
- Guideline #6: Do not make assignments to the same variable from more than one always block.
- Guideline #7: Use proper indentation.
- Guideline #8: Unless it's vendor's ip or examples, do one module per file.

For more information on best practices and guidelines refer to [this](https://wiki.eecs.yorku.ca/course_archive/2013-14/F/3201/_media/verilog_coding_style_guidelines.pdf)

### Contributing
1. Ask to be added as a member/collaborator to UW Reality Labs on GitHub.
2. Create a branch for the task you are working on. Branch naming scheme is `<developer-name>/<feature>`. For example, `danglevm/do-some-task`.
4. Make a PR. It needs approval by at least one other member in the VITracker team.
5. Make requested changes and merge to main branch once PR is approved.
