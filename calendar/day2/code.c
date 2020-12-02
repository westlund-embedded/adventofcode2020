#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  int low;
  int high;
} limits_t;

limits_t
get_limit(char *line)
{
  char *line_clone = malloc(strlen(line));
  memcpy(line_clone, line, strlen(line));
  char *limit_str = strtok(line_clone, " ");
  char *low = strtok(limit_str, "-");
  char *high = strtok(NULL, "-");
  limits_t lim = {
    .high = atoi(high),
    .low = atoi(low)
  };
  free(line_clone);
  return lim;
}

char
get_char(char *line)
{
  char *ch_ptr = strchr(line, ':') - 1;
  return *ch_ptr;
}

char *
get_value(char *line)
{
  return strchr(line, ':') + 2;
}

int
check_limit(limits_t *lim, char ch, char *str)
{
  int ch_count = 0;
  for(int i = 0; i < strlen(str); i++) {
    if(str[i] == ch) {
      ch_count++;
    }
  }

  return ((ch_count >= lim->low) && (ch_count <= lim->high)) ? 1 : 0;
}

int
main()
{
  FILE *input;
  char *line = NULL;
  size_t len = 0;
  int valid_passwords = 0;

  input = fopen("input.txt", "r");
  int res;
  while((res = getline(&line, &len, input)) > 0) {
    limits_t lim = get_limit(line);
    char ch = get_char(line);
    char *value_str = get_value(line);
    int valid = check_limit(&lim, ch, value_str);
    valid_passwords += valid;
  }

  fclose(input);

  printf("Valid passwords: %i\n", valid_passwords);

  return 0;
}
