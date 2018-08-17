module GPIO

    """
    Mode of the GPIO
    """
    module Mode

        @enum ModeCode::UInt8 begin
            PULL_UP_INPUT_MODE = 0
            INPUT_BINDING_MODE = 1
            PUSH_PULL_OUTPUT_MODE = 2
            PWM_OUTPUT_MODE = 3
            OPEN_DRAIN_OUTPUT_MODE = 4
        end

    end

end
