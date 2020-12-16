Content-Type: multipart/mixed; boundary="===============3070698408627316888=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 10th of December 2020
Date: Wed, 16 Dec 2020 11:04:42 +0800
Message-ID: <20201216030442.GA13980@MiBook>
In-Reply-To: 7028988d-259f-fc99-4da2-5939c7720e90@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7180

--===============3070698408627316888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On Thu, Dec 10, 2020 at 08:36:40PM +0100, Matthieu Baerts wrote:
> Hello everyone,
> =

> Today, we had our 128th meeting with Mat and Ossama (Intel), Christoph
> (Apple), Davide, Paolo and Florian (RedHat) and myself (Tessares).
> =

> Thanks again for this new good meeting!
> =

> Here are the minutes of the meeting:
> =

> =

> =

> Accepted patches:
>     - The list of accepted patches can be seen on PatchWork:
>       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3
> =

>     netdev (if mptcp ML is in cc) (Geliang Tang, Mat Martineau, Paolo
> Abeni):
> =

> 1413736  [net-next,11/11] mptcp: use the variable sk instead of open-codi=
ng
> 1413735  [net-next,10/11] mptcp: rename add_addr_signal and
> mptcp_add_addr_sta...
> 1413734  [net-next,09/11] mptcp: drop rm_addr_signal flag
> 1413733  [net-next,08/11] mptcp: print out port and ahmac when receiving
> ADD_A...
> 1413732  [net-next,07/11] mptcp: add port parameter for
> mptcp_pm_announce_addr
> 1413731  [net-next,06/11] mptcp: send out dedicated packet for ADD_ADDR
> using ...
> 1413730  [net-next,05/11] mptcp: add the outgoing ADD_ADDR port support
> 1413729  [net-next,04/11] mptcp: use adding up size to get ADD_ADDR length
> 1413728  [net-next,03/11] mptcp: add port support for ADD_ADDR suboption
> writi...
> 1413726  [net-next,02/11] mptcp: unify ADD_ADDR and ADD_ADDR6 suboptions
> writi...
> 1413727  [net-next,01/11] mptcp: unify ADD_ADDR and echo suboptions writi=
ng
> 1413338  [net-next,3/3] mptcp: be careful on subflows shutdown
> 1413337  [net-next,2/3] mptcp: plug subflow context memory leak
> 1413336  [net-next,1/3] mptcp: link MPC subflow into msk only after accept
> =

> =

>     our repo (by: Geliang Tang, Paolo Abeni):
> =

> 1413552  [mptcp-next] mptcp: push pending frames when subflow has free sp=
ace
> 1411918  [mptcp-next] Squash to "mptcp: parse and act on incoming FASTCLO=
SE
> op...
> 1410977  [mptcp-next] mptcp: plug subflow context memory leak
> 1410476  [net-next] mptcp: pm: simplify select_local_address()
> 1410365  [mptcp-next] mptcp: link MPC subflow into msk only after accept
> 1409493  [mptcp-next] mptcp: use MPTCPOPT_HMAC_LEN macro
> 1409483  [mptcp-next] Squash to "mptcp: use adding up size to get ADD_ADDR
> len...
> 1408049  [v2,mptcp-next,2/2] selftests: mptcp: add the flush addrs testca=
se
> 1408047  [v2,mptcp-next,1/2] mptcp: remove address when netlink flush add=
rs
> 1406751  [v3] mptcp: let MPTCP create max size skbs
> =

> =

> =

> Pending patches:
>     - The list of pending patches can be seen on PatchWork:
>       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*
> =

>     netdev (if mptcp ML is in cc) (by: /):
> =

> /
> =

>     our repo (by: Florian Westphal, Geliang Tang, Paolo Abeni):
> =

> 1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
> 1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets
> 1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support
> 1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
> 1395131: RFC: [3/5] mptcp: add mptcp reset option support
> 1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket with
> unread data:
>     - Any to drop? Replaced by other ones?
>     - WIP
> =

> 1408030: Changes Requested: [v7,mptcp-next,1/7] mptcp: create the listeni=
ng
> socket for new port
> 1408031: Changes Requested: [v7,mptcp-next,2/7] mptcp: add port number ch=
eck
> for MP_JOIN
> 1408032: Changes Requested: [v7,mptcp-next,3/7] mptcp: add port number
> announced check
> 1408033: Changes Requested: [v7,mptcp-next,4/7] mptcp: deal with
> MPTCP_PM_ADDR_ATTR_PORT in PM netlink
> 1408034: Changes Requested: [v7,mptcp-next,5/7] selftests: mptcp: add port
> argument for pm_nl_ctl
> 1408035: Changes Requested: [v7,mptcp-next,6/7] mptcp: add the mibs for
> ADD_ADDR with port
> 1408036: Changes Requested: [v7,mptcp-next,7/7] selftests: mptcp: add
> testcases for ADD_ADDR with port
> 1408091: Changes Requested: [mptcp-next] Squash to "[MPTCP][PATCH v7
> mptcp-next 3/7] mptcp: add port number announced check"
> 1408144: Changes Requested: [mptcp-next] mptcp: enable use_port when invo=
ke
> addresses_equal:
>     - The two last ones can be part of the future v8
>     - Some modifications needed
> =

> 1409622: Changes Requested: [RFC] selinux: handle MPTCP consistently with
> TCP:
>     - fixes in MPTCP core will be needed
>     - sk_security is not copied
>     - either we replace sk_clone_lock with another one copying the
> sk_security field
>     - or we do an explicit copy
> =

> 1410827: Changes Requested: [net-next] mptcp: avoid using the main socket=
 to
> send ack:
>     - Geliang is working on a v2
>     - Paolo is not able to reproduce the issue, probably a different KCon=
fig
> and we need net-next
>     - But this fix is important
>     - If anybody can reproduce it, it can be useful if Geliang needs help
>     - *@Geliang* : can you reproduce it on the export branch too?
> =

> 1413254: New: [v4,mptcp-next,1/2] mptcp: add the address ID assignment
> bitmap
> 1413262: New: [v4,mptcp-next,2/2] selftests: mptcp: add testcases for
> setting the address ID:
>     - Review needed
> =

> 1413268: New: [v3,mptcp-next,1/6] mptcp: add the outgoing MP_PRIO support
> 1413269: New: [v3,mptcp-next,2/6] mptcp: add the incoming MP_PRIO support
> 1413270: New: [v3,mptcp-next,3/6] mptcp: add set_flags command in PM netl=
ink
> 1413271: New: [v3,mptcp-next,4/6] selftests: mptcp: add set_flags command=
 in
> pm_nl_ctl
> 1413272: New: [v3,mptcp-next,5/6] mptcp: add the mibs for MP_PRIO
> 1413273: New: [v3,mptcp-next,6/6] selftests: mptcp: add the MP_PRIO
> testcases:
>     - Review needed
>     - v2 =E2=86=92 v3 is small
> =

> =

> =

> Issues on Github:
>     https://github.com/multipath-tcp/mptcp_net-next/issues/
> =

>     Recently opened (latest from last week: 118)
> =

>   124  ./mptcp_connect.sh -m mmap test blocks: regression [bug]:
>       - Happening since: "mptcp: push pending frames when subflow has free
> space"
>       - From Paolo: mmh
>       - Paolo didn't have the issue on his environment
> =

>   123  sndmsg autotuning is disable [bug] @pabeni:
>       - When investigating low perf between two VMs
>       - Disabled since last sendmsg refactor
>       - When autotuning is not needed, perf are good!
>       - But not easy to re-enable it
> =

>   122  PM doesn't create subflow with IPv4 mapped IPv6 socket [bug]
> @geliangtang:
>       - kernel_bind() =E2=86=92 inet6_bind() =E2=86=92 error
>       - Geliang is looking at it
>       - Geliang had an issue to compile packetdrill (multiple definition =
of
> `mp_state')
>       - From Davide: mmh
>       - *@Geliang* : do you still have the issue?
>       - Fedora 30 is no longer supported, an upgrade might be needed
>       - If still blocked, please report the issue on Github/IRC
> =

>   121  [syzkaller] divide error in __tcp_select_window [bug] [syzkaller]:
>       - It seems similar to #111 but the upstream fix didn't help for this
> one.
> =

>   120  [interop] netnext is dropping packets, causing MPTCP-level
> retransmissions on mptcp.org:
>       - Some logs have been added
> =

>   119  [syzkaller] memory leak in __get_filter [bug] [syzkaller]:
>       - no repro yet
> =

>   125  [syzkaller] KASAN: wild-memory-access Write in subflow_req_destruc=
tor
>   126  [syzkaller] WARNING in mptcp_reset_timer:
>       - might be linked to #105 (still happening) and #70
> =

>   127  [syzkaller] WARNING in corrupted:
>       - all these new ones (125 =E2=86=92 127) are with export from yeste=
rday:
> export/20201209T060936
>       - syzkaller config is different, likely validating new stuff
> =

> =

>     Bugs (opened, flagged as "bug" and assigned)
> =

>   123  sndmsg autotuning is disable [bug] @pabeni:
>       - See =E2=86=91
> =

>   122  PM doesn't create subflow with IPv4 mapped IPv6 socket [bug]
> @geliangtang:
>       - See =E2=86=91
> =

>   104  [syzkaller] general protection fault in skb_release_data [bug]
> [syzkaller] @geliangtang:
>       - Geliang is working on it
>       - one patch has already been shared
> =

>    94  Packetdrill: after a received DATA_FIN, no new packets can be trea=
ted
> [bug] [packetdrill] @dcaratti:
>        - workaround pushed. Can we close this?
>        - No, Matth had the issue yesterday
>        - problem: not matching the port =E2=86=92 cannot understand the p=
ort, maybe
> we can match "any port"
> =

> =

>     Bugs (opened and flagged as "bug" and not assigned)
> =

>   124  ./mptcp_connect.sh -m mmap test blocks: regression [bug]
>   121  [syzkaller] divide error in __tcp_select_window [bug] [syzkaller]
>   119  [syzkaller] memory leak in __get_filter [bug] [syzkaller]
>   115  [syzkaller] WARNING in sk_stream_kill_queues [bug] [syzkaller]
>   114  packetdrill: dss tolerance issue to emit the FIN+ACK [bug]
> [packetdrill]
> =

>   112  sporadic failure of mptcp_join.sh selftest 13 [bug]:
>     - could be good to look at this one not to have many bad reports from
> the CIs.
> =

>   110  [syzkaller] memory leak in __ip_mc_join_group [bug] [syzkaller]
>   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
>   106  [syzkaller] BUG: Bad page state [bug] [syzkaller]
>    65  clearing properly the status in listen() [bug]
>    56  msk connection state set without msk lock [bug]
> =

> =

>     In Progress (opened and assigned)
> =

>   117  Allow user-space to set endpoint ID [enhancement] [help wanted]
> @geliangtang
>    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
>    76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe
>    54  ADD_ADDR: ports support [enhancement] @geliangtang
>    51  MP_PRIO support [enhancement] @geliangtang
>    43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag interface
> [enhancement] [syzkaller] @cpaasch
> =

> =

>     Recently closed (since last week)
> =

>   109  [syzkaller] memory leak in skb_ext_add [bug] [syzkaller]
>   108  [syzkaller] memory leak in sk_clone_lock [bug] [syzkaller] @pabeni
>   103  [syzkaller] WARNING in inet_csk_listen_stop [bug] [syzkaller] @pab=
eni
>    85  Packetdrill: multiple timeout reported by the CI [bug] [packetdril=
l]
> @matttbe
>    72  [iproute2] endpoint add with "id" is not persisted [enhancement]
> [iproute2]
>    67  `./mptcp_connect.sh -m mmap` test blocks [bug]
> =

> =

> =

> FYI: Current Roadmap:
>     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
>     - Current merge window (5.11):
> https://github.com/multipath-tcp/mptcp_net-next/projects/6
>     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects=
/4
> =

> =

> =

> Patches to send to netdev:
>     - net:
>         - /
> =

>     - net-next:
>         - See below: =E2=86=93
>         - Mat can send them
>         - Paolo will send independently the SELinux patch because it will=
 go
> to different tree/ML
> =

> 58f1c48d7bbd bpf: expose is_mptcp flag to bpf_tcp_sock =E2=86=92 no
> =

> f57f3b5446bb mptcp: attach subflow socket to parent cgroup =E2=86=92 yes
> =

> e1a05f57895d bpf: add 'bpf_mptcp_sock' structure and helper =E2=86=92 no
> 921a342fed73 bpf:selftests: add MPTCP test base =E2=86=92 no
> eea7e1d5a580 bpf:selftests: add bpf_mptcp_sock() verifier tests =E2=86=92=
 no
> =

> d27ed1c635bb mptcp: remove address when netlink flushes addrs =E2=86=92 y=
es
> 93713a3225de selftests: mptcp: add the flush addrs testcase =E2=86=92 yes
> 5c5e588b0e93 mptcp: use MPTCPOPT_HMAC_LEN macro =E2=86=92 yes
> dd635e51b7e0 mptcp: hold mptcp socket before calling tcp_done =E2=86=92 y=
es
> 99b4323a4bd4 tcp: parse mptcp options contained in reset packets =E2=86=
=92 yes
> 815187eaa4c5 mptcp: parse and act on incoming FASTCLOSE option =E2=86=92 =
yes
> 62253eedfcee mptcp: pm: simplify select_local_address() =E2=86=92 yes
> 205c9df9ee33 mptcp: let MPTCP create max size skbs =E2=86=92 yes
> =

> 20519a8c3383 mptcp: push pending frames when subflow has free space =E2=
=86=92 no:
>     - can be seen as a fix, we can wait
> =

> =

> =

> Extra tests:
>     - news about Syzkaller? (Christoph):
>         - See =E2=86=91
>         - syzkaller config is different, likely validating new stuff
> =

>     - news about interop with mptcp.org? (Christoph):
>         - an issue reported last week (120: [interop] netnext is dropping
> packets, causing MPTCP-level retransmissions on mptcp.org)
>         - it looks like the sender (mptcp.org) is sending more than what =
it
> should do
>         - pcap captures with the corresponding dmesg log might be needed
>         - *@Christoph* has this and will look at that
> =

>     - news about Intel's kbuild? (Mat):
>         - less frequent failure on MP_JOIN selftests
>         - ADD_ADDR timeout was detected too
>         - Mat will check at the full logs

Is the ADD_ADDR timeout issue's output like this:

12 signal address, ADD_ADDR timeout     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                        add[fail] got 2 ADD_ADDR[s] expecte=
d 4
 - echo  [ ok ]
Server ns stats
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             1                  0.0
MPTcpExtMPJoinAckRx             1                  0.0
Client ns stats
MPTcpExtMPJoinSynAckRx          1                  0.0
MPTcpExtAddAddr                 2                  0.0
13 remove single subflow                syn[ ok ] - synack[ ok ] - ack[ ok ]
                                        rm [ ok ] - sf    [ ok ]

I got it sometimes. I'll fix it recently.

-Geliang

> =

>     - packetdrill (Davide):
>         - Some small modifications to stabilise some tests running on a s=
low
> env
>         - Also tolerance is multiplied by 10 when running it with a debug
> kernel
> =

>     - CI (Matth):
>         - Tests are more stable! (up to yesterday :) )
> =

> =

> =

> Removing subflows:
>     - If the initial subflow has been closed, do we want the path manager=
 to
> close the last subflow when an address is removed?
>     - Or leave it open until it's forced closed by an interface being shut
> down?
>     - Linked to recent modifications done by Geliang
>     - We need to check if the MPTCP connection is left opened in this case
> (PM closes the last subflow):
>         - the msk should still be in Established and can accept/create new
> subflows
>         - maybe safe to close everything by default?
>         - https://github.com/multipath-tcp/mptcp_net-next/issues/128
>         - Note that the situation is different if the msk has been closed:
> if no DATA_FIN is received but all subflows are closed (TCP FIN), the msk=
 is
> closed.
> =

> =

> =

> RPM spec for mptcpd - BSD license:
>     - Davide has a fix for that
>     - (but mptcpd is not compiling anymore)
> =

> =

> =

> mptcpd doesn't build any more with libell-0.35 (see issue #84)
>     - ugly workaround: build with no plugins =E2=86=92
> https://paste.centos.org/view/f1218db0
>     - and use libell 0.33 if you want mptcpd functionality
>     - Ossama has a fix but no release
>     - Davide can apply a patch if it can apply on the 0.5 release
>     - *@Ossama* will look at this patch on top of the right version.
> =

> =

> Next meeting:
>     - starting a bit later? 30 minutes later? (because of conflicting
> meetings)
>     - *@Geliang:* do you plan to participate to the meeting next week? Co=
uld
> we start it 15-30 minutes later
> =

> =

> =

> Next meeting:
>     - We propose to have the next meeting on Thursday, the 17th of Decemb=
er.
>     - /!\ *NOT* the Usual UTC time: 16:30 UTC (8.30am PST, 5.30pm CET,
> Midnight+30 CST)
>     - Still open to everyone!
>     - https://annuel2.framapad.org/p/mptcp_upstreaming_20201217
> =

> =

> =

> Feel free to comment on these points and propose new ones for the next
> meeting!
> =

> Talk to you next Thursday,
> Matt
> -- =

> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============3070698408627316888==--
