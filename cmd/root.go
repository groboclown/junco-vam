// Licensed under the MIT license. See LICENSE for details.
package cmd

import (
	"github.com/groboclown/junco-vam"
	"github.com/spf13/cobra"
)

var (
	cfgFile string

	rootCmd = &cobra.Command{
		Use:     "junco",
		Version: junco.Version,
		Short:   "Junco manages vulnerability analysis descriptions",
		Long:    `Manage your VEX document analysis details in one place`,
		Run: func(cmd *cobra.Command, args []string) {
			// TODO add an implementation
		},
	}
)

// Execute runs the program's main command runner.
func Execute() error {
	return rootCmd.Execute()
}

// WithArgs allows tests or other tooling to set the program's arguments programmatically.
func WithArgs(a []string) {
	rootCmd.SetArgs(a)
}
