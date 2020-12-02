file1 = open('input.txt', 'r')
Lines = file1.readlines()

count = 0
il = []
magic_number = 2020


# Read the file and put the values in an integer list
for line in Lines:
    l = int(line.strip())
    il.append(l)

# Brute force search for the magic sum
for i in range(len(il)):
    for j in range(i+1, len(il), 1):
        for k in range(j+1, len(il), 1):
            if (il[i] + il[j] + il[k] == magic_number):
                print('{} + {} + {} = {}'.format(il[i], il[j], il[k], il[i]+il[j]+il[k]))
                print('{} * {} * {} = {}'.format(il[i], il[j], il[k], il[i]*il[j]*il[k]))
