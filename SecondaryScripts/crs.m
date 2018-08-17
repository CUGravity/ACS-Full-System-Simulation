    function [wcrs] = crs(w)
           %Turn 3x1 array used in a cross prodct into into a pre-multiplying 3x3 matrix.
           wcrs=[ 0    -w(3)  w(2)
                  w(3)  0    -w(1)
                 -w(2)  w(1)  0   ];