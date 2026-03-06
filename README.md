# ChessClub
An enterprise player/game management system for chess clubs. Includes rating calculation capabilities based on the ELO rating system.

### ELO Calculation Formula
```math
\text{New Rating} = \text{Old Rating} + \text{Experience Constant} * (\text{Match Score} - \text{Expected Score})
```
Where:
* Experience Constant =
  * 40 for the first 20 games played, or
  * 20 for all games after the 20^th game played
* Expected Score = $` \frac{1}{1 + 10^{\frac{\text{Opponent's Rating} - \text{Player's Rating}}{400}} `$
* Match Score =
  * 1 if the player won the game, or
  * 0 if the player lost the game, or
  * 0.5 if the game was drawn
 
For the purposes of Expected Score calculation, Opponent's Rating and Player's Rating are the players' ratings prior to the game being played.
