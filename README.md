# junco-vam

A Vulnerability Analysis Management Tool


## Purpose

This tool aids in managing developers and security experts in analyzing the effects of Common Vulnerabilities and Exposures (CVE) on a given software product.

When it comes to constructing Vulnerability Exploitability eXchange (VEX) documents, the limiting factor comes from *time spent analyzing the impact*.  Generating the files to report these uses much cheaper computer time.  As such, this tool attempts to make the analysis collection the primary artifact.

For one-off events, generating the VEX with the CVE analysis takes the same amount of time.  However, the issue becomes complicated when the team releases new versions, and the same issues reoccur.  At this point, the association of the VEX analysis may no longer apply, or worse, if it does, it may mean having an analyst take up more time to ensure it still doesn't affect the product.  When the team releases the product, at that point new CVEs may arise, which require additional analysis that may apply to in-development versions as well.

With all these changes in play, the team can use tooling to help discover the applicability of an existing analysis on the various released versions.


## Levels of Analysis Storage and Association

The analysis of a specific CVE issue happens across several factors:

* The similarly to other affected CVEs.  In some scenarios, multiple CVEs affect a single dependent product area which do not the product under analysis.  For example, the software product may use an HTTP library for its URL encoding capabilities, but the library has many CVEs related to its SSL capabilities; in this case, the same analysis applies to all the CVEs.
* The dependency package and version in the CVE.  A dependent package may release new versions without ever fixing the corresponding CVE.  If the software product updates the dependent version, the analysis remains the same.  For example, some CVEs only take effect if the product enables a specific configuration, and the vulnerability comes from the dependency features.
* The version of the software product.  A newly discovered CVE may apply to old, released software, which required the team to release patches.  The same analysis applies to the old versions, but not to the patched versions.  In some situations, the team may record the affected parts of the source code, and note that the code did not use that portion of the library.
* The parts of the product source code using the affected library.  If the development team marks the part of the code that interacts with the CVE affecting dependency, they can apply that same analysis to other releases that have the same source code and affected dependency version.
* Distinguish issues in dependency use versus the dependency's use of a dependency.  With the creation of the VEX document, it allows the declared dependencies to include their own vendor analysis report so that the team only needs to concern itself with the directly used dependencies.  However, some systems incorrectly generate the software bill of materials (SBOM) which makes analysis difficult, as it mixes the dependency usage with the product usage.
* Distinguish affected parts of the system.  In some circumstances, a product may use an affected dependency in multiple ways or in different sections of the source, which *should* mean each section has its own analysis based on its particular attack vector.


## Storage of Analysis

The tool principally uses a JSON file format to record the analysis.  However, as the analysis maintenance follows a timeline separate from source deployment, the analysis also supports storage through other mechanisms.

[JSON Schema v1](vac-1.0.schema.json)


## Use Cases

The tool supports (or intends to support) the following use cases.

### Construct a VEX Document

**Use case**: The team desires to release a vulnerability exploitability exchange document for a released (or soon-to-be-released) version of their product, incorporating all known vulnerabilities.

### Match a New Vulnerability Report to Known Analysis for a Known Version

**Use case**: A released version of the product has dependencies with potentially newly discovered vulnerabilities.  The team wishes to discover if it includes any vulnerabilities not already analyzed.

### Construct a Template Analysis for a Vulnerability Report and a New Version

**Use case**: The team desires to release a new version of the product, and wants to analyze it for known vulnerabilities in its dependencies.  To do so, they want a starting-point to fill in the missing vulnerability analysis document.

### Discover Chances to Reuse Existing Analysis After Upgrading Dependencies

**Use case**: The team updated the dependencies for a version of the product.  This causes a change in the vulnerability list - some new items, some items dropped off, and some items remain the same.  The team desires to update the analysis list to reflect these changes.

### Incorporate a Dependency's VEX

**Use case**: as the use of the VEX documents increase, the need to analyze dependencies of dependencies reduces.  However, it helps the product owners to include the VEX of the dependencies as attestations, and to alleviate the need to perform this analysis in-house.
