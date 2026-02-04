class BlockOpeners {
    public static var map:Map<String, String> = [
        "START_RACE" => "def",
        "CHECKPOINT" => "if",
        "ALT_ROUTE" => "elif",
        "ELSE_ROUTE" => "else",
        "LOOP_TRACK" => "while",
        "LAP" => "for"
    ];
}

class SimpleKeywords {
    public static var map:Map<String, String> = [
        "PB" => "",
        "GO" => "",
        "RESTART_MAP" => "return",
        "DNF" => "break",
        "RESET_RUN" => "continue"
    ];
}

class Operators {
    public static var map:Map<String, String> = [
        "FASTER_THAN" => ">",
        "SLOWER_THAN" => "<",
        "EQUALS" => "==",
        "NOT_PB" => "!=",
        "AT_LEAST" => ">=",
        "AT_MOST" => "<="
    ];
}
