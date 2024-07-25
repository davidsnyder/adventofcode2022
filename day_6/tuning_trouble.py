import sys

class TuningTrouble:
  def start_of_packet_marker(self, data, packet_len=4):
    marker = []
    chars = [*data]
    for i in range(len(chars)):
      marker.append(chars[i])
      if len(marker) == len(set(marker)) == packet_len:
        return i + 1
      elif len(marker) == packet_len:
        marker.pop(0)

def main():
  sol = TuningTrouble()
  print("mjqjpqmgbljsphdztnvjfqwrcgsmlb 19: " + str(sol.start_of_packet_marker("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 14)))
  print("bvwbjplbgvbhsrlpgdmjqwftvncz 23: " + str(sol.start_of_packet_marker("bvwbjplbgvbhsrlpgdmjqwftvncz", 14)))
  print(str(sol.start_of_packet_marker(sys.stdin.read(), 14)))

main()
