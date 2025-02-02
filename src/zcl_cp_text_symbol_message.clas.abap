"! <p class="shorttext synchronized" lang="EN">Text Symbol Message</p>
"! Inherits from {@link ZCL_CP_FREE_MESSAGE}
"! <br/>Allows use of variables <strong>&1</strong>, <strong>&2</strong>, <strong>&3</strong>, and <strong>&4</strong>
class zcl_cp_text_symbol_message definition
                                 public
                                 inheriting from zcl_cp_free_message
                                 create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN">String with the max possible length of a Text Symbol</p>
    types t_value type c length 132.

    "! <p class="shorttext synchronized" lang="EN">Creates a message with a text symbol text</p>
    "!
    "! @parameter i_text_symbol | <p class="shorttext synchronized" lang="EN">Text Symbol text</p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN">Type</p>
    "! @parameter i_placeholder1 | <p class="shorttext synchronized" lang="EN">Value for variable &1</p>
    "! @parameter i_placeholder2 | <p class="shorttext synchronized" lang="EN">Value for variable &2</p>
    "! @parameter i_placeholder3 | <p class="shorttext synchronized" lang="EN">Value for variable &3</p>
    "! @parameter i_placeholder4 | <p class="shorttext synchronized" lang="EN">Value for variable &4</p>
    "! @parameter i_exc_if_data_loss | <p class="shorttext synchronized" lang="EN">Toggle exception for text overflow</p>
    "! @raising cx_sy_conversion_data_loss | <p class="shorttext synchronized" lang="EN">Thrown when text doesn't fit (if toggled)</p>
    methods constructor
              importing
                i_text_symbol type zcl_text_symbol_message=>t_value
                i_type type ref to zif_cp_message_type default zcl_cp_message_type_fty=>unspecified
                i_placeholder1 type zif_cp_message=>t_variables-msgv1 optional
                i_placeholder2 type zif_cp_message=>t_variables-msgv2 optional
                i_placeholder3 type zif_cp_message=>t_variables-msgv3 optional
                i_placeholder4 type zif_cp_message=>t_variables-msgv4 optional
                i_exc_if_data_loss type xsdboolean default abap_false
              raising
                cx_sy_conversion_data_loss.

  protected section.

endclass.
class zcl_cp_text_symbol_message implementation.

  method constructor.

    super->constructor( i_text = replace( val = replace( val = replace( val = replace( val = i_text_symbol
                                                                                       sub = '&1'
                                                                                       with = i_placeholder1 )
                                                                        sub = '&2'
                                                                        with = i_placeholder2 )
                                                         sub = '&3'
                                                         with = i_placeholder3 )
                                          sub = '&4'
                                          with = i_placeholder4 )
                        i_type = i_type
                        i_exc_if_data_loss = i_exc_if_data_loss ).

  endmethod.

endclass.
