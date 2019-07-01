# M A S S
_rev.2019g01_
#### .MASS is a file format that uses human-readable delimiter-separated values to store data in attribute–value pairs.
###### In the `src` folder you can find a PowerShell module with functions that act upon the .MASS format.
##### TODO:
  * Atom Grammar
  * Implement in-file header definition for new user-defined delimiters and structures
  * Powershell module:
    - implement comments
  * make .js parser // array loader
    - with drag&drop
    - with address #hash reader
    - direct function value pass
---  
* Standard file extension is `.MASS`
* Standard delimiter is `whitespace` or `TAB` (at least one, can be many, if necessary to enhance human-readability)
* Supports commenting, everything on the right of `--` is a comment `-- this is a comment`
* Attribute names must NOT contain `whitespace` or `TAB` or `--`.
  - Attribute values, on the other hand, can contain anything. The attribute value ends with a `newline` or `-- comment`. An actual comment after the `--` is optional.
* Lines beginning without `whitespace` or `TAB` are the header of a block.
* Lines beginning with `whitespace` or `TAB` are contained in the parent block.
* Everything after the second `whitespace` or `TAB` and to the end of each line is the value of the attribute.
* A line starting with `..` is an **array**.
* A line starting with `...` is an **nested object**.
* New blocks are usually added at the top of the file.
* New elements are usually appended at the end of a block.

_Examples:_

~~~~
attributename attributevalue -- this is a block header
  attributename attributevalue
  attributename attributevalue
attributename attributevalue -- this one too
  attributename attributevalue
~~~~
After adding an element to the top block:
~~~~
attributename attributevalue
  attributename attributevalue
  attributename attributevalue
  newattributename  newattributevalue
attributename attributevalue
  attributename attributevalue
~~~~
After adding a new block (at the top)
~~~~
newattributename  newattributevalue -- first element is set as a block header
attributename attributevalue
  attributename attributevalue
  attributename attributevalue
attributename attributevalue
  attributename attributevalue
~~~~

**Array** example:
~~~~
ship      vega deluxe
  ..weapons
    laser cannon
    plasma omnisphere
    shuriken
  engine  turbo
  ..colors
    green and white
    black and orange
    matte black
    radar-scrambling paint
~~~~

**Nested Object** example:
~~~~
customername chthulu
  ...menu
    starter     global madness
    maincourse  blood and violence
    side        sadism and torture
    dessert     proton decay
  table             rooftop
  reservationtime   2100
)
~~~~
