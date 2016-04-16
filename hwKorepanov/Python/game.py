#!/usr/bin/env python
# -*- coding: utf-8 -*-
import curses
import time
import random
import math


# sheeps[id] = animal( coord: (x, y), id: id, gen: generator)
# wolf = (x, y)
# FIELD: M is width, N is height


def in_field(env, x, y):
    if x >= 0 and x < env.M \
        and y >= 0 and y < env.N:
        return True
    return False

def getrandxy(M, N):
    return (random.randint(0, M - 1), random.randint(0, N - 1))

def see_wolf(env, x, y, id):
    c = env.wolf.coord
    res = math.sqrt(float((x-c[0])**2+(y-c[1])**2))

    if res < env.SHEEP_SEING_WOLF_RADIUS:
        return True
    return False

def sign(a):
    if a == 0: return 0
    return 1 if a > 0 else -1

def get_grass_around(env, x, y):
    res = 100000
    (xres, yres) = getrandxy(env.M, env.N)

    for xg in xrange(env.M):
        for yg in xrange(env.N):
            cur_grass = env.field[xg][yg]
            cur = (x - xg)**2 + (y - yg)**2
            if cur_grass > 0:
                if (cur < res):
                    res = cur
                    xres, yres = xg, yg    

    return (xres, yres)

def sheep(env, id, x, y):
    power = 0.5
    delay = 0

    while env.run:
        if power <= 0:
            print_sheep(env, id, 0)
            del env.sheeps[id]
            yield 'die',
            break

        print_sheep(env, id, power)

        power -= env.SHEEP_POWER_DEC*random.random()
        grass = env.field[x][y]

        if (see_wolf(env, x, y, id)):
            coord = env.wolf.coord
            move_x = env.SHEEP_JUMP_WHEN_WOLF*sign(x - coord[0])+\
                random.randint(-env.SHEEP_FEAR, env.SHEEP_FEAR)
            move_y = env.SHEEP_JUMP_WHEN_WOLF*sign(y - coord[1])+\
                random.randint(-env.SHEEP_FEAR, env.SHEEP_FEAR)

        elif delay > 0:
            delay -= 1
            yield 'standby',
            continue
                        
        elif grass > 0:
            delta = min(max(env.MAX_GRASS_EATEN_PER_TIME, 1-power), grass)
            yield 'eat', x, y, delta
            power += delta*env.POWER_PER_GRASS
            continue
        else:
            (aimx, aimy) = get_grass_around(env, x, y)
            move_x = sign(aimx-x)
            move_y = sign(aimy-y)
            
            if (abs(aimx-x) + abs(aimy-y)) > 3:
                move_x += random.randint(-env.SHEEP_FEAR, env.SHEEP_FEAR)
                move_y += random.randint(-env.SHEEP_FEAR, env.SHEEP_FEAR)
        
        delay += env.SHEEP_SLOW_DOWN

        if in_field(env, x+move_x, y+move_y):
            yield 'move', id, x+move_x, y+move_y
            x, y = env.sheeps[id].coord

        elif in_field(env, x, y+move_y):
            yield 'move', id, x, y+move_y
            x, y = env.sheeps[id].coord

        elif in_field(env, x+move_x, y):
            yield 'move', id, x+move_x, y
            x, y = env.sheeps[id].coord
        
        else:
            yield 'standby',


def get_closest_sheep(env, x, y):
    res = 100000

    for id in env.sheeps:
        c = env.sheeps[id].coord
        cur = (x - c[0])**2 + (y - c[1])**2
        if cur < res:
            res = cur
            resid = id

    return resid

def wolf_can_eat(env, x, y):
    id = get_closest_sheep(env, x, y)

    c = env.sheeps[id].coord
    dx = abs(x - c[0])
    dy = abs(y - c[1])
    if (dx+dy <= 1) or ((dx == 1) and (dy == 1)):
        return (True, c[0], c[1])

    return False,


def wolf(env, x, y):
    power = 0.3
    delay = 0
    
    while env.run:
        if delay > 0:
            delay = delay-1
            yield 'standby',
            continue
        
        power -= env.WOLF_POWER_DEC
        env.wolf.power = power

        if power <= 0:
            yield 'die',
            break

        check_eat = wolf_can_eat(env, x, y);
        if check_eat[0]:
            c, xs, ys = check_eat
            yield 'eat_sheep', xs, ys
            power += env.EATEN_SHEEP_POWER
            x, y = env.wolf.coord
            continue

        elif power < env.WOLF_FULL_POWER:
            id = get_closest_sheep(env, x, y)
            
            coord = env.sheeps[id].coord
            move_x = sign(coord[0]-x)
            move_y = sign(coord[1]-y)
            
            move_x = math.ceil(env.WOLF_ANGRY_SPEED*(env.WOLF_FULL_POWER - power)**2) * sign(coord[0]-x)
            move_y = math.ceil(env.WOLF_ANGRY_SPEED*(env.WOLF_FULL_POWER - power)**2) * sign(coord[1]-y)
        else:
            move_x = random.randint(-1, 1)
            move_y = random.randint(-1, 1)
            
        if power > env.WOLF_FULL_POWER:
            delay += env.WOLF_SATIETY_SPEED_RATIO * power

        if in_field(env, x+move_x, y+move_y):
            yield 'move', x + move_x, y + move_y
            x, y = env.wolf.coord
        elif in_field(env, x, y+move_y):
            yield 'move', x, y + move_y
            x, y = env.wolf.coord
        elif in_field(env, x+move_x, y):
            yield 'move', x + move_x, y
            x, y = env.wolf.coord

        else:
            yield 'standby',


def main_cycle(env):
    env.run = True

    while env.run:
        wolf_statement = next(env.wolf.gen)
        wolf_cmd = wolf_statement[0]

        if wolf_cmd == 'die':
            env.printf("Wolf died");
            env.run = False
            break

        if wolf_cmd == 'move':
            c, x, y = wolf_statement
            env.wolf.coord = (x, y)

        elif wolf_cmd == 'eat_sheep':
            c, x, y = wolf_statement
            for id, sheep in env.sheeps.items():
                if sheep.coord == (x, y):
                    del env.sheeps[id]
                    env.printf("Sheep %s was eaten" % str(id))
                    print_sheep(env, id, 0, 'EATEN')
                    env.wolf.coord = (x, y)
                    break
        
        elif wolf_cmd == 'standby':
            pass
        
        else:
            raise Exception('Wolf said %s' % wolf_cmd)

        sheep_statements = []

        for id, sheep in env.sheeps.items():
            sheep_statements.append(next(sheep.gen))

        for statement in sheep_statements:
            sheep_cmd = statement[0]

            if sheep_cmd == 'die':
                pass

            elif sheep_cmd == 'eat':
                c, x, y, amount = statement
                env.field[x][y] -= amount

                if env.field[x][y] <= 0.1:
                    env.field[x][y] = -20000*env.GROWTH

            elif sheep_cmd == 'move':
                c, id, x, y = statement
                
                if not check_exists(env.sheeps, x, y):
                    env.sheeps[id].coord = (x, y)

            elif sheep_cmd == 'standby':
                pass
            else:
                raise Exception('Sheep said %s' % sheep_cmd)
        
        for x, col in enumerate(env.field):
            for y, amount in enumerate(col):

                env.field[x][y] += env.GROWTH
                env.field[x][y] = min(env.field[x][y], 1.0)

        if len(env.sheeps) == 0:
            env.printf("Wolf won!")
            env.run = False
            break
        
        print_field(env)
        print_score(env, env.scoreboard)
        env.cout.refresh()
        env.sheepsout.refresh()
        time.sleep(0.1)

    print_field(env)

def grass_sym(grass):
    v = [0, 0.2, 0.5, 0.7, 0.9, 1.1]
    s = ' _.:vV'
    for x, y in zip(v, s):
        if grass < x:
            return  y
    return '~'


def print_cell(env, x, y):
    wolfhere = (env.wolf.coord == (x, y))

    ch = grass_sym(env.field[x][y])

    env.scr.addch(y+1, x+1, ch, curses.color_pair(5))

    for id, sheep in env.sheeps.items():
        if sheep.coord == (x, y):
            if wolfhere:
                env.scr.addch(y+1, x+1, '@', curses.color_pair(4))
                wolfhere = 0
            else:
                env.scr.addch(y+1, x+1, '#', curses.color_pair(1))
#  env.scr.addstr(y+1, x+1, str(id), curses.color_pair(1))

    if wolfhere:
        env.scr.addch(y+1, x+1, '@', curses.color_pair(3))

def print_field(env):
    env.scr.clear()
    env.scr.border(0)

    for x in xrange(env.M):
        for y in xrange(env.N):
            print_cell(env, x, y)

    env.scr.refresh()

class Animal:
    def __init__(self, coord, gen):
        self.coord = coord
        self.gen = gen

class Environment:
    pass

def generate_field(m, n):
    num = random.randint(10,15)
    bushes = [getrandxy(m,n) for i in xrange(num)]

    field =[[-50 for y in xrange(n)] \
            for x in xrange(m)]

    for (xb, yb) in bushes:
        for x in xrange(m):
            for y in xrange(n):
                dist = math.sqrt((x-xb)**2+(y-yb)**2)
                if dist < 5:
                    dist /= 5
                    prob = (1.0+math.cos(dist*math.pi))/2
                    variety = abs(random.normalvariate(0, 0.5))
                    field[x][y] = min(prob-variety, 1)


    return field

def check_exists(sheeps, x, y):
    for id in sheeps:
        if (x, y) == sheeps[id].coord:
            return True
    return False

def getemptyxy(env, sheeps):
    x, y = getrandxy(env.M, env.N)

    while check_exists(sheeps, x, y):
        x, y = getrandxy(env.M, env.N)

    return (x, y)

def put_sheeps(env, num):
    sheeps = {}

    for id in xrange(num):
        coord = getemptyxy(env, sheeps);
        sheeps[id] = Animal(coord, sheep(env, id, *coord))

    return sheeps

def put_wolf(env):
    coord = getemptyxy(env, env.sheeps)
    return Animal(coord, wolf(env, *coord))

def run_game(scr, scoreboard, sheepsout, cout, M, N):
    env = Environment()
# CONSTS
    env.SHEEPS_NUMBER = 25
    env.SHEEP_POWER_DEC = 0.005
    env.WOLF_POWER_DEC = 0.005
    env.GRASS_THRESHOLD = 0.1
    env.GROWTH = 0.0001
    env.NOGROW_TIME = 0.5
    env.WOLF_FULL_POWER = 1 
    env.EATEN_SHEEP_POWER = 0.3
    env.WOLF_SATIETY_SPEED_RATIO = 0.5
    env.MAX_GRASS_EATEN_PER_TIME = 0.3
    env.SHEEP_FULL_POWER = 0.5
    env.SHEEP_SEING_WOLF_RADIUS = max(M,N)/7
    env.SHEEP_JUMP_WHEN_WOLF = 2
    env.SHEEP_SLOW_DOWN = 2
    env.SHEEP_FEAR = 2
    env.WOLF_ANGRY_SPEED = 2;
    env.POWER_PER_GRASS = 0.4
    env.scr = scr
    env.cout = cout
    env.scoreboard = scoreboard
    env.sheepsout = sheepsout

    env.printf = lambda mes: printf(env.cout, mes)
    env.M = M
    env.N = N

    env.run = False
    env.field = generate_field(M, N)
    env.printf("FIELD SIZE: %d %d" % (M, N))

    env.sheeps = None
    env.sheeps = put_sheeps(env, env.SHEEPS_NUMBER)
    env.wolf = put_wolf(env)
    env.wolf.power = 1.0

    main_cycle(env)


def printf(cout, mes):
    cout.addstr(mes, curses.color_pair(1))
    (height, width) = cout.getmaxyx()
    (y, x) = cout.getyx()

    if y >= (height-1):
        cout.clear()
        cout.move(1,1)
        cout.border(0)
    else:
        cout.move(y+1, 1)

def print_sheep(env, id, power, msg = 'DIED'):
    (ym, xm) = env.sheepsout.getmaxyx()
    if id >= (ym - 1):
        return

    env.sheepsout.move(1+int(id), 1)
    if power > 0:
        (x, y) = env.sheeps[id].coord
        env.sheepsout.addstr("SHEEP %d (%d, %d): %.2f" % (id, x, y, power), curses.color_pair(1))
    else:
        env.sheepsout.addstr("            %s               " % msg, curses.color_pair(1))  


def print_score(env, scoreboard):
    scoreboard.clear()
    scoreboard.border(0)
    scoreboard.addstr(1,1, "WOLF POWER: %.3f" % env.wolf.power)
    scoreboard.refresh()

def proceed(stdscr):
    (height, width) = stdscr.getmaxyx()
    sheepsout = curses.newwin(height - 10, 40, 5, width - 40)      
    scoreboard = curses.newwin(5, 40, 0, width - 40)
    cout = curses.newwin(5, 40, height-5, width - 40)

    width -= 40
    screen = curses.newwin(height, width, 0, 0)

    cout.border(0)
    scoreboard.border(0)
    sheepsout.border(0)
    screen.border(0)


    curses.init_pair(1, curses.COLOR_WHITE, curses.COLOR_BLACK)
    curses.init_pair(3, curses.COLOR_RED, curses.COLOR_BLACK)
    curses.init_pair(4, curses.COLOR_RED, curses.COLOR_WHITE)
    curses.init_pair(5, curses.COLOR_GREEN, curses.COLOR_BLACK)

    scoreboard.bkgd(' ', curses.color_pair(1))
    cout.bkgd(' ', curses.color_pair(1))
    screen.bkgd(' ', curses.color_pair(1))

    cout.move(1, 1)
    scoreboard.move(1, 1)
    screen.move(1, 1)
    sheepsout.move(1,1)

    screen.refresh()
    cout.refresh()
    scoreboard.refresh()
    sheepsout.refresh()

    run_game(screen, scoreboard, sheepsout, cout, width - 2, height - 2)

    screen.refresh()
    cout.refresh()
    scoreboard.refresh()
    sheepsout.refresh()

    cout.getch()

curses.wrapper(proceed)
