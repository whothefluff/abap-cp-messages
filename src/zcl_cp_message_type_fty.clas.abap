"! <p class="shorttext synchronized" lang="EN">Message Type Factory</p>
"! Creates instances of {@link ZCL_CP_MESSAGE_TYPE}
class zcl_cp_message_type_fty definition
                              public
                              create public.

  public section.

    types: begin of t_equivalence,
             val type zif_cp_message_type=>t_value,
             old type sy-msgty,
             rap type if_abap_behv_message=>t_severity,
             xco type ref to cl_xco_message_type,
             ref type ref to zif_cp_message_type,
           end of t_equivalence,
           t_equivalences type standard table of zcl_cp_message_type_fty=>t_equivalence with empty key
                                                                                        with unique hashed key v components val
                                                                                        with unique hashed key o components old
                                                                                        with unique hashed key r components rap.

    class-methods class_constructor.

    "! <p class="shorttext synchronized" lang="EN">Returns a type instance from a classic type</p>
    "!
    "! @parameter i_old | <p class="shorttext synchronized" lang="EN">Classic type</p>
    "! @parameter i_exc_if_not_found | <p class="shorttext synchronized" lang="EN">Toggle exception for not found</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Type</p>
    "! @raising cx_sy_itab_line_not_found | <p class="shorttext synchronized" lang="EN">Thrown when type not found (if toggled)</p>
    methods from_old
              importing
                i_old type sy-msgty
                i_exc_if_not_found type xsdboolean default abap_false
              returning
                value(r_val) type ref to zif_cp_message_type
              raising
                cx_sy_itab_line_not_found.

    "! <p class="shorttext synchronized" lang="EN">Returns a type instance from a type-safe type</p>
    "!
    "! @parameter i_val | <p class="shorttext synchronized" lang="EN">Type-safe type</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Type</p>
    methods from_val
              importing
                i_val type zif_cp_message_type=>t_value
              returning
                value(r_val) type ref to zif_cp_message_type.

    "! <p class="shorttext synchronized" lang="EN">Returns a type instance from a RAP type</p>
    "!
    "! @parameter i_rap | <p class="shorttext synchronized" lang="EN">RAP type</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Type</p>
    methods from_rap
              importing
                i_rap type if_abap_behv_message=>t_severity
              returning
                value(r_val) type ref to zif_cp_message_type.

    "! <p class="shorttext synchronized" lang="EN">Returns a type instance from an Extended Component type</p>
    "!
    "! @parameter i_xco | <p class="shorttext synchronized" lang="EN">Extended Component Message type</p>
    "! @parameter i_exc_if_not_found | <p class="shorttext synchronized" lang="EN">Toggle exception for not found</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Type</p>
    "! @raising cx_sy_itab_line_not_found | <p class="shorttext synchronized" lang="EN">Thrown when type not found (if toggled)</p>
    methods from_xco
              importing
                i_xco type ref to cl_xco_message_type
                i_exc_if_not_found type xsdboolean default abap_false
              returning
                value(r_val) type ref to zif_cp_message_type
              raising
                cx_sy_itab_line_not_found.

    "! <p class="shorttext synchronized" lang="EN">Success type</p>
    class-data success type ref to zif_cp_message_type read-only.

    "! <p class="shorttext synchronized" lang="EN">Information type</p>
    class-data information type ref to zif_cp_message_type read-only.

    "! <p class="shorttext synchronized" lang="EN">Warning type</p>
    class-data warning type ref to zif_cp_message_type read-only.

    "! <p class="shorttext synchronized" lang="EN">Error type</p>
    class-data error type ref to zif_cp_message_type read-only.

    class-data unspecified type ref to zif_cp_message_type read-only.

    "! <p class="shorttext synchronized" lang="EN">Relationship of the different message types</p>
    "!
    "! Exposed because why not, although using the methods is probably better
    "! <br/>No entry for {@link .DATA:UNSPECIFIED} because it can mean many different things for a classic type
    class-data equivalences type zcl_cp_message_type_fty=>t_equivalences read-only.

  protected section.

    class-methods _equivalences
                    returning
                      value(r_val) type zcl_cp_message_type_fty=>t_equivalences.

endclass.
class zcl_cp_message_type_fty implementation.

  method class_constructor.

    success = new zcl_cp_message_type( i_val = zif_cp_message_type=>success
                                       i_old = 'S'
                                       i_rap = if_abap_behv_message=>severity-success
                                       i_xco = xco_cp_message=>type->success ).

    information = new zcl_cp_message_type( i_val = zif_cp_message_type=>information
                                           i_old = 'I'
                                           i_rap = if_abap_behv_message=>severity-information
                                           i_xco = xco_cp_message=>type->information ).

    warning = new zcl_cp_message_type( i_val = zif_cp_message_type=>warning
                                       i_old = 'W'
                                       i_rap = if_abap_behv_message=>severity-warning
                                       i_xco = xco_cp_message=>type->warning ).

    error = new zcl_cp_message_type( i_val = zif_cp_message_type=>error
                                     i_old = 'E'
                                     i_rap = if_abap_behv_message=>severity-error
                                     i_xco = xco_cp_message=>type->error ).

    unspecified = new zcl_cp_message_type( i_val = value #( )
                                           i_old = value #( )
                                           i_rap = value #( )
                                           i_xco = value #( ) ).

    equivalences = _equivalences( ).

  endmethod.
  method _equivalences.

    r_val = value #( ( val = zif_cp_message_type=>error
                       old = 'E'
                       rap = if_abap_behv_message=>severity-error
                       xco = xco_cp_message=>type->error
                       ref = error )
                     ( val = zif_cp_message_type=>warning
                       old = 'W'
                       rap = if_abap_behv_message=>severity-warning
                       xco = xco_cp_message=>type->warning
                       ref = warning )
                     ( val = zif_cp_message_type=>information
                       old = 'I'
                       rap = if_abap_behv_message=>severity-information
                       xco = xco_cp_message=>type->information
                       ref = information )
                     ( val = zif_cp_message_type=>success
                       old = 'S'
                       rap = if_abap_behv_message=>severity-success
                       xco = xco_cp_message=>type->success
                       ref = success ) ).

  endmethod.
  method from_old.

    r_val = value #( equivalences[ key o
                                   old = i_old ]-ref default cond #( when not ( i_exc_if_not_found eq abap_true )
                                                                     then unspecified
                                                                     else throw cx_sy_itab_line_not_found( key_name = `o` ) ) ).

  endmethod.
  method from_rap.

    "if not found it must mean it's IF_ABAP_BEHV_MESSAGE=>SEVERITY-NONE
    r_val = value #( equivalences[ key r
                                   rap = i_rap ]-ref default unspecified ).

  endmethod.
  method from_val.

    r_val = equivalences[ key v
                          val = i_val ]-ref.

  endmethod.
  method from_xco.

    try.

      r_val = equivalences[ xco = i_xco ]-ref.

    catch cx_sy_itab_line_not_found into final(e).

      if i_exc_if_not_found eq abap_true.

        raise exception e.

      else.

        r_val = unspecified.

      endif.

    endtry.

  endmethod.

endclass.
