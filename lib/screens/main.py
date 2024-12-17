import random
import time
import os
from typing import List, Tuple
import sys

# Настройка неблокирующего ввода
if os.name == 'nt':  # для Windows
    import msvcrt
else:  # для Unix-систем
    import tty
    import termios

def get_key():
    if os.name == 'nt':
        if msvcrt.kbhit():
            return msvcrt.getch().decode('utf-8').lower()
        return None
    else:
        def _getch():
            fd = sys.stdin.fileno()
            old_settings = termios.tcgetattr(fd)
            try:
                tty.setraw(sys.stdin.fileno())
                ch = sys.stdin.read(1)
            finally:
                termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
            return ch

        return _getch().lower()

def clear_screen():
    os.system('cls' if os.name == 'nt' else 'clear')

def create_field(width: int, height: int) -> List[List[str]]:
    return [[' ' for _ in range(width)] for _ in range(height)]

def print_field(field: List[List[str]], score: int):
    clear_screen()
    border = '+' + '-' * len(field[0]) + '+'
    print(border)
    for row in field:
        print('|' + ''.join(row) + '|')
    print(border)
    print(f"Счёт: {score}")
    print("Используйте wasd для движения (q для выхода)")

def main():
    width, height = 20, 10
    field = create_field(width, height)
    
    # Начальное положение змейки
    snake: List[Tuple[int, int]] = [(height//2, width//2)]
    direction = (0, 1)  # Начальное направление - вправо
    
    # Первая еда
    food = (random.randint(0, height-1), random.randint(0, width-1))
    
    score = 0
    game_over = False
    
    while not game_over:
        # Проверка ввода
        key = get_key()
        if key == 'q':
            game_over = True
        elif key == 'w' and direction != (1, 0):
            direction = (-1, 0)
        elif key == 's' and direction != (-1, 0):
            direction = (1, 0)
        elif key == 'a' and direction != (0, 1):
            direction = (0, -1)
        elif key == 'd' and direction != (0, -1):
            direction = (0, 1)
            
        # Отрисовка
        field = create_field(width, height)
        field[food[0]][food[1]] = '*'
        for segment in snake:
            field[segment[0]][segment[1]] = '■'
        print_field(field, score)
        
        # Движение змейки
        new_head = (
            (snake[0][0] + direction[0]) % height,
            (snake[0][1] + direction[1]) % width
        )
        
        # Проверка столкновения с собой
        if new_head in snake:
            print(f"Игра окончена! Вы врезались в себя! Финальный счёт: {score}")
            break
            
        snake.insert(0, new_head)
        
        # Проверка еды
        if new_head == food:
            score += 10
            food = (random.randint(0, height-1), random.randint(0, width-1))
            while food in snake:
                food = (random.randint(0, height-1), random.randint(0, width-1))
        else:
            snake.pop()
            
        time.sleep(0.2)  # Скорость движения змейки

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nИгра прервана!")