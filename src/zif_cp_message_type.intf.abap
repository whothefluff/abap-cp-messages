"! <p class="shorttext synchronized" lang="EN">Message Type</p>
interface zif_cp_message_type public.

  types: begin of enum t_value,
           unspecified,
           information,
           success,
           warning,
           error,
         end of enum t_value.

  "! <p class="shorttext synchronized" lang="EN">Returns the associated type-safe type</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
  methods val
            returning
              value(r_val) type zif_cp_message_type=>t_value.

  "! <p class="shorttext synchronized" lang="EN">Returns the associated classic type</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
  methods old
            returning
              value(r_val) type symsg-msgty.

  "! <p class="shorttext synchronized" lang="EN">Returns the associated type for RAP</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
  methods rap
            returning
              value(r_val) type if_abap_behv_message=>t_severity.

  "! <p class="shorttext synchronized" lang="EN">Returns the associated type for Extended Component Message</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
  methods xco
            returning
              value(r_val) type ref to cl_xco_message_type.

endinterface.
