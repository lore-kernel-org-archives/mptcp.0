Content-Type: multipart/mixed; boundary="===============3120501401194449256=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 20th of August 2020
Date: Thu, 20 Aug 2020 10:45:39 -0700
Message-ID: <alpine.OSX.2.23.453.2008201035040.59053@mjmartin-mac01.local>
X-Status: 
X-Keywords:                  
X-UID: 5585

--===============3120501401194449256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello everyone,

Today we held our 112th meeting with Ossama (Intel), Christoph (Apple), =

Geliang (Xaomi), Nicolas (Tessares), and me (Intel).


Minutes:


Accepted patches:
     See patchwork: https://patchwork.ozlabs.org/project/mptcp/list/?state=
=3D3

netdev (if mptcp ML is in cc) (Florian Westphal, Paolo Abeni):

1345044  [net] mptcp: sendmsg: reset iter on error
1342346  [net] mptcp: fix warn at shutdown time for unaccepted msk sockets
1342336  [net] mptcp: more stable diag self-tests
1342150  [net] selftests: mptcp: fix dependecies
1340921  [net] mptcp: be careful on subflow creation

our repo (by: Christoph Paasch, Geliang Tang, Nicolas Rybowski, Paolo =

Abeni):

1343228  [mptcp-next,v2,3/3] bpf: add 'bpf_mptcp_sock' structure and =

helper
1343226  [mptcp-next,v2,2/3] mptcp: attach subflow socket to parent cgroup
1343225  [mptcp-next,v2,1/3] bpf: expose is_mptcp flag to bpf_tcp_sock
1342361  [v2,mptcp-next] selftests/mptcp: Better delay & reordering =

configurat...
1342329  [net] mptcp: fix warn at shutdown time for unaccepted msk sockets
1342323  [net] mptcp: more stable diag self-tests
1341343  [13/13] mptcp: cache subflow write status in subflow ctx
1341344  [12/13] mptcp: simult flow self-tests
1341342  [11/13] mptcp: allow picking different xmit subflows
1341340  [10/13] mptcp: allow creating non-backup subflows
1341341  [09/13] mptcp: move address attribute into mptcp_addr_info
1341339  [08/13] mptcp: add OoO related mibs
1341338  [07/13] mptcp: cleanup mptcp_subflow_discard_data()
1341337  [06/13] mptcp: move ooo skbs into msk out of order queue.
1341335  [05/13] mptcp: introduce and use mptcp_try_coalesce()
1341336  [04/13] mptcp: basic sndbuf autotuning
1341332  [03/13] mptcp: trigger msk processing even for OoO data
1341334  [02/13] mptcp: set data_ready status bit in =

subflow_check_data_avail()
1341330  [01/13] mptcp: rethink 'is writable' conditional
1340774  [v5,mptcp-next,3/4] mptcp: add the incoming RM_ADDR support
1340772  [v5,mptcp-next,2/4] mptcp: add the outgoing RM_ADDR support
1340771  [v5,mptcp-next,1/4] mptcp: rename addr_signal and the related =

functio...

Pending patches:
     See patchwork: https://patchwork.ozlabs.org/project/mptcp/list/?state%=
21=3D3&series=3D&q=3D&delegate=3D&submitter=3D&archive=3D&state=3D*

netdev (if mptcp ML is in cc) (by: n/a):

n/a

our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts):

1325171: Changes Requested: [mptcp-next] selftests: mptcp: interpret \n as =

a new line
      - Presumed still "Matth: TODO..."

1344205: New: [v7,mptcp-next,1/5] mptcp: remove addr and subflow in PM =

netlink
1344207: New: [v7,mptcp-next,2/5] mptcp: add RM_ADDR mib
1344219: New: [v7,mptcp-next,3/5] selftests: mptcp: drop first flag in =

do_rnd_write
1344221: New: [v7,mptcp-next,4/5] selftests: mptcp: add remove addr and =

subflow test case
1344222: New: [v7,mptcp-next,5/5] selftests: mptcp: add RM_ADDR mib check =

function
     - Mat will review

1347515: Changes Requested: [v4,mptcp-next,1/3] mptcp: send out ADD_ADDR =

with echo flag
1347523: Changes Requested: [v4,mptcp-next,2/3] mptcp: add ADD_ADDR =

related mibs
1347530: Changes Requested: [v4,mptcp-next,3/3] selftests: mptcp: add =

ADD_ADDR mibs check function
     - Mat suggested changes to send the echo after ADD_ADDR is fully =

processed
     - Geliang working on v5

1348371: New: [mptcp-next,v3] mptcp: adjust mptcp receive buffer limit if =

subflow has larger one
     - Mat will review


Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

Recently opened (latest from two weeks ago: 72)

   79  allow 'force to MPTCP' mode: BPF [enhancement]
   78  notify the application (userspace) when a subflow is added/removed =

[enhancement]
   77  [gs]etsockopt: forward to new/existing SF [enhancement]
   76  [gs]etsockopt per subflow: BPF [enhancement]
   75  BPF: packet scheduler [enhancement]
   74  BPF: path manager [enhancement]
     - All of above are enhancements related to Nicolas' BPF project
   73  Simultaneous xmit issue [bug]
     - No update

     Recently closed (since two weeks ago)
   80  [syzkaller] KASAN: slab-out-of-bounds Read in subflow_syn_recv_sock =

[bug] [syzkaller]
   68  selftests: diag: failing with new DATA_FIN patches [bug]
   66  [interop] IPv4: Attempt to release TCP socket in state 1 =

00000000cbc88a4a [bug] [interop]


FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.10): =

https://github.com/multipath-tcp/mptcp_net-next/projects/5
     - For later: =

https://github.com/multipath-tcp/mptcp_net-next/projects/4

Extra tests:
     - news about Syzkaller? (Christoph):
         - No updates since net-next merge and 5.9-rc1 release
     - news about interop with mptcp.org? (Christoph):
         - No update
     - news about Intel's kbuild? (Mat):
         - No update
     - packetdrill (Davide):
         - No update
     - CI (Matth):
         - Export branch still getting rebased and updated

Upstream branch status:
     - Net-next has reopened.

Netdev 0x14:
     - Netdev conference this week. MPTCP talk is scheduled for 2020-08-21 =

16:45GMT.
     - Slides, paper, video will eventually be posted to =

https://netdevconf.info/0x14/session.html?talk-using-upstream-MPTCP-in-linu=
x-systems

Next steps:
     - Look at DATA_FIN interop with previous upstream MPTCP releases (Mat)

Next meeting:
     - 27th (Thursday) of August at 15:00 UTC (8am PDT, 5pm CEST)
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200827


Please feel free to comment on the items above or propose topics for the =

next meeting.


Thanks,

--
Mat Martineau
Intel
--===============3120501401194449256==--
