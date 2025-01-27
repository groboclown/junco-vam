// Licensed under the MIT license. See LICENSE for details.

package schema_test

import (
	"encoding/json"
	"testing"

	"github.com/groboclown/junco-vam/lib/vac/schema"
)

func Test_Vac10SchemaJson(t *testing.T) {
	t.Run("simple", func(t *testing.T) {
		doc := `{
  "$schema": "https://raw.githubusercontent.com/groboclown/junco-vam/refs/heads/main/vac-v1.schema.json",
  "product": {
    "name": "foo"
  },
  "analyses": []
}`
		var parsed schema.Vac10SchemaJson
		if err := json.Unmarshal([]byte(doc), &parsed); err != nil {
			t.Error(err)
		}
		if parsed.Schema != "https://raw.githubusercontent.com/groboclown/junco-vam/refs/heads/main/vac-v1.schema.json" {
			t.Errorf("wrong schema: %s", parsed.Schema)
		}
		if len(parsed.Analyses) != 0 {
			t.Errorf("wrong analysis: %v", parsed.Analyses)
		}
		if parsed.Product.Name != "foo" {
			t.Errorf("wrong product name: %s", parsed.Product.Name)
		}
	})
}
