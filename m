Content-Type: multipart/mixed; boundary="===============8868438842654562480=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] selftests: mptcp: add command
 line arguments for mptcp_join.sh
Date: Sat, 09 Jan 2021 09:51:56 +0800
Message-ID: <CA+WQbwuLSRnODw4tKS3enehTDZU8XX0bidfWRaxJyp_VDeQn4A@mail.gmail.com>
In-Reply-To: ecd1cf39-8a2d-b8d5-7091-dc3297482@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7301

--===============8868438842654562480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2021=E5=B9=B4=
1=E6=9C=889=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=889:25=E5=86=99=E9=
=81=93=EF=BC=9A
>
>
> On Tue, 5 Jan 2021, Geliang Tang wrote:
>
> > Since the mptcp_join script is becoming too big, this patch split it in=
to
> > several smaller trunks, each of them has been defined in a function as a
> > individual test group for several related testcases.
> >
> > Using bash getopts function to parse command line arguments, and involk
> > each function to do the individual test group.
> >
> > Here are all the arguments:
> >  -f subflows_tests
> >  -s signal_address_tests
> >  -l link_failure_tests
> >  -t add_addr_timeout_tests
> >  -r remove_tests
> >  -a add_tests
> >  -6 ipv6_tests
> >  -4 v4mapped_tests
> >  -b backup_tests
> >  -p add_addr_ports_tests
> >  -c syncookies_tests
> >  -h help
> >
> > Run mptcp_join.sh with no argument will do all the testcases.
> >
>
> This seems like a good idea to me, but what patchset(s) do I need to apply
> first?
>

Sorry, here is the commit log with all my patches against
export/20210108T061525:

---

commit 25b58355f5ad79c2a623179060730b6b77d53cb2
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Fri Dec 25 14:16:19 2020 +0800

    selftests: mptcp: add add_addr_urgent testcases

    This patch added the multiple addresses testcases for add_addr_urgent in
    signal_address_tests and add_tests.

    It also set add_addr_urgent sysctl in add_addr_timeout testcase to fix
    the ADD_ADDR timeout issue like this:

     12 signal address, ADD_ADDR timeout syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
                                         add[fail] got 2 ADD_ADDR[s] expect=
ed 4
      - echo  [ ok ]
     Server ns stats
     MPTcpExtMPCapableSYNRX          1              0.0
     MPTcpExtMPCapableACKRX          1              0.0
     MPTcpExtMPJoinSynRx             1              0.0
     MPTcpExtMPJoinAckRx             1              0.0
     Client ns stats
     MPTcpExtMPJoinSynAckRx          1              0.0
     MPTcpExtAddAddr                 2              0.0
     13 remove single subflow            syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
                                         rm [ ok ] - sf    [ ok ]

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit e1638e90d6d18db9cb93ac6187d93c1bfdd97033
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Wed Jan 6 14:53:16 2021 +0800

    mptcp: add urgent status for ADD_ADDR

    This patch added a new status named MPTCP_ADD_ADDR_URGENT in
    mptcp_addr_signal_status. If this status is set, a dedicated ADD_ADDR
    packet also needs to be sent out.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit 2cd573236f30d2fe762f4f7d334a683f2dcf380d
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Fri Dec 25 14:11:27 2020 +0800

    mptcp: add a new sysctl add_addr_urgent

    This patch added a new sysctl named add_addr_urgent, to control whether
    the ADD_ADDR suboption can be sent out immediately in only one round tr=
ip.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit 8212e277a0eb4c767bf6431fba41d3a56769cf00
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Wed Jan 6 14:49:47 2021 +0800

    mptcp: simplify mptcp_pm_nl_add_addr_send_ack debug log

    Print out the debug log of mptcp_pm_nl_add_addr_send_ack in a single li=
ne
    when more than one mptcp_addr_signal_status are set.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit 5d745ca0f9d9132b55563d27abdb204b6627255b
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Wed Jan 6 14:46:56 2021 +0800

    mptcp: add mptcp_pm_should_add_signal_send_ack helper

    This patch added a new helper function named
    mptcp_pm_should_add_signal_send_ack, in it put together all the
    mptcp_addr_signal_status which need to send out a dedicated ADD_ADDR
    packet.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit 3827ba4d862f4195d2d5e490f64525cf37e3e9e3
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Thu Dec 24 13:43:19 2020 +0800

    selftests: mptcp: add command line arguments for mptcp_join.sh

    Since the mptcp_join script is becoming too big, this patch split it in=
to
    several smaller trunks, each of them has been defined in a function as a
    individual test group for several related testcases.

    Using bash getopts function to parse command line arguments, and involk
    each function to do the individual test group.

    Here are all the arguments:
      -f subflows_tests
      -s signal_address_tests
      -l link_failure_tests
      -t add_addr_timeout_tests
      -r remove_tests
      -a add_tests
      -6 ipv6_tests
      -4 v4mapped_tests
      -b backup_tests
      -p add_addr_ports_tests
      -c syncookies_tests
      -h help

    Run mptcp_join.sh with no argument will do all the testcases.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit 1e997dbf540506cc21865c8fc922d971245a6db9
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Fri Dec 11 12:02:20 2020 +0800

    selftests: mptcp: add testcases for ADD_ADDR with port

    This patch added testcases for ADD_ADDR with port and the related MIB
    counters check in chk_add_nr. The output looks like this:

     24 signal address with port           syn[ ok ] - synack[ ok ] - ack[ =
ok ]
                                           add[ ok ] - echo  [ ok ] - pt [ =
ok ]
                                           syn[ ok ] - synack[ ok ] - ack[ =
ok ]
                                           syn[ ok ] - ack   [ ok ]
     25 subflow and signal with port       syn[ ok ] - synack[ ok ] - ack[ =
ok ]
                                           add[ ok ] - echo  [ ok ] - pt [ =
ok ]
                                           syn[ ok ] - synack[ ok ] - ack[ =
ok ]
                                           syn[ ok ] - ack   [ ok ]
     26 remove single address with port    syn[ ok ] - synack[ ok ] - ack[ =
ok ]
                                           add[ ok ] - echo  [ ok ] - pt [ =
ok ]
                                           syn[ ok ] - synack[ ok ] - ack[ =
ok ]
                                           syn[ ok ] - ack   [ ok ]
                                           rm [ ok ] - sf    [ ok ]

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit 7f669efea704be47eb38537ca8909d4756c34d0d
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Thu Dec 24 14:53:25 2020 +0800

    mptcp: add the mibs for ADD_ADDR with port

    This patch added the mibs for ADD_ADDR with port:

    MPTCP_MIB_PORTADD for receiving of the ADD_ADDR suboption with a port
    number.

    MPTCP_MIB_PORTSYNRX, MPTCP_MIB_PORTSYNACKRX, MPTCP_MIB_PORTACKRX, for
    receiving of the MP_JOIN's SYN or SYN/ACK or ACK with a port number whi=
ch
    is different from the msk's port number.

    MPTCP_MIB_MISMATCHPORTSYNRX and MPTCP_MIB_MISMATCHPORTACKRX, for
    receiving a SYN or ACK MP_JOIN with a mismatched port-number.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit e4e8712c5e5b03ce0f9869f081188351d646f261
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Wed Oct 28 22:14:21 2020 +0800

    selftests: mptcp: add port argument for pm_nl_ctl

    This patch added a new argument for pm_nl_ctl tool. We can use it like
    this:

     # pm_nl_ctl add 10.0.2.1 flags signal port 10100
     # pm_nl_ctl dump
     id 1 flags signal 10.0.2.1 10100

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit fbc10581c0e470e93b24981dfafada66b08d8b44
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Wed Oct 28 23:00:34 2020 +0800

    mptcp: deal with MPTCP_PM_ADDR_ATTR_PORT in PM netlink

    This patch added the MPTCP_PM_ADDR_ATTR_PORT filling and parsing in PM
    netlink.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit 9e7157c8f67cdc5f23a28bfe60b98e985ba9fcd3
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Mon Nov 30 18:21:59 2020 +0800

    mptcp: enable use_port when invoke addresses_equal

    When dealing with the addresses list local_addr_list or anno_list, we
    should enable the function addresses_equal's parameter use_port. And
    enable it in address_zero too.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit 2ab3740345b63c9a030425c532c4a961c7ae6c7b
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Thu Dec 24 14:45:54 2020 +0800

    mptcp: add port number check for MP_JOIN

    This patch adds two new helpers, subflow_use_different_sport and
    subflow_use_different_dport, to check whether the subflow's source or
    destination port number is different from the msk's port number. When
    receiving the MP_JOIN's SYN/SYNACK/ACK, we do these port number checks
    and print out the different port numbers.

    And furthermore, when receiving the MP_JOIN's SYN/ACK, we also use a new
    helper mptcp_pm_sport_in_anno_list to check whether this port number is
    announced. If it isn't, we need to abort this connection.

    This patch alse populates the local address's port field in local_addre=
ss.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit da7e1d7f592b0a00110ea55a315a18fda4331359
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Fri Dec 25 16:44:06 2020 +0800

    mptcp: add a new helper subflow_req_create_thmac

    This patch added a new helper named subflow_req_create_thmac, which spl=
it
    from subflow_token_join_request. It initialized subflow_req's local_non=
ce
    and thmac fields, those are the more expensive to populate.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit 4444585cd57ccadfd773e3d0d6c3fecdff7f5509
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Thu Dec 24 14:44:07 2020 +0800

    mptcp: drop unused skb in subflow_token_join_request

    This patch dropped the unused parameter skb in subflow_token_join_reque=
st.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit b63852ca9bdaa1d050b8b026809f43f3de3cf4b2
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Fri Dec 18 23:36:11 2020 +0800

    mptcp: create the listening socket for new port

    This patch created a listening socket when an address with a port-number
    is added by PM netlink. Then binded the new port to the socket, and
    listened for the connection.

    When the address is removed or the addresses are flushed by PM netlink,
    release the listening socket.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit 497a817d7d99b3463fc347cdafc03b843a573662
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Wed Dec 16 17:16:54 2020 +0800

    selftests: mptcp: add testcases for newly added addresses

    This patch added the testcases to create subflows or signal addresses
    for the newly added IPv4 or IPv6 addresses.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit c56c8d8024cc3eac386f5350d0b141ee99e49e0f
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Fri Dec 18 20:52:55 2020 +0800

    selftests: mptcp: use minus values for removing address numbers

    This patch changed the removing addresses numbers to minus values, left=
 the
    plus values for the adding addresses numbers.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit 659881b8bd01a9e1d42490734cc9eaec82c08c89
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Thu Dec 24 14:20:01 2020 +0800

    mptcp: create subflow or signal addr for newly added address

    Currently, when a new MPTCP endpoint is added, the existing MPTCP socke=
ts
    are not affected.

    This patch implemented a new function mptcp_nl_add_subflow_or_signal_ad=
dr,
    invoked when an address is added from PM netlink. This function travers=
ed
    the MPTCP sockets list and invoked mptcp_pm_create_subflow_or_signal_ad=
dr
    to try to create a subflow or signal an address for the newly added
    address, if local constraint allows that.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit b3c73cf0d34a4ff9479aadb763d5bfc71cc10b61
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Thu Dec 24 14:15:25 2020 +0800

    mptcp: drop *_max fields in mptcp_pm_data

    This patch dropped the per-msk values add_addr_signal_max,
    add_addr_accept_max, local_addr_max and subflows_max fields in struct
    mptcp_pm_data, used the pernet *_max values instead. And added four new
    helpers to get the pernet *_max values separately.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit 934040e9277a1ae32db383c43726fd057c7c46f3
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Wed Jan 6 12:12:05 2021 +0800

    mptcp: use WRITE_ONCE/READ_ONCE for the pernet *_max

    This patch used WRITE_ONCE() and READ_ONCE for all the pernet
    add_addr_signal_max, add_addr_accept_max, local_addr_max and
    subflows_max fields in struct pm_nl_pernet.

    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit 371bf6fd38a7c286e3c7459b33283e87ea69ba3f
Author: Geliang Tang <geliangtang(a)gmail.com>
Date:   Sat Dec 19 14:07:00 2020 +0100

    selftests: mptcp: add IPv4-mapped IPv6 testcases

    Here, we make sure we support IPv4-mapped in IPv6 addresses in different
    contexts:

    - a v4-mapped address is received by the PM and can be used as v4.
    - a v4 address is received by the PM and can be used even with a v4
      mapped socket.

    We also make sure we don't try to establish subflows between v4 and v6
    addresses, e.g. if a real v6 address ends with a valid v4 address.

    Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
    Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

commit 7f61fc1295b2b9f445a96d351fb55e25e21247ae
Author: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Date:   Sat Dec 19 14:06:59 2020 +0100

    mptcp: pm nl: support IPv4 mapped in v6 addresses

    On one side, we can allow the creation of subflows between v4 mapped in
    v6 and v4 addresses. For that we look for v4mapped addresses between the
    local address we want to select and the remote one.

    On the other side, we also properly deal with received v4mapped
    addresses, either announced ones or set via Netlink.

    Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
    Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/122
    Co-developed-by: Geliang Tang <geliangtang(a)gmail.com>
    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
    Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

commit ef6cb8147e67a980ea2f3b2c7e792d495cb7889f
Author: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Date:   Sat Dec 19 14:06:58 2020 +0100

    mptcp: support MPJoin with IPv4 mapped in v6 sk

    With an IPv4 mapped in v6 socket, we were trying to call inet6_bind()
    with an IPv4 address resulting in a -EINVAL error because the given
    addr_len -- size of the address structure -- was too short.

    We now make sure to use address structures for the same family as the
    MPTCP socket for both the bind() and the connect(). It means we convert
    v4 addresses to v4 mapped in v6 or the opposite if needed.

    Fixes: ec3edaa7ca6c ("mptcp: Add handling of outgoing MP_JOIN requests")
    Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/122
    Co-developed-by: Geliang Tang <geliangtang(a)gmail.com>
    Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
    Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

(export/20210108T061525)
commit a87127862c21202b8b464ae55397e607ba74a748
Author: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Date:   Fri Jan 8 06:15:40 2021 +0000

    DO-NOT-MERGE: mptcp: enabled by default

    This commit is useful for automated builds, e.g. from Intel's kbuild.

    Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

---

The first three patches (IPv4mapped patchset) should be sent by Matt, I
only added them in the attachment.

Thanks.

-Geliang


>
> Mat
>
>
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> > .../testing/selftests/net/mptcp/mptcp_join.sh | 1068 +++++++++--------
> > 1 file changed, 590 insertions(+), 478 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/te=
sting/selftests/net/mptcp/mptcp_join.sh
> > index f32fa18b4695..540d98243a1e 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -680,6 +680,551 @@ chk_prio_nr()
> >       fi
> > }
> >
> > +subflows_tests()
> > +{
> > +     reset
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "no JOIN" "0" "0" "0"
> > +
> > +     # subflow limited by client
> > +     reset
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "single subflow, limited by client" 0 0 0
> > +
> > +     # subflow limited by server
> > +     reset
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "single subflow, limited by server" 1 1 0
> > +
> > +     # subflow
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "single subflow" 1 1 1
> > +
> > +     # multiple subflows
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "multiple subflows" 2 2 2
> > +
> > +     # multiple subflows limited by serverf
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "multiple subflows, limited by server" 2 2 1
> > +}
> > +
> > +signal_address_tests()
> > +{
> > +     # add_address, unused
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "unused signal address" 0 0 0
> > +     chk_add_nr 1 1
> > +
> > +     # accept and use add_addr
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "signal address" 1 1 1
> > +     chk_add_nr 1 1
> > +
> > +     # accept and use add_addr with an additional subflow
> > +     # note: signal address in server ns and local addresses in client=
 ns must
> > +     # belong to different subnets or one of the listed local address =
could be
> > +     # used for 'add_addr' subflow
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "subflow and signal" 2 2 2
> > +     chk_add_nr 1 1
> > +
> > +     # accept and use add_addr with additional subflows
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 3
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "multiple subflows and signal" 3 3 3
> > +     chk_add_nr 1 1
> > +}
> > +
> > +link_failure_tests()
> > +{
> > +     # accept and use add_addr with additional subflows and link loss
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 3
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1 1
> > +     chk_join_nr "multiple flows, signal, link failure" 3 3 3
> > +     chk_add_nr 1 1
> > +}
> > +
> > +add_addr_timeout_tests()
> > +{
> > +     # add_addr timeout
> > +     reset_with_add_addr_timeout
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +     run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> > +     chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
> > +     chk_add_nr 4 0
> > +
> > +     # add_addr timeout IPv6
> > +     reset_with_add_addr_timeout 6
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +     ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> > +     run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> > +     chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
> > +     chk_add_nr 4 0
> > +}
> > +
> > +remove_tests()
> > +{
> > +     # single subflow, remove
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
> > +     chk_join_nr "remove single subflow" 1 1 1
> > +     chk_rm_nr 1 1
> > +
> > +     # multiple subflows, remove
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
> > +     chk_join_nr "remove multiple subflows" 2 2 2
> > +     chk_rm_nr 2 2
> > +
> > +     # single address, remove
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +     run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
> > +     chk_join_nr "remove single address" 1 1 1
> > +     chk_add_nr 1 1
> > +     chk_rm_nr 0 0
> > +
> > +     # subflow and signal, remove
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
> > +     chk_join_nr "remove subflow and signal" 2 2 2
> > +     chk_add_nr 1 1
> > +     chk_rm_nr 1 1
> > +
> > +     # subflows and signal, remove
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 3
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
> > +     chk_join_nr "remove subflows and signal" 3 3 3
> > +     chk_add_nr 1 1
> > +     chk_rm_nr 2 2
> > +
> > +     # subflows and signal, flush
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 3
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> > +     chk_join_nr "flush subflows and signal" 3 3 3
> > +     chk_add_nr 1 1
> > +     chk_rm_nr 2 2
> > +}
> > +
> > +add_tests()
> > +{
> > +     # add single subflow
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +     run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
> > +     chk_join_nr "add single subflow" 1 1 1
> > +
> > +     # add signal address
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +     run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> > +     chk_join_nr "add signal address" 1 1 1
> > +     chk_add_nr 1 1
> > +
> > +     # add multiple subflows
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > +     run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
> > +     chk_join_nr "add multiple subflows" 2 2 2
> > +
> > +     # add multiple subflows IPv6
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > +     run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
> > +     chk_join_nr "add multiple subflows IPv6" 2 2 2
> > +
> > +     # add multiple addresses IPv6
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 2 2
> > +     run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
> > +     chk_join_nr "add multiple addresses IPv6" 2 2 2
> > +     chk_add_nr 2 2
> > +}
> > +
> > +ipv6_tests()
> > +{
> > +     # subflow IPv6
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
> > +     run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> > +     chk_join_nr "single subflow IPv6" 1 1 1
> > +
> > +     # add_address, unused IPv6
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> > +     run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> > +     chk_join_nr "unused signal address IPv6" 0 0 0
> > +     chk_add_nr 1 1
> > +
> > +     # signal address IPv6
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +     run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> > +     chk_join_nr "single address IPv6" 1 1 1
> > +     chk_add_nr 1 1
> > +
> > +     # single address IPv6, remove
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +     run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
> > +     chk_join_nr "remove single address IPv6" 1 1 1
> > +     chk_add_nr 1 1
> > +     chk_rm_nr 0 0
> > +
> > +     # subflow and signal IPv6, remove
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> > +     ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
> > +     run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
> > +     chk_join_nr "remove subflow and signal IPv6" 2 2 2
> > +     chk_add_nr 1 1
> > +     chk_rm_nr 1 1
> > +}
> > +
> > +v4mapped_tests()
> > +{
> > +     # subflow IPv4-mapped to IPv4-mapped
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
> > +     run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> > +     chk_join_nr "single subflow IPv4-mapped" 1 1 1
> > +
> > +     # signal address IPv4-mapped with IPv4-mapped sk
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +     ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
> > +     run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> > +     chk_join_nr "signal address IPv4-mapped" 1 1 1
> > +     chk_add_nr 1 1
> > +
> > +     # subflow v4-map-v6
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> > +     chk_join_nr "single subflow v4-map-v6" 1 1 1
> > +
> > +     # signal address v4-map-v6
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +     run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> > +     chk_join_nr "signal address v4-map-v6" 1 1 1
> > +     chk_add_nr 1 1
> > +
> > +     # subflow v6-map-v4
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "single subflow v6-map-v4" 1 1 1
> > +
> > +     # signal address v6-map-v4
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +     ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "signal address v6-map-v4" 1 1 1
> > +     chk_add_nr 1 1
> > +
> > +     # no subflow fake IPv4-mapped
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::10.0.3.2 flags su=
bflow
> > +     run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> > +     chk_join_nr "no JOIN with fake IPv4-mapped" 0 0 0
> > +
> > +     # no subflow IPv6 to v4 address
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> > +     chk_join_nr "no JOIN with diff families v4-v6" 0 0 0
> > +
> > +     # no subflow IPv4 to v6 address
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> > +     chk_join_nr "no JOIN with diff families v6-v4" 0 0 0
> > +}
> > +
> > +backup_tests()
> > +{
> > +     # single subflow, backup
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
> > +     run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
> > +     chk_join_nr "single subflow, backup" 1 1 1
> > +     chk_prio_nr 0 1
> > +
> > +     # single address, backup
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +     run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
> > +     chk_join_nr "single address, backup" 1 1 1
> > +     chk_add_nr 1 1
> > +     chk_prio_nr 1 0
> > +}
> > +
> > +add_addr_ports_tests()
> > +{
> > +     # signal address with port
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 101=
00
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "signal address with port" 1 1 1
> > +     chk_add_nr 1 1 1
> > +
> > +     # subflow and signal with port
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 101=
00
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "subflow and signal with port" 2 2 2
> > +     chk_add_nr 1 1 1
> > +
> > +     # single address with port, remove
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 101=
00
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +     run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
> > +     chk_join_nr "remove single address with port" 1 1 1
> > +     chk_add_nr 1 1 1
> > +     chk_rm_nr 0 0
> > +
> > +     # subflow and signal with port, remove
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 101=
00
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
> > +     chk_join_nr "remove subflow and signal with port" 2 2 2
> > +     chk_add_nr 1 1 1
> > +     chk_rm_nr 1 1
> > +
> > +     # subflows and signal with port, flush
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 3
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 101=
00
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> > +     chk_join_nr "flush subflows and signal with port" 3 3 3
> > +     chk_add_nr 1 1
> > +     chk_rm_nr 2 2
> > +
> > +     # multiple addresses with port
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 2 2
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 101=
00
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 101=
00
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 2 2
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "multiple addresses with port" 2 2 2
> > +     chk_add_nr 2 2 2
> > +
> > +     # multiple addresses with ports
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 2 2
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 101=
00
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 101=
01
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 2 2
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "multiple addresses with ports" 2 2 2
> > +     chk_add_nr 2 2 2
> > +}
> > +
> > +syncookies_tests()
> > +{
> > +     # single subflow, syncookies
> > +     reset_with_cookies
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "single subflow with syn cookies" 1 1 1
> > +
> > +     # multiple subflows with syn cookies
> > +     reset_with_cookies
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "multiple subflows with syn cookies" 2 2 2
> > +
> > +     # multiple subflows limited by server
> > +     reset_with_cookies
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "subflows limited by server w cookies" 2 2 1
> > +
> > +     # test signal address with cookies
> > +     reset_with_cookies
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "signal address with syn cookies" 1 1 1
> > +     chk_add_nr 1 1
> > +
> > +     # test cookie with subflow and signal
> > +     reset_with_cookies
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "subflow and signal w cookies" 2 2 2
> > +     chk_add_nr 1 1
> > +
> > +     # accept and use add_addr with additional subflows
> > +     reset_with_cookies
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 0 3
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> > +     run_tests $ns1 $ns2 10.0.1.1
> > +     chk_join_nr "subflows and signal w. cookies" 3 3 3
> > +     chk_add_nr 1 1
> > +}
> > +
> > +all_tests()
> > +{
> > +     subflows_tests
> > +     signal_address_tests
> > +     link_failure_tests
> > +     add_addr_timeout_tests
> > +     remove_tests
> > +     add_tests
> > +     ipv6_tests
> > +     v4mapped_tests
> > +     backup_tests
> > +     add_addr_ports_tests
> > +     syncookies_tests
> > +}
> > +
> > +usage()
> > +{
> > +     echo "mptcp_join usage:"
> > +     echo "  -f subflows_tests"
> > +     echo "  -s signal_address_tests"
> > +     echo "  -l link_failure_tests"
> > +     echo "  -t add_addr_timeout_tests"
> > +     echo "  -r remove_tests"
> > +     echo "  -a add_tests"
> > +     echo "  -6 ipv6_tests"
> > +     echo "  -4 v4mapped_tests"
> > +     echo "  -b backup_tests"
> > +     echo "  -p add_addr_ports_tests"
> > +     echo "  -c syncookies_tests"
> > +     echo "  -h help"
> > +}
> > +
> > sin=3D$(mktemp)
> > sout=3D$(mktemp)
> > cin=3D$(mktemp)
> > @@ -690,483 +1235,50 @@ make_file "$cin" "client" 1
> > make_file "$sin" "server" 1
> > trap cleanup EXIT
> >
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "no JOIN" "0" "0" "0"
> > -
> > -# subflow limted by client
> > -reset
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "single subflow, limited by client" 0 0 0
> > -
> > -# subflow limted by server
> > -reset
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "single subflow, limited by server" 1 1 0
> > -
> > -# subflow
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "single subflow" 1 1 1
> > -
> > -# multiple subflows
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "multiple subflows" 2 2 2
> > -
> > -# multiple subflows limited by serverf
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "multiple subflows, limited by server" 2 2 1
> > -
> > -# add_address, unused
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "unused signal address" 0 0 0
> > -chk_add_nr 1 1
> > -
> > -# accept and use add_addr
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "signal address" 1 1 1
> > -chk_add_nr 1 1
> > -
> > -# accept and use add_addr with an additional subflow
> > -# note: signal address in server ns and local addresses in client ns m=
ust
> > -# belong to different subnets or one of the listed local address could=
 be
> > -# used for 'add_addr' subflow
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "subflow and signal" 2 2 2
> > -chk_add_nr 1 1
> > -
> > -# accept and use add_addr with additional subflows
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 3
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "multiple subflows and signal" 3 3 3
> > -chk_add_nr 1 1
> > -
> > -# accept and use add_addr with additional subflows and link loss
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 3
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1 1
> > -chk_join_nr "multiple flows, signal, link failure" 3 3 3
> > -chk_add_nr 1 1
> > -
> > -# add_addr timeout
> > -reset_with_add_addr_timeout
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> > -chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
> > -chk_add_nr 4 0
> > -
> > -# single subflow, remove
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
> > -chk_join_nr "remove single subflow" 1 1 1
> > -chk_rm_nr 1 1
> > -
> > -# multiple subflows, remove
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
> > -chk_join_nr "remove multiple subflows" 2 2 2
> > -chk_rm_nr 2 2
> > -
> > -# single address, remove
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > -run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
> > -chk_join_nr "remove single address" 1 1 1
> > -chk_add_nr 1 1
> > -chk_rm_nr 0 0
> > -
> > -# subflow and signal, remove
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
> > -chk_join_nr "remove subflow and signal" 2 2 2
> > -chk_add_nr 1 1
> > -chk_rm_nr 1 1
> > -
> > -# subflows and signal, remove
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 3
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
> > -chk_join_nr "remove subflows and signal" 3 3 3
> > -chk_add_nr 1 1
> > -chk_rm_nr 2 2
> > -
> > -# subflows and signal, flush
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 3
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> > -chk_join_nr "flush subflows and signal" 3 3 3
> > -chk_add_nr 1 1
> > -chk_rm_nr 2 2
> > -
> > -# add single subflow
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > -run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
> > -chk_join_nr "add single subflow" 1 1 1
> > -
> > -# add signal address
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > -run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> > -chk_join_nr "add signal address" 1 1 1
> > -chk_add_nr 1 1
> > -
> > -# add multiple subflows
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > -run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
> > -chk_join_nr "add multiple subflows" 2 2 2
> > -
> > -# add multiple subflows IPv6
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > -run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
> > -chk_join_nr "add multiple subflows IPv6" 2 2 2
> > -
> > -# add multiple addresses IPv6
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns2 ./pm_nl_ctl limits 2 2
> > -run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
> > -chk_join_nr "add multiple addresses IPv6" 2 2 2
> > -chk_add_nr 2 2
> > -
> > -# subflow IPv6
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
> > -run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> > -chk_join_nr "single subflow IPv6" 1 1 1
> > -
> > -# add_address, unused IPv6
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> > -run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> > -chk_join_nr "unused signal address IPv6" 0 0 0
> > -chk_add_nr 1 1
> > -
> > -# signal address IPv6
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > -run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> > -chk_join_nr "single address IPv6" 1 1 1
> > -chk_add_nr 1 1
> > -
> > -# add_addr timeout IPv6
> > -reset_with_add_addr_timeout 6
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > -ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> > -run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> > -chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
> > -chk_add_nr 4 0
> > -
> > -# single address IPv6, remove
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > -run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
> > -chk_join_nr "remove single address IPv6" 1 1 1
> > -chk_add_nr 1 1
> > -chk_rm_nr 0 0
> > -
> > -# subflow and signal IPv6, remove
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> > -ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
> > -run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
> > -chk_join_nr "remove subflow and signal IPv6" 2 2 2
> > -chk_add_nr 1 1
> > -chk_rm_nr 1 1
> > -
> > -# subflow IPv4-mapped to IPv4-mapped
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
> > -run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> > -chk_join_nr "single subflow IPv4-mapped" 1 1 1
> > -
> > -# signal address IPv4-mapped with IPv4-mapped sk
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > -ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
> > -run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> > -chk_join_nr "signal address IPv4-mapped" 1 1 1
> > -chk_add_nr 1 1
> > -
> > -# subflow v4-map-v6
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> > -chk_join_nr "single subflow v4-map-v6" 1 1 1
> > -
> > -# signal address v4-map-v6
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> > -chk_join_nr "signal address v4-map-v6" 1 1 1
> > -chk_add_nr 1 1
> > -
> > -# subflow v6-map-v4
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "single subflow v6-map-v4" 1 1 1
> > -
> > -# signal address v6-map-v4
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > -ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "signal address v6-map-v4" 1 1 1
> > -chk_add_nr 1 1
> > -
> > -# no subflow fake IPv4-mapped
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::10.0.3.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> > -chk_join_nr "no JOIN with fake IPv4-mapped" 0 0 0
> > -
> > -# no subflow IPv6 to v4 address
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> > -chk_join_nr "no JOIN with diff families v4-v6" 0 0 0
> > -
> > -# no subflow IPv4 to v6 address
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> > -chk_join_nr "no JOIN with diff families v6-v4" 0 0 0
> > -
> > -# single subflow, backup
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
> > -run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
> > -chk_join_nr "single subflow, backup" 1 1 1
> > -chk_prio_nr 0 1
> > -
> > -# single address, backup
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > -run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
> > -chk_join_nr "single address, backup" 1 1 1
> > -chk_add_nr 1 1
> > -chk_prio_nr 1 0
> > -
> > -# signal address with port
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "signal address with port" 1 1 1
> > -chk_add_nr 1 1 1
> > -
> > -# subflow and signal with port
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "subflow and signal with port" 2 2 2
> > -chk_add_nr 1 1 1
> > -
> > -# single address with port, remove
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > -run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
> > -chk_join_nr "remove single address with port" 1 1 1
> > -chk_add_nr 1 1 1
> > -chk_rm_nr 0 0
> > -
> > -# subflow and signal with port, remove
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
> > -chk_join_nr "remove subflow and signal with port" 2 2 2
> > -chk_add_nr 1 1 1
> > -chk_rm_nr 1 1
> > -
> > -# subflows and signal with port, flush
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 3
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> > -chk_join_nr "flush subflows and signal with port" 3 3 3
> > -chk_add_nr 1 1
> > -chk_rm_nr 2 2
> > -
> > -# multiple addresses with port
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 2 2
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10100
> > -ip netns exec $ns2 ./pm_nl_ctl limits 2 2
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "multiple addresses with port" 2 2 2
> > -chk_add_nr 2 2 2
> > -
> > -# multiple addresses with ports
> > -reset
> > -ip netns exec $ns1 ./pm_nl_ctl limits 2 2
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10101
> > -ip netns exec $ns2 ./pm_nl_ctl limits 2 2
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "multiple addresses with ports" 2 2 2
> > -chk_add_nr 2 2 2
> > -
> > -# single subflow, syncookies
> > -reset_with_cookies
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "single subflow with syn cookies" 1 1 1
> > -
> > -# multiple subflows with syn cookies
> > -reset_with_cookies
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "multiple subflows with syn cookies" 2 2 2
> > -
> > -# multiple subflows limited by server
> > -reset_with_cookies
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "subflows limited by server w cookies" 2 2 1
> > -
> > -# test signal address with cookies
> > -reset_with_cookies
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "signal address with syn cookies" 1 1 1
> > -chk_add_nr 1 1
> > -
> > -# test cookie with subflow and signal
> > -reset_with_cookies
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "subflow and signal w cookies" 2 2 2
> > -chk_add_nr 1 1
> > -
> > -# accept and use add_addr with additional subflows
> > -reset_with_cookies
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 3
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > -ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> > -run_tests $ns1 $ns2 10.0.1.1
> > -chk_join_nr "subflows and signal w. cookies" 3 3 3
> > -chk_add_nr 1 1
> > +if [ -z $1 ]; then
> > +     all_tests
> > +     exit $ret
> > +fi
> > +
> > +while getopts 'fsltra64bpch' opt; do
> > +     case $opt in
> > +             f)
> > +                     subflows_tests
> > +                     ;;
> > +             s)
> > +                     signal_address_tests
> > +                     ;;
> > +             l)
> > +                     link_failure_tests
> > +                     ;;
> > +             t)
> > +                     add_addr_timeout_tests
> > +                     ;;
> > +             r)
> > +                     remove_tests
> > +                     ;;
> > +             a)
> > +                     add_tests
> > +                     ;;
> > +             6)
> > +                     ipv6_tests
> > +                     ;;
> > +             4)
> > +                     v4mapped_tests
> > +                     ;;
> > +             b)
> > +                     backup_tests
> > +                     ;;
> > +             p)
> > +                     add_addr_ports_tests
> > +                     ;;
> > +             c)
> > +                     syncookies_tests
> > +                     ;;
> > +             h | *)
> > +                     usage
> > +                     ;;
> > +     esac
> > +done
> >
> > exit $ret
> > --
> > 2.29.2
> > _______________________________________________
> > mptcp mailing list -- mptcp(a)lists.01.org
> > To unsubscribe send an email to mptcp-leave(a)lists.01.org
> >
>
> --
> Mat Martineau
> Intel

--===============8868438842654562480==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-mptcp-support-MPJoin-with-IPv4-mapped-in-v6-sk.patch"

RnJvbSAzZGVmN2RmZTJlMzI0Mjc4Yzc0NTE0ZDYyNTk1NWNjNjM4ZmM5NTE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXR0aGlldSBCYWVydHMgPG1hdHRoaWV1LmJhZXJ0c0B0ZXNz
YXJlcy5uZXQ+CkRhdGU6IFNhdCwgMTkgRGVjIDIwMjAgMTQ6MDY6NTggKzAxMDAKU3ViamVjdDog
W1BBVENIIDAxLzI3XSBtcHRjcDogc3VwcG9ydCBNUEpvaW4gd2l0aCBJUHY0IG1hcHBlZCBpbiB2
NiBzawoKV2l0aCBhbiBJUHY0IG1hcHBlZCBpbiB2NiBzb2NrZXQsIHdlIHdlcmUgdHJ5aW5nIHRv
IGNhbGwgaW5ldDZfYmluZCgpCndpdGggYW4gSVB2NCBhZGRyZXNzIHJlc3VsdGluZyBpbiBhIC1F
SU5WQUwgZXJyb3IgYmVjYXVzZSB0aGUgZ2l2ZW4KYWRkcl9sZW4gLS0gc2l6ZSBvZiB0aGUgYWRk
cmVzcyBzdHJ1Y3R1cmUgLS0gd2FzIHRvbyBzaG9ydC4KCldlIG5vdyBtYWtlIHN1cmUgdG8gdXNl
IGFkZHJlc3Mgc3RydWN0dXJlcyBmb3IgdGhlIHNhbWUgZmFtaWx5IGFzIHRoZQpNUFRDUCBzb2Nr
ZXQgZm9yIGJvdGggdGhlIGJpbmQoKSBhbmQgdGhlIGNvbm5lY3QoKS4gSXQgbWVhbnMgd2UgY29u
dmVydAp2NCBhZGRyZXNzZXMgdG8gdjQgbWFwcGVkIGluIHY2IG9yIHRoZSBvcHBvc2l0ZSBpZiBu
ZWVkZWQuCgpGaXhlczogZWMzZWRhYTdjYTZjICgibXB0Y3A6IEFkZCBoYW5kbGluZyBvZiBvdXRn
b2luZyBNUF9KT0lOIHJlcXVlc3RzIikKQ2xvc2VzOiBodHRwczovL2dpdGh1Yi5jb20vbXVsdGlw
YXRoLXRjcC9tcHRjcF9uZXQtbmV4dC9pc3N1ZXMvMTIyCkNvLWRldmVsb3BlZC1ieTogR2VsaWFu
ZyBUYW5nIDxnZWxpYW5ndGFuZ0BnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEdlbGlhbmcgVGFu
ZyA8Z2VsaWFuZ3RhbmdAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBNYXR0aGlldSBCYWVydHMg
PG1hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQ+Ci0tLQogbmV0L21wdGNwL3N1YmZsb3cuYyB8
IDI0ICsrKysrKysrKysrKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L21wdGNwL3N1YmZsb3cuYyBi
L25ldC9tcHRjcC9zdWJmbG93LmMKaW5kZXggMjc4Y2JlM2U1MzllLi44ZGM0ZDlmODY3NzMgMTAw
NjQ0Ci0tLSBhL25ldC9tcHRjcC9zdWJmbG93LmMKKysrIGIvbmV0L21wdGNwL3N1YmZsb3cuYwpA
QCAtMTA3NCwyMSArMTA3NCwzMSBAQCB2b2lkIG1wdGNwdjZfaGFuZGxlX21hcHBlZChzdHJ1Y3Qg
c29jayAqc2ssIGJvb2wgbWFwcGVkKQogI2VuZGlmCiAKIHN0YXRpYyB2b2lkIG1wdGNwX2luZm8y
c29ja2FkZHIoY29uc3Qgc3RydWN0IG1wdGNwX2FkZHJfaW5mbyAqaW5mbywKLQkJCQlzdHJ1Y3Qg
c29ja2FkZHJfc3RvcmFnZSAqYWRkcikKKwkJCQlzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSAqYWRk
ciwKKwkJCQl1bnNpZ25lZCBzaG9ydCBmYW1pbHkpCiB7CiAJbWVtc2V0KGFkZHIsIDAsIHNpemVv
ZigqYWRkcikpOwotCWFkZHItPnNzX2ZhbWlseSA9IGluZm8tPmZhbWlseTsKKwlhZGRyLT5zc19m
YW1pbHkgPSBmYW1pbHk7CiAJaWYgKGFkZHItPnNzX2ZhbWlseSA9PSBBRl9JTkVUKSB7CiAJCXN0
cnVjdCBzb2NrYWRkcl9pbiAqaW5fYWRkciA9IChzdHJ1Y3Qgc29ja2FkZHJfaW4gKilhZGRyOwog
Ci0JCWluX2FkZHItPnNpbl9hZGRyID0gaW5mby0+YWRkcjsKKwkJaWYgKGluZm8tPmZhbWlseSA9
PSBBRl9JTkVUKQorCQkJaW5fYWRkci0+c2luX2FkZHIgPSBpbmZvLT5hZGRyOworI2lmIElTX0VO
QUJMRUQoQ09ORklHX01QVENQX0lQVjYpCisJCWVsc2UgaWYgKGlwdjZfYWRkcl92NG1hcHBlZCgm
aW5mby0+YWRkcjYpKQorCQkJaW5fYWRkci0+c2luX2FkZHIuc19hZGRyID0gaW5mby0+YWRkcjYu
czZfYWRkcjMyWzNdOworI2VuZGlmCiAJCWluX2FkZHItPnNpbl9wb3J0ID0gaW5mby0+cG9ydDsK
IAl9CiAjaWYgSVNfRU5BQkxFRChDT05GSUdfTVBUQ1BfSVBWNikKIAllbHNlIGlmIChhZGRyLT5z
c19mYW1pbHkgPT0gQUZfSU5FVDYpIHsKIAkJc3RydWN0IHNvY2thZGRyX2luNiAqaW42X2FkZHIg
PSAoc3RydWN0IHNvY2thZGRyX2luNiAqKWFkZHI7CiAKLQkJaW42X2FkZHItPnNpbjZfYWRkciA9
IGluZm8tPmFkZHI2OworCQlpZiAoaW5mby0+ZmFtaWx5ID09IEFGX0lORVQpCisJCQlpcHY2X2Fk
ZHJfc2V0X3Y0bWFwcGVkKGluZm8tPmFkZHIuc19hZGRyLAorCQkJCQkgICAgICAgJmluNl9hZGRy
LT5zaW42X2FkZHIpOworCQllbHNlCisJCQlpbjZfYWRkci0+c2luNl9hZGRyID0gaW5mby0+YWRk
cjY7CiAJCWluNl9hZGRyLT5zaW42X3BvcnQgPSBpbmZvLT5wb3J0OwogCX0KICNlbmRpZgpAQCAt
MTEzMiwxMSArMTE0MiwxMSBAQCBpbnQgX19tcHRjcF9zdWJmbG93X2Nvbm5lY3Qoc3RydWN0IHNv
Y2sgKnNrLCBjb25zdCBzdHJ1Y3QgbXB0Y3BfYWRkcl9pbmZvICpsb2MsCiAJc3ViZmxvdy0+cmVt
b3RlX2tleSA9IG1zay0+cmVtb3RlX2tleTsKIAlzdWJmbG93LT5sb2NhbF9rZXkgPSBtc2stPmxv
Y2FsX2tleTsKIAlzdWJmbG93LT50b2tlbiA9IG1zay0+dG9rZW47Ci0JbXB0Y3BfaW5mbzJzb2Nr
YWRkcihsb2MsICZhZGRyKTsKKwltcHRjcF9pbmZvMnNvY2thZGRyKGxvYywgJmFkZHIsIHNzay0+
c2tfZmFtaWx5KTsKIAogCWFkZHJsZW4gPSBzaXplb2Yoc3RydWN0IHNvY2thZGRyX2luKTsKICNp
ZiBJU19FTkFCTEVEKENPTkZJR19NUFRDUF9JUFY2KQotCWlmIChsb2MtPmZhbWlseSA9PSBBRl9J
TkVUNikKKwlpZiAoYWRkci5zc19mYW1pbHkgPT0gQUZfSU5FVDYpCiAJCWFkZHJsZW4gPSBzaXpl
b2Yoc3RydWN0IHNvY2thZGRyX2luNik7CiAjZW5kaWYKIAlzc2stPnNrX2JvdW5kX2Rldl9pZiA9
IGxvYy0+aWZpbmRleDsKQEAgLTExNTIsNyArMTE2Miw3IEBAIGludCBfX21wdGNwX3N1YmZsb3df
Y29ubmVjdChzdHJ1Y3Qgc29jayAqc2ssIGNvbnN0IHN0cnVjdCBtcHRjcF9hZGRyX2luZm8gKmxv
YywKIAlzdWJmbG93LT5yZW1vdGVfaWQgPSByZW1vdGVfaWQ7CiAJc3ViZmxvdy0+cmVxdWVzdF9q
b2luID0gMTsKIAlzdWJmbG93LT5yZXF1ZXN0X2JrdXAgPSAhIShsb2MtPmZsYWdzICYgTVBUQ1Bf
UE1fQUREUl9GTEFHX0JBQ0tVUCk7Ci0JbXB0Y3BfaW5mbzJzb2NrYWRkcihyZW1vdGUsICZhZGRy
KTsKKwltcHRjcF9pbmZvMnNvY2thZGRyKHJlbW90ZSwgJmFkZHIsIHNzay0+c2tfZmFtaWx5KTsK
IAogCW1wdGNwX2FkZF9wZW5kaW5nX3N1YmZsb3cobXNrLCBzdWJmbG93KTsKIAllcnIgPSBrZXJu
ZWxfY29ubmVjdChzZiwgKHN0cnVjdCBzb2NrYWRkciAqKSZhZGRyLCBhZGRybGVuLCBPX05PTkJM
T0NLKTsKLS0gCjIuMjkuMgoK

--===============8868438842654562480==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-mptcp-pm-nl-support-IPv4-mapped-in-v6-addresses.patch"

RnJvbSBmMjYzMmZiMDJhNDQ2YmI3YWRiYTFlY2U2N2VjODE2NjI2ZjNjYzFhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXR0aGlldSBCYWVydHMgPG1hdHRoaWV1LmJhZXJ0c0B0ZXNz
YXJlcy5uZXQ+CkRhdGU6IFNhdCwgMTkgRGVjIDIwMjAgMTQ6MDY6NTkgKzAxMDAKU3ViamVjdDog
W1BBVENIIDAyLzI3XSBtcHRjcDogcG0gbmw6IHN1cHBvcnQgSVB2NCBtYXBwZWQgaW4gdjYgYWRk
cmVzc2VzCgpPbiBvbmUgc2lkZSwgd2UgY2FuIGFsbG93IHRoZSBjcmVhdGlvbiBvZiBzdWJmbG93
cyBiZXR3ZWVuIHY0IG1hcHBlZCBpbgp2NiBhbmQgdjQgYWRkcmVzc2VzLiBGb3IgdGhhdCB3ZSBs
b29rIGZvciB2NG1hcHBlZCBhZGRyZXNzZXMgYmV0d2VlbiB0aGUKbG9jYWwgYWRkcmVzcyB3ZSB3
YW50IHRvIHNlbGVjdCBhbmQgdGhlIHJlbW90ZSBvbmUuCgpPbiB0aGUgb3RoZXIgc2lkZSwgd2Ug
YWxzbyBwcm9wZXJseSBkZWFsIHdpdGggcmVjZWl2ZWQgdjRtYXBwZWQKYWRkcmVzc2VzLCBlaXRo
ZXIgYW5ub3VuY2VkIG9uZXMgb3Igc2V0IHZpYSBOZXRsaW5rLgoKRml4ZXM6IDAxY2FjYjAwYjM1
YyAoIm1wdGNwOiBhZGQgbmV0bGluay1iYXNlZCBQTSIpCkNsb3NlczogaHR0cHM6Ly9naXRodWIu
Y29tL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvaXNzdWVzLzEyMgpDby1kZXZlbG9wZWQt
Ynk6IEdlbGlhbmcgVGFuZyA8Z2VsaWFuZ3RhbmdAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBH
ZWxpYW5nIFRhbmcgPGdlbGlhbmd0YW5nQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogTWF0dGhp
ZXUgQmFlcnRzIDxtYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0PgotLS0KIG5ldC9tcHRjcC9w
bV9uZXRsaW5rLmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL25ldC9tcHRjcC9wbV9uZXRsaW5rLmMgYi9uZXQvbXB0Y3AvcG1fbmV0bGluay5jCmlu
ZGV4IDliMWY2Mjk4YmJkYi4uY2M5OTQxMGFjYTg5IDEwMDY0NAotLS0gYS9uZXQvbXB0Y3AvcG1f
bmV0bGluay5jCisrKyBiL25ldC9tcHRjcC9wbV9uZXRsaW5rLmMKQEAgLTYwLDE1ICs2MCwyMCBA
QCBzdGF0aWMgYm9vbCBhZGRyZXNzZXNfZXF1YWwoY29uc3Qgc3RydWN0IG1wdGNwX2FkZHJfaW5m
byAqYSwKIHsKIAlib29sIGFkZHJfZXF1YWxzID0gZmFsc2U7CiAKLQlpZiAoYS0+ZmFtaWx5ICE9
IGItPmZhbWlseSkKLQkJcmV0dXJuIGZhbHNlOwotCi0JaWYgKGEtPmZhbWlseSA9PSBBRl9JTkVU
KQotCQlhZGRyX2VxdWFscyA9IGEtPmFkZHIuc19hZGRyID09IGItPmFkZHIuc19hZGRyOworCWlm
IChhLT5mYW1pbHkgPT0gYi0+ZmFtaWx5KSB7CisJCWlmIChhLT5mYW1pbHkgPT0gQUZfSU5FVCkK
KwkJCWFkZHJfZXF1YWxzID0gYS0+YWRkci5zX2FkZHIgPT0gYi0+YWRkci5zX2FkZHI7CiAjaWYg
SVNfRU5BQkxFRChDT05GSUdfTVBUQ1BfSVBWNikKLQllbHNlCi0JCWFkZHJfZXF1YWxzID0gIWlw
djZfYWRkcl9jbXAoJmEtPmFkZHI2LCAmYi0+YWRkcjYpOworCQllbHNlCisJCQlhZGRyX2VxdWFs
cyA9ICFpcHY2X2FkZHJfY21wKCZhLT5hZGRyNiwgJmItPmFkZHI2KTsKKwl9IGVsc2UgaWYgKGEt
PmZhbWlseSA9PSBBRl9JTkVUKSB7CisJCWlmIChpcHY2X2FkZHJfdjRtYXBwZWQoJmItPmFkZHI2
KSkKKwkJCWFkZHJfZXF1YWxzID0gYS0+YWRkci5zX2FkZHIgPT0gYi0+YWRkcjYuczZfYWRkcjMy
WzNdOworCX0gZWxzZSBpZiAoYi0+ZmFtaWx5ID09IEFGX0lORVQpIHsKKwkJaWYgKGlwdjZfYWRk
cl92NG1hcHBlZCgmYS0+YWRkcjYpKQorCQkJYWRkcl9lcXVhbHMgPSBhLT5hZGRyNi5zNl9hZGRy
MzJbM10gPT0gYi0+YWRkci5zX2FkZHI7CiAjZW5kaWYKKwl9CiAKIAlpZiAoIWFkZHJfZXF1YWxz
KQogCQlyZXR1cm4gZmFsc2U7CkBAIC0xMzMsMTAgKzEzOCwxMiBAQCBzdGF0aWMgYm9vbCBsb29r
dXBfc3ViZmxvd19ieV9zYWRkcihjb25zdCBzdHJ1Y3QgbGlzdF9oZWFkICpsaXN0LAogfQogCiBz
dGF0aWMgc3RydWN0IG1wdGNwX3BtX2FkZHJfZW50cnkgKgotc2VsZWN0X2xvY2FsX2FkZHJlc3Mo
Y29uc3Qgc3RydWN0IHBtX25sX3Blcm5ldCAqcGVybmV0LAotCQkgICAgIHN0cnVjdCBtcHRjcF9z
b2NrICptc2spCitzZWxlY3RfbG9jYWxfYWRkcmVzcyhjb25zdCBzdHJ1Y3QgcG1fbmxfcGVybmV0
ICpwZXJuZXQsIHN0cnVjdCBtcHRjcF9zb2NrICptc2spCiB7CiAJc3RydWN0IG1wdGNwX3BtX2Fk
ZHJfZW50cnkgKmVudHJ5LCAqcmV0ID0gTlVMTDsKKwlzdHJ1Y3QgbXB0Y3BfYWRkcl9pbmZvIHJl
bW90ZSA9IHsgMCB9OworCisJcmVtb3RlX2FkZHJlc3MoKHN0cnVjdCBzb2NrX2NvbW1vbiAqKW1z
aywgJnJlbW90ZSk7CiAKIAlyY3VfcmVhZF9sb2NrKCk7CiAJX19tcHRjcF9mbHVzaF9qb2luX2xp
c3QobXNrKTsKQEAgLTE0NCwxMSArMTUxLDIwIEBAIHNlbGVjdF9sb2NhbF9hZGRyZXNzKGNvbnN0
IHN0cnVjdCBwbV9ubF9wZXJuZXQgKnBlcm5ldCwKIAkJaWYgKCEoZW50cnktPmFkZHIuZmxhZ3Mg
JiBNUFRDUF9QTV9BRERSX0ZMQUdfU1VCRkxPVykpCiAJCQljb250aW51ZTsKIAorCQlpZiAoZW50
cnktPmFkZHIuZmFtaWx5ICE9IHJlbW90ZS5mYW1pbHkpIHsKKyNpZiBJU19FTkFCTEVEKENPTkZJ
R19NUFRDUF9JUFY2KQorCQkJaWYgKChlbnRyeS0+YWRkci5mYW1pbHkgPT0gQUZfSU5FVCAmJgor
CQkJICAgICAhaXB2Nl9hZGRyX3Y0bWFwcGVkKCZyZW1vdGUuYWRkcjYpKSB8fAorCQkJICAgIChy
ZW1vdGUuZmFtaWx5ID09IEFGX0lORVQgJiYKKwkJCSAgICAgIWlwdjZfYWRkcl92NG1hcHBlZCgm
ZW50cnktPmFkZHIuYWRkcjYpKSkKKyNlbmRpZgorCQkJCWNvbnRpbnVlOworCQl9CisKIAkJLyog
YXZvaWQgYW55IGFkZHJlc3MgYWxyZWFkeSBpbiB1c2UgYnkgc3ViZmxvd3MgYW5kCiAJCSAqIHBl
bmRpbmcgam9pbgogCQkgKi8KLQkJaWYgKGVudHJ5LT5hZGRyLmZhbWlseSA9PSAoKHN0cnVjdCBz
b2NrICopbXNrKS0+c2tfZmFtaWx5ICYmCi0JCSAgICAhbG9va3VwX3N1YmZsb3dfYnlfc2FkZHIo
Jm1zay0+Y29ubl9saXN0LCAmZW50cnktPmFkZHIpKSB7CisJCWlmICghbG9va3VwX3N1YmZsb3df
Ynlfc2FkZHIoJm1zay0+Y29ubl9saXN0LCAmZW50cnktPmFkZHIpKSB7CiAJCQlyZXQgPSBlbnRy
eTsKIAkJCWJyZWFrOwogCQl9Ci0tIAoyLjI5LjIKCg==

--===============8868438842654562480==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0003-selftests-mptcp-add-IPv4-mapped-IPv6-testcases.patch"

RnJvbSBiNzcwY2M0MTUwMjRmMGFiZDY1MTRiOTBjZTMzODA2MGNjM2NiOGJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHZWxpYW5nIFRhbmcgPGdlbGlhbmd0YW5nQGdtYWlsLmNvbT4K
RGF0ZTogU2F0LCAxOSBEZWMgMjAyMCAxNDowNzowMCArMDEwMApTdWJqZWN0OiBbUEFUQ0ggMDMv
MjddIHNlbGZ0ZXN0czogbXB0Y3A6IGFkZCBJUHY0LW1hcHBlZCBJUHY2IHRlc3RjYXNlcwoKSGVy
ZSwgd2UgbWFrZSBzdXJlIHdlIHN1cHBvcnQgSVB2NC1tYXBwZWQgaW4gSVB2NiBhZGRyZXNzZXMg
aW4gZGlmZmVyZW50CmNvbnRleHRzOgoKLSBhIHY0LW1hcHBlZCBhZGRyZXNzIGlzIHJlY2VpdmVk
IGJ5IHRoZSBQTSBhbmQgY2FuIGJlIHVzZWQgYXMgdjQuCi0gYSB2NCBhZGRyZXNzIGlzIHJlY2Vp
dmVkIGJ5IHRoZSBQTSBhbmQgY2FuIGJlIHVzZWQgZXZlbiB3aXRoIGEgdjQKICBtYXBwZWQgc29j
a2V0LgoKV2UgYWxzbyBtYWtlIHN1cmUgd2UgZG9uJ3QgdHJ5IHRvIGVzdGFibGlzaCBzdWJmbG93
cyBiZXR3ZWVuIHY0IGFuZCB2NgphZGRyZXNzZXMsIGUuZy4gaWYgYSByZWFsIHY2IGFkZHJlc3Mg
ZW5kcyB3aXRoIGEgdmFsaWQgdjQgYWRkcmVzcy4KCkNvLWRldmVsb3BlZC1ieTogTWF0dGhpZXUg
QmFlcnRzIDxtYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0PgpTaWduZWQtb2ZmLWJ5OiBNYXR0
aGlldSBCYWVydHMgPG1hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQ+ClNpZ25lZC1vZmYtYnk6
IEdlbGlhbmcgVGFuZyA8Z2VsaWFuZ3RhbmdAZ21haWwuY29tPgotLS0KIC4uLi90ZXN0aW5nL3Nl
bGZ0ZXN0cy9uZXQvbXB0Y3AvbXB0Y3Bfam9pbi5zaCB8IDc1ICsrKysrKysrKysrKysrKysrKysK
IDEgZmlsZSBjaGFuZ2VkLCA3NSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21wdGNwX2pvaW4uc2ggYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9uZXQvbXB0Y3AvbXB0Y3Bfam9pbi5zaAppbmRleCBmNzRjZDk5M2IxNjguLjhkMjBh
OGE4MTEyOCAxMDA3NTUKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21w
dGNwX2pvaW4uc2gKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21wdGNw
X2pvaW4uc2gKQEAgLTc5MCw2ICs3OTAsODEgQEAgY2hrX2pvaW5fbnIgInJlbW92ZSBzdWJmbG93
IGFuZCBzaWduYWwgSVB2NiIgMiAyIDIKIGNoa19hZGRfbnIgMSAxCiBjaGtfcm1fbnIgMSAxCiAK
KyMgc3ViZmxvdyBJUHY0LW1hcHBlZCB0byBJUHY0LW1hcHBlZAorcmVzZXQKK2lwIG5ldG5zIGV4
ZWMgJG5zMSAuL3BtX25sX2N0bCBsaW1pdHMgMCAxCitpcCBuZXRucyBleGVjICRuczIgLi9wbV9u
bF9jdGwgbGltaXRzIDAgMQoraXAgbmV0bnMgZXhlYyAkbnMyIC4vcG1fbmxfY3RsIGFkZCAiOjpm
ZmZmOjEwLjAuMy4yIiBmbGFncyBzdWJmbG93CitydW5fdGVzdHMgJG5zMSAkbnMyICI6OmZmZmY6
MTAuMC4xLjEiCitjaGtfam9pbl9uciAic2luZ2xlIHN1YmZsb3cgSVB2NC1tYXBwZWQiIDEgMSAx
CisKKyMgc2lnbmFsIGFkZHJlc3MgSVB2NC1tYXBwZWQgd2l0aCBJUHY0LW1hcHBlZCBzaworcmVz
ZXQKK2lwIG5ldG5zIGV4ZWMgJG5zMSAuL3BtX25sX2N0bCBsaW1pdHMgMCAxCitpcCBuZXRucyBl
eGVjICRuczIgLi9wbV9ubF9jdGwgbGltaXRzIDEgMQoraXAgbmV0bnMgZXhlYyAkbnMxIC4vcG1f
bmxfY3RsIGFkZCAiOjpmZmZmOjEwLjAuMi4xIiBmbGFncyBzaWduYWwKK3J1bl90ZXN0cyAkbnMx
ICRuczIgIjo6ZmZmZjoxMC4wLjEuMSIKK2Noa19qb2luX25yICJzaWduYWwgYWRkcmVzcyBJUHY0
LW1hcHBlZCIgMSAxIDEKK2Noa19hZGRfbnIgMSAxCisKKyMgc3ViZmxvdyB2NC1tYXAtdjYKK3Jl
c2V0CitpcCBuZXRucyBleGVjICRuczEgLi9wbV9ubF9jdGwgbGltaXRzIDAgMQoraXAgbmV0bnMg
ZXhlYyAkbnMyIC4vcG1fbmxfY3RsIGxpbWl0cyAwIDEKK2lwIG5ldG5zIGV4ZWMgJG5zMiAuL3Bt
X25sX2N0bCBhZGQgMTAuMC4zLjIgZmxhZ3Mgc3ViZmxvdworcnVuX3Rlc3RzICRuczEgJG5zMiAi
OjpmZmZmOjEwLjAuMS4xIgorY2hrX2pvaW5fbnIgInNpbmdsZSBzdWJmbG93IHY0LW1hcC12NiIg
MSAxIDEKKworIyBzaWduYWwgYWRkcmVzcyB2NC1tYXAtdjYKK3Jlc2V0CitpcCBuZXRucyBleGVj
ICRuczEgLi9wbV9ubF9jdGwgbGltaXRzIDAgMQoraXAgbmV0bnMgZXhlYyAkbnMyIC4vcG1fbmxf
Y3RsIGxpbWl0cyAxIDEKK2lwIG5ldG5zIGV4ZWMgJG5zMSAuL3BtX25sX2N0bCBhZGQgMTAuMC4y
LjEgZmxhZ3Mgc2lnbmFsCitydW5fdGVzdHMgJG5zMSAkbnMyICI6OmZmZmY6MTAuMC4xLjEiCitj
aGtfam9pbl9uciAic2lnbmFsIGFkZHJlc3MgdjQtbWFwLXY2IiAxIDEgMQorY2hrX2FkZF9uciAx
IDEKKworIyBzdWJmbG93IHY2LW1hcC12NAorcmVzZXQKK2lwIG5ldG5zIGV4ZWMgJG5zMSAuL3Bt
X25sX2N0bCBsaW1pdHMgMCAxCitpcCBuZXRucyBleGVjICRuczIgLi9wbV9ubF9jdGwgbGltaXRz
IDAgMQoraXAgbmV0bnMgZXhlYyAkbnMyIC4vcG1fbmxfY3RsIGFkZCAiOjpmZmZmOjEwLjAuMy4y
IiBmbGFncyBzdWJmbG93CitydW5fdGVzdHMgJG5zMSAkbnMyIDEwLjAuMS4xCitjaGtfam9pbl9u
ciAic2luZ2xlIHN1YmZsb3cgdjYtbWFwLXY0IiAxIDEgMQorCisjIHNpZ25hbCBhZGRyZXNzIHY2
LW1hcC12NAorcmVzZXQKK2lwIG5ldG5zIGV4ZWMgJG5zMSAuL3BtX25sX2N0bCBsaW1pdHMgMCAx
CitpcCBuZXRucyBleGVjICRuczIgLi9wbV9ubF9jdGwgbGltaXRzIDEgMQoraXAgbmV0bnMgZXhl
YyAkbnMxIC4vcG1fbmxfY3RsIGFkZCAiOjpmZmZmOjEwLjAuMi4xIiBmbGFncyBzaWduYWwKK3J1
bl90ZXN0cyAkbnMxICRuczIgMTAuMC4xLjEKK2Noa19qb2luX25yICJzaWduYWwgYWRkcmVzcyB2
Ni1tYXAtdjQiIDEgMSAxCitjaGtfYWRkX25yIDEgMQorCisjIG5vIHN1YmZsb3cgZmFrZSBJUHY0
LW1hcHBlZAorcmVzZXQKK2lwIG5ldG5zIGV4ZWMgJG5zMSAuL3BtX25sX2N0bCBsaW1pdHMgMCAx
CitpcCBuZXRucyBleGVjICRuczIgLi9wbV9ubF9jdGwgbGltaXRzIDAgMQoraXAgbmV0bnMgZXhl
YyAkbnMyIC4vcG1fbmxfY3RsIGFkZCBkZWFkOmJlZWY6Mjo6MTAuMC4zLjIgZmxhZ3Mgc3ViZmxv
dworcnVuX3Rlc3RzICRuczEgJG5zMiAxMC4wLjEuMSAwIDAgMCBzbG93CitjaGtfam9pbl9uciAi
bm8gSk9JTiB3aXRoIGZha2UgSVB2NC1tYXBwZWQiIDAgMCAwCisKKyMgbm8gc3ViZmxvdyBJUHY2
IHRvIHY0IGFkZHJlc3MKK3Jlc2V0CitpcCBuZXRucyBleGVjICRuczEgLi9wbV9ubF9jdGwgbGlt
aXRzIDAgMQoraXAgbmV0bnMgZXhlYyAkbnMyIC4vcG1fbmxfY3RsIGxpbWl0cyAwIDEKK2lwIG5l
dG5zIGV4ZWMgJG5zMiAuL3BtX25sX2N0bCBhZGQgZGVhZDpiZWVmOjM6OjIgZmxhZ3Mgc3ViZmxv
dworcnVuX3Rlc3RzICRuczEgJG5zMiAxMC4wLjEuMSAwIDAgMCBzbG93CitjaGtfam9pbl9uciAi
bm8gSk9JTiB3aXRoIGRpZmYgZmFtaWxpZXMgdjQtdjYiIDAgMCAwCisKKyMgbm8gc3ViZmxvdyBJ
UHY0IHRvIHY2IGFkZHJlc3MKK3Jlc2V0CitpcCBuZXRucyBleGVjICRuczEgLi9wbV9ubF9jdGwg
bGltaXRzIDAgMQoraXAgbmV0bnMgZXhlYyAkbnMyIC4vcG1fbmxfY3RsIGxpbWl0cyAwIDEKK2lw
IG5ldG5zIGV4ZWMgJG5zMiAuL3BtX25sX2N0bCBhZGQgMTAuMC4zLjIgZmxhZ3Mgc3ViZmxvdwor
cnVuX3Rlc3RzICRuczEgJG5zMiBkZWFkOmJlZWY6MTo6MSAwIDAgMCBzbG93CitjaGtfam9pbl9u
ciAibm8gSk9JTiB3aXRoIGRpZmYgZmFtaWxpZXMgdjYtdjQiIDAgMCAwCisKICMgc2luZ2xlIHN1
YmZsb3csIGJhY2t1cAogcmVzZXQKIGlwIG5ldG5zIGV4ZWMgJG5zMSAuL3BtX25sX2N0bCBsaW1p
dHMgMCAxCi0tIAoyLjI5LjIKCg==

--===============8868438842654562480==--
