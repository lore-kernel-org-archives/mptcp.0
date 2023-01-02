Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312E5667
	for <mptcp@lists.linux.dev>; Mon,  2 Jan 2023 17:18:09 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id fc4so67869522ejc.12
        for <mptcp@lists.linux.dev>; Mon, 02 Jan 2023 09:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGSFtjHZKY7VscVL6qcW7xKHPw2VzRk6t8QuuKAi7cw=;
        b=d3O1hjRW4w2drZzJ99XLfKe40uJPSZfQCfguqf4PMOUTXN6J2tq/OJCaZRchOkMo6r
         leqwn3fNoP62e8r8sboTuC6cCudWrYyGUjV+6jQexbqD4XLn9P2iSu4PtDwoYKJfM/lK
         d4NyFtOU7e57/mgia88dklztwinGKwTuaXRkDcF09jochD7Zb9HMtVsnPdoFov74n6PX
         byv7fGi0WvgZeDQ12nMHtw4cEUCahWouBUggalQ8JQI8fSqft/9CqhjK6onQl81lWAQt
         XZstakv7dbvMS4qyQBcSfHhxEPO/+eb3yt696KH7PmHvwoO+37zJmwhpdZhyHxEKVuI7
         cj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hGSFtjHZKY7VscVL6qcW7xKHPw2VzRk6t8QuuKAi7cw=;
        b=DWqxGcRmXMZ9QBi+Jx4viSI3pNTmmoUabCDbZYAtt1FimG8phFq8tgd+n+nRsTLRBs
         WGoIIjt/1Vizye64sPelIa0I63cmjdiCD7HiVlZ1gY4d+L/Mi75q/vzrDDd3YFn10/2F
         TfrKMvPJ5Tf/A092raRdFt6sXZraMjlDagOcGMNq1Ddw3KV/BCL1e8pQv5U4njqwUwDn
         1wfJnOCj9ruXBjdf4Z9Klci5Ldq/JUsnxccFTp0gOhoanUH8NC3a1nnk61bDLCf4GyLa
         ucFXqFIImWpA0LBjTiIcS7Vc2c6JYw//1d2VuxoSKMJrtGXQ+1JionbL1dtDQB9ZD1pF
         VfqA==
X-Gm-Message-State: AFqh2ko55GMeF197bZjlnZn65wYj7nlTnPsr0SUAndQfgokJn2Fl7MYZ
	3xJ52mTdvyK8DV3IvlyhWdxRR55GAjYKzqX4
X-Google-Smtp-Source: AMrXdXuZoDbuWqlnHqXR21z5LgFoXCQcNNB27LXk/UMmJqqmrMl3416YZTyNiIJ9FgqdfWwo9pl4Tw==
X-Received: by 2002:a17:907:7d8f:b0:7b5:911c:9b12 with SMTP id oz15-20020a1709077d8f00b007b5911c9b12mr43734540ejc.1.1672679887182;
        Mon, 02 Jan 2023 09:18:07 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id kd25-20020a17090798d900b0084cc4c53ce8sm2082885ejc.94.2023.01.02.09.18.06
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 09:18:06 -0800 (PST)
Message-ID: <1f07a3b0-644f-f69a-fdd8-f4fc7a7baeb5@tessares.net>
Date: Mon, 2 Jan 2023 18:18:06 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 20th of December 2022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last ~week~ year/month, we had our 222nd meeting with Mat, Ossama
(Intel), Christoph (Apple), Florian, Paolo, Davide (Red Hat) and myself
(Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Menglong Dong):

13076446: [mptcp-next,v10,1/6] mptcp: introduce 'sk' to replace
'sock->sk' in mptcp_listen()
13076447: [mptcp-next,v10,2/6] mptcp: init sk->sk_prot in build_msk()
13076448: [mptcp-next,v10,3/6] mptcp: rename 'sk' to 'ssk' in
mptcp_token_new_connect()
13076449: [mptcp-next,v10,4/6] mptcp: add statistics for mptcp socket in use
13076450: [mptcp-next,v10,5/6] selftest: mptcp: exit from
copyfd_io_poll() when receive SIGUSR1
13076451: [mptcp-next,v10,6/6] selftest: mptcp: add test for mptcp
socket in use:
      - Series: mptcp: add statistics for mptcp socket in use
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=705564&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Paolo Abeni):

13076926: [v2,1/2] security, lsm: Introduce security_mptcp_add_subflow()
13076927: [v2,2/2] selinux: Implement mptcp_add_subflow hook:
      - Series: lsm: introduce and use security_mptcp_add_subflow()
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=705673&state=*&archive=both
      - We will probably get some feedback next year
      - Will be handled by LSM team.
      - Will it be backported to stable? → probably not, not a security
issue
      - Once it is acked by the LSM team, we can apply a copy in our tree


    our repo (by: Geliang Tang, Jiapeng Chong, Matthieu Baerts):

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
      - see the discussion below (Redundant Sched)

13074155: [mptcp-next,v25,1/5] mptcp: add scheduler wrappers
13074156: [mptcp-next,v25,2/5] mptcp: use get_send wrapper
13074157: [mptcp-next,v25,3/5] mptcp: use get_retrans wrapper
13074158: [mptcp-next,v25,4/5] selftests/bpf: Add bpf_red scheduler
13074159: [mptcp-next,v25,5/5] selftests/bpf: Add bpf_red test:
      - State: Queued
      - Series: BPF redundant scheduler, part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=704762&state=*&archive=both
      - Can be applied

13077497: [mptcp-next] Squash to "mptcp: use get_send wrapper, v25":
      - State: Queued
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/db6dc5629093dea02dd3b6c1088f8efdf78ea03a.1671507997.git.geliang.tang@suse.com/
      - Can be applied



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/
    TODO: check no label/project

https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+no%3Alabel

https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+no%3Aproject+-label%3Aquestion

    Recently opened (latest from last week: 327):

  331  MPTCP in multihoming doesn't announce all endpoints [question]:
      - with the in-kernel PM, due to some limitations, only one is
announced, then more are announced when the first one is established
      - this could be improved but not that easy
      - For more details, see Paolo's reply on the ticket

  330  `MPTCP_INFO`: document and support `mptcpi_subflows` for the
server side [enhancement]
  329  PM: userspace: update `MPTCP_INFO` fields [bug]:
      - both linked to #327

  328  Problem using REDIRECT/MASQUERADE/TPROXY with MPTCP [question]:
      - Not an issue with MPTCP at the end


    Bugs (opened, flagged as "bug" and assigned)

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - see above


    Bugs (opened and flagged as "bug" and not assigned)

  329  PM: userspace: update `MPTCP_INFO` fields [bug]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: test 98 `fastclose test` is sometimes
failing [bug] [selftests]
  323  selftests: `mptcp_join`: test 111 `delete and re-add` is often
failing [bug] [selftests]
  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]
  315  Issues with backup flow [bug]
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
      - see above

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe


    Open questions (opened, questions and not assigned)

  331  MPTCP in multihoming doesn't announce all endpoints [question]
  328  Problem using REDIRECT/MASQUERADE/TPROXY with MPTCP [question]
  326  Issue with streaming traffic with MPTCP upstream implementation
[question]


    For later (opened and not assigned assigned)

  330  `MPTCP_INFO`: document and support `mptcpi_subflows` for the
server side [enhancement]
  298  CG Memory accounting for passive MPTCP socket [enhancement]
  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]
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


    Recently closed (since last week)

  327  Number of subflows is equal to zero when expecting 1. [question]
  322  TFO: possible circular locking dependency detected [bug] @pabeni
  319  kmemleak: 6 new suspected memory leaks in -net [bug]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.3):
https://github.com/multipath-tcp/mptcp_net-next/projects/18
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [caf43b24883d] mptcp: fix deadlock in fastopen error path
(Paolo Abeni)
        - [abae24b094e0] mptcp: fix lockdep false positive (Paolo Abeni):
            - can be sent → done

    - Fixes for net-next: /

    - Features for net-next:

        - [6c888567b8e2] mptcp: use msk_owned_by_me helper (Geliang Tang)
        - [a17f5bc11fa9] mptcp: use net instead of sock_net (Geliang Tang)
        - [b25bc11bcdd5] mptcp: use local variable ssk in write_options
(Geliang Tang)
        - [2140d45e596e] mptcp: introduce 'sk' to replace 'sock->sk' in
mptcp_listen() (Menglong Dong)
        - [3bc3a25c1267] mptcp: init sk->sk_prot in build_msk()
(Menglong Dong)
        - [2f4cc689c912] mptcp: rename 'sk' to 'ssk' in
mptcp_token_new_connect() (Menglong Dong)
        - [417c4c08a48d] mptcp: add statistics for mptcp socket in use
(Menglong Dong)
        - [04097b429968] selftest: mptcp: exit from copyfd_io_poll()
when receive SIGUSR1 (Menglong Dong)
        - [32fe254af698] selftest: mptcp: add test for mptcp socket in
use (Menglong Dong):
            - net-next is closed for the moment

    - Features for net-next (next): /

    - Features for other trees:

        - [448a3435d4d6] mptcp: refactor push_pending logic (Geliang Tang)
        - [b7d37993922b] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [4a09e8f9504d] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [a46618febe39] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [2375224b6115] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [0212eb96c87c] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [f356db97c095] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [89e8fdc3739a] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [0fbe9a607f53] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [c2630ca38c37] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [3fcc0619462c] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [289c47eb04bc] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [598313fbfb6f] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [c32fedc668e3] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [5306f79932ea] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [6565e46c46c3] selftests/bpf: Add bpf_rr test (Geliang Tang)
            - status: same as last week



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - nothing new

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - no tests have been executed

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - same status as last week


Redundant schedulers:
    - Olivier Bonaventure and Gregory Detal helped me to do this list

    - Use cases:

        - Low latency:
            - bandwidth is not the priority, just quickly recover from
losses
            - Note: in this use-case, it is important to be able to
quickly restart a connection if we need to retransmit too much (from a
TCP point of view)
            - (but MPTCP is maybe not the best fit for that...)

        - High losses networks:
            - does it really help because something transmitted over one
path will have to be retransmitted anyway (from a TCP point of view)?
            - MPTCP doesn't seem to be a good fit for that because of TCP

    - cases where a "normal" scheduler might want to "quickly" reinject
the same segment over multiple subflows:
        - to probe one subflow:
            - but OK to just take the last byte(s) that have been sent

        - a TLP algo could be implemented at MPTCP level:
            - alternative to TLP (tail-loss-probe):
https://lwn.net/Articles/542642/
            - Quickly reinject after a timeout? (after any RTO?
            - preventively send on other links the last packet(s) that
ends a burst/connection?

        - opportunistic retransmission (re-injection):
            - when we realize we are blocked by the window, we will need
to re-inject the last segments over other subflows
            - important to reach high speed
            -
https://www.usenix.org/system/files/conference/nsdi12/nsdi12-final125.pdf
→ section 4.2
            - in mptcp.org, it is tied to the scheduler which takes the
decision to do that
            - but the decision could be taken by the core → react to an
event
            - from an API point of view, this would be similar to what
we need for the redundant scheduler:
                - small difference: just re-inject to one subflow
                - maybe using the delegate action infra would be
possible because ↑
            - maybe having a "redundant flag" not to "move on" would be
enough?

    - techniques:
        - enough to just remember the last MPTCP data seq sent per subflow?
        - this info should be handled by the BPF scheduler

    - to simplify the implementation:
        - always send the same amount of data
        - if there is not enough space in the sending window: queue or drop
        - or only duplicate if we have chunks < mss with TCP_NODELAY

    - listing what is needed would really be useful to (re)design the
scheduler API:
        - what is needed to solve some corner cases for the scheduler
        - TODO: Matth

    - What can be useful:
        - being able to ask to be re-scheduled after a timeout (can be
0) and pick the subflow after (or maybe enough before?)

    - what to do if we have different links?:
        - if one subflow cannot keep up → ideally skip transmitting
chunks to keep up
        - always tricky because we need to keep retransmitting lost data
and we might loose quite some time
        - → might need a way to "abort", skip next chunk, etc.



FOSDEM:
    - confirmed: there will be one presentation about MPTCP in the
upstream kernel!



Next meeting:
    - Next one on *Tuesday*, the 3rd of January.
    - 16:30 UTC (8.30am PST, 5.30pm CET, 12.30am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20230103



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
