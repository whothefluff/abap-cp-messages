"! <p class="shorttext synchronized" lang="EN">Message</p>
"! Typing using the standard interfaces {@link if_message} and {@link if_xco_news} is generally preferable
"! to using this interface, as they will provide more flexibility
interface zif_cp_message public.

  interfaces: if_abap_behv_message,
              if_xco_message.

  types t_variables type symsg.

  "! <p class="shorttext synchronized" lang="EN">Returns this message's type</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Message type</p>
  methods type
            returning
              value(r_val) type ref to zif_cp_message_type.

  "! <p class="shorttext synchronized" lang="EN">Returns this message's variables</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Classic message variables</p>
  methods variables
            returning
              value(r_val) type zif_cp_message=>t_variables.

  "! <p class="shorttext synchronized" lang="EN">Returns this message's content</p>
  "! Same as <strong>MESSAGE... INTO</strong>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Message text</p>
  methods content
            returning
              value(r_val) type string.

  "! <p class="shorttext synchronized" lang="EN">Returns this message's long text, if it exists</p>
  "! Only relevant for messages from message classes that are not "self-explanatory"
  "!
  "! @parameter i_preserving_line_breaks | <p class="shorttext synchronized" lang="EN">When false, line breaks are replaced by spaces</p>
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Long text or empty</p>
  methods long_text
            importing
              i_preserving_line_breaks type xsdboolean default abap_false
            returning
              value(r_val) type string.

endinterface.
