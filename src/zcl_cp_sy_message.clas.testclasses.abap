*"* use this source file for your ABAP unit test classes
class _sy_message definition ##CLASS_FINAL
                  create public
                  inheriting from zcl_cp_sy_message
                  for testing.

  public section.

  protected section.

endclass.
class _sy_message implementation.

endclass.
class _ definition
        final
        for testing
        duration short
        risk level harmless.

  private section.

    "! Type tested in different method
    methods constructor_uses_sy_str for testing.

    "! Technically testing the constructor of the super class, so it's not independent (but no other possibility)
    methods constructor_uses_type_fty for testing.

    methods set_sy_structure.

endclass.

class zcl_cp_sy_message definition local friends _.

class _ implementation.

  method constructor_uses_sy_str.

    "arrange
    set_sy_structure( ).

    "act
    final(m) = new zcl_cp_sy_message( ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = value symsg( msgid = sy-msgid
                                                           msgno = sy-msgno
                                                           msgv1 = sy-msgv1
                                                           msgv2 = sy-msgv2
                                                           msgv3 = sy-msgv3
                                                           msgv4 = sy-msgv4 )
                                        act = value symsg( msgid = m->if_t100_message~t100key-msgid
                                                           msgno = m->if_t100_message~t100key-msgno
                                                           msgv1 = m->if_t100_dyn_msg~msgv1
                                                           msgv2 = m->if_t100_dyn_msg~msgv2
                                                           msgv3 = m->if_t100_dyn_msg~msgv3
                                                           msgv4 = m->if_t100_dyn_msg~msgv4 ) ).

  endmethod.
  method constructor_uses_type_fty.

    "arrange
    final(type_fty) = new zcl_cp_message_type_fty( ).

    set_sy_structure( ).

    "act
    final(m) = new zcl_cp_sy_message( ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = type_fty->from_old( sy-msgty )
                                        act = m->_type ).

  endmethod.
  method set_sy_structure.

    message e000(ZCPMSG) with 1 2 3 4 into final(dummy) ##NEEDED.

  endmethod.

endclass.
