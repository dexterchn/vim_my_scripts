^\s*input\s*\(\[\d\+:\d\+]\)*\s*\(\w\+\),
^\(\s*output\s*\)\(reg\|wire\)\s*\(\[\d\+:\d\+]\)*\s*\(\w\+\),


Port list 
-- input
s/^\s*input\s*\(\[\d\+:\d\+]\)*\s*\(\w\+\)\(,\| \).*/  \2\3

-- output
s/\s*output\s*\(reg\|wire\)\s*\(\[\d\+:\d\+]\)*\s*\(\w\+\)\(,\| \).*/  \3\4

-- Remove comment lines
s/^\s\+\/\/.*/\b

-- Remove multiple empty lines
s/^\s*\n\{2}//

I/O declaration
s/,/;/
s/^\(\s*output \)\(reg \|wire\)\s*\(\[\d\+:\d\+]\)/\1\3 /
s/^\(\s*output \)\(reg \|wire\)/\1

reg/wire declaration
-- remove comments
s/,.*/;/

-- remove "input" lines
s/^\s*input.*//

-- remove comment lines
s/^\s*\/\/.*//

-- remove multiple empty lines
s/^\s*\n\{2}//

-- remove "output" keyword
s/^\(\s*\)output /\1
