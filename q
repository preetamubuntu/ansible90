> ANSIBLE.POSIX.FIREWALLD    (/usr/lib/python3/dist-packages/ansible_collections/ansible/posix/plugins/modules/firewalld.py)

        This module allows for addition or deletion of services and ports (either TCP or UDP) in
        either running or permanent firewalld rules.

OPTIONS (= is mandatory):

- icmp_block
        The ICMP block you would like to add/remove to/from a zone in firewalld.
        default: null
        type: str

- icmp_block_inversion
        Enable/Disable inversion of ICMP blocks for a zone in firewalld.
        default: null
        type: str

- immediate
        Should this configuration be applied immediately, if set as permanent.
        default: false
        type: bool

- interface
        The interface you would like to add/remove to/from a zone in firewalld.
        default: null
        type: str

- masquerade
        The masquerade setting you would like to enable/disable to/from zones within firewalld.
        default: null
        type: str

- offline
        Whether to run this module even when firewalld is offline.
        default: null
        type: bool

- permanent
        Should this configuration be in the running firewalld configuration or persist across
        reboots.
        As of Ansible 2.3, permanent operations can operate on firewalld configs when it is not
        running (requires firewalld >= 0.3.9).
        Note that if this is `false', immediate is assumed `true'.
        default: null
        type: bool

- port
        Name of a port or port range to add/remove to/from firewalld.
        Must be in the form PORT/PROTOCOL or PORT-PORT/PROTOCOL for port ranges.
        default: null
        type: str

- port_forward
        Port and protocol to forward using firewalld.
        default: null
        elements: dict
        type: list

        SUBOPTIONS:

        = port
            Source port to forward from
            type: str

        = proto
            protocol to forward
            choices: [udp, tcp]
            type: str

        - toaddr
            Optional address to forward to
            default: null
            type: str

        = toport
            destination port
            type: str

- rich_rule
        Rich rule to add/remove to/from firewalld.
        See Syntax for firewalld rich language rules <https://firewalld.org/documentation/man-
        pages/firewalld.richlanguage.html>.
        default: null
        type: str

- service
        Name of a service to add/remove to/from firewalld.
        The service must be listed in output of firewall-cmd --get-services.
        default: null
        type: str

- source
        The source/network you would like to add/remove to/from firewalld.
        default: null
        type: str

= state
        Enable or disable a setting.
        For ports: Should this port accept (enabled) or reject (disabled) connections.
        The states `present' and `absent' can only be used in zone level operations (i.e. when no
        other parameters but zone and state are set).
        choices: [absent, disabled, enabled, present]
        type: str

- target
        firewalld Zone target
        If state is set to `absent', this will reset the target to default
        choices: [default, ACCEPT, DROP, '%%REJECT%%']
        default: null
        type: str
        added in: version 1.2.0 of ansible.posix


- timeout
        The amount of time in seconds the rule should be in effect for when non-permanent.
        default: 0
        type: int

- zone
        The firewalld zone to add/remove to/from.
        Note that the default zone can be configured per system but `public' is default from
        upstream.
        Available choices can be extended based on per-system configs, listed here are "out of the
        box" defaults.
        Possible values include `block', `dmz', `drop', `external', `home', `internal', `public',
        `trusted', `work'.
        default: null
        type: str


NOTES:
      * Not tested on any Debian based system.
      * Requires the python2 bindings of firewalld, which may not be installed by default.
      * For distributions where the python2 firewalld bindings are unavailable (e.g Fedora 28
        and later) you will have to set the ansible_python_interpreter for these hosts to the
        python3 interpreter path and install the python3 bindings.
      * Zone transactions (creating, deleting) can be performed by using only the zone and
        state parameters "present" or "absent". Note that zone transactions must explicitly be
        permanent. This is a limitation in firewalld. This also means that you will have to
        reload firewalld after adding a zone that you wish to perform immediate actions on. The
        module will not take care of this for you implicitly because that would undo any
        previously performed immediate actions which were not permanent. Therefore, if you
        require immediate access to a newly created zone it is recommended you reload firewalld
        immediately after the zone creation returns with a changed state and before you perform
        any other immediate, non-permanent actions on that zone.
      * This module needs `python-firewall' or `python3-firewall' on managed nodes. It is
        usually provided as a subset with `firewalld' from the OS distributor for the OS
        default Python interpreter.


REQUIREMENTS:  firewalld >= 0.2.11, python-firewall >= 0.2.11

AUTHOR: Adam Miller (@maxamillion)

EXAMPLES:

- name: permit traffic in default zone for https service
  ansible.posix.firewalld:
    service: https
    permanent: true
    state: enabled

- name: do not permit traffic in default zone on port 8081/tcp
  ansible.posix.firewalld:
    port: 8081/tcp
    permanent: true
    state: disabled

- ansible.posix.firewalld:
    port: 161-162/udp
    permanent: true
    state: enabled

- ansible.posix.firewalld:
    zone: dmz
    service: http
    permanent: true
    state: enabled

- ansible.posix.firewalld:
    rich_rule: rule service name="ftp" audit limit value="1/m" accept
    permanent: true
    state: enabled

- ansible.posix.firewalld:
    source: 192.0.2.0/24
    zone: internal
    state: enabled

- ansible.posix.firewalld:
    zone: trusted
    interface: eth2
    permanent: true
    state: enabled

- ansible.posix.firewalld:
    masquerade: true
    state: enabled
    permanent: true
    zone: dmz

- ansible.posix.firewalld:
    zone: custom
    state: present
    permanent: true

- ansible.posix.firewalld:
    zone: drop
    state: enabled
    permanent: true
    icmp_block_inversion: true

- ansible.posix.firewalld:
    zone: drop
    state: enabled
    permanent: true
    icmp_block: echo-request

- ansible.posix.firewalld:
    zone: internal
    state: present
    permanent: true
    target: ACCEPT

- name: Redirect port 443 to 8443 with Rich Rule
  ansible.posix.firewalld:
    rich_rule: rule family=ipv4 forward-port port=443 protocol=tcp to-port=8443
    zone: public
    permanent: true
    immediate: true
    state: enabled

