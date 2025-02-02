"! <p class="shorttext synchronized" lang="EN">Message Factory</p>
"! Creates instances of {@link ZCL_CP_MESSAGE}
"! <br/>Can be used instead of the sub-classes
class zcl_cp_message_fty definition
                         public
                         create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from the system structure</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">New system message</p>
    methods from_system_message
              returning
                value(r_val) type ref to if_abap_behv_message.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from a free text</p>
    "!
    "! @parameter i_free_text | <p class="shorttext synchronized" lang="EN">Text up to 200 characters</p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN">Type</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">New free message</p>
    methods from_string
              importing
                i_free_text type string
                i_type type ref to zif_cp_message_type default zcl_cp_message_type_fty=>unspecified
              returning
                value(r_val) type ref to if_abap_behv_message.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from a text symbol</p>
    "! Replaces place-holders &1, &2, &3, and &4 if provided
    "!
    "! @parameter i_text_symbol | <p class="shorttext synchronized" lang="EN">Text symbol text</p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN">Type</p>
    "! @parameter i_placeholder1 | <p class="shorttext synchronized" lang="EN">Value for '&1'</p>
    "! @parameter i_placeholder2 | <p class="shorttext synchronized" lang="EN">Value for '&2'</p>
    "! @parameter i_placeholder3 | <p class="shorttext synchronized" lang="EN">Value for '&3'</p>
    "! @parameter i_placeholder4 | <p class="shorttext synchronized" lang="EN">Value for '&4'</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">New text symbol message</p>
    methods from_text_symbol
              importing
                i_text_symbol type zcl_cp_text_symbol_message=>t_value
                i_type type ref to zif_cp_message_type default zcl_cp_message_type_fty=>unspecified
                i_placeholder1 type sy-msgv1 optional
                i_placeholder2 type sy-msgv2 optional
                i_placeholder3 type sy-msgv3 optional
                i_placeholder4 type sy-msgv4 optional
              returning
                value(r_val) type ref to if_abap_behv_message.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from an exception message</p>
    "! The type is whichever the exception has if it implements {@link IF_T100_DYN_MSG}, or error if it doesn't
    "!
    "! @parameter i_exception | <p class="shorttext synchronized" lang="EN">Exception with {@link IF_T100_MESSAGE} message</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">New error message</p>
    "! @raising cx_sy_message_illegal_text | <p class="shorttext synchronized" lang="EN">Provided exception doesn't implement {@link IF_T100_MESSAGE}</p>
    methods from_exception
              importing
                i_exception type ref to cx_root
              returning
                value(r_val) type ref to if_abap_behv_message
              raising
                cx_sy_message_illegal_text.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from an existing message</p>
    "!
    "! @parameter i_message | <p class="shorttext synchronized" lang="EN">Other message</p>
    "! @parameter i_new_type | <p class="shorttext synchronized" lang="EN">Type override</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">New copy</p>
    methods clone
              importing
                i_message type ref to if_message
                i_new_type type ref to zif_cp_message_type optional
              returning
                value(r_val) type ref to if_abap_behv_message.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from an XCO message</p>
    "!
    "! @parameter i_message | <p class="shorttext synchronized" lang="EN">Other message</p>
    "! @parameter i_new_type | <p class="shorttext synchronized" lang="EN">Type override</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">New copy</p>
    methods clone_xco
              importing
                i_message type ref to if_xco_message
                i_new_type type ref to zif_cp_message_type optional
              returning
                value(r_val) type ref to if_abap_behv_message.

  protected section.

endclass.
class zcl_cp_message_fty implementation.

  method from_system_message.

    r_val = cast #( new zcl_cp_message( i_id = sy-msgid
                                        i_number = sy-msgno
                                        i_type = new zcl_cp_message_type_fty( )->from_old( i_old = sy-msgty )
                                        i_var1 = sy-msgv1
                                        i_var2 = sy-msgv2
                                        i_var3 = sy-msgv3
                                        i_var4 = sy-msgv4 ) ).

  endmethod.
  method from_string.

    types: begin of free_text_as_t100_message,
             part1 like if_t100_dyn_msg=>msgv1,
             part2 like if_t100_dyn_msg=>msgv2,
             part3 like if_t100_dyn_msg=>msgv3,
             part4 like if_t100_dyn_msg=>msgv4,
           end of free_text_as_t100_message.

    final(free_text_as_t100_message) = conv free_text_as_t100_message( i_free_text ).

    r_val = cast #( new zcl_cp_message( i_id = 'ZCPMSG'
                                        i_number = 000
                                        i_type = i_type
                                        i_var1 = free_text_as_t100_message-part1
                                        i_var2 = free_text_as_t100_message-part2
                                        i_var3 = free_text_as_t100_message-part3
                                        i_var4 = free_text_as_t100_message-part4 ) ).

  endmethod.
  method from_text_symbol.

    r_val = me->from_string( i_free_text = replace( val = replace( val = replace( val = replace( val = i_text_symbol
                                                                                                 sub = '&1'
                                                                                                 with = i_placeholder1 )
                                                                                  sub = '&2'
                                                                                  with = i_placeholder2 )
                                                                   sub = '&3'
                                                                   with = i_placeholder3 )
                                                    sub = '&4'
                                                    with = i_placeholder4 )
                             i_type = i_type ).

  endmethod.
  method from_exception.

    cl_message_helper=>set_msg_vars_for_if_msg( cast #( i_exception ) ).

    final(aux) = me->from_system_message( ).

    r_val = new zcl_cp_message( i_id = aux->if_t100_message~t100key-msgid
                                i_number = aux->if_t100_message~t100key-msgno
                                i_type = new zcl_cp_message_type_fty( )->from_old( cond #( when i_exception is instance of if_t100_dyn_msg
                                                                                           then cast if_t100_dyn_msg( i_exception )->msgty
                                                                                           else 'E' ) )
                                i_var1 = aux->if_t100_dyn_msg~msgv1
                                i_var2 = aux->if_t100_dyn_msg~msgv2
                                i_var3 = aux->if_t100_dyn_msg~msgv3
                                i_var4 = aux->if_t100_dyn_msg~msgv4 ).

  endmethod.
  method clone.

    cl_message_helper=>set_msg_vars_for_if_msg( i_message ).

    final(aux) = me->from_system_message( ).

    r_val = new zcl_cp_message( i_id = aux->if_t100_message~t100key-msgid
                                i_number = aux->if_t100_message~t100key-msgno
                                i_type = cond #( when i_new_type is bound
                                                 then i_new_type
                                                 else new zcl_cp_message_type_fty( )->from_old( sy-msgty ) )
                                i_var1 = aux->if_t100_dyn_msg~msgv1
                                i_var2 = aux->if_t100_dyn_msg~msgv2
                                i_var3 = aux->if_t100_dyn_msg~msgv3
                                i_var4 = aux->if_t100_dyn_msg~msgv4 ).

  endmethod.
  method clone_xco.

    r_val = new zcl_cp_message( i_id = i_message->value-msgid
                                i_number = i_message->value-msgno
                                i_type = cond #( when i_new_type is bound
                                                 then i_new_type
                                                 else new zcl_cp_message_type_fty( )->from_xco( i_message->get_type( ) ) )
                                i_var1 = i_message->value-msgv1
                                i_var2 = i_message->value-msgv2
                                i_var3 = i_message->value-msgv3
                                i_var4 = i_message->value-msgv4 ).

  endmethod.

endclass.
