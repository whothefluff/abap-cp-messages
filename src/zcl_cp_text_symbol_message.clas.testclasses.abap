*"* use this source file for your ABAP unit test classes
class _ definition
        final
        for testing
        duration short
        risk level harmless.

  private section.

    methods constr_uses_txt_replacing_v1 for testing.

    methods constr_uses_txt_replacing_v2 for testing.

    methods constr_uses_txt_replacing_v3 for testing.

    methods constr_uses_txt_replacing_v4 for testing.

    "! Technically testing the constructor of the super class, so it's not independent (but no other possibility)
    methods constr_uses_type_argument for testing.

    methods constr_uses_excifloss_argument for testing.

endclass.

class zcl_cp_text_symbol_message definition local friends _.

class _ implementation.

  method constr_uses_txt_replacing_v1.

    "act
    final(m) = cast if_t100_dyn_msg( new zcl_cp_text_symbol_message( i_text_symbol = 'some &1'
                                                                     i_placeholder1 = 'var' ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = 'some var'
                                        act = m->msgv1 ).

  endmethod.
  method constr_uses_txt_replacing_v2.

    "act
    final(m) = cast if_t100_dyn_msg( new zcl_cp_text_symbol_message( i_text_symbol = 'some &2'
                                                                     i_placeholder2 = 'var' ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = 'some var'
                                        act = m->msgv1 ).

  endmethod.
  method constr_uses_txt_replacing_v3.

    "act
    final(m) = cast if_t100_dyn_msg( new zcl_cp_text_symbol_message( i_text_symbol = 'some &3'
                                                                     i_placeholder3 = 'var' ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = 'some var'
                                        act = m->msgv1 ).

  endmethod.
  method constr_uses_txt_replacing_v4.

    "act
    final(m) = cast if_t100_dyn_msg( new zcl_cp_text_symbol_message( i_text_symbol = 'some &4'
                                                                     i_placeholder4 = 'var' ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = 'some var'
                                        act = m->msgv1 ).

  endmethod.
  method constr_uses_type_argument.

    "arrange
    final(some_type) = cast zif_cp_message_type( cl_abap_testdouble=>create( 'ZIF_CP_MESSAGE_TYPE' ) ).

    "act
    final(m) = new zcl_cp_text_symbol_message( i_text_symbol = value #( )
                                               i_type = some_type ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_type
                                        act = m->_type ).

  endmethod.
  method constr_uses_excifloss_argument.

    cl_abap_unit_assert=>skip( 'Independent test not possible' ). "dependent test useless (duplicating test of super class)

  endmethod.

endclass.
