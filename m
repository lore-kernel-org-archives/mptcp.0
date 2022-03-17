Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B6C2F31
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 17:11:29 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id bg10so12130147ejb.4
        for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to
         :subject:content-transfer-encoding;
        bh=0MWU3a81VPXnz3SRVxueH6IoIjJISp48j1EZsOEnSSA=;
        b=banyOmx0SvYYW7gA0F9JoUgErfyciaY1hp/3FBoZNYvW/G6yKAlZdu/XJu7wokmmaD
         cSia/fxl03uYTm2u4SaTqG9yPxJXk+QvdQ7PtnGuKaWhlSgKcRDY+QrA5upB5Srpe+jw
         y4QtStu6QBCcjAAdcToMDU8bkr1c2Y064G7O4ySM1GksMdXL4TEL0GeKEP3lTo1PkCIz
         B5vxCrTWQgVGvs7gVsYM5+yPtdxq/glPMt5Y2w/iPLrfK+JZY5OEVi5iR9jCxq92xTHp
         WyOm3lFKujMNQ5ubvJbZ6zoHhggup49Tqimo0qYCpKk+4yzSsEvScjr2JkL5na/VIvcU
         8XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:subject:content-transfer-encoding;
        bh=0MWU3a81VPXnz3SRVxueH6IoIjJISp48j1EZsOEnSSA=;
        b=gFjUlkpykUUVzD3K9ukj+Z28SA8Hqo15TY22J6Pv/IqSRSpnuQsND5Yn1efXp6PkGb
         ONDYAWlJYmy0jYNFQkDOG2cVtmzmeieMAzLUoRwI+E62FiUGqPnZ3Xge6l4rPDFlUEix
         1qqov9pwFJnacZBuLa6QwJsWOTBnt3qNcM6ebE1Y1uZqCHkmCcxECRTMjRUSCwU0iV1t
         Qldd0GnuwZ0qeUMf8FnviTfd28JwFOGH5kqaQKlOhBq+68Uzlk2ut5ktAqvJIUlD/PHS
         hvuFKsgGb/TT/02wC4mIXwVXivo6vElMUjK0WkRTD0i2A6YoAx2Iurzkd/XCnuE3BKeb
         Yx5g==
X-Gm-Message-State: AOAM530WEUYY1fGsngThBOiVYtkokdUQUSobH9T4jAVojfVCNnn4qMUR
	SjVUp7HEW3WeN6a1CqddqGiRXBBfBEBXFQ==
X-Google-Smtp-Source: ABdhPJyZx6m3tqv9gjlFvx/BHh/mhE6bG6A6mi4LFJ83uvju5GaNcqPq9q4lognw8vn3snQHQQSfNw==
X-Received: by 2002:a17:906:1e13:b0:6d1:5042:e8c1 with SMTP id g19-20020a1709061e1300b006d15042e8c1mr5547647ejj.354.1647537086891;
        Thu, 17 Mar 2022 10:11:26 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:112d:b226:da71:ca81? ([2a02:578:8593:1200:112d:b226:da71:ca81])
        by smtp.gmail.com with ESMTPSA id x12-20020a50d9cc000000b0040f70fe78f3sm3046041edj.36.2022.03.17.10.11.26
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 10:11:26 -0700 (PDT)
Message-ID: <3fb7c787-a793-de7b-5224-92e34dd7ff8a@tessares.net>
Date: Thu, 17 Mar 2022 18:11:25 +0100
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
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 17th of March 2022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This Thursday, we had our 188th meeting with Mat, Ossama, Kishen (Intel)
Paolo, Davide (Red Hat), and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12775482  [net-next,10/10] selftests: mptcp: join: make it shellcheck
compliant
12775481  [net-next,09/10] selftests: mptcp: join: avoid backquotes
12775479  [net-next,08/10] selftests: mptcp: join: clarify local/global vars
12775483  [net-next,07/10] selftests: mptcp: join: helper to filter TCP
12775480  [net-next,06/10] selftests: mptcp: join: list failure at the end
12775478  [net-next,05/10] selftests: mptcp: join: alt. to exec specific
tests
12775477  [net-next,04/10] selftests: mptcp: join: option to execute
specific t...
12775476  [net-next,03/10] selftests: mptcp: join: reset failing links
12775475  [net-next,02/10] selftests: mptcp: join: define tests groups once
12775474  [net-next,01/10] selftests: mptcp: drop msg argument of
chk_csum_nr


    our repo (by: Yonglong Li):

12774895  mptcp: Fix crash due to tcp_tsorted_anchor was initialized
before rel...



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Dmytro SHYTYI, Florian Westphal, Geliang Tang, Jiapeng
Chong, Kishen Maloor, Mat Martineau, Matthieu Baerts):

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
    - RFCs

12714439: RFC: [net-next,v2] net: mptcp, Fast Open Mechanism:
    - any news?

12759420: RFC: [RFC,mptcp-next,1/4] mptcp: Move some symbols to be
visible outside the MPTCP subsystem
12759421: RFC: [RFC,mptcp-next,2/4] tcp: Allow tcp_check_req() to return
more status values
12759422: RFC: [RFC,mptcp-next,3/4] tcp: Check for the presence of a
MP_JOIN option
12759423: RFC: [RFC,mptcp-next,4/4] tcp: Add TCP hooks for detecting
MP_JOIN on a regular TCP listener
12765701: RFC: [5/4] mptcp: handle join requests early:
    - series: "MP_JOIN fallback for TCP listeners"
    - see discussion from last week, we will not go into this direction
    - → Rejected

12758811  [mptcp-next,4/4] mptcp: remove per-address listening sockets
12758810  [mptcp-next,3/4] mptcp: handle join requests via pernet listen
socket
12758808  [mptcp-next,2/4] tcp: add mptcp join demultiplex hooks
12758809  [mptcp-next,1/4] mptcp: prefer ip address in syn skb instead
of liste...:
    - see discussion from last week, we will not go into this direction
    - → Rejected

12774701: Queued: [mptcp-next,v10,1/5] Revert "selftests: bpf: add
bpf_mptcp_sock() verifier tests"
12774702: Queued: [mptcp-next,v10,2/5] Revert "bpf: add 'bpf_mptcp_sock'
structure and helper"
12774703: Queued: [mptcp-next,v10,3/5] bpf: add bpf_skc_to_mptcp_sock_proto
12774704: Queued: [mptcp-next,v10,4/5] Squash to "selftests: bpf: add
MPTCP test base"
12774705: Queued: [mptcp-next,v10,5/5] selftests: bpf: test
bpf_skc_to_mptcp_sock:
    - series: "add add skc_to_mptcp_sock"
    - can be applied and sent to BPF maintainers
    - TODO: Matth: to apply

12779222: New: [mptcp-next,1/3] Squash to "selftests: bpf: test
bpf_skc_to_mptcp_sock"
12779223: New: [mptcp-next,2/3] selftests: bpf: verify ca_name of struct
mptcp_sock
12779224: New: [mptcp-next,3/3] selftests: bpf: verify first subflow of
mptcp_sock
12779257: New: [mptcp-next,v3] Squash to "selftests: bpf: verify ca_name
of struct mptcp_sock":
    - Matth will have a look at these patches

12781139: Under Review: [mptcp-next,v5,1/6] mptcp: use mptcp_stop_timer
12781140: Under Review: [mptcp-next,v5,2/6] mptcp: add data lock for sk
timers
12781141: Under Review: [mptcp-next,v5,3/6] mptcp: add MP_FAIL response
support
12781142: Under Review: [mptcp-next,v5,4/6] mptcp: reset subflow when
MP_FAIL doesn't respond
12781143: Under Review: [mptcp-next,v5,5/6] selftests: mptcp: check
MP_FAIL response mibs
12781144: Under Review: [mptcp-next,v5,6/6] selftests: mptcp: print
extra msg in chk_csum_nr:
    - series: "MP_FAIL echo and retrans"
    - Mat is reviewing them

12784219: New: [mptcp-next,v7,1/5] mptcp: bypass in-kernel PM
restrictions for non-kernel PMs
12784220: New: [mptcp-next,v7,2/5] mptcp: store remote id from MP_JOIN
SYN/ACK in local ctx
12784221: New: [mptcp-next,v7,3/5] mptcp: reflect remote port (not 0) in
ANNOUNCED events
12784222: New: [mptcp-next,v7,4/5] mptcp: establish subflows from either
end of connection
12784223: New: [mptcp-next,v7,5/5] mptcp: expose server_side attribute
in MPTCP netlink events:
    - series: mptcp: fixes and enhancements related to path management
    - the new version: Dropped framework and functionality around the
use of kernel listening sockets for receiving MPJs.
    - the rest is almost the same as in February
    - To be reviewed

12783267: New: [mptcp-next,v5,01/14] mptcp: allow ADD_ADDR reissuance by
userspace PMs
12783274: New: [mptcp-next,v5,02/14] mptcp: handle local addrs announced
by userspace PMs
12783269: New: [mptcp-next,v5,03/14] mptcp: read attributes of addr
entries managed by userspace PMs
12783271: New: [mptcp-next,v5,04/14] mptcp: netlink: split
mptcp_pm_parse_addr into two functions
12783273: New: [mptcp-next,v5,05/14] mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE
12783270: New: [mptcp-next,v5,06/14] selftests: mptcp: support
MPTCP_PM_CMD_ANNOUNCE
12783276: New: [mptcp-next,v5,07/14] mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
12783266: New: [mptcp-next,v5,08/14] selftests: mptcp: support
MPTCP_PM_CMD_REMOVE
12783277: New: [mptcp-next,v5,09/14] mptcp: netlink: allow
userspace-driven subflow establishment
12783275: New: [mptcp-next,v5,10/14] selftests: mptcp: support
MPTCP_PM_CMD_SUBFLOW_CREATE
12783268: New: [mptcp-next,v5,11/14] selftests: mptcp: support
MPTCP_PM_CMD_SUBFLOW_DESTROY
12783272: New: [mptcp-next,v5,12/14] selftests: mptcp: capture netlink
events
12783279: New: [mptcp-next,v5,13/14] selftests: mptcp: create listeners
to receive MPJs
12783278: New: [mptcp-next,v5,14/14] selftests: mptcp: functional tests
for the userspace PM type:
    - series: mptcp: APIs and self-tests for userspace path management
    - for the listener bit, it is relying on the userspace to create the
listener sockets (support added in pm_nl_ctl)
    - Mat will send a new 'patchew/*' tag combining series 1 and 2 to
get some feedback from the CI
    - To be reviewed

12783882: New: [mptcp-next,1/5] mptcp: add a new sysctl scheduler
12783883: New: [mptcp-next,2/5] mptcp: add struct mptcp_sched_ops
12783884: New: [mptcp-next,3/5] mptcp: add bpf_mptcp_sched_ops
12783885: New: [mptcp-next,4/5] selftests: bpf: implement bpf_first
scheduler
12783886: New: [mptcp-next,5/5] selftests: bpf: add mptcp sched test
12783894: New: [mptcp-next] Squash to "mptcp: add a new sysctl scheduler":
    - series: "BPF packet scheduler"
    - to be reviewed



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 264)

/

    Bugs (opened, flagged as "bug" and assigned)

  264  selftests: diag: failing on the public CI with the new
debug.config [bug] [selftests] @matttbe:
      - Matth will try to reproduce it  and implement the suggested solution

  203  PM: server: accept subflows [bug] @kmaloor:
      - can be closed if this has to be handled by the userspace PM
      - TODO Matth: close → Done


    Bugs (opened and flagged as "bug" and not assigned)

  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]


    In Progress (opened, new feature and assigned)

  261  MP_FAIL echo and retrans [enhancement] @geliangtang:
      - See patches above

  246  Netlink PM events: add one attribute about the connection type
(connect/accept) [enhancement] @kmaloor:
      - See patches above

  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva

  216  The infinite mapping support [enhancement] @geliangtang

  186  Add netlink command support [enhancement] @kmaloor
      - See patches above

  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
      - See patches above

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

None.



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.18):
https://github.com/multipath-tcp/mptcp_net-next/projects/13
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - [07860dc4d44a] mptcp: Fix crash due to tcp_tsorted_anchor was
initialized before release skb (Yonglong Li):
            - Mat will send it this week

    - net-next:
        - [1ac16e2cbcfc] mptcp: send ADD_ADDR echo before create
subflows (Yonglong Li):
            - Mat will send it this week

    - net-next-next:
        - [2a5bf2846ad1] mptcp: don't send RST for single subflow
(Geliang Tang)
        - [c3f1e01f32dc] mptcp: add the fallback check (Geliang Tang)
        - [3910d584f8bb] mptcp: track and update contiguous data status
(Geliang Tang)
        - [a842af22088b] mptcp: infinite mapping sending (Geliang Tang)
        - [2dc9f2b2ac85] mptcp: infinite mapping receiving (Geliang Tang)
        - [27627bc940ef] mptcp: add mib for infinite map sending
(Geliang Tang)
        - [3717d131b288] mptcp: dump infinite_map field in
mptcp_dump_mpext (Geliang Tang)
        - [8595b4467eb4] selftests: mptcp: add infinite map mibs check
(Geliang Tang)
        - [9f96f46a860d] selftests: mptcp: add the MP_FAIL testcases
(Geliang Tang)

        - [65a3b16a25bb] mptcp: Remove redundant assignments in path
manager init (Mat Martineau)
        - [9569f50ee6c0] mptcp: Add a member to mptcp_pm_data to track
kernel vs userspace mode (Mat Martineau)
        - [585b797f9f0a] mptcp: Bypass kernel PM when userspace PM is
enabled (Mat Martineau)
        - [9167ab77ab21] mptcp: Make kernel path manager check for
userspace-managed sockets (Mat Martineau)
        - [b914b69b0756] mptcp: Add a per-namespace sysctl to set the
default path manager type (Mat Martineau)
        - [aecefd8ffebc] selftests: mptcp: Add tests for userspace PM
type (Mat Martineau)



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - Nothing new \o/

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - broken / trying to keep up
        - building both export and export-net

    - packetdrill (Davide):
        - Davide added more tests, see PR:
            https://github.com/multipath-tcp/packetdrill/pull/82
        - checking backup/non backup SF
        - kernel patch coming later

    - Patchew (Davide):
        - /

    - CI (Matth):
        - now validating both export and export-net branches
        - there are new branches in the repo hosting the script to run
the selftests
        - one branch per kernel version in packetdrill


New tree:
    - There are now:
        - two bases: net & net-next
        - two tops: t/upstream & t/upstream-net
        - two exports: export & export-net
        - two 'for-review': for-review & for-review-net
    - There is an explicit merge commit to switch from net to net-next.
    - Also some topic are duplicated (KASAN support) to stay at the top
or when it is specific (CI for -net).
    - Export for -net should only be updated if there is a need.
    - The 'net' base is the common commit ('git merge-base') between net
and net-next. We do that to avoid having to deal with conflicts from
elsewhere than MPTCP code.


- export branch:

* df0e2a4c394f DO-NOT-MERGE: mptcp: enabled by default
* 716dfed92db1 DO-NOT-MERGE: mptcp: use kmalloc on kasan build
* 451fd4bb64cd DO-NOT-MERGE: git markup: features other trees
* 8293590c8ef4 selftests: mptcp: Add the uapi headers include variable
* 241c92f25e5e selftests: bpf: add bpf_mptcp_sock() verifier tests
* fcf7717f179c selftests: bpf: add MPTCP test base
* 6b275511acfd bpf: add 'bpf_mptcp_sock' structure and helper
* 29abe199b007 bpf: expose is_mptcp flag to bpf_tcp_sock
* e02ad5531c65 DO-NOT-MERGE: git markup: features net-next-next
* aecefd8ffebc selftests: mptcp: Add tests for userspace PM type
* b914b69b0756 mptcp: Add a per-namespace sysctl to set the default path
manager type
* 9167ab77ab21 mptcp: Make kernel path manager check for
userspace-managed sockets
* 585b797f9f0a mptcp: Bypass kernel PM when userspace PM is enabled
* 9569f50ee6c0 mptcp: Add a member to mptcp_pm_data to track kernel vs
userspace mode
* 65a3b16a25bb mptcp: Remove redundant assignments in path manager init
* 9f96f46a860d selftests: mptcp: add the MP_FAIL testcases
* 8595b4467eb4 selftests: mptcp: add infinite map mibs check
* 3717d131b288 mptcp: dump infinite_map field in mptcp_dump_mpext
* 27627bc940ef mptcp: add mib for infinite map sending
* 2dc9f2b2ac85 mptcp: infinite mapping receiving
* a842af22088b mptcp: infinite mapping sending
* 3910d584f8bb mptcp: track and update contiguous data status
* c3f1e01f32dc mptcp: add the fallback check
* 2a5bf2846ad1 mptcp: don't send RST for single subflow
* 5dd673eac0e9 DO-NOT-MERGE: git markup: features net-next
* 1ac16e2cbcfc mptcp: send ADD_ADDR echo before create subflows
* 449ef1268460 DO-NOT-MERGE: git markup: fixes net-next
*   6e88005deb38 TopGit-driven merge of branches:
|\
| * 6a0c27a48734 DO-NOT-MERGE: git markup: end common net net-next
| * eb3ed595883c DO-NOT-MERGE: mptcp: add CI support
| * 6dc21f00086e DO-NOT-MERGE: git markup: fixes net
| * 07860dc4d44a mptcp: Fix crash due to tcp_tsorted_anchor was
initialized before release skb
| * 999a98e0796e DO-NOT-MERGE: git markup: fixes other trees
| * 0a4c91e58a53 DO-NOT-MERGE: git markup: net
* 555741234e8c DO-NOT-MERGE: git markup: net-next

- export-net branch:

* 30a3e35d0090 DO-NOT-MERGE: mptcp: enabled by default (net)
* 237e98afcc75 DO-NOT-MERGE: mptcp: use kmalloc on kasan build (net)
* 4adb0b7ed9d5 DO-NOT-MERGE: mptcp: CI: switching to -net
* 03cc096c1352 DO-NOT-MERGE: git markup: fixes net only
* e4fc9875f228 DO-NOT-MERGE: git markup: end common net net-next
* 6a342b0fca4a DO-NOT-MERGE: mptcp: add CI support
* ca7eebdbb71a DO-NOT-MERGE: git markup: fixes net
* dee55cdd7aa8 mptcp: Fix crash due to tcp_tsorted_anchor was
initialized before release skb
* 9a90b32bf38d DO-NOT-MERGE: git markup: fixes other trees
* d319ce1c8f50 DO-NOT-MERGE: git markup: net

→ we can see the same commit (mptcp: Fix crash due to tcp_tsorted_anchor
was initialized before release skb) in both branches



Documentation:
    - Seems needed: https://blog.benjojo.co.uk/post/multipath-without-mptcp
    - https://www.multipath-tcp.org/ → new message in red about the
upstream project
    - The wiki home page should probably be improved:
        - separate kernel dev info vs user dev info (and refer to
another page about MPTCP in general)
        - Tessares owns mptcp.dev:
            - this could be used to host a webserver using the MPTCP
upstream kernel + eventually replace the wiki page
            - but no resource to work on that now :-/
            - GH pages could be use for the main page but not running MPTCP:
                - it seems we can do that with the multipath-tcp account
on GitHub
            - there could be a dedicated subdomain for the tests
        - any help is welcome :-)



Next events:
    - LPC: Dublin: 12–14 Sep 2022
    - Netdev: Maybe Portugal, maybe October/November?
    - Anything about MPTCP?



Next meeting:
    - Next one on Thursday, the 24th of March.
    - /!\ DIFFERENT UTC time /!\: 15:00 UTC (8am PST, 4pm CET,
11am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20220324



Feel free to comment on these points and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
