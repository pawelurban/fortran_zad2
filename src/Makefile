IFORT=ifort -std08
SRC_SUM=sum_of_signals.F90
OUT_SUM=sum_of_signals
SRC_NOISE=noise.F90
OUT_NOISE=noise
LIB=lfftw3

sum:    $(IFORT) $(SRC_SUM) -o $(OUT_SUM) -$(LIB)

noise:  $(IFORT) $(SRC_NOISE) -o $(OUT_NOISE) -$(LIB)

run_sum: ./$(OUT_SUM)

run_noise: ./$(OUT_NOISE)

clean: rm -f $(OUT_SUM) $(OUT_NOISE)
