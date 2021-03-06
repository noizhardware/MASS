# M A S S
_rev.2019g23_

🔴 WARNING!!! These file format specs are a work-in-progress 🔴
---
#### .MASS is an extensible database file format that uses human-readable delimiter-separated values to store data in attribute–value pairs and arrays.
###### In the `src` folder you can find a PowerShell module with functions that act upon the .MASS format.
#### TODO:
  * Any non-js parser must ignore the .js object header and footer
  * Atom Grammar
  * Implement in-file header definition for new user-defined delimiters and structures
    - `#delimiter ::` sets `::` as a delimiter
    - `#valsep ,` sets `,` as a separator inside value elements
    - `#nospace` `#nonewline` to disable default delimiters
    - `#wrapvalue` `#wrapname` sets wrapping glyphs for attribute _name_ or _value_
  * Powershell module:
    - implement comments
  * make .js parser // array loader
    - with drag&drop
    - with address #hash reader
    - direct function value pass
  * x-dimensional arrays
  * split repo per language and add repos via github modules
---  
* Standard file extension is `.MASS`
* Standard delimiter is `double whitespace`
  - `double whitespace` keeps things tidy as a `TAB`, but is universally typable (it's difficult, if not impossible, to type a `TAB` on Android, for example)
  - To enhance readability, it's good practice to use a fixed number of letters for the _attribute name_
    + You can use `#namelength` to declare a fixed length. (use it as an attribute name at the beginning of the file)
* Supports commenting, everything on the right of `--` is a comment `-- this is a comment`
* Attribute names must NOT contain `double whitespace` or `--`.
  - Attribute values, on the other hand, can contain anything. The attribute value ends with a `newline` or `-- comment`. An actual comment after the `--` is optional.
* Lines beginning without `double whitespace` are the header of an object. That's where the objects begins.
  - Thus objects have no names. The first element is the header of the object itself.
* Lines beginning with `double whitespace` are elements contained in the parent object.
* Everything after the second `double whitespace` and to the end of each line is the value of the attribute.
* multi-line attribute _values_ are possible, each new line must be indented with `four whitespace`
* A line starting with `double whitespace` `..` is an **array**, elements must start with `four whitespace` `.`
* A line starting with `double whitespace` `...` is an **nested object**, its elements must start with `four whitespace` `.`
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
newattributename  newattributevalue -- first element is always set as a block header
attributename  attributevalue
  attributename  attributevalue
  attributename  attributevalue
attributename  attributevalue
  attributename  attributevalue
~~~~

Multi-line attribute value:
~~~~
attname  attval
  attname  this is the value, it can be multi-line.
    This is the continuation of the same value as above, indented of 4 whitespace.
    Makes decent journaling possible!
  anotherattname  another attribute value
  etcetc  bla bla
~~~~
Another example:
~~~~
2020a30  
    Entry. Here I'm "misusing" the format, to obtain a more compact form.
    I'm using the main attribute name as "DATE" attribute value,
    and its attribute value as the actual journal entry.
    I like it that it's possible to bend the format.
    This is still valid .MASS format, but can be used for a purpose-specific application.
    And still, you can use the same parser to read it.
2020a31  
    another entry. (note the trailing twospace in the line above!)
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

Example usage of `#namelength`
~~~~
 #namelength  4
 nam1  value
   nam2  value
   nam3  value
   othe  value
~~~~

Example usage of `#valsep`
~~~~
 #valsep ,
 thingname  something,other thing,that thing,this,foo
~~~~
