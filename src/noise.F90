program main
    use, intrinsic :: iso_c_binding
    implicit none
    include 'fftw3.f03'

    real, parameter :: PI = 3.1415926
    integer :: samples_count, sampling_freq
    integer :: i  
    real(kind=16) :: time, diff, function_val, rand_num

    type(c_ptr) :: plan, plan_inv
    real(c_double), allocatable :: data_input(:)
    complex(c_double_complex), allocatable :: data_output(:)

    samples_count = 1024
    sampling_freq = 1024
    time = 0.0
    diff = 1.0 / real(sampling_freq-1)

    allocate(data_input(samples_count))
    allocate(data_output(samples_count/2 + 1))

    open(1, file = "../res/cos.txt", status = 'replace')
    open(2, file = "../res/cos_with_rand.txt", status = 'replace')
    open(3, file = "../res/after_fft.txt", status = 'replace')
    open(4, file = "../res/no_noise.txt", status = 'replace')
    open(5, file = "../res/inversed.txt", status = 'replace')

    do i=1, samples_count
        time = diff + time
        function_val = cos(2 * PI * time * 20)
        data_input(i) = function_val
        write(1,*) function_val

        call random_number(rand_num)
        write(2,*) function_val + rand_num * 0.5
    end do

    plan = fftw_plan_dft_r2c_1d(size(data_input), data_input, data_output, FFTW_ESTIMATE+FFTW_UNALIGNED)
    call fftw_execute_dft_r2c(plan, data_input, data_output)

    do i=1, samples_count/2+1
        function_val = abs(data_output(i))
        write(3,*) function_val
    end do

    do i=1, samples_count/2+1
        if(abs(data_output(i)) < 50) then
        data_output(i) = 0.0
        end if
        write(4,*) abs(data_output(i))
    end do

    plan_inv = fftw_plan_dft_c2r_1d(size(data_input), data_output, data_input, FFTW_ESTIMATE+FFTW_UNALIGNED)
    call fftw_execute_dft_c2r(plan_inv, data_output, data_input)

    time = 0.0
    do i=1, samples_count
        time = diff + time 
        write(5,*) data_input(i) / samples_count
    end do


    call fftw_destroy_plan(plan)
    call fftw_destroy_plan(plan_inv)
    close(1)
    close(2)
    close(3)
    close(4)
    close(5)

end program
