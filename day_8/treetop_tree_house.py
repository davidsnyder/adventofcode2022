import sys

class TreetopTreeHouse:
  def num_visible(self, data):
    lines = data.splitlines()
    trees = [[*r] for r in lines]
    visible_count = 0
    for x in range(len(trees)):
      for y in range(len(trees[0])):
        if x == 0 or y == 0 or x == len(trees)-1 or y == len(trees[0])-1:
          visible_count += 1
        else:
          visible_e,visible_s,visible_n,visible_w = [True,True,True,True]
          for i in range(x+1, len(trees)):
            if trees[i][y] >= trees[x][y]:
              visible_s = False
              break
          for i in range(0, x):
            if trees[i][y] >= trees[x][y]:
              visible_n = False
              break
          for j in range(y+1, len(trees[0])):
            if trees[x][j] >= trees[x][y]:
              visible_e = False
              break
          for j in range(0, y):
            if trees[x][j] >= trees[x][y]:
              visible_w = False
              break
          if visible_n or visible_e or visible_s or visible_w:
            visible_count += 1
    return visible_count

  def scenic_score(self, data):
    lines = data.splitlines()
    trees = [[*r] for r in lines]
    scenic_score = 0
    for x in range(len(trees)):
      for y in range(len(trees[0])):
        if x == 0 or y == 0 or x == len(trees)-1 or y == len(trees[0])-1:
          pass
        else:
          visible_e,visible_s,visible_n,visible_w = [0,0,0,0]
          for i in range(x+1, len(trees)):
            visible_s +=1                        
            if trees[i][y] >= trees[x][y]:
              break
          for i in range(x-1,-1,-1):
            visible_n +=1                                    
            if trees[i][y] >= trees[x][y]:
              break
          for j in range(y+1, len(trees[0])):
            visible_e +=1                                    
            if trees[x][j] >= trees[x][y]:
              break
          for j in range(y-1,-1,-1):
            visible_w +=1                                    
            if trees[x][j] >= trees[x][y]:
              break
          scenic_score = max(scenic_score,visible_n * visible_s * visible_w * visible_e)
    return scenic_score

def main():
  sol = TreetopTreeHouse()
  input = sys.stdin.read()
  print("part 1: " + str(sol.num_visible(input)))  
  print("part 2: " + str(sol.scenic_score(input)))

main()
