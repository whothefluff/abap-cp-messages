*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class xco_msg_fty definition ##CLASS_FINAL
                   create public.

  public section.

    methods new
              importing
                i_variables type zif_cp_message=>t_variables
              returning
                value(r_val) type ref to if_xco_message.

  protected section.

endclass.
class xco_msg_fty implementation.

  method new.

    r_val = xco_cp=>message( i_variables ).

  endmethod.

endclass.
