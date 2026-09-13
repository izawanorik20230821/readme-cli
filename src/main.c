#include <stdio.h>
#include <string.h>

#define VERSION "readme-cli 0.1.0"

static const char help_text[] =
    "\n"
    "READMEを読むための、とても小さなプログラムです。\n"
    "\n"
    "Usage:\n"
    "  readme-cli [OPTION] [FILE]\n"
    "\n"
    "Options:\n"
    "  -h, --help       このヘルプを表示します\n"
    "  -v, --version    バージョンを表示します\n"
    "\n"
    "このプログラムはREADMEを表示するだけです。\n"
    "本当にそれだけです。\n"
    "\n";

/* 終了コード */
#define EXIT_SUCCESS_CODE     0
#define EXIT_FILE_ERROR       1
#define EXIT_USAGE_ERROR      2
#define EXIT_IO_ERROR         3

static void print_help(void)
{
    printf("%s", help_text);
}

static void print_version(void)
{
    printf("%s\n", VERSION);
}

/* ファイルの内容をstdoutへ逐次出力する */
static int copy_file_to_stdout(const char *filename)
{
    FILE *fp = fopen(filename, "r");
    if (fp == NULL) {
        fprintf(stderr, "Error: cannot open file: %s\n", filename);
        return EXIT_FILE_ERROR;
    }

    int ch;
    while ((ch = fgetc(fp)) != EOF) {
        if (putchar(ch) == EOF) {
            fclose(fp);
            return EXIT_IO_ERROR;
        }
    }

    if (ferror(fp)) {
        fclose(fp);
        return EXIT_IO_ERROR;
    }

    fclose(fp);
    return EXIT_SUCCESS_CODE;
}

int main(int argc, char *argv[])
{
    /* 引数を逐次スキャン */
    int seen_option = 0;        /* これまでにオプションを見たか */
    int option_is_help = 0;     /* -h/--help を見たか */
    int option_is_version = 0;  /* -v/--version を見たか */
    const char *first_file = NULL;
    int file_count = 0;

    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-h") == 0 || strcmp(argv[i], "--help") == 0) {
            /* オプションが重複指定された場合 */
            if (seen_option != 0 && file_count == 0) {
                fprintf(stderr, "Error: too many options specified\n");
                return EXIT_USAGE_ERROR;
            }
            seen_option = 1;
            option_is_help = 1;
        } else if (strcmp(argv[i], "-v") == 0 || strcmp(argv[i], "--version") == 0) {
            /* オプションが重複指定された場合 */
            if (seen_option != 0 && file_count == 0) {
                fprintf(stderr, "Error: too many options specified\n");
                return EXIT_USAGE_ERROR;
            }
            seen_option = 1;
            option_is_version = 1;
        } else if (strncmp(argv[i], "-", 1) == 0) {
            /* '-' で始まるが -h/--help/-v/--version 以外の未知のオプション */
            fprintf(stderr, "Error: unknown option: %s\n", argv[i]);
            return EXIT_USAGE_ERROR;
        } else {
            /* ファイル引数 */
            file_count++;
            if (first_file == NULL) {
                first_file = argv[i];
            }
        }
    }

    /* オプション + ファイルの同時指定はエラー */
    if (seen_option != 0 && file_count > 0) {
        fprintf(stderr, "Error: options cannot be used with a file\n");
        return EXIT_USAGE_ERROR;
    }

    /* -h / --help */
    if (option_is_help) {
        print_help();
        return EXIT_SUCCESS_CODE;
    }

    /* -v / --version */
    if (option_is_version) {
        print_version();
        return EXIT_SUCCESS_CODE;
    }

    /* ファイルが2個以上 */
    if (file_count > 1) {
        fprintf(stderr, "Error: too many arguments\n");
        return EXIT_USAGE_ERROR;
    }

    /* ファイル指定がある場合 */
    if (first_file != NULL) {
        return copy_file_to_stdout(first_file);
    }

    /* 引数なしの場合、README.md を読む */
    return copy_file_to_stdout("README.md");
}
