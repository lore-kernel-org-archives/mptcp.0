Content-Type: multipart/mixed; boundary="===============7186672539065072151=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 21st of January 2021
Date: Wed, 27 Jan 2021 11:21:45 +0100
Message-ID: <5f1ccd0d-70ae-7bd4-0a82-d52d3c83f8a7@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 7495

--===============7186672539065072151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Last Thursday, we had our 132nd meeting with Mat and Ossama (Intel), =

Christoph (Apple), Paolo, Davide and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (/):

/

     our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts, =

Paolo Abeni ):

1428710  [v2,mptcp-next] Squash-to: "mptcp: implement delegated actions"

1427488  [mptcp-next] Squash to "mptcp: drop *_max fields in mptcp_pm_data"

1427182  [v2,mptcp-next] mptcp: implement delegated actions

1427174  [net-next] Squash-to: "mptcp: re-enable sndbuf autotune"

1426548  [2/7] mptcp: move pm netlink work into pm_netlink
1426547  [1/7] mptcp: pm: add lockdep assertions

1426538  [mptcp-next,v6,5/5] selftests: increase timeout to 10 min
1426534  [mptcp-next,v6,4/5] selftests: mptcp: add IPv4-mapped IPv6 =

testcases
1426533  [mptcp-next,v6,3/5] mptcp: pm nl: reduce variable scope
1426537  [mptcp-next,v6,2/5] mptcp: pm nl: support IPv4 mapped in v6 =

addresses
1426536  [mptcp-next,v6,1/5] mptcp: support MPJoin with IPv4 mapped in =

v6 sk

1426191  [v2,mptcp-next] selftests: mptcp: add command line arguments =

for mptc...

1426190  [v10,mptcp-next,9/9] selftests: mptcp: add testcases for =

ADD_ADDR wit...
1426189  [v10,mptcp-next,8/9] mptcp: add the mibs for ADD_ADDR with port
1426188  [v10,mptcp-next,7/9] selftests: mptcp: add port argument for =

pm_nl_ctl
1426187  [v10,mptcp-next,6/9] mptcp: deal with MPTCP_PM_ADDR_ATTR_PORT =

in PM n...
1426186  [v10,mptcp-next,5/9] mptcp: enable use_port when invoke =

addresses_equ...
1426185  [v10,mptcp-next,4/9] mptcp: add port number check for MP_JOIN
1426184  [v10,mptcp-next,3/9] mptcp: add a new helper =

subflow_req_create_thmac
1426183  [v10,mptcp-next,2/9] mptcp: drop unused skb in =

subflow_token_join_req...
1426182  [v10,mptcp-next,1/9] mptcp: create the listening socket for new =

port

1426180  [v5,mptcp-next,5/5] selftests: mptcp: add testcases for newly =

added a...
1426179  [v5,mptcp-next,4/5] selftests: mptcp: use minus values for =

removing a...
1426178  [v5,mptcp-next,3/5] mptcp: create subflow or signal addr for =

newly ad...
1426177  [v5,mptcp-next,2/5] mptcp: drop *_max fields in mptcp_pm_data
1426175  [v5,mptcp-next,1/5] mptcp: use WRITE_ONCE/READ_ONCE for the =

pernet *_...



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: Paolo Abeni):

1429235  [v2,net-next,5/5] mptcp: implement delegated actions
1429234  [v2,net-next,4/5] mptcp: schedule work for better snd subflow =

selecti...
1429232  [v2,net-next,3/5] mptcp: do not queue excessive data on subflows
1429233  [v2,net-next,2/5] mptcp: re-enable sndbuf autotune
1429230  [v2,net-next,1/5] mptcp: always graft subflow socket to parent
=E2=86=92 Done now

     our repo (by: Florian Westphal, Geliang Tang):

1370700: RFC: [RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
1370702: RFC: [RFC,4/4] tcp: parse tcp options contained in reset packets
1375893: RFC: [RFC,mptpcp-next] mptcp: add ooo prune support
1395128: RFC: [1/5] tcp: make two mptcp helpers available to tcp stack
1395131: RFC: [3/5] mptcp: add mptcp reset option support
1395133: RFC: [5/5] mptcp: send fastclose if userspace closes socket =

with unread data:
     - WIP

1426554: Changes Requested: [PATCHi,iproute2] mptcp: add support for =

event monitoring:
     - clear, modifications will be done later

1429039: New: [mptcp-next] mptcp: send ack for every add_addr:
     - Waiting for review =E2=86=92 Done now

1429289: New: [v2,mptcp-next,1/5] mptcp: split __mptcp_close_ssk helper
1429290: New: [v2,mptcp-next,2/5] mptcp: pass subflow socket to a few =

helpers
1429291: New: [v2,mptcp-next,3/5] mptcp: avoid lock_fast usage in accept =

path
1429320: New: [v2,mptcp-next,4/5] genetlink: add CAP_NET_ADMIN test for =

multicast bind
1429292: New: [v2,mptcp-next,5/5] mptcp: add netlink event support:
     - Netlink PM events: name:
         - mptcp_events: like mptcp.org
         - mptcp_pm_events: same prefix (mptcp_pm_) as the others ones =

but different from mptcp.org
         - not an issue to have a different name for mptcpd
         - OK to keep the same convention
         - =E2=86=92 "mptcp_pm_events" it is then
     - sk_err: the one from the subflow is taken (ssk->sk_err). If this =

one is set to 0, does it make sense to fallback to msk->sk_err? Maybe =

not...:
         - this one is used to know if it makes sense to re-estab a subflow
     - =E2=86=92 Done now



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 134)

   141  avoid acquiring mptcp_data_lock() twice in the receive path =

[enhancement]:
       - was already discussed a few months ago
       - Paolo re-look at that when working on the sndbuf auto tuning patch
       - Could be useful to improve perfs

   140  RM_ADDR: remove a list of addresses [enhancement] @geliangtang:
       - we can receive a list of addresses, not just one according to =

the specs

   139  selftests: mptcp_join.sh: ADD_ADDR timeout issue [bug] @geliangtang:
       - Already reported by Mat and Matth before but there was no ticket
       - should be fixed by "mptcp: send ack for every add_addr" =E2=86=92 =
Done now

   137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable =

[bug]:
       - Matth: TODO: check if it is still visible after the last =

version of the autotuning patchset =E2=86=92 Yes it is
       - this bug was exposed by the mentioned commit (adding lock in =

mptcp_shutdown) but should not be introduced by this one (simply because =

this patch was suggested by Eric?)

   136  [syzkaller] WARNING in sk_stream_kill_queues [bug] [syzkaller]
   135  [syzkaller] WARNING in __mptcp_destroy_sock [bug] [syzkaller]:
       - both look similar
       - still visible
       - @Christoph: may you print the value of the mem before the =

warning please? =E2=86=92 Done now


     Bugs (opened, flagged as "bug" and assigned)

   139  selftests: mptcp_join.sh: ADD_ADDR timeout issue [bug] @geliangtang:
       - see above

    94  Packetdrill: after a received DATA_FIN, no new packets can be =

treated [bug] [packetdrill] @dcaratti:
        - Davide didn't manage to reproduce it with =

"./packetdrill/run_all.py -vslS mptcp/"
        - Matth: TODO: retry =E2=86=92 Done now


     Bugs (opened and flagged as "bug" and not assigned)

   137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable =

[bug]
   136  [syzkaller] WARNING in sk_stream_kill_queues [bug] [syzkaller]
   135  [syzkaller] WARNING in __mptcp_destroy_sock [bug] [syzkaller]
   130  [syzkaller] WARNING in mptcp_token_destroy_request [bug] =

[syzkaller]
   125  [syzkaller] KASAN: wild-memory-access Write in =

subflow_req_destructor [bug] [syzkaller]
   120  [interop] netnext is dropping packets, causing MPTCP-level =

retransmissions on mptcp.org [bug]
   119  [syzkaller] memory leak in __get_filter [bug] [syzkaller]
   112  sporadic failure of mptcp_join.sh selftest 13 [bug]
   110  [syzkaller] memory leak in __ip_mc_join_group [bug] [syzkaller]
   107  Review use of WARN_ON() / WARN_ON_ONCE() [bug]
    65  clearing properly the status in listen() [bug]
    56  msk connection state set without msk lock [bug]


     In Progress (opened and assigned)

   140  RM_ADDR: remove a list of addresses [enhancement] @geliangtang
   134  Checksum support [enhancement] @geliangtang
   131  replace some/most pr_debug with trace events [enhancement] =

@geliangtang
    96  Python: add support for IPPROTO_MPTCP [enhancement] @matttbe
    76  [gs]etsockopt per subflow: BPF [enhancement] @matttbe
    60  PM: netlink: events per connection [enhancement] @fw-strlen
    54  ADD_ADDR: ports support [enhancement] @geliangtang
    51  MP_PRIO support [enhancement] @geliangtang


     Recently closed (since last week)

   138  mptcp_join.sh: WARNING: possible recursive locking detected =

[bug] @geliangtang
   129  set subflow socket consistently [bug] [enhancement]
   127  [syzkaller] WARNING in corrupted [bug] [syzkaller]
   126  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller] =

@dcaratti
   123  sndmsg autotuning is disable [bug] @pabeni
   122  PM doesn't create subflow with IPv4 mapped IPv6 socket [bug] =

@geliangtang
   115  [syzkaller] WARNING in sk_stream_kill_queues [bug] [syzkaller]
    19  let PM netlink update live sockets on local addresses list =

change [enhancement] @geliangtang



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.12): =

https://github.com/multipath-tcp/mptcp_net-next/projects/7
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
     - net:
         - /

     - net-next:
         - Once Paolo's patches (autotuning) have been accepted... =E2=86=
=92 Done
         - ... send what we have but in two chunks:
             - v4 mapped support =E2=86=92 it can be considered as a fix or=
 a =

new feature, we can keep or remove "Fixes" tag (but this is maybe needed =

for distro where they backport MPTCP patches ;-) )
             - Mat will send them. =E2=86=92 Done now, waiting to be applied
             - the rest about ADD_ADDR/MP_JOIN on a different port



Extra tests:
     - news about Syzkaller? (Christoph):
         - https://github.com/multipath-tcp/mptcp_net-next/issues/110 :
             - =E2=86=92 there is a new repro:
             - maybe due to the way we handle setsockopt where we don't =

close <something>
         - updating HEAD with debug patch

     - news about interop with mptcp.org? (Christoph):
         - /
         - curl multipath-tcp.org is telling user they don't support =

MPTCP, maybe we should redirect them to a wiki page instead of the =

"funny" message.
         - Matth: TODO: check =E2=86=91 =E2=86=92 Discussions are in progre=
ss.

     - news about Intel's kbuild? (Mat):
         - most of the builds are passing
         - ~1 in 5 is hitting ADD_ADDR timeout failure

     - packetdrill (Davide):
         - would be really nice to support new features (MP_PRIO, =

ADD_ADDR on a different port, etc.) because it will help us reproduce =

issue, debug, having stable and (much) quicker tests.:
             - idea is to wait a bit before closing some tickets adding =

these features
         - Is Packetdrill difficult to put in place?

     - CI (Matth):
         - Planning to move to Github Action (CI) to allow more people =

to use it and see results
         - hopefully, tests would be stable there but hard to say
         - had to increase tolerance for packetdrill tests due to the =

use of a busy and old server some times



[sg]etsockopts:
     - we should really look at that!
     - probably refuse the ones we don't support and add the ones we support
     - it means code duplication but at least the behaviour will be the =

one expected
     - it is still possible to use Apache and NGinx with static pages, =

not so many setsockopt used



mptcpd:
     - idea is to validate new patches from Florian =E2=86=92 in progress



Next meeting:
     - We propose to have the next meeting on Thursday, the 28th of January.
     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, Midnight CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20210128



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7186672539065072151==--
