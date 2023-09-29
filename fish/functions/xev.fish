function xev
<<<<<<< Updated upstream
  command xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
end
=======
  xev | awk -F'[
end
>>>>>>> Stashed changes
