import sys

class TreetopTreeHouse:
  def num_visible(self, data):
    lines = data.splitlines()
    trees = [[*r] for r in lines]
    visible_count = 0
#    print(data)
    for x in range(len(trees)):
      for y in range(len(trees[0])):
        if x == 0 or y == 0 or x == len(trees)-1 or y == len(trees[0])-1:
          visible_count += 1
        else:
          visible_e,visible_s,visible_n,visible_w = [True,True,True,True]
          for i in range(x+1, len(trees)):
#            print(x,y,i,y)            
            if trees[i][y] >= trees[x][y]:
              visible_s = False
              break
          for i in range(0, x):
#            print(x,y,i,y)            
            if trees[i][y] >= trees[x][y]:
              visible_n = False
              break
          for j in range(y+1, len(trees[0])):
#            print(x,y,x,j)            
            if trees[x][j] >= trees[x][y]:
              visible_e = False
              break
          for j in range(0, y):
#            print(x,y,x,j)                          
            if trees[x][j] >= trees[x][y]:
              visible_w = False
              break
          if visible_n or visible_e or visible_s or visible_w:
#            print(x,y,"visible")
            visible_count += 1
    return visible_count

def main():
  sol = TreetopTreeHouse()
  print(str(sol.num_visible(sys.stdin.read())))

main()
