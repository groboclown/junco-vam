// Licensed under the MIT license. See LICENSE for details.
package cmd_test

import (
	"testing"

	"github.com/groboclown/junco-vam/cmd"
)

func Test_rootCmd(t *testing.T) {
	t.Run("no-arg", func(t *testing.T) {
		cmd.Execute()
	})
	t.Run("help", func(t *testing.T) {
		cmd.WithArgs([]string{"-h"})
		cmd.Execute()
	})
}
