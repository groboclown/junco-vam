// Licensed under the MIT license. See LICENSE for details.

package junco

import _ "embed"

//go:embed version.txt
var Version string

//go:embed "vac-1.0-min.schema.json"
var VacSchema []byte
