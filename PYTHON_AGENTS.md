## Code Style Guidelines

### Whitespace

Use one line of blank whitespace between blocks such as classes or functions.

DO NOT insert blank lines within functions, prefer to have one line with a descriptive comment that separates "sections" of a function's logic.

### Indenting

Use a hanging indent:
```python
def process_videos(videos: List[Path],
                   cache: Optional[Dict[str, Any]] = None) -> Dict[str, List[Path]]:
    function_w_many_arguments(one_arg,
                              two_arg,
                              three_arg,
                              four_arg,
                              five_arg,
                              keyword_arg=foo)
```

Prefer to keep arguments in one line breaking first by keyword.
```python
function_call(one_arg, two_arg, three_arg, four_arg,
              keyword_arg=foo, another_kwarg=bar)
```

If the rules above still result in long line length, then use black-style indentation.
```python
function_w_many_arguments_but_really_long_name_so_hanging_is_bad(
    one_arg, two_arg, three_arg, four_arg, five_arg,
    keyword_arg=foo
)
```

### Import Order
1. Standard/third-party library `import`
2. Standard/third-party library `import X as Y`
3. Standard/third-party library `from X import Y`
4. Local imports (`from localmodule.*`)

```python
import os
import re
import numpy as np
from pathlib import Path
from omegaconf import OmegaConf

from localmodule.submodule import local_func
```

### Type Annotations
- Use Python 3.10+ union syntax: `str | Path` instead of `Union[str, Path]`
- Import specific types from typing module: `List`, `Dict`, `Optional`, `Dict`, `Any`, `Tuple`

```python
from typing import List, Dict, Optional, Any
from pathlib import Path

def process_videos(videos: List[Path],
                   cache: Optional[Dict[str, Any]] = None) -> Dict[str, List[Path]]:
    ...
```

### Naming Conventions
- Functions: `snake_case` (e.g., `download_sessions`, `list_grid_files`)
- Variables: `snake_case` (e.g., `local_root`, `video_files`)
- Constants: `UPPER_SNAKE_CASE` (e.g., `DEFAULT_GRID_MOUNT`, `RSYNC_COMMON_FLAGS`)
- Classes: `PascalCase` (rarely used in this codebase)

### Docstring Format
Use short docstrings (2-3 lines) with Arguments section when needed:
```python
def function_name(param1: str, param2: Optional[int] = None) -> Path:
    """Brief description of what the function does."""
    # Implementation
```

### Formatting
- Use 4-space indentation
- Line length: Aim for ~80-100 characters, flexible for long strings
- No trailing whitespace
- One blank line between functions
- One blank line at end of file
