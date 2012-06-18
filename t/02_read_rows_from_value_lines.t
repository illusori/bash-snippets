#!/bin/bash

. $(dirname $0)/bash-tap-bootstrap
. $(dirname $0)/../read_rows_from_value_lines

columns_per_row=6
max_rows_per_rowset=3
total_rowsets=2

plan tests $(((columns_per_row * max_rows_per_rowset * total_rowsets) + total_rowsets))

#  Test data, resultset 1
results1="Assemblage 23
Naked (God Module RMX)
Addendum
2001
80
5:22
Ayria
Sapphire
Debris

100
6:14
Apoptygma Berzerk
Kathy's Song
Welcome To Earth \"Extra bit for testing\"

100
6:35"

#  Test data, resultset 2
results2="Colony 5
The Bottle
Lifeline

80
4:34"

output=$(_read_rows_from_value_lines "track" "$results1" artist track album year rating tracktime 2>&1)
is "$output" "" "Read of rowset 1 should produce no output"
#  Since $() runs in a subshell, we need to run it "for real" now
_read_rows_from_value_lines "track" "$results1" artist track album year rating tracktime &>/dev/null

#  Track 1
is "${track_artist[0]}" "Assemblage 23" "rowset 1 track 1 artist"
is "${track_track[0]}" "Naked (God Module RMX)" "rowset 1 track 1 track"
is "${track_album[0]}" "Addendum" "rowset 1 track 1 album"
is "${track_year[0]}" "2001" "rowset 1 track 1 year"
is "${track_rating[0]}" "80" "rowset 1 track 1 rating"
is "${track_tracktime[0]}" "5:22" "rowset 1 track 1 tracktime"

#  Track 2
is "${track_artist[1]}" "Ayria" "rowset 1 track 2 artist"
is "${track_track[1]}" "Sapphire" "rowset 1 track 2 track"
is "${track_album[1]}" "Debris" "rowset 1 track 2 album"
is "${track_year[1]}" "" "rowset 1 track 2 year"
is "${track_rating[1]}" "100" "rowset 1 track 2 rating"
is "${track_tracktime[1]}" "6:14" "rowset 1 track 2 tracktime"

#  Track 3
is "${track_artist[2]}" "Apoptygma Berzerk" "rowset 1 track 3 artist"
is "${track_track[2]}" "Kathy's Song" "rowset 1 track 3 track"
is "${track_album[2]}" "Welcome To Earth \"Extra bit for testing\"" "rowset 1 track 3 album"
is "${track_year[2]}" "" "rowset 1 track 3 year"
is "${track_rating[2]}" "100" "rowset 1 track 3 rating"
is "${track_tracktime[2]}" "6:35" "rowset 1 track 3 tracktime"

output=$(_read_rows_from_value_lines "track" "$results2" artist track album year rating tracktime 2>&1)
is "$output" "" "Read of rowset 2 should produce no output"
#  Since $() runs in a subshell, we need to run it "for real now
_read_rows_from_value_lines "track" "$results2" artist track album year rating tracktime &>/dev/null

#  Track 1
is "${track_artist[0]}" "Colony 5" "rowset 2 track 1 artist"
is "${track_track[0]}" "The Bottle" "rowset 2 track 1 track"
is "${track_album[0]}" "Lifeline" "rowset 2 track 1 album"
is "${track_year[0]}" "" "rowset 2 track 1 year"
is "${track_rating[0]}" "80" "rowset 2 track 1 rating"
is "${track_tracktime[0]}" "4:34" "rowset 2 track 1 tracktime"

#  Track 2
is "${track_artist[1]}" "" "rowset 2 track 2 artist"
is "${track_track[1]}" "" "rowset 2 track 2 track"
is "${track_album[1]}" "" "rowset 2 track 2 album"
is "${track_year[1]}" "" "rowset 2 track 2 year"
is "${track_rating[1]}" "" "rowset 2 track 2 rating"
is "${track_tracktime[1]}" "" "rowset 2 track 2 tracktime"

#  Track 3
is "${track_artist[2]}" "" "rowset 2 track 3 artist"
is "${track_track[2]}" "" "rowset 2 track 3 track"
is "${track_album[2]}" "" "rowset 2 track 3 album"
is "${track_year[2]}" "" "rowset 2 track 3 year"
is "${track_rating[2]}" "" "rowset 2 track 3 rating"
is "${track_tracktime[2]}" "" "rowset 2 track 3 tracktime"
