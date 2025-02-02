*"* use this source file for your ABAP unit test classes
class _xco_msg_fty_stub definition ##CLASS_FINAL
                        create public
                        inheriting from xco_msg_fty
                        for testing.

  public section.

    methods constructor
              importing
                i_xco_msg type ref to if_xco_message.

    methods new redefinition.

  protected section.

    data _xco_msg type ref to if_xco_message.

endclass.
class _xco_msg_fty_stub implementation.

  method constructor.

    super->constructor( ).

    _xco_msg = i_xco_msg.

  endmethod.
  method new.

    r_val = _xco_msg.

  endmethod.

endclass.
class _xco_message_spy definition ##CLASS_FINAL
                       create public
                       for testing.

  public section.

    interfaces: if_xco_message partially implemented.

    data t100_dyn_msg_used type ref to if_t100_dyn_msg.

endclass.
class _xco_message_spy implementation.

  method if_xco_message~write_to_t100_dyn_msg.

    t100_dyn_msg_used = io_t100_dyn_msg.

  endmethod.

endclass.
class _type_dummy_fty definition ##CLASS_FINAL
                      create public
                      for testing.

  public section.

    methods new
              returning
                value(r_val) type ref to zif_cp_message_type.

endclass.
class _type_dummy_fty implementation.

  method new.

    final(dummy) = cast zif_cp_message_type( cl_abap_testdouble=>create( 'ZIF_CP_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( dummy ).

    dummy->old( ).

    dummy->rap( ).

    dummy->val( ).

    dummy->xco( ).

    r_val = dummy.

  endmethod.

endclass.
class _message_td definition ##CLASS_FINAL
                  create public
                  inheriting from zcl_cp_message
                  for testing.

endclass.
class _message_td implementation.

endclass.
class _message_stub definition ##CLASS_FINAL
                    create public
                    inheriting from _message_td
                    for testing.

  public section.

    methods constructor
              importing
                i_id type zif_cp_message=>t_variables-msgid optional
                i_number type zif_cp_message=>t_variables-msgno optional
                i_type type ref to zif_cp_message_type optional
                i_var1 type zif_cp_message=>t_variables-msgv1 optional
                i_var2 type zif_cp_message=>t_variables-msgv2 optional
                i_var3 type zif_cp_message=>t_variables-msgv3 optional
                i_var4 type zif_cp_message=>t_variables-msgv4 optional
                i_content type string optional
                i_long_text type string optional
                i_xco type ref to if_xco_message optional.

    methods content redefinition.

    methods long_text redefinition.

  protected section.

    data _content type string.

    data _long_text type string.

endclass.
class _message_stub implementation.

  method constructor.

    super->constructor( i_id = i_id
                        i_number = i_number
                        i_type = cond #( when i_type is bound
                                         then i_type
                                         else new _type_dummy_fty( )->new( ) )
                        i_var1 = i_var1
                        i_var2 = i_var2
                        i_var3 = i_var3
                        i_var4 = i_var4 ).

    _content = i_content.

    _long_text = i_long_text.

    _xco = i_xco.

  endmethod.
  method content.

    r_val = cond #( when _content is not initial
                    then _content
                    else super->content( ) ).

  endmethod.
  method long_text.

    r_val = cond #( when _long_text is not initial
                    then _long_text
                    else super->long_text( ) ).

  endmethod.

endclass.
class _ definition
        final
        for testing
        duration short
        risk level harmless.

  private section.

    methods constructor_fills_in_order for testing.

    methods constructor_fills_rap_ty_w_ref for testing.

    methods constructor_fills_type for testing.

    methods content_equals_msg_statement for testing.

    methods long_txt_reads_from_msg_class for testing.

    methods type_returns_attribute for testing.

    methods variables_returns_attribute for testing.

    methods get_stxt_calls_content for testing.

    methods get_ltxt_calls_long_text for testing.

    methods xco_get_messages_delegates for testing.

    methods xco_get_short_text_delegates for testing.

    methods xco_get_text_delegates for testing.

    methods xco_get_type_delegates for testing.

    methods xco_overwrite_delegates for testing.

    methods xco_place_string_delegates for testing.

    methods xco_write_to_t100dyn_delegates for testing.

endclass.

class zcl_cp_message definition local friends _.

class _ implementation.

  method constructor_fills_in_order.

    "arrange
    final(vars) = value zif_cp_message=>t_variables( msgid = 1
                                                     msgno = 2
                                                     msgty = 3
                                                     msgv1 = 4
                                                     msgv2 = 5
                                                     msgv3 = 6
                                                     msgv4 = 7 ).

    final(type_stub) = cast zif_cp_message_type( cl_abap_testdouble=>create( 'ZIF_CP_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( type_stub )->returning( vars-msgty )->and_expect( )->is_called_once( ).

    type_stub->old( ).

    final(xco_spy) = new _xco_message_spy( ).

    "act
    final(m) = new zcl_cp_message( i_id = vars-msgid
                                   i_number = vars-msgno
                                   i_type = type_stub
                                   i_var1 = vars-msgv1
                                   i_var2 = vars-msgv2
                                   i_var3 = vars-msgv3
                                   i_var4 = vars-msgv4 ).

    final(stub) = new zcl_cp_message( i_id = vars-msgid
                                      i_number = vars-msgno
                                      i_type = new _type_dummy_fty( )->new( )
                                      i_var1 = vars-msgv1
                                      i_var2 = vars-msgv2
                                      i_var3 = vars-msgv3
                                      i_var4 = vars-msgv4
                                      i_xco_msg_fty = new _xco_msg_fty_stub( xco_spy ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = vars "this also tests calling of type->old( )....
                                        act = m->_variables
                                        msg = '_VARIABLES has to be set first since it''s used to set _XCO'(t01) ).

    cl_abap_unit_assert=>assert_true( act = xsdbool( m->_xco is bound and m->_xco->value eq vars )
                                      msg = '_XCO has to be set second with the value in _VARIABLES since it''s used to set the attributes of IF_T100_MESSAGE and IF_T100_DYN_MSG'(t02) ).

    cl_abap_unit_assert=>assert_equals( exp = stub
                                        act = cast _xco_message_spy( stub->_xco )->t100_dyn_msg_used
                                        msg = '_XCO->WRITE_TO_T100_DYN_MSG( ) has to be called for the instance of the message to set the interface variables'(t03) ).

  endmethod.
  method constructor_fills_rap_ty_w_ref.

    "arrange
    final(some_type) = if_abap_behv_message=>severity-warning.

    final(type_stub) = cast zif_cp_message_type( cl_abap_testdouble=>create( 'ZIF_CP_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( type_stub )->returning( some_type ).

    type_stub->rap( ).

    "act
    final(m) = new zcl_cp_message( i_id = value #( )
                                   i_number = value #( )
                                   i_type = type_stub ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_type
                                        act = cast if_abap_behv_message( m )->m_severity ).

  endmethod.
  method constructor_fills_type.

    "arrange
    final(vars) = value zif_cp_message=>t_variables( msgid = 1 ).

    final(type_dummy) = cast zif_cp_message_type( cl_abap_testdouble=>create( 'ZIF_CP_MESSAGE_TYPE' ) ).

    "act
    final(m) = new zcl_cp_message( i_id = vars-msgid
                                   i_number = vars-msgno
                                   i_type = type_dummy ).

    cl_abap_unit_assert=>assert_equals( exp = type_dummy
                                        act = m->_type ).

  endmethod.
  method content_equals_msg_statement.

    "arrange
    final(var1) = 'ex1'.

    final(var3) = 'ex2'.

    message e999(ZCPMSG) with var1 '' var3 into final(t).

    final(m) = new zcl_cp_message( i_id = 'ZCPMSG'
                                   i_number = 999
                                   i_type = zcl_cp_message_type_fty=>error
                                   i_var1 = exact #( var1 )
                                   i_var3 = exact #( var3 ) ).

    final(xco_spy) = new _xco_message_spy( ).

    final(stub) = new zcl_cp_message( i_id = 'ZCPMSG'
                                      i_number = 999
                                      i_type = zcl_cp_message_type_fty=>error
                                      i_var1 = exact #( var1 )
                                      i_var3 = exact #( var3 )
                                      i_xco_msg_fty = new _xco_msg_fty_stub( xco_spy ) ).

    "act & assert
    cl_abap_unit_assert=>assume_true( act = xsdbool( m->_variables is not initial )
                                      msg = '_VARIABLES has to be set first since it''s used to set _XCO'(t01) ).

    cl_abap_unit_assert=>assume_true( act = xsdbool( m->_xco is bound )
                                      msg = '_XCO has to be set second with the value in _VARIABLES since it''s used to set the attributes of IF_T100_MESSAGE and IF_T100_DYN_MSG'(t02) ).

    cl_abap_unit_assert=>assume_true( act = xsdbool( xco_spy->t100_dyn_msg_used eq stub )
                                      msg = '_XCO->WRITE_TO_T100_DYN_MSG( ) has to be called for the instance of the message to set the interface variables'(t03) ).

    cl_abap_unit_assert=>assert_equals( exp = t
                                        act = m->content( ) ).

  endmethod.
  method long_txt_reads_from_msg_class.

    types text type standard table of bapitgb with default key.

    "arrange
    data(text) = value text( ).

    call function 'BAPI_MESSAGE_GETDETAIL'
      exporting
        id         = 'ZCPMSG'
        number     = 999
        textformat = 'ASC'
      tables
        text       = text.

    final(m) = new zcl_cp_message( i_id = 'ZCPMSG'
                                   i_number = 999
                                   i_type = zcl_cp_message_type_fty=>error ).

    final(xco_spy) = new _xco_message_spy( ).

    final(stub) = new zcl_cp_message( i_id = 'ZCPMSG'
                                      i_number = 999
                                      i_type = zcl_cp_message_type_fty=>error
                                      i_xco_msg_fty = new _xco_msg_fty_stub( xco_spy ) ).

    "act & assert
    cl_abap_unit_assert=>assume_true( act = xsdbool( m->_variables is not initial )
                                      msg = '_VARIABLES has to be set first since it''s used to set _XCO'(t01) ).

    cl_abap_unit_assert=>assume_true( act = xsdbool( m->_xco is bound )
                                      msg = '_XCO has to be set second with the value in _VARIABLES since it''s used to set the attributes of IF_T100_MESSAGE and IF_T100_DYN_MSG'(t02) ).

    cl_abap_unit_assert=>assume_true( act = xsdbool( xco_spy->t100_dyn_msg_used eq stub )
                                      msg = '_XCO->WRITE_TO_T100_DYN_MSG( ) has to be called for the instance of the message to set the interface variables'(t03) ).

    cl_abap_unit_assert=>assert_equals( exp = concat_lines_of( table = value string_table( for <e> in text
                                                                                           ( conv #( <e>-line ) ) )
                                                               sep = ` ` )
                                        act = m->long_text( i_preserving_line_breaks = abap_false )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = concat_lines_of( table = value string_table( for <e> in text
                                                                                           ( conv #( <e>-line ) ) )
                                                               sep = cl_abap_char_utilities=>newline )
                                        act = m->long_text( i_preserving_line_breaks = abap_true )
                                        quit = if_abap_unit_constant=>quit-no ).

  endmethod.
  method type_returns_attribute.

    "arrange
    final(dummy_type) = new _type_dummy_fty( )->new( ).

    final(m) = new zcl_cp_message( i_id = value #( )
                                   i_number = value #( ) ).

    m->_type = dummy_type.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = dummy_type
                                        act = m->type( ) ).

  endmethod.
  method variables_returns_attribute.

    "arrange
    final(some_variables) = value zif_cp_message=>t_variables( msgv3 = 'varvarvar' ).

    final(m) = new zcl_cp_message( i_id = value #( )
                                   i_number = value #( ) ).

    m->_variables = some_variables.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_variables
                                        act = m->variables( ) ).

  endmethod.
  method get_ltxt_calls_long_text.

    "arrange
    final(some_text) = `asd asd fasdf asdfasdf`.

    final(m) = cast if_message( new _message_stub( i_long_text = some_text ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_text
                                        act = m->get_longtext( ) ).

  endmethod.
  method get_stxt_calls_content.

    "arrange
    final(some_text) = `hjkl ghjkghj ghjk`.

    final(m) = cast if_message( new _message_stub( i_content = some_text ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_text
                                        act = m->get_text( ) ).

  endmethod.
  method xco_get_messages_delegates.

    "arrange
    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    final(some_messages) = value sxco_t_messages( ( xco_stub ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_messages )->and_expect( )->is_called_once( ).

    xco_stub->if_xco_news~get_messages( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_messages
                                        act = new _message_stub( i_xco = xco_stub )->if_xco_news~get_messages( ) ).

  endmethod.
  method xco_get_short_text_delegates.

    "arrange
    final(some_short_text) = cast if_xco_message_short_text( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE_SHORT_TEXT' ) ).

    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_short_text )->and_expect( )->is_called_once( ).

    xco_stub->get_short_text( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_short_text
                                        act = new _message_stub( i_xco = xco_stub )->if_xco_message~get_short_text( ) ).

  endmethod.
  method xco_get_text_delegates.

    "arrange
    final(some_text) = `ads asdfkajñklñ jñkljaj`.

    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_text )->and_expect( )->is_called_once( ).

    xco_stub->get_text( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_text
                                        act = new _message_stub( i_xco = xco_stub )->if_xco_message~get_text( ) ).

  endmethod.
  method xco_get_type_delegates.

    "arrange
    final(some_type) = xco_cp_message=>type->for( 'S' ).

    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_type )->and_expect( )->is_called_once( ).

    xco_stub->get_type( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_type
                                        act = new _message_stub( i_xco = xco_stub )->if_xco_message~get_type( ) ).

  endmethod.
  method xco_overwrite_delegates.

    "arrange
    final(some_ovrwrt_msg) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->ignore_all_parameters( )->returning( some_ovrwrt_msg )->and_expect( )->is_called_once( ).

    xco_stub->overwrite( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_ovrwrt_msg
                                        act = new _message_stub( i_xco = xco_stub )->if_xco_message~overwrite( ) ).

  endmethod.
  method xco_place_string_delegates.

    "arrange
    final(some_string) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->ignore_all_parameters( )->returning( some_string )->and_expect( )->is_called_once( ).

    xco_stub->place_string( `` ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_string
                                        act = new _message_stub( i_xco = xco_stub )->if_xco_message~place_string( `` ) ).

  endmethod.
  method xco_write_to_t100dyn_delegates.

    "arrange
    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->ignore_all_parameters( )->and_expect( )->is_called_once( ).

    xco_stub->write_to_t100_dyn_msg( value #( ) ).

    "act
    new _message_stub( i_xco = xco_stub )->if_xco_message~write_to_t100_dyn_msg( value #( ) ).

    "assert
    cl_abap_testdouble=>verify_expectations( xco_stub ).

  endmethod.

endclass.
