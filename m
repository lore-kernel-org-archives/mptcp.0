Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A66138F
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 21:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651180953; x=1682716953;
  h=date:from:to:subject:message-id:mime-version;
  bh=U8p7pC2KyKEdNMzUO8vE3ZpfNZPFlkA5FFB3EAOcH2Y=;
  b=VvowwiHfk+H+nK6yueqfZEFCu6rg5r2hyEBp+Ju+PXWVVMXaGpxTup4S
   4g+xZQujm2b7F2PbiVpHDnL3byAwQ0zjLHX8aHHrioLBslN2o1i12GrYa
   QNEwJk0RjxX4CcmAezgMvRORb7piFQOpV8jXeoPaRm1vtVV/TOz9jLWVg
   i3pcJckXVrdPIME+FYtSP0YMUxn22wfUCIdrN5hOnG1/fEFXAoINvnquL
   oXhJe++JCWRR4+XKMdqzRDviC4+msHRIZu9qZFBE0WvK6FSKIh01XrY2o
   vI8ZOnxdaKk/mN4Pd1Vzd+gkg9x30VrtE8lh63BQPQMQ8rKEmyeQMzAUa
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266243401"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="266243401"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 14:22:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="581649663"
Received: from davideli-mobl.amr.corp.intel.com ([10.209.69.78])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 14:22:31 -0700
Date: Thu, 28 Apr 2022 14:22:30 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Subject: [Weekly meetings] MoM - 28th of April 2022
Message-ID: <6052111-39d7-1037-d711-59a3929db477@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Hello everyone -

Today was our 193rd meeting, with Paolo, Davide, Florian (Red Hat), 
Geliang (SuSE), Giray (Parkyeri), Pol (Tessares), Ossama, and me (Intel).


Meeting minutes:

Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.kernel.org/project/mptcp/list/?state=3


     netdev (if mptcp ML is in cc) (by: Mat Martineau):

12827998  [net-next,7/7] selftests: mptcp: print extra msg in chk_csum_nr
12827997  [net-next,6/7] selftests: mptcp: check MP_FAIL response mibs
12827995  [net-next,5/7] mptcp: reset subflow when MP_FAIL doesn't respond
12827996  [net-next,4/7] mptcp: add MP_FAIL response support
12827994  [net-next,3/7] mptcp: add data lock for sk timers
12827993  [net-next,2/7] mptcp: use mptcp_stop_timer
12827992  [net-next,1/7] selftests: mptcp: add infinite map testcase
12824090  [net-next,8/8] selftests: mptcp: add infinite map mibs check
12824091  [net-next,7/8] mptcp: dump infinite_map field in 
mptcp_dump_mpext
12824089  [net-next,6/8] mptcp: add mib for infinite map sending
12824087  [net-next,5/8] mptcp: infinite mapping receiving
12824088  [net-next,4/8] mptcp: infinite mapping sending
12824086  [net-next,3/8] mptcp: track and update contiguous data status
12824085  [net-next,2/8] mptcp: add the fallback check
12824084  [net-next,1/8] mptcp: don't send RST for single subflow
   - Both of these series have been merged.


     our repo (by: Geliang Tang, kernel test robot, Paolo Abeni):

12826789  [mptcp-next] selftests/bpf: Drop duplicate max/min definitions
12826453  [mptcp-next] Squash to "selftests: bpf: test 
bpf_skc_to_mptcp_sock"
12826452  [mptcp-next] Squash to "bpf: add bpf_skc_to_mptcp_sock_proto"

12824418  mptcp: fix semicolon.cocci warnings

12821720  [v2,5/5] mptcp: add more offered MIBs counter.
12821719  [v2,4/5] mptcp: never shrink offered window
12821718  [v2,3/5] tcp: allow MPTCP to update the announced window.
12821717  [v2,2/5] mptcp: add mib for xmit window sharing
12821716  [v2,1/5] mptcp: really share subflow snd_wnd


Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.kernel.org/project/mptcp/list/?state=*

     netdev (if mptcp ML is in cc) (by: Mat Martineau, Paolo Abeni):

12829644  [net-next,6/6] selftests: mptcp: Add tests for userspace PM type
12829643  [net-next,5/6] mptcp: Add a per-namespace sysctl to set the 
default p...
12829642  [net-next,4/6] mptcp: Make kernel path manager check for 
userspace-ma...
12829641  [net-next,3/6] mptcp: Bypass kernel PM when userspace PM is 
enabled
12829640  [net-next,2/6] mptcp: Add a member to mptcp_pm_data to track 
kernel v...
12829639  [net-next,1/6] mptcp: Remove redundant assignments in path 
manager in...

12819235  [RFC,2/2] mptcp: never shrink offered window
12819237  [RFC,1/2] tcp: allow MPTCP to update the announced window.
   - No comment, must be ok :)

     our repo (by: Dmytro SHYTYI, Geliang Tang, Jiapeng Chong, Mat 
Martineau, Matthieu Baerts, Paolo Abeni):

RFC:

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to 
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset 
packets
12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support
12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp 
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes 
socket with unread data
12321111: RFC: mptcp: Remove redundant assignment to remaining
12714439: RFC: [net-next,v2] net: mptcp, Fast Open Mechanism

New:
12829923: New: [mptcp-next,v2] selftests/bpf: Enable CONFIG_IKCONFIG_PROC 
in config
   - To be part of the bpf v2 series

12829996: New: [mptcp-next,v17,1/8] mptcp: add struct mptcp_sched_ops
12829997: New: [mptcp-next,v17,2/8] mptcp: add a new sysctl scheduler
12829998: New: [mptcp-next,v17,3/8] mptcp: add sched in mptcp_sock
12829999: New: [mptcp-next,v17,4/8] mptcp: add get_subflow wrappers
12830000: New: [mptcp-next,v17,5/8] mptcp: add bpf_mptcp_sched_ops
12830001: New: [mptcp-next,v17,6/8] mptcp: add last_snd write access
12830002: New: [mptcp-next,v17,7/8] selftests: bpf: add bpf_first 
scheduler
12830003: New: [mptcp-next,v17,8/8] selftests: bpf: add bpf_first test
     - Addressed Paolo's comments on v16
     - Geliang asks: what about using a separate BPF call for the 
retransmit scheduler?
       - v17 handling of retransmit seems ok to reviewers so far
     - Doesn't fully handle sending on multiple subflows yet - we still 
need to work out how the BPF api (with 'call again' option) ties in to the 
transmit loop.


Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

  Upcoming:
      - Paolo has observed an issue where the MPTCP socket is left dangling 
up to a 60-second timeout, even after the owner process exits. Still need 
to investigate.


      Recently opened (latest from last week: 268)

   271  TCP_DEFER_ACCEPT socket option is not supported
     - No MPTCP support yet, running
   270  KASAN: use-after-free in dst_destroy (net/core/dst.c:118)  [bug] 
[selftests]
     - Appears to be upstream, not caused by MPTCP code
   269  Allow having a mix of v4/v6 subflows for the same socket 
[enhancement]
     - Enhancement request


     Bugs (opened, flagged as "bug" and assigned)

   264  selftests: diag: failing on the public CI with the new debug.config 
[bug] [selftests] @matttbe
   181  implement data_fin ack retransmission for subflow in  TIME_WAIT 
state [bug] @mjmartineau
     - Nothing to report


     Bugs (opened and flagged as "bug" and not assigned)

   265  self-tests #94 && #95 failing [bug] [selftests]
   248  packetdrill: more tests failing due to packets arriving later than 
expected [bug] [packetdrill]


     In Progress (opened, new feature and assigned)

   234  Packetdrill: Support MPC+DATA+checksum error [enhancement] 
[packetdrill] @spoorva
   216  The infinite mapping support: drop data [enhancement] @geliangtang
   167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill] 
@dcaratti
    - Trying to check on IPv6 failures first

    75  BPF: packet scheduler [enhancement] @geliangtang
    - Actively revising - see v17 patch series above
    74  BPF: path manager [enhancement] @geliangtang


     For later (opened and not assigned assigned)

   271  TCP_DEFER_ACCEPT socket option is not supported
   269  Allow having a mix of v4/v6 subflows for the same socket 
[enhancement]
   266  Packetdrill: add MP_FAIL coverage [packetdrill]
   236  Review supported sockopts list [enhancement]
   222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
   215  TCP Urgent pointer and MPTCP [enhancement]
   213  add MPTCP man page [enhancement]
   208  better handing of ssk memory pressure in the TX path [enhancement]
   202  Add sendmsg support for ancillary data [enhancement]
   197  more mibs needed [enhancement]
   180  Get an update when MPTCP fall back to TCP [enhancement]
   177  improve retransmit subflow selection [enhancement]
   169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different 
port [enhancement] [packetdrill]
   150  remove completely workqueue usage [enhancement]
   141  avoid acquiring mptcp_data_lock() twice in the receive path 
[enhancement]
   133  PM: Closing the MPTCP connection when last subflow is not the 
initial one and its IP address is removed [enhancement]
   128  When the last subflow is closed without DATA_FIN and msk 
Established, close msk (after a timeout) [enhancement]
    79  allow 'force to MPTCP' mode: BPF [enhancement]
    78  notify the application (userspace) when a subflow is added/removed 
[enhancement]
    77  [gs]etsockopt: forward to new/existing SF [enhancement]
    76  [gs]etsockopt per subflow: BPF [enhancement]
    61  move msk clone after ctx creation [enhancement]
    59  (MP)TFO support [enhancement]
    57  After a few attempts of failed MPTCP, directly fallback to TCP for 
new connections [enhancement]
    48  MP_FASTCLOSE support (send part remaining) [enhancement]
    43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag interface 
[enhancement] [syzkaller]
    41  reduce indirect call usage [enhancement]
    24  Revisit layout of struct mptcp_subflow_context [enhancement]


     Recently closed (since last week)

   268  kmemleak: suspected mem leak in msr_build_context() [bug] 
[selftests] @matttbe
     - Alignment issue in x86 arch code.
   267  Kmemleak report with mptcp_connect [bug] [selftests] @mjmartineau
     - Reference counting issue in userspace PM - fixes squashed
   186  Add netlink command support [enhancement] @kmaloor


FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current/Coming merge window (5.18): 
https://github.com/multipath-tcp/mptcp_net-next/projects/14
     - For later: 
https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

            - [c492f39068e2] selftests/bpf: Drop duplicate max/min 
definitions (Geliang Tang)

     - Fixes for other trees:

         - [070aefe5b490] x86/pm: Fix false positive kmemleak report in 
msr_build_context() (Matthieu Baerts)
            - Merged: 
https://lore.kernel.org/all/165106098627.4207.9339334897773264387.tip-bot2@tip-bot2/

     - Fixes for -net:
        - None pending

     - Features for net-next:

         - [a03b05f10487] mptcp: really share subflow snd_wnd (Paolo Abeni)
         - [8296c4050142] mptcp: add mib for xmit window sharing (Paolo 
Abeni)
         - [64fa181719da] tcp: allow MPTCP to update the announced window 
(Paolo Abeni)
         - [1efb25c8f2f9] mptcp: never shrink offered window (Paolo Abeni)
         - [156b6c6a2b62] mptcp: add more offered MIBs counter (Paolo 
Abeni)
            - Ready to send

     - Features for net-next (next):

         - [8053fb8d49ed] selftests: mptcp: add MP_FAIL reset testcase 
(Geliang Tang)
           - Two pending issues: open issue regarding multiple MP_FAIL in 
self test, and dropping of bad data.
           - Prioritize MP_FAIL fixes
           - Follow up on ML to make sure Geliang is not blocked [Mat]

         - [89e7a9a44cd0] mptcp: bypass in-kernel PM restrictions for 
non-kernel PMs (Kishen Maloor)
         - [9c644de3762e] selftests: mptcp: ADD_ADDR echo test with missing 
userspace daemon (Mat Martineau)
         - [a7fcc034b220] mptcp: store remote id from MP_JOIN SYN/ACK in 
local ctx (Kishen Maloor)
         - [cab49bddc766] mptcp: reflect remote port (not 0) in ANNOUNCED 
events (Kishen Maloor)
         - [cd2b6a1ea78b] mptcp: establish subflows from either end of 
connection (Kishen Maloor)
         - [8ddb114e8dc8] mptcp: expose server_side attribute in MPTCP 
netlink events (Kishen Maloor)
            - Second batch, next to be sent after series already posted to 
netdev is merged.

         - [05854bd213ba] mptcp: allow ADD_ADDR reissuance by userspace PMs 
(Kishen Maloor)
         - [a7c6b9cb5ac9] mptcp: handle local addrs announced by userspace 
PMs (Kishen Maloor)
         - [d549cb7f5cbd] mptcp: read attributes of addr entries managed by 
userspace PMs (Kishen Maloor)
         - [9be55418a31f] mptcp: netlink: split mptcp_pm_parse_addr into 
two functions (Florian Westphal)
         - [08f35a937818] mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE (Kishen 
Maloor)
         - [55262999192a] selftests: mptcp: support MPTCP_PM_CMD_ANNOUNCE 
(Kishen Maloor)
         - [141bd3b6ad7f] mptcp: netlink: Add MPTCP_PM_CMD_REMOVE (Kishen 
Maloor)
         - [6e543b5ba6f9] selftests: mptcp: support MPTCP_PM_CMD_REMOVE 
(Kishen Maloor)
         - [1d835bd5681f] mptcp: netlink: allow userspace-driven subflow 
establishment (Florian Westphal)
         - [3b08c6d29698] selftests: mptcp: support 
MPTCP_PM_CMD_SUBFLOW_CREATE (Kishen Maloor)
         - [c28e52832aeb] selftests: mptcp: support 
MPTCP_PM_CMD_SUBFLOW_DESTROY (Kishen Maloor)
         - [15ba7ea78c85] selftests: mptcp: capture netlink events (Kishen 
Maloor)
         - [05f43c2e5606] selftests: mptcp: create listeners to receive 
MPJs (Kishen Maloor)
         - [3402c68b325e] selftests: mptcp: functional tests for the 
userspace PM type (Kishen Maloor)
            - Third userspace PM batch

     - Features for other trees:

         - [ba947123d3d7] bpf: expose is_mptcp flag to bpf_tcp_sock 
(Nicolas Rybowski)
         - [2819631b4882] bpf: add bpf_skc_to_mptcp_sock_proto (Geliang 
Tang)
         - [e9620c459676] selftests: bpf: add MPTCP test base (Nicolas 
Rybowski)
         - [0ecdd13945c8] selftests: bpf: test bpf_skc_to_mptcp_sock 
(Geliang Tang)
         - [bbcf53e23497] selftests: bpf: verify token of struct mptcp_sock 
(Geliang Tang)
         - [c8c1887cd0fe] selftests: bpf: verify ca_name of struct 
mptcp_sock (Geliang Tang)
         - [702b1056a80c] selftests: bpf: verify first of struct mptcp_sock 
(Geliang Tang)
           - Might be ready for v2 - Mat will upstream.


Extra tests:
     - news about Syzkaller? (Christoph / Mat):
         - Nothing new related to MPTCP.

     - news about interop with mptcp.org/other stacks? (Christoph):
         - /

     - news about Intel's kbuild? (Mat):
         - No builds since 24 April, will check with kbuild team

     - packetdrill (Davide):
         - Nothing new

     - Patchew (Davide):
         - Network outage a few days ago, did not affect MPTCP. Dashboard 
looks ok now.

     - CI (Matth):
         - No changes

     - Other test issue
     - Paolo has observed some issues with subflow accounting, where the PM 
thinks there are more active subflows than there really are. Only affects 
in-kernel PM.


LPC:
     - https://lpc.events/event/16/abstracts/
     - Considering a talk proposal for MPTCP userspace path manager. (Mat)
     - Netdev conf also expected in Nov '22 (Lisbon?), likely not 
conflicting with IETF in London.


Next meeting:
     - Thursday, the 5th of May.
     - 15:00 UTC (8am PST, 4pm CET, 11am CST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20220505


--
Mat Martineau
Intel
