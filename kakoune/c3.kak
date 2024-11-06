hook global BufCreate .*[.]c3 %{
    set-option buffer filetype c3
}

addhl shared/c3                   regions
addhl shared/c3/code              default-region group
addhl shared/c3/comment-line      region '//' '$' fill comment
addhl shared/c3/comment-block     region /\*  \*/ fill comment
addhl shared/c3/comment-doc       region <\* \*> fill comment
addhl shared/c3/double-string     region 'c?"' (?<!\\)(\\\\)*" fill string
addhl shared/c3/single-string     region "'" (?<!\\)(\\\\)*' fill string
addhl shared/c3/compiler-builtin  region '\$\$\w' '\b' fill keyword

addhl shared/c3/code/		    regex '\b(?:asm|assert|bitstruct|break|case|catch|const|continue)\b' 0:keyword
addhl shared/c3/code/		    regex '\b(?:def|default|defer|distinct|do|else|enum|extern)\b' 0:keyword
addhl shared/c3/code/		    regex '\b(?:false|fault|for|foreach|foreach_r|fn|tlocal|if)\b' 0:keyword
addhl shared/c3/code/		    regex '\b(?:inline|import|macro|module|nextcase|null|return|static)\b' 0:keyword
addhl shared/c3/code/		    regex '\b(?:struct|switch|true|try|union|var|while)\b' 0:keyword
addhl shared/c3/code/		    regex '[$](?:switch|default|case|if|typeof|else|sizeof|for|case|foreach|endif|endfor|endforeach|endswitch|alignof|append|assert|assignable|defined|echo|embed|error|eval|evaltype|exec|extnameof|qnameof|nameof|feature|is_const|nameof|offsetof|qnameof|vacount|vaconst|vaexpr|varef|vasplat|vatype|sizeof|stringify|typeof|typefrom)\b' 0:keyword

addhl shared/c3/code/bool       regex '\b(?:true|false)\b' 0:keyword
addhl shared/c3/code/type       regex '\b(?:any|anyfault|bool|char|ichar|short|ushort|int|uint|long|ulong|int128|uint128|isz|usz|iptr|uptr|float16|float|double|float128|typeid|void)\b' 0:type
addhl shared/c3/code/operator   regex '(?:\.|>|<|=|\+|-|\*|/|%|&|\^|\||!|:|\?|;|,|@)=?' 0:default
addhl shared/c3/code/num        regex '(?<=[^A-z0-9])[+-]?(?:0(?:[xX][0-9a-fA-F](?:_|[0-9a-fA-F])*|[oO][0-7](?:_|[0-7])*|[bB][10](?:_|[10])*)|[0-9](?:_?[0-9])*(?:_?[eE][+-]?[0-9]+)?)(?:i8|i16|i32|i64|i128|u8|u16|u32|u|u64|u128|f|f32|f64)?\b' 0:value
addhl shared/c3/code/attribute  regex '[@][a-z]+' 0:keyword

addhl shared/c3/code/const-and-struct   regex '\b[A-Z].+?\b' 0:value
addhl shared/c3/code/function           regex '@?\b(?![A-Z])(?![0-9])(?<!\$)\w+?(?=\()' 0:function
addhl shared/c3/code/module             regex '\b(\w+)(?:::)' 1:module
addhl shared/c3/code/module-statement   regex '(?:module|import) +((?:[A-z1-9]+(?:::)?)+)' 1:module

hook -group c3-highlight global WinSetOption filetype=c3 %{ add-highlighter window/ ref c3 }
hook -group c3-highlight global WinSetOption filetype=(?!c3).* %{ remove-highlighter window/c3 }
