*"* use this source file for your ABAP unit test classes
class _ definition
        final
        for testing
        duration short
        risk level harmless.

  private section.

    methods constructor_uses_fixed_t100msg for testing.

    "! Technically testing the constructor of the super class, so it's not independent (but no other possibility)
    methods constructor_uses_type_argument for testing.

    methods constructor_saves_whole_if_lt2 for testing.

    methods constructor_saves_whole_if_eq2 for testing.

    methods constructor_saves_fragm_if_gt2 for testing.

    methods constructor_throws_exc_if_gt2 for testing.

endclass.

class zcl_cp_free_message definition local friends _.

class _ implementation.

  method constructor_uses_fixed_t100msg.

    "act
    final(m) = cast if_t100_message( new zcl_cp_free_message( `some text` ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = 'ZCPMSG' && '000'
                                        act = m->t100key-msgid && m->t100key-msgno ).

  endmethod.
  method constructor_uses_type_argument.

    "arrange
    final(some_type) = cast zif_cp_message_type( cl_abap_testdouble=>create( 'ZIF_CP_MESSAGE_TYPE' ) ).

    final(m) = new zcl_cp_free_message( i_text = `some text`
                                        i_type = some_type ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_type
                                        act = m->_type ).

  endmethod.
  method constructor_saves_whole_if_lt2.

    "arrange
    final(short_text) = reduce #( init t = ``
                                  for i = 0 until i eq 199
                                  next t &&= `a` ).

    "act
    final(m) = cast if_t100_dyn_msg( new zcl_cp_free_message( short_text ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = short_text
                                        act = m->msgv1 && m->msgv2 && m->msgv3 && m->msgv4 ).

  endmethod.
  method constructor_saves_whole_if_eq2.

    "arrange
    final(short_text) = reduce #( init t = ``
                                  for i = 0 until i eq 200
                                  next t &&= `a` ).

    "act
    final(m) = cast if_t100_dyn_msg( new zcl_cp_free_message( short_text ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = short_text
                                        act = m->msgv1 && m->msgv2 && m->msgv3 && m->msgv4 ).

  endmethod.
  method constructor_saves_fragm_if_gt2.

    "arrange
    final(long_text) = reduce #( init t = ``
                                 for i = 0 until i eq 201
                                 next t &&= `a` ).

    "act
    final(m) = cast if_t100_dyn_msg( new zcl_cp_free_message( i_text = long_text
                                                              i_exc_if_data_loss = abap_false ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = substring( val = long_text
                                                         len = 200 )
                                        act = m->msgv1 && m->msgv2 && m->msgv3 && m->msgv4 ).

  endmethod.
  method constructor_throws_exc_if_gt2.

    "arrange
    final(long_text) = reduce #( init t = ``
                                 for i = 0 until i eq 201
                                 next t &&= `a` ).

    "act & assert
    try.

      new zcl_cp_free_message( i_text = long_text
                               i_exc_if_data_loss = abap_true ).

    catch cx_sy_conversion_data_loss into final(e) ##NO_HANDLER.

    endtry.

    cl_abap_unit_assert=>assert_bound( e ).

  endmethod.

endclass.
