# M A S S
_rev.2019g01_
#### .MASS is a file format that uses human-readable delimiter-separated values to store data in attribute–value pairs.
###### In the `src` folder you can find a PowerShell module with functions that act upon the .MASS format.
##### TODO:
  * Atom Grammar
  * Implement in-file header definition for new user-defined delimiters and structures
    - `#delimiter ::` sets `::` as a delimiter
    - `#nospace` `nonewline` to disable default delimiters
  * Powershell module:
    - implement comments
  * make .js parser // array loader
    - with drag&drop
    - with address #hash reader
    - direct function value pass
---  
* Standard file extension is `.MASS`
* Standard delimiter is `double whitespace`
  - `double whitespace` keeps things tidy as a `TAB`, but is universally typable (it's difficult, if not impossible, to type a `TAB` on Android, for example)
  - To enhance readability, I suggest you use a fixed number of letters for the _attribute name_
* Supports commenting, everything on the right of `--` is a comment `-- this is a comment`
* Attribute names must NOT contain `double whitespace` or `--`.
  - Attribute values, on the other hand, can contain anything. The attribute value ends with a `newline` or `-- comment`. An actual comment after the `--` is optional.
* Lines beginning without `double whitespace` are the header of an object. That's where the objects begins.
* Lines beginning with `double whitespace` are contained in the parent object.
* Everything after the second `double whitespace` and to the end of each line is the value of the attribute.
* A line starting with `..` is an **array**, elements must start with `.`
* A line starting with `...` is an **nested object**, its elements must start with `.`
* New objects are usually added at the top of the file.
* New elements are usually appended at the end of an object.

_Examples:_

~~~~
attributename  attributevalue -- this is a block header
  attributename  attributevalue
  attributename  attributevalue
attributename  attributevalue -- this one too
  attributename  attributevalue
~~~~
After adding an element to the top block:
~~~~
attributename  attributevalue
  attributename  attributevalue
  attributename  attributevalue
  newattributename  newattributevalue
attributename  attributevalue
  attributename  attributevalue
~~~~
After adding a new block (at the top)
~~~~
newattributename  newattributevalue -- first element is set as a block header
attributename  attributevalue
  attributename  attributevalue
  attributename  attributevalue
attributename  attributevalue
  attributename  attributevalue
~~~~

**Array** example:
~~~~
ship  vega deluxe
  ..weapons
    .laser cannon
    .plasma omnisphere
    .shuriken
  engine  turbo
  ..colors
    .green and white
    .black and orange
    .matte black
    .radar-scrambling paint
~~~~

**Nested Object** example:
~~~~
customername chthulu
  ...menu
    .starter     global madness
    .maincourse  blood and violence
    .side        sadism and torture
    .dessert     proton decay
  table  rooftop
  reservationtime  2100
~~~~

An header's attributename can be used as **object name**, omitting the attributevalue
~~~~
objectname
  any     thing
  blabla  ectetera
~~~~
