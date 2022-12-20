Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E5023B7
	for <mptcp@lists.linux.dev>; Tue, 20 Dec 2022 13:52:06 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id a16so17550022edb.9
        for <mptcp@lists.linux.dev>; Tue, 20 Dec 2022 05:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3KrNxoqnNab6R2Vhx9zJS+DniC65B8yATtYwtfM24I=;
        b=H6LgjQSKTfH5XkTdCyssg6kxmFNAZ1y8FDVoxY+UF2q10poAmgSrErd5LL7LDS/Jp4
         k17uvFfUoVdJLUsqYmRZo9XuZRhiB74Q3pcG19rNm82E3+mjhBNVBb27BLuWLY0AWxey
         XbtS/9ipB6NUUaz6JDjFxjS1TXiZZNdbQWmMgJ4RcBLQZuakewzA9s3vBHvEKfpDYJYw
         XfPbBKgNJHrdMhUsHv+Mh8YULa+XgxuDVNz06wXlkx3n8GubpmEjrhbYhQqW+BpKZYTs
         yZZBpdHKToYFvyNHsX86IginFm++xoOHZBWMshM+r0+8C4x98eE3qZO3XqAnz03xv5TM
         JYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q3KrNxoqnNab6R2Vhx9zJS+DniC65B8yATtYwtfM24I=;
        b=u6YxQIe1rCRUuoLEisie3gQdMWSc1GRj9qTWJT8m/RJw2JmcDXdhskV5QLntgpNmA0
         lL4PpI4Au05BPVa5BqhFh5y00DyGwuGXhWO/Pa6Do+cuReKgajmZoVSZnI+8wJzZUICS
         rM48BYQg9c2s8SJeZt5Y3otPpfnZ4MUDiHNauMYRtdMvKsDzChD7yc8pp42hz/D629kP
         CUxUzKWyPoWK43qaQqxtIyPH6RprmpypVV4msjkHnyo2SXzm3cM2b2+XMntO7jnKTdrj
         03ZK5mVGTDpGzhEkDOs3d3Fsh1Qx7q5lhktH6KNvpmDv/bgeQGwb5JwJEBSgeH9y5G2O
         cLSQ==
X-Gm-Message-State: ANoB5pkGGup2kRykE3ksTKzaMgutLf2gEIic91WrawrggKVW2/g9GFDL
	rB8ayBwAGFtPfEtl5MC+C9jw+pGMzZaK6GMt
X-Google-Smtp-Source: AA0mqf6hinIhyV213STtmsfXQPK25g35w1r7KGAP/qsd/td6Pwxik6yNLhfPpe7/yzAnkTse/9RbMA==
X-Received: by 2002:a05:6402:2986:b0:45c:834b:f298 with SMTP id eq6-20020a056402298600b0045c834bf298mr37543248edb.21.1671544324565;
        Tue, 20 Dec 2022 05:52:04 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id q20-20020a056402041400b0046c2eee21a2sm5639393edv.11.2022.12.20.05.52.04
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 05:52:04 -0800 (PST)
Message-ID: <91c07beb-5e2c-6e3d-08b1-4151a52743e1@tessares.net>
Date: Tue, 20 Dec 2022 14:52:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 15th of December 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our 221st meeting with Ossama (Intel), Florian, Paolo,
Davide (Red Hat), Dmytro (?), Benjamin and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

13069101: [net-next,1/2] mptcp: use nlmsg_free instead of kfree_skb
13069102: [net-next,2/2] mptcp: return 0 instead of 'err' var:
      - Series: mptcp: Miscellaneous cleanup
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703141&state=*&archive=both

13070179: [net,1/4] mptcp: netlink: fix some error return code
13070180: [net,2/4] mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
13070181: [net,3/4] mptcp: dedicated request sock for subflow in v6
13070182: [net,4/4] mptcp: use proper req destructor for IPv6:
      - Series: mptcp: Fix IPv6 reqsk ops and some netlink error codes
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703518&state=*&archive=both


    our repo (by: Geliang Tang, Paolo Abeni):

13069231: [mptcp-next] mptcp: use msk_owned_by_me helper:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221209045925.20408-1-geliang.tang@suse.com/

13069379: [mptcp-next,1/2] mptcp: use net instead of sock_net
13069380: [mptcp-next,2/2] mptcp: use local variable ssk in write_options:
      - Series: two small cleanups
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703228&state=*&archive=both

13073251: [mptcp-net,v2] mptcp: fix lockdep false positive:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/1f27ea6ff3b76035685ec372cc9e2753b9f9d90e.1671032651.git.pabeni@redhat.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Geliang Tang, Jiapeng Chong, Matthieu Baerts, Menglong
Dong, Paolo Abeni):

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

13067832: [mptcp-next,v8,1/4] mptcp: introduce 'sk' to replace
'sock->sk' in mptcp_listen()
13067833: [mptcp-next,v8,2/4] mptcp: add statistics for mptcp socket in use
13067834: [mptcp-next,v8,3/4] selftest: mptcp: exit from
copyfd_io_poll() when receive SIGUSR1
13067835: [mptcp-next,v8,4/4] selftest: mptcp: add test for mptcp socket
in use:
      - State: Changes requested
      - Series: mptcp: add statistics for mptcp socket in use
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=702785&state=*&archive=both
      - Paolo gave some hints about the error
      - Expecting a v9 then → done

13074155: [mptcp-next,v25,1/5] mptcp: add scheduler wrappers
13074156: [mptcp-next,v25,2/5] mptcp: use get_send wrapper
13074157: [mptcp-next,v25,3/5] mptcp: use get_retrans wrapper
13074158: [mptcp-next,v25,4/5] selftests/bpf: Add bpf_red scheduler
13074159: [mptcp-next,v25,5/5] selftests/bpf: Add bpf_red test:
      - State: New
      - Series: BPF redundant scheduler, part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=704762&state=*&archive=both
      - v25 is addressing recent comments from Mat

13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
      - State: Changes requested
      - Series: BPF redundant scheduler, part 3
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
      - Delegate action could be used but not trivial: needs to exchange
info about what has to be re-injected from the queue
      - or have a workqueue just to handle this use case? Would be
easier but there is an impact (but maybe OK because we don't use the
redundant scheduler to reach the higher perfs?)
      - Check what are the typical use cases for the redundant scheduler
→ Matth: TODO (in progress)
      - Check if we might want to send data over multiple subflows "at
the send time" in a "normal" use case → Matth: TODO (in progress)

13073613: [1/2] security, lsm: Introduce security_mptcp_add_subflow()
13073614: [2/2] selinux: Implement mptcp_add_subflow hook:
      - State: Changes requested
      - Series: lsm: introduce and use security_mptcp_add_subflow()
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=704597&state=*&archive=both
      - Just some small adjustments to have it to build without warnings
but the idea is there
      - Will be handled by the security team




Extra, just in case



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 325):

  327  Number of subflows is equal to zero when expecting 1. [question]:
      - the info from MPTCP_INFO is a bit confusing
      - mptcpi_subflows will be incremented only for additional subflows
and for the client (and for the in kernel PM)
      - TODO: Matth: open an issue about some fields from this structure
not updated if we use the userspace pm? → Done: #329
      - would we even decrement subflows counters with the userspace pm?

  326  Issue with streaming traffic with MPTCP upstream implementation
[question]:
      - more info needed
      - we should probably add a ticket template with info that are
needed (or stuff to check)


    Bugs (opened, flagged as "bug" and assigned)

  320  Broken SELinux/LSM labelling with MPTCP and accept(2) [bug] @pabeni:
      - see series "lsm: introduce and use security_mptcp_add_subflow()"
above


    Bugs (opened and flagged as "bug" and not assigned)

  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: test 98 `fastclose test` is sometimes
failing [bug] [selftests]
  323  selftests: `mptcp_join`: test 111 `delete and re-add` is often
failing [bug] [selftests]

  319  kmemleak: 6 new suspected memory leaks in -net [bug]:
      - TODO: Matth: close it, not MPTCP related and not reproduced → done

  318  selftests: `mptcp_connect.sh` sometimes fails when validating SYN
cookies [bug] [selftests]:
      - could be good to print more info like expected syn cookie, what
we got, etc.
      - could be nice to reproduce it locally first

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
       - see patches above

   74  BPF: path manager [enhancement] @geliangtang


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe


    Open questions (opened, questions and not assigned)

  327  Number of subflows is equal to zero when expecting 1. [question]
  326  Issue with streaming traffic with MPTCP upstream implementation
[question]


    For later (opened and not assigned assigned)

  298  CG Memory accounting for passive MPTCP socket [enhancement]
  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]

  269  Allow having a mix of v4/v6 subflows for the same socket
[enhancement]:
      - It looks like it is not possible to have subflows in v4 and v6
for the same connection with the userspace PM as well. To be investigated.

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

  322  TFO: possible circular locking dependency detected [bug] @pabeni
   59  (MP)TFO support [enhancement] @dmytroshytyi-6WIND



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.3):
https://github.com/multipath-tcp/mptcp_net-next/projects/18
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4

    - ChangeLog has been updated!
        https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [9a520f0045eb] mptcp: fix deadlock in fastopen error path
(Paolo Abeni)
        - [cd81e73077d8] mptcp: fix lockdep false positive (Paolo Abeni):
            - The last one has been applied today, maybe best to wait
for the beginning of next week

    - Fixes for net-next: /

    - Features for net-next:

        - [20d044855236] mptcp: use msk_owned_by_me helper (Geliang Tang)
        - [309364aa5359] mptcp: use net instead of sock_net (Geliang Tang)
        - [85c549bffc9c] mptcp: use local variable ssk in write_options
(Geliang Tang):
            - net-next is closed

    - Features for net-next (next): /

    - Features for other trees:

        - [80da22c827a2] mptcp: refactor push_pending logic (Geliang Tang)
        - [95e0668783a9] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
(Geliang Tang)
        - [62ae6f18b066] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [943bf8e311a3] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [8ab7ea2cff5c] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [0d70fec6438d] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [0c2ac301efe4] mptcp: add sched_data_set_contexts helper
(Geliang Tang)
        - [5cbcf4d3d720] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [94cc4a6f5cee] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [364b16d404c7] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [66bdbc6ad2dd] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [e5d7f38aab11] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [f846c9a7b169] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [2d0f1788cb0e] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [65199f7d0de9] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [53f634daf424] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - need to wait for fixes



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - nothing new

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - kbuild has been having some non-MPTCP problems so tests
haven’t been running

    - packetdrill (Davide):
        - https://github.com/multipath-tcp/packetdrill_mptcp/pull/1 →
lot of new tests for the fork
        - TFO server side tests have been re-added

    - Patchew (Davide):
        - /

    - CI (Matth):
        - mostly green, some issues with mptcp_join but tracked on GH


Change Day / Time?:
    - Tuesday?
    - Later? (30m?)
    - *OK for Tuesday, half an hour later*

    - For people in Asia / Oceania, we suggest to setup new meetings at
a different time (e.g. morning in Europe, afternoon/evening in
Asia/Oceania), maybe less regularly (once a month? on request?) if there
are people from there who want to participate.



MPTCP in Go net lib:
    - The proposition has been accepted!
    - https://github.com/golang/go/issues/56539
    - Not sure what's next: someone has to implement it, not sure who



FOSDEM 23:
    - There will probably have a talk about MPTCP on the Sunday, to be
confirmed → confirmed



Next meeting:
    - Next one on *Tuesday*, the 20th of December.
    - 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20221220



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Tuesday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
