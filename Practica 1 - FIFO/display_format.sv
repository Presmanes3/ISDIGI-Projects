function test_format_display(string test_name);
    $timeformat(-9, 3, "ns");
    $display("%0t || > [TEST] %s", $realtime, test_name);
endfunction

function battery_test_display(string battery_name);
    $display("========== [ %s ] ==========", battery_name);
endfunction

function check_assertion(string assertion);
    $timeformat(-9, 3, "ns");
    $display("%0t || > > [CHECK ASSERTION] %s", $realtime, assertion);
endfunction
