"! <p class="shorttext synchronized" lang="EN">Integration Testing</p>
"! @testing ZCL_CP_MESSAGE_TYPE
"! @testing ZCL_CP_MESSAGE_TYPE_FTY
"! @testing ZCL_CP_MESSAGE
"! @testing ZCL_CP_FREE_MESSAGE
"! @testing ZCL_CP_TEXT_SYMBOL_MESSAGE
"! @testing ZCL_CP_SY_MESSAGE
"! @testing ZCL_CP_MESSAGE_FTY
class zcl_cp_message_it definition
                        public
                        final
                        create private
                        for testing
                        risk level harmless
                        duration short.

  public section.

    methods basic_message_content for testing.

    methods free_message_content for testing.

    methods text_symbol_message_content for testing.

    methods sy_message_content for testing.

    methods fty_from_system_eqs_sy_msg for testing.

    methods fty_from_string_eqs_free_msg for testing.

    methods fty_from_txtsym_eqs_txtsym_msg for testing.

    methods fty_from_exc_eqs_standard_exc for testing.

    methods fty_clone_eqs_original_msg for testing.

    methods fty_clone_xco_eqs_original_msg for testing.

  protected section.

    methods set_sy_structure.

endclass.
class zcl_cp_message_it implementation.

  method set_sy_structure.

    message i000(ZCPMSG) with `hello` into final(dummy) ##NEEDED.

  endmethod.
  method basic_message_content.

    "arrange
    final(msg) = new zcl_cp_message( i_id = 'ZCPMSG'
                                     i_number = 000
                                     i_var1 = `hello` ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = `hello`
                                        act = msg->content( ) ).

  endmethod.
  method free_message_content.

    "arrange
    final(msg) = new zcl_cp_free_message( `hello` ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = `hello`
                                        act = msg->content( ) ).

  endmethod.
  method text_symbol_message_content.

    "arrange
    final(msg) = new zcl_cp_text_symbol_message( 'hello'(000) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = 'hello'(000)
                                        act = msg->content( ) ).

  endmethod.
  method sy_message_content.

    "arrange
    set_sy_structure( ).

    final(msg) = new zcl_cp_sy_message( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = `hello`
                                        act = msg->content( ) ).

  endmethod.
  method fty_from_system_eqs_sy_msg.

    "arrange
    set_sy_structure( ).

    final(sy_msg) = new zcl_cp_sy_message( ).

    final(fty_msg) = new zcl_cp_message_fty( )->from_system_message( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = sy_msg->content( )
                                        act = cast if_message( fty_msg )->get_text( ) ).

  endmethod.
  method fty_from_string_eqs_free_msg.

    "arrange
    final(some_text) = `asdf a9083 nasdf98`.

    final(free_msg) = new zcl_cp_free_message( some_text ).

    final(fty_msg) = new zcl_cp_message_fty( )->from_string( some_text ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = free_msg->content( )
                                        act = cast if_message( fty_msg )->get_text( ) ).

  endmethod.
  method fty_from_txtsym_eqs_txtsym_msg.

    "arrange
    final(some_text) = conv zcl_text_symbol_message=>t_value( 'ñlkfd spoisdfg &1' ).

    final(some_var) = conv symsgv( 8 ).

    final(text_symb_msg) = new zcl_cp_text_symbol_message( i_text_symbol = some_text
                                                           i_placeholder1 = some_var ).

    final(fty_msg) = new zcl_cp_message_fty( )->from_text_symbol( i_text_symbol = some_text
                                                                  i_placeholder1 = some_var ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = text_symb_msg->content( )
                                        act = cast if_message( fty_msg )->get_text( ) ).

  endmethod.
  method fty_from_exc_eqs_standard_exc.

    "arrange
    try.

      raise exception type cx_abap_api_state message e000(ZCPMSG) with 1 2 3 4.

    catch cx_abap_api_state into final(e).

      final(exc_msg) = new zcl_cp_message_fty( )->from_exception( e ).

    endtry.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = e->get_text( )
                                        act = cast if_message( exc_msg )->get_text( ) ).

  endmethod.
  method fty_clone_eqs_original_msg.

    "arrange
    try.

      raise exception type cx_abap_random.

    catch cx_abap_random into final(if_message_msg).

      final(cloned_msg) = new zcl_cp_message_fty( )->clone( if_message_msg ).

    endtry.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = if_message_msg->get_text( )
                                        act = cast if_message( cloned_msg )->get_text( ) ).

  endmethod.
  method fty_clone_xco_eqs_original_msg.

    "arrange
    final(some_msg) = xco_cp=>message( value #( msgid = 'ZCPMSG'
                                                msgno = 000
                                                msgty = 'W'
                                                msgv1 = `random text` ) ).

    final(fty_msg) = new zcl_cp_message_fty( )->clone_xco( some_msg ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_msg->get_text( )
                                        act = cast zif_cp_message( fty_msg )->content( ) ).

  endmethod.

endclass.
