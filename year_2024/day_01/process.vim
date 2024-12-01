
function! ParseInput()
    const file = readfile('year_2024/day_01/input.txt')
    let list_1 = []
    let list_2 = []
    for ln in file
        let [entry_1, entry_2] = split(ln)
        call add(list_1, str2nr(entry_1))
        call add(list_2, str2nr(entry_2))
    endfor
    return [list_1, list_2]
endfunction


function! Part1(list_1, list_2)
    const sorted_list_1 = sort(copy(a:list_1))
    const sorted_list_2 = sort(copy(a:list_2))

    let result = 0
    for idx in range(len(sorted_list_1))
        let result += abs(sorted_list_1[idx] - sorted_list_2[idx])
    endfor

    return result
endfunction


function! Part2(list_1, list_2)
    let counts = {}
    for entry in a:list_2
        if has_key(counts, entry)
            let counts[entry] += 1
        else
            let counts[entry] = 1
        endif
    endfor
    
    let result = 0
    for entry in a:list_1
        if has_key(counts, entry)
            let result += entry * counts[entry]
        endif
    endfor

    return result
endfunction


function! Solution()
    const [list_1, list_2] = ParseInput()
    echo Part1(list_1, list_2)
    echo Part2(list_1, list_2)

endfunction

call Solution()
