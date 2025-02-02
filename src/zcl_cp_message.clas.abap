"! <p class="shorttext synchronized" lang="EN">Message</p>
"! Specializations {@link ZCL_CP_FREE_MESSAGE} and {@link ZCL_CP_SY_MESSAGE} are easier to use in certain contexts
"! <br/>All methods implemented assuming the instances are immutable
class zcl_cp_message definition
                     public
                     create public.

  public section.

    interfaces: zif_cp_message.

    aliases: content for zif_cp_message~content,
             long_text for zif_cp_message~long_text,
             type for zif_cp_message~type,
             variables for zif_cp_message~variables.

    "! <p class="shorttext synchronized" lang="EN">Creates a T100 message</p>
    "!
    "! @parameter i_id | <p class="shorttext synchronized" lang="EN">Message class</p>
    "! @parameter i_number | <p class="shorttext synchronized" lang="EN">Message number</p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN">Type</p>
    "! @parameter i_var1 | <p class="shorttext synchronized" lang="EN">Variable</p>
    "! @parameter i_var2 | <p class="shorttext synchronized" lang="EN">Variable</p>
    "! @parameter i_var3 | <p class="shorttext synchronized" lang="EN">Variable</p>
    "! @parameter i_var4 | <p class="shorttext synchronized" lang="EN">Variable</p>
    methods constructor
              importing
                i_id type zif_cp_message=>t_variables-msgid
                i_number type zif_cp_message=>t_variables-msgno
                i_type type ref to zif_cp_message_type default zcl_cp_message_type_fty=>unspecified
                i_var1 type zif_cp_message=>t_variables-msgv1 optional
                i_var2 type zif_cp_message=>t_variables-msgv2 optional
                i_var3 type zif_cp_message=>t_variables-msgv3 optional
                i_var4 type zif_cp_message=>t_variables-msgv4 optional
                i_xco_msg_fty type ref to object optional.

  protected section.

    data _type type ref to zif_cp_message_type.

    data _xco type ref to if_xco_message.

    data _variables type zif_cp_message=>t_variables.

endclass.
class zcl_cp_message implementation.

  method constructor.

    _variables = value #( msgid = i_id
                          msgno = i_number
                          msgty = i_type->old( )
                          msgv1 = i_var1
                          msgv2 = i_var2
                          msgv3 = i_var3
                          msgv4 = i_var4 ).

    _xco = cond #( when i_xco_msg_fty is bound
                   then cast xco_msg_fty( i_xco_msg_fty )->new( _variables )
                   else new xco_msg_fty( )->new( _variables ) ).

    if _xco is bound.

      _xco->write_to_t100_dyn_msg( me ).

    endif.

    cast if_abap_behv_message( me )->m_severity = i_type->rap( ).

    _type = i_type.

  endmethod.
  method if_message~get_longtext.

    "get long text only, to get everything as in standard exception implementation concatenate short and long
    result = long_text( preserve_newlines ).

  endmethod.
  method if_message~get_text.

    result = content( ).

  endmethod.
  method if_xco_news~get_messages.

    rt_messages = cast if_xco_news( _xco )->get_messages( ).

  endmethod.
  method if_xco_message~get_short_text.

    ro_short_text = _xco->get_short_text( ).

  endmethod.
  method if_xco_message~get_text.

    rv_text = _xco->get_text( ).

  endmethod.
  method if_xco_message~get_type.

    ro_type = _xco->get_type( ).

  endmethod.
  method if_xco_message~overwrite.

    ro_message = _xco->overwrite( iv_msgty = iv_msgty
                                  iv_msgid = iv_msgid
                                  iv_msgno = iv_msgno
                                  iv_msgv1 = iv_msgv1
                                  iv_msgv2 = iv_msgv2
                                  iv_msgv3 = iv_msgv3
                                  iv_msgv4 = iv_msgv4 ).

  endmethod.
  method if_xco_message~place_string.

    ro_message = _xco->place_string( iv_string = iv_string
                                     iv_msgv1  = abap_false
                                     iv_msgv2  = abap_false
                                     iv_msgv3  = abap_false
                                     iv_msgv4  = abap_false ).

  endmethod.
  method if_xco_message~write_to_t100_dyn_msg.

    _xco->write_to_t100_dyn_msg( io_t100_dyn_msg ).

  endmethod.
  method zif_cp_message~content.

    r_val = cl_message_helper=>get_text_for_message( me ).

  endmethod.
  method zif_cp_message~long_text.

    r_val = condense( val = cl_message_helper=>get_longtext_for_message( text = me
                                                                         preserve_newlines = i_preserving_line_breaks
                                                                         t100_prepend_short = abap_false )
                      from = `` ).

  endmethod.
  method zif_cp_message~type.

    r_val = _type.

  endmethod.
  method zif_cp_message~variables.

    r_val = _variables.

  endmethod.

endclass.
