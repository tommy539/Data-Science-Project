# World Cup 2018 Group Stage Prediction
Objective

This was a Datathon project I participated in 2018 before the FIFA World Cup. The objective of this project was to predict the odds (probability) of each game in the group stage. There were 32 teams and 48 matches in the FIFA World Cup 2018 group stage. The output is the win, draw and lose probabilities of each game. 


Data Source

The dataset is given by the host, Betfair, with all the international match records from 2000 to 2018. 


Methodology

This project is written in R, using the ELO rating system, which is widely used in multiplayer competitions including sports, video games, board games, etc., to calculate the ELO score of every teams. The odds for each match are then calculated according to the ELO score of two teams. For example, a team with higher ELO score (stronger) is more likely to win the game when the opponent is with a lower ELO score (weaker).

More about ELO rating system: https://www.gautamnarula.com/rating/

[Read the full report here](https://nbviewer.jupyter.org/gist/tommy539/60595e205ee03594042d654ab79a7994)


Final ELO ranking according to my model:
![text](https://github.com/tommy539/Data-Science-Project/blob/master/World%20Cup%202018%20prediction/ELO.png "ELO ranking")
