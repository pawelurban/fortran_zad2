program main
    use, intrinsic :: iso_c_binding
    implicit none
    include 'fftw3.f03'


    ! types declarations
    real, parameter :: PI = 3.1415926
    integer :: samples_count, sampling_freq
    integer :: i  
    real(kind=16) :: time, diff, function_val

    type(c_ptr) :: plan
    real(c_double), allocatable :: data_input(:)
    complex(c_double_complex), allocatable :: data_output(:)

    samples_count = 1024
    sampling_freq = 1024
    time = 0.0
    diff = 1.0 / real(sampling_freq-1)

    allocate(data_input(samples_count))
    allocate(data_output(samples_count/2 + 1))

    open(1, file = "../res/signal.txt", status = 'replace')
    open(2, file = "../res/after_fft.txt", status = 'replace')

    do i=1, samples_count
        time = diff + time
        function_val = sin(2*PI * time * 200) + sin(2*PI * time * 400)
        data_input(i) = function_val
        write(1,*) function_val
    end do


    plan = fftw_plan_dft_r2c_1d(size(data_input), data_input, data_output, FFTW_ESTIMATE + FFTW_UNALIGNED)
    call fftw_execute_dft_r2c(plan, data_input, data_output)

    do i=1, samples_count/2+1
        function_val = abs(data_output(i))
        write(2,*) function_val
    end do

    call fftw_destroy_plan(plan)
    close(1)
    close(2)
    deallocate(data_input)
    deallocate(data_output)

end program
