# M A S S
_rev.2019E02_
#### A file format that uses human-readable delimiter-separated values to store data in attribute–value pairs.
###### In the `src` folder you can find a PowerShell module with functions that act upon the .MASS format.
##### TODO:
  * Atom Grammar
---  
* Standard file extension is `.MASS`
* Standard delimiter is `whitespace` or `TAB` (at least one, can be many, if necessary to enhance human-readability)
* Supports commenting, everything on the right of `//` is a comment `// this is a comment`
* Attribute names must NOT contain `whitespace` or `TAB` or `//`.
* Everything after the first `whitespace` or `TAB` and to the end of each line is the value of the attribute.
* Lines beginning without `whitespace` or `TAB` are the header of a block.
* Lines beginning with `whitespace` or `TAB` are contained in the parent block.
* Lines beginning with double or more `whitespace` or `TAB` are multiple values of a common parent attribute, to form a multi-value array.
* Lines beginning with `.` are multi-element arrays. The following elements must begin with one more tab than the parent to be included in the array.
* Multi-value and multi-element arrays can be nested indefinitely.
* New blocks are usually added at the top of the file.
* New elements are usually appended at the end of a block.

Examples:

~~~~
attributename attributevalue // this is a block header
  attributename attributevalue
  attributename attributevalue
attributename attributevalue // this one too
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
newattributename  newattributevalue // first element is set as a block header
attributename attributevalue
  attributename attributevalue
  attributename attributevalue
attributename attributevalue
  attributename attributevalue
~~~~

Multi-value **Array** example:

~~~~
ship      vega deluxe
  weapons
    laser cannon
    plasma omnisphere
    shuriken
  engine  turbo
  colors
    green and white
    black and orange
    matte black
    radar-scrambling paint
~~~~

Multi-element **Array** example:
~~~~
customername chthulu
  .menu
    starter     global madness
    maincourse  blood and violence
    side        sadism and torture
    dessert     proton decay
  table           rooftop
  reservationtime h2100
)
~~~~
