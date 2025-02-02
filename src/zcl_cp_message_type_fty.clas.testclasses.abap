*"* use this source file for your ABAP unit test classes
class _ definition
        final
        for testing
        duration short
        risk level harmless
        inheriting from zcl_cp_message_type_fty.

  private section.

    methods setup.

    methods success_instantiation for testing.

    methods information_instantiation for testing.

    methods warning_instantiation for testing.

    methods error_instantiation for testing.

    methods unspecified_instantiation for testing.

    methods equivalences_initialization for testing.

    methods from_val_uses_equiv_tab_data for testing.

    methods from_old_uses_equiv_tab_data for testing.

    methods from_old_notfound_usesdefaults for testing.

    methods from_old_notfound_throws_exc for testing.

    methods from_rap_uses_equiv_tab_data for testing.

    methods from_xco_uses_equiv_tab_data for testing.

    methods from_xco_notfound_usesdefaults for testing.

    methods from_xco_notfound_throws_exc for testing.

endclass.
class _ implementation.

  method setup.

    equivalences = _equivalences( ).

  endmethod.
  method success_instantiation.

    "assert
    cl_abap_unit_assert=>assert_equals( exp = zif_cp_message_type=>success
                                        act = zcl_cp_message_type_fty=>success->val( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = 'S'
                                        act = zcl_cp_message_type_fty=>success->old( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = if_abap_behv_message=>severity-success
                                        act = zcl_cp_message_type_fty=>success->rap( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = xco_cp_message=>type->success
                                        act = zcl_cp_message_type_fty=>success->xco( )
                                        quit = if_abap_unit_constant=>quit-no ).

  endmethod.
  method information_instantiation.

    "assert
    cl_abap_unit_assert=>assert_equals( exp = zif_cp_message_type=>information
                                        act = zcl_cp_message_type_fty=>information->val( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = 'I'
                                        act = zcl_cp_message_type_fty=>information->old( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = if_abap_behv_message=>severity-information
                                        act = zcl_cp_message_type_fty=>information->rap( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = xco_cp_message=>type->information
                                        act = zcl_cp_message_type_fty=>information->xco( )
                                        quit = if_abap_unit_constant=>quit-no ).

  endmethod.
  method warning_instantiation.

    "assert
    cl_abap_unit_assert=>assert_equals( exp = zif_cp_message_type=>warning
                                        act = zcl_cp_message_type_fty=>warning->val( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = 'W'
                                        act = zcl_cp_message_type_fty=>warning->old( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = if_abap_behv_message=>severity-warning
                                        act = zcl_cp_message_type_fty=>warning->rap( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = xco_cp_message=>type->warning
                                        act = zcl_cp_message_type_fty=>warning->xco( )
                                        quit = if_abap_unit_constant=>quit-no ).

  endmethod.
  method error_instantiation.

    "assert
    cl_abap_unit_assert=>assert_equals( exp = zif_cp_message_type=>error
                                        act = zcl_cp_message_type_fty=>error->val( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = 'E'
                                        act = zcl_cp_message_type_fty=>error->old( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = if_abap_behv_message=>severity-error
                                        act = zcl_cp_message_type_fty=>error->rap( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = xco_cp_message=>type->error
                                        act = zcl_cp_message_type_fty=>error->xco( )
                                        quit = if_abap_unit_constant=>quit-no ).

  endmethod.
  method unspecified_instantiation.

    "assert
    cl_abap_unit_assert=>assert_initial( act = zcl_cp_message_type_fty=>unspecified->val( )
                                         quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_initial( act = zcl_cp_message_type_fty=>unspecified->old( )
                                         quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_initial( act = zcl_cp_message_type_fty=>unspecified->rap( )
                                         quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_initial( act = zcl_cp_message_type_fty=>unspecified->xco( )
                                         quit = if_abap_unit_constant=>quit-no ).

  endmethod.
  method equivalences_initialization.

    "assert
    cl_abap_unit_assert=>assert_table_contains( line = value zcl_cp_message_type_fty=>t_equivalence( val = zif_cp_message_type=>error
                                                                                                     old = 'E'
                                                                                                     rap = if_abap_behv_message=>severity-error
                                                                                                     xco = xco_cp_message=>type->error
                                                                                                     ref = zcl_cp_message_type_fty=>error )
                                                table = zcl_cp_message_type_fty=>equivalences
                                                quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_table_contains( line = value zcl_cp_message_type_fty=>t_equivalence( val = zif_cp_message_type=>warning
                                                                                                     old = 'W'
                                                                                                     rap = if_abap_behv_message=>severity-warning
                                                                                                     xco = xco_cp_message=>type->warning
                                                                                                     ref = zcl_cp_message_type_fty=>warning  )
                                                table = zcl_cp_message_type_fty=>equivalences
                                                quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_table_contains( line = value zcl_cp_message_type_fty=>t_equivalence( val = zif_cp_message_type=>information
                                                                                                     old = 'I'
                                                                                                     rap = if_abap_behv_message=>severity-information
                                                                                                     xco = xco_cp_message=>type->information
                                                                                                     ref = zcl_cp_message_type_fty=>information )
                                                table = zcl_cp_message_type_fty=>equivalences
                                                quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_table_contains( line = value zcl_cp_message_type_fty=>t_equivalence( val = zif_cp_message_type=>success
                                                                                                     old = 'S'
                                                                                                     rap = if_abap_behv_message=>severity-success
                                                                                                     xco = xco_cp_message=>type->success
                                                                                                     ref = zcl_cp_message_type_fty=>success )
                                                table = zcl_cp_message_type_fty=>equivalences
                                                quit = if_abap_unit_constant=>quit-no ).

  endmethod.
  method from_old_uses_equiv_tab_data.

    "arrange
    final(some_entry) = value zcl_cp_message_type_fty=>t_equivalence( old = 'I'
                                                                      ref = zcl_cp_message_type_fty=>warning ).

    zcl_cp_message_type_fty=>equivalences = value #( ( some_entry ) ).

    "act
    data(type) = new zcl_cp_message_type_fty( )->from_old( some_entry-old ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_entry-ref
                                        act = type ).

  endmethod.
  method from_old_notfound_usesdefaults.

    "act
    data(type) = new zcl_cp_message_type_fty( )->from_old( '%' ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = value zcl_cp_message_type_fty=>t_equivalence( val = zif_cp_message_type=>unspecified
                                                                                            old = value #( )
                                                                                            rap = if_abap_behv_message=>severity-none
                                                                                            xco = value #( ) )
                                        act = value zcl_cp_message_type_fty=>t_equivalence( val = type->val( )
                                                                                            old = type->old( )
                                                                                            rap = type->rap( )
                                                                                            xco = type->xco( ) ) ).

  endmethod.
  method from_old_notfound_throws_exc.

    "act
    try.

      data(type) = new zcl_cp_message_type_fty( )->from_old( i_old = '%'
                                                           i_exc_if_not_found = abap_true ).

    catch cx_sy_itab_line_not_found into final(e) ##NO_HANDLER.

    endtry.

    "assert
    cl_abap_unit_assert=>assert_bound( e ).

  endmethod.
  method from_rap_uses_equiv_tab_data.

    "arrange
    final(some_entry) = value zcl_cp_message_type_fty=>t_equivalence( rap = if_abap_behv_message=>severity-success
                                                                      ref = zcl_cp_message_type_fty=>error ).

    zcl_cp_message_type_fty=>equivalences = value #( ( some_entry ) ).

    "act
    data(type) = new zcl_cp_message_type_fty( )->from_rap( some_entry-rap ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_entry-ref
                                        act = type ).

  endmethod.
  method from_val_uses_equiv_tab_data.

    "arrange
    final(some_entry) = value zcl_cp_message_type_fty=>t_equivalence( val = zif_cp_message_type=>error
                                                                      ref = zcl_cp_message_type_fty=>success ).

    zcl_cp_message_type_fty=>equivalences = value #( ( some_entry ) ).

    "act
    data(type) = new zcl_cp_message_type_fty( )->from_val( some_entry-val ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_entry-ref
                                        act = type ).

  endmethod.
  method from_xco_uses_equiv_tab_data.

    "arrange
    final(some_entry) = value zcl_cp_message_type_fty=>t_equivalence( xco = xco_cp_message=>type->warning
                                                                      ref = zcl_cp_message_type_fty=>information ).

    zcl_cp_message_type_fty=>equivalences = value #( ( some_entry ) ).

    "act
    data(type) = new zcl_cp_message_type_fty( )->from_xco( some_entry-xco ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_entry-ref
                                        act = type ).

  endmethod.
  method from_xco_notfound_usesdefaults.

    "act
    data(type) = new zcl_cp_message_type_fty( )->from_xco( value #( ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = value zcl_cp_message_type_fty=>t_equivalence( val = zif_cp_message_type=>unspecified
                                                                                            old = value #( )
                                                                                            rap = if_abap_behv_message=>severity-none
                                                                                            xco = value #( ) )
                                        act = value zcl_cp_message_type_fty=>t_equivalence( val = type->val( )
                                                                                            old = type->old( )
                                                                                            rap = type->rap( )
                                                                                            xco = type->xco( ) ) ).

  endmethod.
  method from_xco_notfound_throws_exc.

    "act
    try.

      data(type) = new zcl_cp_message_type_fty( )->from_xco( i_xco = value #( )
                                                             i_exc_if_not_found = abap_true ).

    catch cx_sy_itab_line_not_found into final(e) ##NO_HANDLER.

    endtry.

    "assert
    cl_abap_unit_assert=>assert_bound( e ).

  endmethod.

endclass.
