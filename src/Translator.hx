import haxe.io.Output;
import Maps.BlockOpeners;
import Maps.SimpleKeywords;
import Maps.Operators;

class Translator {
	public static function translateLine(line:String):String {
		line = StringTools.trim(line);
		if (line == "" || StringTools.startsWith(line, "#")) {
			return "";
		}

		for (k in Operators.map.keys()) {
			var v = Operators.map.get(k);
			StringTools.replace(line, k, v);
		}

		if (StringTools.startsWith(line, "CHAT ")) {
			var rest = StringTools.trim(line.substring("CHAT ".length));
			if (!(StringTools.startsWith(rest, "(") && StringTools.endsWith(rest, ")"))) {
				rest = '($rest)';
			}
			return 'print$rest';
		}

		if (StringTools.startsWith(line, "INSTALLOPENPLANETPLUGIN ")) {
			var parts = line.split(" ");
			if (parts.indexOf("AS") != -1) {
				var module = parts[1];
				var alias = parts[3];
				return 'import $module as $alias';
			} else {
				var module = parts[1];
				return 'import $module';
			}
		}

		if (StringTools.startsWith(line, "DOWNLOADFROMNADEO ")) {
			var parts = line.split(" ");
			var module = parts[1];
			var thing = parts[2];
			return 'from $module import $thing';
		}

		for (k in SimpleKeywords.map.keys()) {
			var v = SimpleKeywords.map.get(k);
			StringTools.replace(line, k, v);
		}

		return line;
	}

	public static function translate(src:String):String {
		var indent = 0;
		var output = [];
		for (rawLine in src.split("\n")) {
			var line = StringTools.trim(rawLine);
			if (line == "") {
				continue;
			}
			if (line == "FINISH") {
				indent = indent - 1;
				if (indent < 0) {
					throw "FINISH without matching block";
				}
				continue;
			}
			var opened = false;
			for (k in BlockOpeners.map.keys()) {
				var v = BlockOpeners.map.get(k);
				if (StringTools.startsWith(line, k)) {
					var rest = StringTools.trim(line.substr(k.length));
					var lineToAdd = StringTools.rtrim('$v $rest:');
					output.push([for (i in 0...indent) "    "].join("") + lineToAdd);
					indent = indent + 1;
					opened = true;
					break;
				}
			}
			if (!opened) {
				var translated = translateLine(line);
				if (translated != "") {
					output.push([for (i in 0...indent) "    "].join("") + translated);
				}
			}
		}
		if (indent != 0) {
			throw "Unclosed block (missing FINISH)";
		}
		return output.join("\n");
	}
}
