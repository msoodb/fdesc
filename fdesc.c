/*
 * This program is free software; you can redistribute it and/or modify it
 * under the terms and conditions of the GNU General Public License,
 * version 2, as published by the Free Software Foundation.
 *
 * This program is distributed in the hope it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <string.h>
#include <stdbool.h>
#include <time.h>

#include <unistd.h>
#include <signal.h>
#include <stdarg.h>
#include <sys/stat.h>

/* 
 * the official name and description of this program.
*/
#define _PROGRAM_NAME       "fdesc"
#define _PROGRAM_DESC       "command line tool for generate fake description"
#define _PROGRAM_AUTHORS    "msoodb (Masoud Bolhassani)"
#define _PROGRAM_VERSION    "0.0.1"
#define _PROGRAM_URL        "https://github.com/msoodb/fdesc"

#define EXIT_NONE -1
#define IN_RANGE(char_count) ((atoi((char_count)) > 10 && atoi((char_count)) < 65535))

struct _command
{
	int char_count;
        bool verbose_flag;
};

struct _command command;

#define VERSION_LONG_OPT    1600

static struct option const long_options[] = {		
	{"verbose",     no_argument,        0,                 'v'},
	{"help",        no_argument,        0,                 'h'},
	{"version",     no_argument,        0,    VERSION_LONG_OPT},
	{NULL, 0, 0, 0}
};


void init_command()
{
	command.verbose_flag = false;
	command.char_count = 128;
}

int vbprintf(const char *fmt, ...)
{
	va_list ap;
	int res = 0;

	if (command.verbose_flag) {
		va_start(ap, fmt);
		res = vprintf(fmt, ap);
		va_end(ap);
	}
	return res;
}

void help(int status)
{
	printf("%s %s (%s)\n", _PROGRAM_NAME, _PROGRAM_VERSION, _PROGRAM_URL);
	printf("Usage: %s [OPTIONS] COUNT\n", _PROGRAM_NAME);
	printf("COUNT should be between 10 and 65535\n", _PROGRAM_NAME);
	printf("%s\n", _PROGRAM_DESC);
	printf("\nOptions:\n");
	printf("   -v, --verbose           Explain what is being done.\n");
	printf("   -h, --help              Display this help and exit.\n");
	printf("       --version           Output version information and exit.\n");	
	printf("%s %s%s\n", "See the", _PROGRAM_NAME,
	       "(1) manpage for full options, descriptions and usage examples.");
	printf("\n");

	if (status != EXIT_NONE)
		exit(status);
}

void version(void)
{
	printf("%s %s (%s)\n", _PROGRAM_NAME, _PROGRAM_VERSION, _PROGRAM_URL);
	printf("\n");
	printf("%s\n", "Copyright (C) 2019 Free Software Foundation, Inc.");
	printf("%s",   "License GPLv3+: GNU GPL version 3 or later");
	printf("%s\n", " <https://gnu.org/licenses/gpl.html>.");
	printf("%s\n", "This is free software: you are free to change and redistribute it.");
	printf("%s\n", "There is NO WARRANTY, to the extent permitted by law.");
	printf("\n");
	printf("%s %s.\n", "Written by", _PROGRAM_AUTHORS);
}

void sig_handler(int signo)
{
	if (signo == SIGINT){
		vbprintf("\n%s\n", "Received SIGINT");
		exit(EXIT_FAILURE);
	}
}

void terminate()
{
	return;
}

bool rand_bool(double bias) {
    return rand() < ((RAND_MAX + 1.0) * ((bias + 1) / 5));
}

void fake_desc (int char_count)
{	
	// printf("%s\n", "this is first fake description.");
	srand(time(0));
	char randomletter = 'A' + (random() % 26);
	printf("%c", randomletter);

	for (int i = 0; i < char_count - 2; ++i) {
		char randomletter = 'a' + (random() % 26);
		printf("%c", randomletter);
		if (rand_bool(0.20)) {
			printf("%c", ' ');
		}		
	}
	printf("%c\n", '.');
}

int main(int argc, char *argv[])
{		
	if (signal(SIGINT, sig_handler) == SIG_ERR)
		printf("\n%s\n","can't catch SIGINT");
	atexit(terminate);

	int option_value;
	int option_index;
	int argument_index;

	option_value = 0;
	option_index = 0;
	argument_index = 0;
		
	init_command();
				
	while (1) {
		
		option_value = getopt_long(argc, argv, "-:hv", long_options, &option_index);
		if (option_value == -1)
			break;

		switch (option_value) {
		case 'v':
			command.verbose_flag = true;
			break;
		case 'h':
			help(EXIT_SUCCESS);
			break;
		case VERSION_LONG_OPT:
			version();
			return EXIT_SUCCESS;
		case 1:
			if (argument_index == 0 && IN_RANGE(optarg)) {
				command.char_count = atoi(optarg); 
			}
			argument_index++;
			break;		
		case '?':
			help(EXIT_FAILURE);
			break;
		case ':':
			printf("%s: %s %c\n", _PROGRAM_NAME, "missing arg for", optopt);
			printf("%s %s %s\n", "Try '", _PROGRAM_NAME, "--help' for more information.");
			exit(EXIT_FAILURE);
			break;
		}
	}

	/* if (!IN_RANGE(command.char_count)) { */
	/* 	printf("%s\n", "CHAR COUNT is out of range, set to default!"); */
	/* 	command.char_count = 128; */
	/* } */
	vbprintf("%s %d\n", "COUNT is set to", command.char_count);

	fake_desc(command.char_count);	

	return EXIT_SUCCESS;
}
