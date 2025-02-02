*"* use this source file for your ABAP unit test classes
class _type definition ##CLASS_FINAL
            create public
            inheriting from zcl_cp_message_type
            for testing.

  public section.

endclass.
class _type implementation.

endclass.
class _ definition
        final
        for testing
        duration short
        risk level harmless.

  private section.

    methods constructor_fills_components for testing.

endclass.
class _ implementation.

  method constructor_fills_components.

    "arrange
    final(some_val_type) = zif_cp_message_type=>warning.

    final(some_old_type) = 'Z'.

    final(some_rap_type) = if_abap_behv_message=>severity-success.

    final(some_xco_type) = xco_cp_message=>type->error.

    "act
    final(type) = new _type( i_val = some_val_type
                             i_old = some_old_type
                             i_rap = some_rap_type
                             i_xco = some_xco_type ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_val_type
                                        act = type->val( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = some_old_type
                                        act = type->old( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = some_rap_type
                                        act = type->rap( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = some_xco_type
                                        act = type->xco( )
                                        quit = if_abap_unit_constant=>quit-no ).

  endmethod.

endclass.
