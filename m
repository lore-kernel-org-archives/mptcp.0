Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2525665
	for <mptcp@lists.linux.dev>; Mon,  6 Mar 2023 16:56:20 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id cw28so41436160edb.5
        for <mptcp@lists.linux.dev>; Mon, 06 Mar 2023 08:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678121778;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8ljWzwn0F4PGacd4siApR2ZUveQYeWk+ndIW249OcM=;
        b=M78pB7XEqb/Sz5fBHBLV7sxvftpNQdftMzDK3/axR/RmrsB71DqUTnbSnioYfGEZVk
         I95lBj4mXejrZQx9k8EKVUJa/IlqBTji4cH5bjtIhVvS/0LKf77nWg4iDHsLMikZ/n6k
         ToSueeY2c14h3c+fkTX+6lTqcbN8nmqPwJMhyzYG5FZe0G90213CMPK6EsfwHoLFl6A/
         ZI70UGeu01F8ueRa8DSV8MTpQd5absqNc8vf0i8ya/GBWvgqbD5FTRyJvivndwv/Ywq6
         VidObxZsUjYj0Npq/j3+ukMR2rK7KLslDpbyHN4p1gEX5YVtHdv2+IES6Oa73CRcjdyr
         cGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678121778;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K8ljWzwn0F4PGacd4siApR2ZUveQYeWk+ndIW249OcM=;
        b=XSv1TxTggmkkz8Fh8nK1YFZo2ubc5Pe1AxMaYhoSAK3gUbfya5vQOGACL2/WjODB3o
         ScSzAOQ9C7QHxJlWZPYdGnzHrgY/eNrgUGJRxDMMOLhKgSCgNe0TZ29umEWVwMRvgs8p
         OzpE7rvFh4q8ZUbyNWqy8kbRE1hGtZJjP/QZfM7XUg87DPK3THrTM6I/HXlNMInGvQgb
         io7ISf4c5GdvXf9gOYYPvVlLQfv2xZpL2NqecoBnpaE5niA4B20+67LQ0saZ3eeZt964
         8Max4gF5K0A8i32xFgIuiH9l9+xlyIQGh0y+CByNmpJoKerfbrpYsr+I7BItkK8VliEX
         YJww==
X-Gm-Message-State: AO0yUKVigOnuQ6zAnj8aZTxzaECOkh3DMDkT2b1sD+rkTXVIG0w52cT3
	ZgUWFBaD/HZAJPz0jbGz4KJqfhSw40KYflb39kE=
X-Google-Smtp-Source: AK7set8JQZ+LNE9voNvoMzMgi/tqllHK3C/bhlX9AnzySqzwBb86FKSngIbFmIMK2nH7X01Vcjpz5A==
X-Received: by 2002:a05:6402:6d2:b0:4af:51b6:fe49 with SMTP id n18-20020a05640206d200b004af51b6fe49mr12784200edy.13.1678121778284;
        Mon, 06 Mar 2023 08:56:18 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id hy26-20020a1709068a7a00b008d92897cc29sm4792789ejc.37.2023.03.06.08.56.17
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 08:56:18 -0800 (PST)
Message-ID: <4db89e7b-7d87-191b-90dc-8d1098520183@tessares.net>
Date: Mon, 6 Mar 2023 17:56:17 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 28th of February 2022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our 231st meeting with Christoph (Apple), Paolo (Red
Hat), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:

Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Hangbin Liu):

13150950: [PATCHv3,bpf-next,1/2] selftests/bpf: move SYS() macro into
the test_progs.h
13150951: [PATCHv3,bpf-next,2/2] selftests/bpf: run mptcp in a dedicated
netns:
      - Series: move SYS() macro to test_progs.h and run mptcp in a
dedicated netns
      - Submitter: Hangbin Liu
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=724537&state=*&archive=both


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

13142838: [mptcp-next] selftests: mptcp: userspace pm: fix printed values:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230216-mptcp-selftests-userspace-pm-typo-expected-v1-1-e004734154d6@tessares.net/

13148242: [mptcp-net,1/2] mptcp: avoid setting TCP_CLOSE state twice
13148243: [mptcp-net,2/2] Squash-to: DO-NOT-MERGE: mptcp: use kmalloc on
kasan build:
      - Series: mptcp: avoid tcp_done() on already closed sockets
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=723830&state=*&archive=both

13149808: [mptcp-next] mptcp: add ro_after_init for tcp{,v6}_prot_override:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/f2d3a14b9382645f8770ad6496fcba6db699ad19.1677123443.git.geliang.tang@suse.com/

13151205: [mptcp-net] mptcp: fix lockdep false positive in
mptcp_pm_nl_create_listen_socket():
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/011f8740491f4cbbdc7b568551a2b44fab942ab5.1677240111.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13153933: [net,1/7] mptcp: fix possible deadlock in subflow_error_report
13153934: [net,2/7] mptcp: refactor passive socket initialization
13153935: [net,3/7] mptcp: use the workqueue to destroy unaccepted sockets
13153936: [net,4/7] mptcp: fix UaF in listener shutdown
13153937: [net,5/7] selftests: mptcp: userspace pm: fix printed values
13153938: [net,6/7] mptcp: add ro_after_init for tcp{,v6}_prot_override
13153939: [net,7/7] mptcp: avoid setting TCP_CLOSE state twice:
      - Series: mptcp: fixes for 6.3
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=725263&state=*&archive=both


    our repo (by: Geliang Tang, Jiapeng Chong, Matthieu Baerts, Paolo
Abeni):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining:
      - State: RFC
      - Series: mptcp: Remove redundant assignment to remaining
      - Submitter: Jiapeng Chong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=500495&state=*&archive=both
      - Status: same as last week

13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
      - State: Changes requested
      - Series: BPF redundant scheduler, part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
      - Status: same as last week

13127109: [mptcp-next,v3] mptcp: update userspace pm mptcp_info fields:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/7f695489e0ecba3f0951193be81a1620b1f8e6e7.1675410794.git.geliang.tang@suse.com/
      - Status: same as last week

13146706: [mptcp-net] Revert "mptcp: fix locking for in-kernel listener
creation":
      - State: Changes requested
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/1cde3460ddf2e5fa7be0e81dd2c3060a663d4ccc.1676909181.git.pabeni@redhat.com/
      - replaced by another patch

13150136: [mptcp-net] mptcp: do not fill info not used by the PM in used:
      - State: New
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20230223-mptcp-diag-info-limits-in-kernel-pm-v1-1-699561f9f9f4@tessares.net/
      - not to display limits that are not used

13155054: [mptcp-net,1/2] Squash-to: mptcp: use the workqueue to destroy
unaccepted sockets
13155055: [mptcp-net,2/2] Squash-to: "mptcp: fix UaF in listener shutdown":
      - State: New
      - Series: [mptcp-net,1/2] Squash-to: mptcp: use the workqueue to
destroy unaccepted sockets
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=725561&state=*&archive=both:
          - first patch is a real fix
          - second patch is a cleanup
          - could be good to apply them soon and have feedback from
syzkaller to be able to send the patches later



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 362):

  366  syzkaller: WARNING: refcount bug in `inet_csk_listen_stop` [bug]
[syzkaller] [reproducer] [bisected]:
      - should be fixed by Paolo's patches

  364  syzkaller: memory leak in `tcp_get_metrics` [bug] [syzkaller]:
      - happened once
      - (usually no reproducers for kmemleaks)

  363  syzkaller: BUG: soft lockup in `mptcp_retransmit_timer` [bug]
[syzkaller]:
      - happened once


    Bugs (opened, flagged as "bug" and assigned)

  329  PM: userspace: update `MPTCP_INFO` fields [bug] [pm] @geliangtang:
      - see patches above

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - see patches in our tree


    Bugs (opened and flagged as "bug" and not assigned)

  366  syzkaller: WARNING: refcount bug in `inet_csk_listen_stop` [bug]
[syzkaller] [reproducer] [bisected]:
      - see patches above

  364  syzkaller: memory leak in `tcp_get_metrics` [bug] [syzkaller]:
      - happened once

  363  syzkaller: BUG: soft lockup in `mptcp_retransmit_timer` [bug]
[syzkaller]:
      - happened once

  360  syzkaller: INFO: rcu detected stall in `mptcp_pm_add_timer` [bug]
[syzkaller]:
      - happened once

  356  syzkaller: memory leak in `subflow_create_ctx` [bug] [syzkaller]:
      - happened twice but quite rare

  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched]
  336  Issues with BPF packet scheduler [bug]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: test 98 `fastclose test` is sometimes
failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  315  Issues with backup flow [bug]
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  353  sockopt: uniform code to get/set values [enhancement] @matttbe

  340  netlink: switch to YAML Netlink specs [enhancement] @dcaratti:
      - Davide made some progress
      - Real documentation for our Netlink API is coming!

  330  PM: in-kernel: `MPTCP_INFO`: document and support
`mptcpi_subflows` for the server side [enhancement] [pm] @geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] [sched] @geliangtang
   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe


    Open questions (opened, questions and not assigned)

  326  Issue with streaming traffic with MPTCP upstream implementation
[question]


    For later (opened and not assigned assigned)

  350  scheduler: API changes (tasks) [enhancement] [sched]
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
  348  scheduler: frequently probe "stale" subflow with reinjected data
[enhancement] [sched]
  345  scheduler: "penalise" some subflows by sending less than their
cwnd [enhancement] [sched]
  344  scheduler: new callback to initiate optimisations [enhancement]
[sched]
  342  scheduler: area in the socket structures reserved for schedulers
[enhancement] [sched]
  337  in-kernel PM: listen socket: support "behind a NAT" use case
[enhancement]
  335  Server to Client subflows: option to allow joining the initial
address and port [enhancement]
  334  PM: in-kernel: send >1 ADD_ADDR before the establishment of a new
subflow [enhancement]
  333  New MIBs to help understanding issues when PM cannot create new
subflows [enhancement]
  332  scheduler: implement a "opportunistic retransmission"
[enhancement] [sched]
  298  CG Memory accounting for passive MPTCP socket [enhancement]
  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]
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
   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   77  [gs]etsockopt: forward to new/existing SF [enhancement]
   76  [gs]etsockopt per subflow: BPF [enhancement]
   61  move msk clone after ctx creation [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2023-02-21)

  365  syzkaller: soft lockup in `mptcp_token_exists()`
  362  Avoid `tcp_done()` on already closed sockets [enhancement]
[selftests]
  358  `getsockopt(SOL_MPTCP, ...)` on a MPTCP->TCP fallback connection
returns `EOPNOTSUPP` in IPv4 and `ENOPROTOOPT` in IPv6 [bug]
  354  syzkaller: possible deadlock in `tcp_close` [bug] [syzkaller]
[reproducer] [bisected]
  347  syzkaller: KASAN: use-after-free Read in `__token_bucket_busy`
[bug] [syzkaller] [reproducer]
  346  syzkaller: KASAN: use-after-free Write in `subflow_error_report`
[bug] [syzkaller] [reproducer]



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.4):
https://github.com/orgs/multipath-tcp/projects/2/views/1
    - For later: https://github.com/orgs/multipath-tcp/projects/1/views/1
    - ChangeLog has been updated (6.3):
https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [91ed5c7a344a] mptcp: fix possible deadlock in
subflow_error_report (Paolo Abeni)
        - [e0f840b05123] mptcp: refactor passive socket initialization
(Paolo Abeni)
        - [3d9ec43f65be] mptcp: use the workqueue to destroy unaccepted
sockets (Paolo Abeni)
        - [ab7c97370a53] mptcp: fix UaF in listener shutdown (Paolo Abeni)
        - [cac5e03175f4] selftests: mptcp: userspace pm: fix printed
values (Matthieu Baerts)
        - [b61819e1fa89] mptcp: add ro_after_init for
tcp{,v6}_prot_override (Geliang Tang)
        - [f9f28dcb02b6] mptcp: avoid setting TCP_CLOSE state twice
(Matthieu Baerts):
            - sent on Monday but v2 needed
            - v2 can probably be sent next week

        - [49a112696a71] mptcp: fix lockdep false positive in
mptcp_pm_nl_create_listen_socket() (Paolo Abeni):
            - can also be sent next week

    - Fixes for net-next: /

    - Features for net-next:

        - [22848125d167] mptcp: use mptcp_schedule_work() instead of
open-coding it (Paolo Abeni)
        - [6b1fdf14a961] mptcp: drop unneeded argument (Paolo Abeni)
        - [4c515f545c36] mptcp: drop legacy code (Paolo Abeni)
        - [18180fd8f8cd] mptcp: avoid unneeded __mptcp_nmpc_socket()
usage (Paolo Abeni)
        - [0c6b20b2b722] mptcp: move fastopen subflow check inside
mptcp_sendmsg_fastopen() (Paolo Abeni)
        - [363c3a320e00] mptcp: move first subflow allocation at mpc
access time (Paolo Abeni)
        - [01d1eedce8a5] mptcp: fastclose msk when cleaning unaccepted
sockets (Paolo Abeni)
        - [b5f41a51ee33] inet: factor out locked section of
inet_accept() in a new helper (Paolo Abeni)
        - [b111310d073b] mptcp: refactor mptcp_stream_accept() (Paolo
Abeni):
            - net-next is closed

    - Features for net-next (next): /

    - Features for other trees:

        - [6e7770a1d5b1] security, lsm: Introduce
security_mptcp_add_subflow() (Paolo Abeni)
        - [cd26112733a3] selinux: Implement mptcp_add_subflow hook
(Paolo Abeni)
        - [1d2c679de383] mptcp: refactor push_pending logic (Geliang Tang)
        - [690ed6b75e61] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [7c61b3401a5e] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [884819295732] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [d6fae6b3b3c9] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [81c6b76d1db4] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [e42c0f53b097] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [cee0f61d4093] mptcp: add scheduler wrappers (Geliang Tang)
        - [869932b74a73] mptcp: use get_send wrapper (Geliang Tang)
        - [a048c7cbaf3a] mptcp: use get_retrans wrapper (Geliang Tang)
        - [07b0c1b5580d] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [22eb5191fb1c] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [abfa942d2ced] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [aaf92be4f3f0] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [a935addc35df] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [ecd81544846a] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [800655f29bec] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [d8fe29bef400] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [52897c52ddde] selftests/bpf: Add bpf_rr test (Geliang Tang)
        - [c6f94911ab78] selftests/bpf: Add bpf_red scheduler (Geliang Tang)
        - [9dd3162b7404] selftests/bpf: Add bpf_red test (Geliang Tang):
            - net-next is closed



Extra tests:
    - news about Syzkaller? (Christoph):
        - still running

    - news about interop with mptcp.org/other stacks? (?):
        - /

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - /



MPTCP support in Go:
    - in progress: https://go-review.googlesource.com/c/go/+/471135



Other topics:
    - MPTCP workshop?
    - Could be good to check who is interested by that
    - Maybe talk to Olivier: something similar to the workshop organised
by UCLouvain a few years ago?:
        - Matth will do that → done
    - Something open
    - To be discussed next time



Next meeting:
    - Next one on Tuesday, the 7th of March.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230307



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
