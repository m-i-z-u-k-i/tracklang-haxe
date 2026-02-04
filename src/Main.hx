import sys.io.File;

class Main {
	static function main() {
		var fileToBuild = Sys.args()[0];
        Sys.stdout().writeString(Translator.translate(File.getContent(fileToBuild)) + "\n");
	}
}
