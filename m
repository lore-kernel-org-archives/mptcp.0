Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA9D187C
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 14:10:20 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id qk11so4912126ejb.2
        for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 06:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=yY+FsLnDbwrjguicxZGIloHQokZDZlX7LvlnOIXxdD0=;
        b=mST0Ovo+ZcKIt5SxeYtxH1hErHk2JQZ6cSOhmhSgpDRgHwDLpiPpMaGv7LlZqunEiW
         mqEIT0VfrKAwkLpni/xrFSGEkFas0NZtnm62StiLPlIzxa6phF2bA4oPX3HratNzBYI1
         GAlC0ePjsshykh++xjk+f96xp35wTdUOkNIqrYtz7HYWBRFGJ1pXU0l2dV+6644pfBL+
         wMBjmiBN83zwSNq+MBSShXb3GXp8JxzKN0KM8R6p1pSnKC6UpfPbAjI6VPCnYswc+/QF
         VFX0GJuQ4PMEQZk5J3j/rGmnXW1rlstQFypIu0pjuP2pO1FLPnJ2iboBQivvioCF8Xk/
         VJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=yY+FsLnDbwrjguicxZGIloHQokZDZlX7LvlnOIXxdD0=;
        b=VXJdixWh+Z+wuRGKmpOLf1Zl3MKR/WMb4GdIfk4r+E11PcMFRCwKSY+wQQZ/Erf13I
         oF5HVrYhpL6dVNNLGmy2VBiBYmXhJx7HYUkBAV/dpwJPY3C6W5lEaqaKWgSNIF2w0BiD
         pIulhIBrNZs0o+VOTXxyFwfDkpuQMIGhH+5qkmPIQMqGVVr148H/tdhEE9bv+iCAthCy
         v2DCWN6fC4L+jNM5EiJEXXBQ8hW75cpO5JUvc/PacJfazbb4qnxLxedBAggifAihMNQD
         P6PKs6vjKxmWrWoDddk0d6x5lENML7WuNS/rHkwjHIO4vc0VFkn8IyCszcf5LUausdil
         hu6g==
X-Gm-Message-State: AOAM531rSIoca2kM52bhBQRJgVFfAu803r35hdN766/HQfO6w2GZHfMa
	a39oQT6q9PjhxOQGrTF/SDzyL86SrzRqJw==
X-Google-Smtp-Source: ABdhPJyLNh2mBJM0AahCQ89beSWA9BqCuKEM+amtkeOgGZ04j8B0Dvq3mZ5wzVhLCfDDgdGaVOuy2g==
X-Received: by 2002:a17:906:f1cf:b0:6ae:9992:484 with SMTP id gx15-20020a170906f1cf00b006ae99920484mr2459466ejb.607.1645020618218;
        Wed, 16 Feb 2022 06:10:18 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:f860:24ec:64c5:373a? ([2a02:578:8593:1200:f860:24ec:64c5:373a])
        by smtp.gmail.com with ESMTPSA id z10sm5461591ejl.110.2022.02.16.06.10.17
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 06:10:17 -0800 (PST)
Message-ID: <37414d8c-2010-e437-03be-0fa0beb8e858@tessares.net>
Date: Wed, 16 Feb 2022 15:10:17 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 10th of February 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 183rd meeting with Mat, Ossama, Kishen (Intel)
Florian, Paolo, Davide (Red Hat), Geliang (Suse), Giray (Parkyeri) and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12741102  [net,2/2] mptcp: netlink: process IPv6 addrs in creating
listening so...
12741101  [net,1/2] selftests: mptcp: add missing join check

12735908  mptcp: fix msk traversal in mptcp_nl_cmd_set_flags():
    - for stable

12735878  [net-next,9/9] selftests: mptcp: set ip_mptcp in command line
12735877  [net-next,8/9] selftests: mptcp: add set_flags tests in
pm_netlink.sh
12735875  [net-next,7/9] selftests: mptcp: add the id argument for set_flags
12735874  [net-next,6/9] selftests: mptcp: add wrapper for setting flags
12735873  [net-next,5/9] selftests: mptcp: add wrapper for showing addrs
12735876  [net-next,4/9] selftests: mptcp: add ip mptcp wrappers
12735872  [net-next,3/9] selftests: mptcp: add backup with port testcase
12735871  [net-next,2/9] selftests: mptcp: add the port argument for
set_flags
12735870  [net-next,1/9] mptcp: allow to use port and non-signal in
set_flags


    our repo (by: Florian Westphal, Geliang Tang, Matthieu Baerts, Paolo
Abeni):

12740532  [mptcp-net] selftests: mptcp: be more conservative with cookie
MPJ li...

12740069  [mptcp-next] mptcp: mark ops structures as ro_after_init
12739954  [mptcp-next] mptcp: constify a bunch of of helpers

12739949  [mptcp-net,v3,4/4] selftests: mptcp: more robust signal race test
12739948  [mptcp-net,v3,3/4] mptcp: add mibs counter for ignored
incoming optio...
12739947  [mptcp-net,v3,2/4] mptcp: fix race in incoming ADD_ADDR option
proces...
12739950  [mptcp-net,v3,1/4] mptcp: fix race in overlapping signal events

12738491  [mptcp-next,1/4] mptcp: drop port parameter of
mptcp_pm_add_addr_sign...
12738367  [mptcp-next,v2] selftests: mptcp: increase timeout to 20 minutes
12738210  [mptcp-next,2/2] mptcp: add SNDTIMEO setsockopt support
12738209  [mptcp-next,1/2] Squash to "bpf:selftests: add MPTCP test base"

12737118  [mptcp-next] mptcp: drop unneeded type casts for hmac
12736947  [mptcp-next] selftests: mptcp: simplify pm_nl_change_endpoint
12736905  [mptcp-next] selftests: mptcp: adjust output alignment for
more tests
12735449  [mptcp-next] selftests: mptcp: improve 'fair usage on close'
stability

12735032  [v2,mptcp-next] selftests: mptcp: fix diag instability



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang):

12734767  [iproute2-next] mptcp: add the fullmesh flag setting support:
    - TODO: Matth: Check status
    - Mark as Changes requested:
https://patchwork.kernel.org/project/netdevbpf/patch/49c0f49f6aabf0f55a16034b79d30fbceb1bc997.1643945076.git.geliang.tang@suse.com/
    - Maybe in a week or two it could be resent including a reply to
Stephen's question?



    our repo (by: Dmytro SHYTYI, Florian Westphal, Geliang Tang, Jiapeng
Chong, Kishen Maloor, Matthieu Baerts, Paolo Abeni):

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets:
    - WIP

12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
    - WIP

12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data:
    - WIP

12321111: RFC: mptcp: Remove redundant assignment to remaining:
    - WIP

12714439: RFC: [net-next,v2] net: mptcp, Fast Open Mechanism:
    - WIP

12730676: Rejected: [mptcp-next] mptcp: use nla_parse_nested:
    - for stable, was just needed for the reviews

12733865: Needs ACK: [mptcp-next,v5,1/8] mptcp: bypass in-kernel PM
restrictions for non-kernel PMs
12733864: Needs ACK: [mptcp-next,v5,2/8] mptcp: store remote id from
MP_JOIN SYN/ACK in local ctx
12733867: Needs ACK: [mptcp-next,v5,3/8] mptcp: reflect remote port (not
0) in ANNOUNCED events
12733866: Needs ACK: [mptcp-next,v5,4/8] mptcp: establish subflows from
either end of connection
12733868: Needs ACK: [mptcp-next,v5,5/8] mptcp: netlink: store per
namespace list of refcounted listen socks
12733869: Needs ACK: [mptcp-next,v5,6/8] mptcp: netlink: store lsk ref
in mptcp_pm_addr_entry
12733870: Needs ACK: [mptcp-next,v5,7/8] mptcp: attempt to add listening
sockets for announced addrs
12733871: Needs ACK: [mptcp-next,v5,8/8] mptcp: expose server_side
attribute in MPTCP netlink events:
    - Was blocked, waiting for the modifications from Florian
    - See series: "mptcp: replace per-addr listener sockets"

12733808: Needs ACK: [mptcp-next,v4,01/13] mptcp: allow ADD_ADDR
reissuance by userspace PMs
12733811: Needs ACK: [mptcp-next,v4,02/13] mptcp: handle local addrs
announced by userspace PMs
12733810: Needs ACK: [mptcp-next,v4,03/13] mptcp: read attributes of
addr entries managed by userspace PMs
12733817: Needs ACK: [mptcp-next,v4,04/13] mptcp: netlink: split
mptcp_pm_parse_addr into two functions
12733812: Needs ACK: [mptcp-next,v4,05/13] mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12733813: Needs ACK: [mptcp-next,v4,06/13] mptcp: selftests: support
MPTCP_PM_CMD_ANNOUNCE
12733814: Needs ACK: [mptcp-next,v4,07/13] mptcp: netlink: Add
MPTCP_PM_CMD_REMOVE
12733815: Needs ACK: [mptcp-next,v4,08/13] mptcp: selftests: support
MPTCP_PM_CMD_REMOVE
12733821: Needs ACK: [mptcp-next,v4,09/13] mptcp: netlink: allow
userspace-driven subflow establishment
12733816: Needs ACK: [mptcp-next,v4,10/13] mptcp: selftests: support
MPTCP_PM_CMD_SUBFLOW_CREATE
12733818: Needs ACK: [mptcp-next,v4,11/13] mptcp: selftests: support
MPTCP_PM_CMD_SUBFLOW_DESTROY
12733819: Needs ACK: [mptcp-next,v4,12/13] mptcp: selftests: capture
netlink events
12733820: Needs ACK: [mptcp-next,v4,13/13] selftests: mptcp: functional
tests for the userspace PM type:
    - series: "mptcp: APIs and self-tests for userspace path management"

12738492: Rejected: [mptcp-next,2/4] mptcp: add echo bit in mptcp_addr_info
12738493: Rejected: [mptcp-next,3/4] mptcp: drop echo parameter of
mptcp_pm_add_addr_signal
12738494: Rejected: [mptcp-next,4/4] mptcp: drop echo parameter of
mptcp_pm_announce_addr:
    - series: "reflect mptcp_pm_add_addr_signal"
    - first patch has been applied
    - the rest is not needed

12740912: Queued: [mptcp-next,1/9] selftests: mptcp: join: allow running
-cCi
12740913: Queued: [mptcp-next,2/9] selftests: mptcp: join: exit after
usage()
12740917: Under Review: [mptcp-next,3/9] selftests: mptcp: join: option
to execute specific tests
12740914: Queued: [mptcp-next,4/9] selftests: mptcp: join: remove unused
vars
12740915: Queued: [mptcp-next,5/9] selftests: mptcp: join: create tmp
files only if needed
12740916: Queued: [mptcp-next,6/9] selftests: mptcp: join: check for
tools only if needed
12740920: Under Review: [mptcp-next,7/9] selftests: mptcp: join: clarify
local/global vars
12740918: Under Review: [mptcp-next,8/9] selftests: mptcp: join: avoid
backquotes
12740919: Under Review: [mptcp-next,9/9] selftests: mptcp: join: make it
shellcheck compliant:
    - series: "Refactor mptcp_join.sh"
    - a large change might be difficult to manage if:
        - we have fixes for the -net tree → sync with net-next
        - backports
    - Maybe we can keep patch 3/9 but modify each "main" functions to
not do anything if the test is skip, see Paolo's comment
    - the most annoying one might be the patch 7/9:
        - a solution is not to rename "global" variables → Matth


12741376: New: [mptcp-next,v6,1/7] Squash to "mptcp: infinite mapping
receiving"
12741377: New: [mptcp-next,v6,2/7] Squash to "selftests: mptcp: add
infinite map mibs check"
12741378: New: [mptcp-next,v6,3/7] mptcp: add the mibs for MP_RST
12741379: New: [mptcp-next,v6,4/7] selftests: mptcp: add the MP_RST mibs
check
12741380: New: [mptcp-next,v6,5/7] selftests: mptcp: add more arguments
for chk_join_nr
12741381: New: [mptcp-next,v6,6/7] selftests: mptcp: reuse linkfail to
make given size files
12741382: New: [mptcp-next,v6,7/7] selftests: mptcp: add the MP_FAIL
testcases:
    - series: "add mp_fail testcases"
    - there was a "retry" feature that can be dropped if we add delay to
force using a specific subflow
    - Geliang will send a Squash-to patch later (done)

12741730: New: [mptcp-next] Squash to "bpf: add 'bpf_mptcp_sock'
structure and helper":
    - addressing comments sent by BPF maintainers 1.5y ago
    - one remaining questions about how to test that: see the ML
    - in our repo, there is a "scripts" branch with other BPF tests.
    - there is one question for Geliang, see ML

12742030: New: [v2,mptcp-next] mptcp: don't save tcp data_ready and
write space callbacks:
    - addressing Mat's comments

12742037: New: [mptcp-next] mptcp: subflow: get_af_ops should return const:
    - waiting for reviews

12742094: New: [mptcp-next,1/4] mptcp: prefer ip address in syn skb
instead of listen sk bound address
12742095: New: [mptcp-next,2/4] tcp: add mptcp join demultiplex hooks
12742096: New: [mptcp-next,3/4] mptcp: handle join requests via pernet
listen socket
12742097: New: [mptcp-next,4/4] mptcp: remove per-address listening sockets:
    - series "mptcp: replace per-addr listener sockets"
    - solution not add more in-kernel listerner sockets
    - related to discussions from last week
    - to be reviewed

12741647: New: [v2,mptcp-next] mptcp: strict local address ID selection.
    - This fixes the last instabilities with the selftests
    - But also introduce a RFC violation (sorry I miss half of the
conversation)
    - But we were also sending by accident id=0 for subflows that should
not have been 0 (but hard to fix without the refactoring)
    - Should be good to check what is done in mptcp.org → Paolo is going
to check that
    - Probably best to cc Christoph → Paolo will do that.



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 258)

  259  [syzkaller] UBSAN: shift-out-of-bounds in net/mptcp/protocol.c
[bug] [syzkaller] @mjmartineau:
      - Patch already discussed before
      - updated patch proposed


    Bugs (opened, flagged as "bug" and assigned)

  259  [syzkaller] UBSAN: shift-out-of-bounds in net/mptcp/protocol.c
[bug] [syzkaller] @mjmartineau:
      - see above

  203  PM: server: accept subflows [bug] @kmaloor:
      - see patches above → waiting for the new implem from Florian not
to create listening sk


    Bugs (opened and flagged as "bug" and not assigned)

  255  selftests: connect: checksum failed [bug]:
      - might be worrying: when transferring a bit of data, we have a
wrong csum detected → test is not correct, see ML

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]

  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]:
      - linked to "mptcp: strict local address ID selection."

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]


    In Progress (opened, new feature and assigned)

  246  Netlink PM events: add one attribute about the connection type
(connect/accept) [enhancement] @kmaloor:
      - See patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva

  216  The infinite mapping support [enhancement] @geliangtang
      - See patches above

  186  Add netlink command support [enhancement] @kmaloor:
      - See patches above

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] @geliangtang
   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)

  236  Review supported sockopts list [enhancement]
  222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
  215  TCP Urgent pointer and MPTCP [enhancement]
  213  add MPTCP man page [enhancement]
  210  Accept new subflows when the listening socket is closed or bind
to one IP? [enhancement]
  208  better handing of ssk memory pressure in the TX path [enhancement]
  202  Add sendmsg support for ancillary data [enhancement]
  197  more mibs needed [enhancement]
  180  Get an update when MPTCP fall back to TCP [enhancement]
  177  improve retransmit subflow selection [enhancement]
  169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different
port [enhancement] [packetdrill]
  163  allow ss dumping msk socket in TCP_LISTEN status [enhancement]
  150  remove completely workqueue usage [enhancement]
  141  avoid acquiring mptcp_data_lock() twice in the receive path
[enhancement]
  133  PM: Closing the MPTCP connection when last subflow is not the
initial one and its IP address is removed [enhancement]
  128  When the last subflow is closed without DATA_FIN and msk
Established, close msk (after a timeout) [enhancement]
   79  allow 'force to MPTCP' mode: BPF [enhancement]
   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   77  [gs]etsockopt: forward to new/existing SF [enhancement]
   76  [gs]etsockopt per subflow: BPF [enhancement]
   61  move msk clone after ctx creation [enhancement]
   59  (MP)TFO support [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   48  MP_FASTCLOSE support (send part remaining) [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since last week)

  258  selftests: `diag.sh` is regularly failing [bug] [selftests]
  257  selftests: `mptcp_join.sh`: "multi subflows, fair usage on close"
is unstable [bug] [selftests]
  254  selftests: join: `signal invalid addresses` is unstable [bug] @pabeni



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/13
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for -net:

        - [68ede6ffdae1] selftests: mptcp: add missing join check
(Matthieu Baerts)
        - [406773617956] mptcp: netlink: process IPv6 addrs in creating
listening sockets (Kishen Maloor):
            - in -net, not in net-next yet

        - [d048fe891950] selftests: mptcp: fix diag instability (Paolo
Abeni)
        - [0be2ef680bc3] selftests: mptcp: improve 'fair usage on close'
stability (Paolo Abeni):
            - was initially for net-next but they are fixing issues so
good to have them in -net
            - there for a bit of time so ready for netdev

        - [86b66dc16670] mptcp: fix race in overlapping signal events
(Paolo Abeni)
        - [c8b8d00c4104] mptcp: fix race in incoming ADD_ADDR option
processing (Paolo Abeni)
        - [856fdbf84fc1] mptcp: add mibs counter for ignored incoming
options (Paolo Abeni)
        - [1b0f1c6fc6fe] selftests: mptcp: more robust signal race test
(Paolo Abeni):
            - has been applied "recently" (earlier this week), seems
working fine

        - [37d2aec3b4c5] selftests: mptcp: be more conservative with
cookie MPJ limits (Paolo Abeni):
            - can wait a bit: applied today


    - Features for net-next:

        - [5496b7df6b8d] mptcp: don't send RST for single subflow
(Geliang Tang)
        - [5691fc6246b9] mptcp: add the fallback check (Geliang Tang)
        - [665b151556a3] mptcp: track and update contiguous data status
(Geliang Tang)
        - [c5d3e50d93e6] mptcp: infinite mapping sending (Geliang Tang)
        - [0801028313b6] mptcp: infinite mapping receiving (Geliang Tang)
        - [c21b90bcda04] mptcp: add mib for infinite map sending
(Geliang Tang)
        - [04e71409d411] selftests: mptcp: add invert check in
check_transfer (Geliang Tang)
        - [7334fe2429c4] selftests: mptcp: add infinite map mibs check
(Geliang Tang):
            - there are pending patches for this series

        - [07be0f6c301a] mptcp: Remove redundant assignments in path
manager init (Mat Martineau)
        - [4c9b5f7ff54d] mptcp: Add a member to mptcp_pm_data to track
kernel vs userspace mode (Mat Martineau)
        - [348246d10e53] mptcp: Bypass kernel PM when userspace PM is
enabled (Mat Martineau)
        - [c678cc05a800] mptcp: Make kernel path manager check for
userspace-managed sockets (Mat Martineau)
        - [47f260e4b4e0] mptcp: Add a per-namespace sysctl to set the
default path manager type (Mat Martineau)
        - [d26ea2e8150c] selftests: mptcp: Add tests for userspace PM
type (Mat Martineau):
            - Linked to Kishen's series, that can wait a bit more

        - [91988d797286] selftests: mptcp: increase timeout to 20
minutes (Matthieu Baerts)

        - [040d33e003b2] selftests: mptcp: adjust output alignment for
more tests (Geliang Tang)

        - [2b291bfccab9] selftests: mptcp: simplify
pm_nl_change_endpoint (Geliang Tang)

        - [bb5dfeea3b9e] mptcp: mptcp_parse_option is no longer exported
(Matthieu Baerts)

        - [94713dc46a37] mptcp: drop unused sk in mptcp_get_options
(Geliang Tang)

        - [f4d221d49cda] mptcp: use MPTCP_SUBFLOW_NODATA (Geliang Tang)

        - [c81eeedbc53d] mptcp: drop unneeded type casts for hmac
(Geliang Tang)

        - [0cd21f580ce6] mptcp: drop port parameter of
mptcp_pm_add_addr_signal (Geliang Tang)

        - [3c0376615b84] mptcp: add SNDTIMEO setsockopt support (Geliang
Tang)

        - [82be488b5f48] mptcp: constify a bunch of of helpers (Paolo Abeni)

        - [227ec5406c0e] mptcp: mark ops structures as ro_after_init
(Florian Westphal)

     → "small" patches not really related to each others: they can
probably all be sent but the last ones have been recently applied so we
can split that and send those later



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - One issue with UBSAN, 259
        - rest is fine

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - similar instabilities that should be fixed soon thanks to
Paolo's patches
        - Saw "# 67 flush subflows and signal with port", seems linked
to issue 225, addressed by Paolo's patch
        - the same splat we saw has been seen there → introduced and
fixed by Eric

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - Still running, good!
        - the importer node will need to be migrated to another place
        - that will be done next week → if a patch is not visible there
(CI is not testing your patch), maybe because of that.

    - CI (Matth):
        - getting greener \o/
        - thanks Paolo!
        - timeout for the selftests have been increased, from 10 to 20
min per test



mptcpd 0.9:
    - going to be accepted in Fedora soon
    - hopefully in Debian too:
        - https://mentors.debian.net/package/mptcpd/
        - https://ftp-master.debian.org/new/mptcpd_0.9-1.html




Next meeting:
    - Next one on Thursday, the 17th of February.
    - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220217



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
