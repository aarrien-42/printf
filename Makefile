# Normbre del ejecutable
NAME = libftprintf.a

# Directorios
SRC_DIR = srcs/
OBJ_DIR = objs/
OBJF = objs
INC = incs

# Ficheros
SRC_FILES = ft_printf ft_printf_utils ft_print_unsigned ft_print_ptr
SRC = $(addprefix $(SRC_DIR), $(addsuffix .c, $(SRC_FILES)))
OBJ = $(addprefix $(OBJ_DIR), $(addsuffix .o, $(SRC_FILES)))

# Comandos
CC = gcc
CFLAGS = -Wall -Werror -Wextra
RM = rm -f
AR = ar rcs

# REGLAS #
all: $(NAME)

# Compilar conjuntamente
$(NAME): $(OBJ)
	@echo "Compiling libft..."
	@make -C ./libft
	@cp libft/libft.a $(NAME)
	@$(AR) $(NAME) $(OBJ)
	@echo "libftprintf compiled!"

# Compilar objetos individualmente y meterlos al directorio correspodiente mediante una pipe
$(OBJ_DIR)%.o: $(SRC_DIR)%.c | $(OBJF)
	@echo "Compiling: $<"
	@$(CC) $(CFLAGS) -I $(INC) -c $< -o $@

# Crear directorio temporal para los obj
$(OBJF):
	@mkdir -p $(OBJ_DIR)

# Eliminar temporales
clean:
	@make clean -C ./libft
	@$(RM) -r $(OBJ_DIR)
	@echo "Objects and directory cleaned!"

# Eliminar temporales y ejecutable
fclean: clean
	@make fclean -C ./libft
	@$(RM) $(NAME)
	@echo "Executable cleaned!"

re: fclean all

norm:
	@norminette $(SRC) $(INC)

.PHONY: all clean fclean re
