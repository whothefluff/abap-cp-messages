"! <p class="shorttext synchronized" lang="EN">System Fields Message</p>
"! Inherits from {@link ZCL_CP_MESSAGE}
class zcl_cp_sy_message definition
                        public
                        create public
                        inheriting from zcl_cp_message.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Creates msg. with SY MSGID, MSGTY, MSGNO, and MSGV1 to MSGV4</p>
    methods constructor.

  protected section.

endclass.
class zcl_cp_sy_message implementation.

  method constructor.

    super->constructor( i_id = sy-msgid
                        i_number = sy-msgno
                        i_type = new zcl_cp_message_type_fty( )->from_old( sy-msgty )
                        i_var1 = sy-msgv1
                        i_var2 = sy-msgv2
                        i_var3 = sy-msgv3
                        i_var4 = sy-msgv4 ).

  endmethod.

endclass.

