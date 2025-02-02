"! <p class="shorttext synchronized" lang="EN">Message Type</p>
"! Use {@link ZCL_CP_MESSAGE_TYPE_FTY} to get an instance
class zcl_cp_message_type definition
                          public
                          create protected
                          global friends zcl_cp_message_type_fty.

  public section.

    interfaces: zif_cp_message_type.

    aliases: val for zif_cp_message_type~val,
             old for zif_cp_message_type~old,
             rap for zif_cp_message_type~rap,
             xco for zif_cp_message_type~xco.

    "! <p class="shorttext synchronized" lang="EN">Creates a new type</p>
    "!
    "! @parameter i_val | <p class="shorttext synchronized" lang="EN">Type-safe </p>
    "! @parameter i_old | <p class="shorttext synchronized" lang="EN">Classic Type</p>
    "! @parameter i_rap | <p class="shorttext synchronized" lang="EN">Type for RAP</p>
    "! @parameter i_xco | <p class="shorttext synchronized" lang="EN">Type for Extended Component Message</p>
    methods constructor
              importing
                i_val type zif_cp_message_type=>t_value
                i_old type symsg-msgty
                i_rap type if_abap_behv_message=>t_severity
                i_xco type ref to cl_xco_message_type.

  protected section.

    data _val type zif_cp_message_type=>t_value.

    data _old type symsg-msgty.

    data _rap type if_abap_behv_message=>t_severity.

    data _xco type ref to cl_xco_message_type.

endclass.
class zcl_cp_message_type implementation.

  method constructor.

    _val = i_val.

    _old = i_old.

    _rap = i_rap.

    _xco = i_xco.

  endmethod.
  method zif_cp_message_type~old.

    r_val = _old.

  endmethod.
  method zif_cp_message_type~rap.

    r_val = _rap.

  endmethod.
  method zif_cp_message_type~val.

    r_val = _val.

  endmethod.
  method zif_cp_message_type~xco.

    r_val = _xco.

  endmethod.

endclass.
