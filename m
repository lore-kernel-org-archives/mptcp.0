Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA3F7B
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 15:00:15 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id z92so28468017ede.13
        for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=1znHgQVDhjUKSprq9sDOBwiXuoeRBvBsspsVQva7jXE=;
        b=LXvgOcTO9woDlTni9iASmu0oMs1rlWm+HjIxFe2gqIrIT7rxWHrvBMK5MEDxmWxF52
         9KKU5mIi7g8NCbODlf1n7uKKJPKeems8YsyGEbGA4jLD2RqsChEEEA/3VxnmP5ORaLtu
         7WYO4Sh6SnPzyu1iS5YD3KQ5MoeXJ3+7RVwxg7PGcMkfDeyowU2wNnBmNcTduTGj7Axe
         +qxbGjWmQ9NPD22B3Oauin73n+vvoUtOf9lKBdsMG2Wdf4TdhUERL05IPrfaSaigkNYf
         Fs/8vElDGT0X4UaTDHLGe4Wr2Hhg7KqgrKWvwlU5CYv395NAgkd+BfyBc0Op3pJfM+LF
         Eh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=1znHgQVDhjUKSprq9sDOBwiXuoeRBvBsspsVQva7jXE=;
        b=A64jsKmzSGbrDrbIqFIzouUNHJ/7snHlSkHwXjbReb8eFMZYnKeSfgKvHkXOqvMy/d
         XjKxp8Truyof56noG6M59BESzuNIg/tS1mzXAEIOGZ6cr3AZW0MsIRM+KNzKgtuSSjka
         eFC5diLtIKP8knpuF4qTMnRgVwATQD1KovEf7ga3lTXexdU8uRwARgT6wK7OC1UsNs8u
         Jv2Pn/WrfRMa5BHH/k/TN6263XAFOZ7lKTzoTUzA28kBSFcN4gEZ6A2re51HBjLrCiFs
         moHZgN8VJXEwolq0sWJgb7f6xDVSuWo21O5Ov6rmhmjJizXuaoLMH++xOpYFVcdpoe+n
         22XA==
X-Gm-Message-State: AOAM532ktdOO6p/vPIuPGFtBGHlp0Oqms1JVGgO0v1A1OtYFnwEcIwH4
	5g7IgCGVFHujTAJektrIRoNdIWyLTtXreg==
X-Google-Smtp-Source: ABdhPJxRb7HqQSh3LFsOMEPwPJkuPaLc4ul1cy4q98vRcWIhXy7h0R798NOg1ItlS0UxcBhL2X37qw==
X-Received: by 2002:a05:6402:1385:b0:413:2bc6:4400 with SMTP id b5-20020a056402138500b004132bc64400mr17388132edv.94.1648738812787;
        Thu, 31 Mar 2022 08:00:12 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:67bb:4772:e0be:4bc4? ([2a02:578:8593:1200:67bb:4772:e0be:4bc4])
        by smtp.gmail.com with ESMTPSA id o5-20020a170906974500b006dfc781498dsm9672833ejy.37.2022.03.31.08.00.12
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 08:00:12 -0700 (PDT)
Message-ID: <e2addc0f-da7d-b1e9-acb6-b6bdb764ff62@tessares.net>
Date: Thu, 31 Mar 2022 17:00:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 24th of March 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 189th meeting with Mat, Ossama, Kishen (Intel)
Florian, Paolo (Red Hat), Geliang (SUSE), Poorva and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12784626  [net-next] mptcp: send ADD_ADDR echo before create subflows
12784623  [net] mptcp: Fix crash due to tcp_tsorted_anchor was
initialized befo...


    our repo (by: Geliang Tang, Paolo Abeni):

12789603  [mptcp-next,v11,2/7] Revert "bpf: add 'bpf_mptcp_sock'
structure and ...
12789602  [mptcp-next,v11,1/7] Revert "selftests: bpf: add
bpf_mptcp_sock() ver...

12788718  [v2,mptcp-next,3/3] mptcp: reset the packet scheduler on PRIO
change
12788717  [v2,mptcp-next,2/3] mptcp: reset the packet scheduler on
incoming MP_...
12788716  [v2,mptcp-next,1/3] mptcp: optimize release_cb for the common case

12781144  [mptcp-next,v5,6/6] selftests: mptcp: print extra msg in
chk_csum_nr
12781143  [mptcp-next,v5,5/6] selftests: mptcp: check MP_FAIL response mibs
12781142  [mptcp-next,v5,4/6] mptcp: reset subflow when MP_FAIL doesn't
respond
12781141  [mptcp-next,v5,3/6] mptcp: add MP_FAIL response support
12781140  [mptcp-next,v5,2/6] mptcp: add data lock for sk timers
12781139  [mptcp-next,v5,1/6] mptcp: use mptcp_stop_timer



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang):

12790564  [bpf-next] bpf: Sync comments for bpf_get_stack


    our repo (by: Dmytro SHYTYI, Florian Westphal, Geliang Tang, Jiapeng
Chong, Kishen Maloor, Matthieu Baerts):

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets
12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support
12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data
12321111: RFC: mptcp: Remove redundant assignment to remaining
12714439: RFC: [net-next,v2] net: mptcp, Fast Open Mechanism:
    - RFC

12765701: RFC: [5/4] mptcp: handle join requests early:
    - do we still need it?
    - no, part of a prev series, can be dropped

12783267: Changes Requested: [mptcp-next,v5,01/14] mptcp: allow ADD_ADDR
reissuance by userspace PMs
12783274: Changes Requested: [mptcp-next,v5,02/14] mptcp: handle local
addrs announced by userspace PMs
12783269: Changes Requested: [mptcp-next,v5,03/14] mptcp: read
attributes of addr entries managed by userspace PMs
12783271: Changes Requested: [mptcp-next,v5,04/14] mptcp: netlink: split
mptcp_pm_parse_addr into two functions
12783273: Changes Requested: [mptcp-next,v5,05/14] mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12783270: Changes Requested: [mptcp-next,v5,06/14] selftests: mptcp:
support MPTCP_PM_CMD_ANNOUNCE
12783276: Changes Requested: [mptcp-next,v5,07/14] mptcp: netlink: Add
MPTCP_PM_CMD_REMOVE
12783266: Changes Requested: [mptcp-next,v5,08/14] selftests: mptcp:
support MPTCP_PM_CMD_REMOVE
12783277: Changes Requested: [mptcp-next,v5,09/14] mptcp: netlink: allow
userspace-driven subflow establishment
12783275: Changes Requested: [mptcp-next,v5,10/14] selftests: mptcp:
support MPTCP_PM_CMD_SUBFLOW_CREATE
12783268: Changes Requested: [mptcp-next,v5,11/14] selftests: mptcp:
support MPTCP_PM_CMD_SUBFLOW_DESTROY
12783272: Changes Requested: [mptcp-next,v5,12/14] selftests: mptcp:
capture netlink events
12783279: Changes Requested: [mptcp-next,v5,13/14] selftests: mptcp:
create listeners to receive MPJs
12783278: Changes Requested: [mptcp-next,v5,14/14] selftests: mptcp:
functional tests for the userspace PM type
12784644: Changes Requested: [mptcp-next,v8,1/6] Squash-to: mptcp:
Bypass kernel PM when userspace PM is enabled
12784645: Changes Requested: [mptcp-next,v8,2/6] mptcp: bypass in-kernel
PM restrictions for non-kernel PMs
12784646: Changes Requested: [mptcp-next,v8,3/6] mptcp: store remote id
from MP_JOIN SYN/ACK in local ctx
12784648: Changes Requested: [mptcp-next,v8,4/6] mptcp: reflect remote
port (not 0) in ANNOUNCED events
12784647: Changes Requested: [mptcp-next,v8,5/6] mptcp: establish
subflows from either end of connection
12784649: Changes Requested: [mptcp-next,v8,6/6] mptcp: expose
server_side attribute in MPTCP netlink events:
    - Paolo did a review
    - Kishen will reply and send a new version later


12789684: New: [mptcp-next,v2] mptcp: add pm_nl_pernet helpers:
    - v2 addressing Florian's comments
    - to be reviewed

12790678: New: [mptcp-next,v12,1/5] bpf: add bpf_skc_to_mptcp_sock_proto
12790679: New: [mptcp-next,v12,2/5] Squash to "selftests: bpf: add MPTCP
test base"
12790680: New: [mptcp-next,v12,3/5] selftests: bpf: test
bpf_skc_to_mptcp_sock
12790681: New: [mptcp-next,v12,4/5] selftests: bpf: verify ca_name of
struct mptcp_sock
12790682: New: [mptcp-next,v12,5/5] selftests: bpf: verify first subflow
of mptcp_sock:
    - series: "add skc_to_mptcp_sock"
    - Matth is looking at it → Done

12790709: New: [mptcp-next,1/4] mptcp: diag: switch to context structure
12790708: New: [mptcp-next,2/4] mptcp: remove locking in
mptcp_diag_fill_info
12790710: New: [mptcp-next,3/4] mptcp: listen diag dump support
12790711: New: [mptcp-next,4/4] mptcp: let mptcp listen dump show listen
backlog size:
    - series: "mptcp: listen dump support"
    - linked to issue 163: allow ss dumping msk socket in TCP_LISTEN status
    - to be reviewed

12790724: New: [RESEND,mptcp-next,v5,1/8] mptcp: add struct mptcp_sched_ops
12790725: New: [RESEND,mptcp-next,v5,2/8] mptcp: register default scheduler
12790726: New: [RESEND,mptcp-next,v5,3/8] mptcp: add a new sysctl scheduler
12790727: New: [RESEND,mptcp-next,v5,4/8] mptcp: add sched in mptcp_sock
12790728: New: [RESEND,mptcp-next,v5,5/8] mptcp: add get_subflow wrapper
12790729: New: [RESEND,mptcp-next,v5,6/8] mptcp: add bpf_mptcp_sched_ops
12790730: New: [RESEND,mptcp-next,v5,7/8] selftests: bpf: add bpf_first
scheduler
12790731: New: [RESEND,mptcp-next,v5,8/8] selftests: bpf: add bpf_first
test:
    - just rebased: but easier to increase the version and avoid
"resend" → easier for patches tracking (and for Patchew)
    - For patch 1, Florian suggests to use a global lock and not a
pernet one
    - having a pernet params for the scheduler seems to be difficult
with BPF
    - then we can keep a global list



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 264)

  265  self-tests #94 && #95 failing [bug] [selftests]:
      - seems not too difficult to reproduce
      - Geliang managed to reproduce it
      - It looks like we got 2 checksum failures on 2 different failures:
          - it triggers 2 checksum failures → 2 MP Fail
          - if it is the case, could we make sure we only "break" one
subflow
          - but strange because the 'iptables' rule should mark only one
packet
          - so only one packet should be corrupted on one sublow
      - anybody wants to look at it?


    Bugs (opened, flagged as "bug" and assigned)

  264  selftests: diag: failing on the public CI with the new
debug.config [bug] [selftests] @matttbe:
      - not able to reproduce
      - do we still want to increase the timeout and see if it improves
stuff?


    Bugs (opened and flagged as "bug" and not assigned)

  265  self-tests #94 && #95 failing [bug] [selftests]
  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]

  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]:
      - now assigned to Mat


    In Progress (opened, new feature and assigned)

  261  MP_FAIL echo and retrans [enhancement] @geliangtang:
      - would be good to have a packetdrill test for this one
      - TODO: Matth: update description or create a new ticket just for
packetdrill → Done

  246  Netlink PM events: add one attribute about the connection type
(connect/accept) [enhancement] @kmaloor:
      - Patches are ↑

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva:
      - Poorva is looking at it

  216  The infinite mapping support [enhancement] @geliangtang:
      - last and hard remaining part: drop data that have been corrupted
      - Geliang is looking for help on this one
      - Mat will have a look at alternative ways → at least the 1
subflow case
      - Maybe best to create a new dedicated ticket for that?
      - technically, it is difficult to drop data with the current
architecture:
          - but when does it make sense to drop packets?
          - when a middlebox adds/removes data from a packet without
modifying the DSS?
          - maybe not an issue when there is only one subflow
          - Mat will check that (RFC)
      - TODO: Matth: update description or create a new ticket just for
packetdrill → Done

  186  Add netlink command support [enhancement] @kmaloor:
      - See patches ↑

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

  163  allow ss dumping msk socket in TCP_LISTEN status [enhancement]
      - See patches ↑

   75  BPF: packet scheduler [enhancement] @geliangtang
      - See patches ↑

   74  BPF: path manager [enhancement] @geliangtang


    For later (opened and not assigned assigned)


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

  210  Accept new subflows when the listening socket is closed or bind
to one IP? [enhancement]
  203  PM: server: accept subflows [bug] @kmaloor



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/13
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
    - TODO: Matth: update changelog and ↑ → Done



Patches to send to netdev:

    - Fixes for -net:

        /

    - Features for net-next:

        - http://vger.kernel.org/~davem/net-next.html → it is opened but
only accepting fixes

        - [8c99194e4ca1] mptcp: optimize release_cb for the common case
(Paolo Abeni)
        - [94f81ac775f3] mptcp: reset the packet scheduler on incoming
MP_PRIO (Paolo Abeni)
        - [6eb568345beb] mptcp: reset the packet scheduler on PRIO
change (Paolo Abeni)

    - Features for net-next (next): for after

        - [f015dca53798] mptcp: don't send RST for single subflow
(Geliang Tang)
        - [623ed6883d85] mptcp: add the fallback check (Geliang Tang)
        - [7f7a32f8533a] mptcp: track and update contiguous data status
(Geliang Tang)
        - [9b40e0d4ad8b] mptcp: infinite mapping sending (Geliang Tang)
        - [0933308b06dd] mptcp: infinite mapping receiving (Geliang Tang)
        - [7122939ec384] mptcp: add mib for infinite map sending
(Geliang Tang)
        - [877fd5a73fb0] mptcp: dump infinite_map field in
mptcp_dump_mpext (Geliang Tang)
        - [ec257b716baa] selftests: mptcp: add infinite map mibs check
(Geliang Tang)
        - [e57f3a64017a] selftests: mptcp: add the MP_FAIL testcases
(Geliang Tang)
        - [c0cf8641e2fa] mptcp: use mptcp_stop_timer (Geliang Tang)
        - [6c4b0ff9c68b] mptcp: add data lock for sk timers (Geliang Tang)
        - [2e0d9ed7f6c5] mptcp: add MP_FAIL response support (Geliang Tang)
        - [69aaebaf363d] mptcp: reset subflow when MP_FAIL doesn't
respond (Geliang Tang)
        - [a56d31f71d34] selftests: mptcp: check MP_FAIL response mibs
(Geliang Tang)
        - [17a312f15c11] selftests: mptcp: print extra msg in
chk_csum_nr (Geliang Tang)
        - [f28546d93b95] mptcp: Remove redundant assignments in path
manager init (Mat Martineau)
        - [3d633f028210] mptcp: Add a member to mptcp_pm_data to track
kernel vs userspace mode (Mat Martineau)
        - [a32bfaf74185] mptcp: Bypass kernel PM when userspace PM is
enabled (Mat Martineau)
        - [ccd1eab4676f] mptcp: Make kernel path manager check for
userspace-managed sockets (Mat Martineau)
        - [c646c1c6025f] mptcp: Add a per-namespace sysctl to set the
default path manager type (Mat Martineau)
        - [0e189d4043ed] selftests: mptcp: Add tests for userspace PM
type (Mat Martineau)

    - Features for other trees:

        - [858969ef9202] bpf: expose is_mptcp flag to bpf_tcp_sock
(Nicolas Rybowski)
        - [cad52cb67c26] selftests: bpf: add MPTCP test base (Nicolas
Rybowski)
        - [5d6c077c87f3] selftests: mptcp: Add the uapi headers include
variable (Muhammad Usama Anjum)

For BPF, it looks like they don't close bpf-next:
    - so we can send related patches when they are ready



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - No new failures \o/

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - Seems running OK with the export branch
        - Mat needs to check if export-net is also validated:
            - Still waiting on https://github.com/intel/lkp-tests/pull/125

    - packetdrill (Davide):
        - there is a PR: Davide is going to modify it, should be merged soon
        - Davide is doing more tests with multiple subflows, maybe an
issue with rbuff, to be validated

    - Patchew (Davide):
        - Was down for a few days but back again
        - If you don't see your patches validated by the CI because they
are not listed on patchew.org/MPTCP, do not hesitate to ping Davide

    - CI (Matth):
        - debug.config is too slow, it takes more than 2h to build and
launch all tests in debug mode...
        - also there are some instabilities
        - ideas:
            - split in different jobs (but we might need to update the
list of tests we run in // when there are new ones)
            - "improve" selftests?
            - disable some kconfig having a too high impact?
        - → maybe better to split the tests to keep all the useful debug
stuff
        - how to test only MPTCP BPF selftests?:
            - "./test_progs -a mptcp"
            - it might requires the latest version of LLVM, etc. or with
even non released features
            - but it seems it might be ok to latest released versions
for MPTCP BPF selftests → to check



New Network maintainer:
    - MPTCP modifications can now be applied in net and net-next repo!
    - https://lore.kernel.org/all/20220314222819.958428-1-kuba@kernel.org/
    - Congratulations Paolo :)



Paolo got contacted by people having issues running selftests:
    - at the beginning of these meetings, we can discuss about these
questions
    - doc can also be improved



Next meeting:
    - Next one on Thursday, the 31st of March.
    - 15:00 UTC (8am PST, 4pm CET, 11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220331



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
