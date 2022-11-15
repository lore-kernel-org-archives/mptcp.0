Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA224F29
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 17:42:33 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so10825821wmi.3
        for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 09:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ug6YLO955OyREtfhJvuoARRa/0YtnFmMtQF7fZV1XX0=;
        b=H8H81SKQmxHTbZm0Wv7cr4aSrnW8q01pUbiOp3vi5tyT/OlsVl/fLRe9mmuEOZkdgZ
         M1Cy+U4uQQccGvNA/1Bt+WZDIN2Bi/LeB0V/l+3Rw1IPkrZimeZEd+dnmdlvxHqSWdIC
         mmecZVKDqyi3Yy/p3yYL83e3muycqbg1OMezwawOWxFEOMXc5x9gw8qv5S1M0dJhqe6f
         IoI3K6NJRGGJJ0ID7WRgx8aNGn598WmdTzmlaco64fdwRqA/vUnmldI2NWHOKLVPXua7
         yq+FuVH1sZNnVFcP8ySNQxgKEuptFiVfncjE1MQsPSo/LAW0Nt7nawPVyyVk8pdHQ0sM
         gDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ug6YLO955OyREtfhJvuoARRa/0YtnFmMtQF7fZV1XX0=;
        b=v9PIColKQNETTrBBpvyXM/rmBSy4sJDZ12daDRdwKGxgeiulCC2yBr5wGXlBJZenaW
         3PIowmsxRLd5t+3ZPmlfjB3/fbqVeB8MDLnMpyRnZ2f+HSSapBgOJHGpCk0A1weSUjoP
         xSqlq66JdHGziBLUeODmjurKDe/S7IvKiQYv9vA9ZA8YXG85gKVH8w4E0uCDc5NgIETJ
         zJ9kmxnMmakwi38w9z5ISJ6iKi1p88RcQXG5s8eUbh7OCepLGLjZ7z/ojtXoOYLVKZtc
         DgCERnowLg/TRy05tqHk3FJRd6RzS1w7v6I5vL6QEOiV/lEzvU9BNznaXpEy3eOVLVBl
         Cgjg==
X-Gm-Message-State: ANoB5pkTxloVNMOum7hdkLw/r7J1IunjF2L1YTBTLozkEHacKg2x31Dz
	YeQI3p8eifx6dcG5csDDz3Q5sYXrXL7zsg==
X-Google-Smtp-Source: AA0mqf7OP61aKArj1Yx39HdWwdtmINmQANezuwH+WdbXRzvK4KcIS0Rwyr7tah2eqv1rtNfY6K2Wtg==
X-Received: by 2002:a05:600c:6029:b0:3cf:a258:99b with SMTP id az41-20020a05600c602900b003cfa258099bmr2358198wmb.34.1668534150767;
        Tue, 15 Nov 2022 09:42:30 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:765b:95ed:f124:a78a? ([2a02:578:8593:1200:765b:95ed:f124:a78a])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003b4c979e6bcsm24431403wms.10.2022.11.15.09.42.30
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 09:42:30 -0800 (PST)
Message-ID: <e2d1d46d-201c-1120-4079-31c3f86cb7a4@tessares.net>
Date: Tue, 15 Nov 2022 18:42:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 3rd of November 2022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday (two weeks ago), we had our 215th meeting with Mat, Ossama
(Intel), Paolo, Davide (Redhat), Dmytro () and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Kuniyuki Iwashima, Mat Martineau,
Paolo Abeni):

13012428: [v2,net-next,1/5] inet6: Remove inet6_destroy_sock() in
sk->sk_prot->destroy().

13013851: [net-next,v2,1/2] net: introduce and use custom sockopt socket
flag
13013852: [net-next,v2,2/2] udp: track the forward memory release
threshold in an hot cacheline:
      - Series: udp: avoid false sharing on receive
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=687246&state=*&archive=both

13015567: [net,1/3] mptcp: set msk local address earlier
13015568: [net,2/3] mptcp: factor out mptcp_connect()
13015569: [net,3/3] mptcp: fix abba deadlock on fastopen:
      - Series: mptcp: Fixes for 6.1
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=687708&state=*&archive=both

13015668: [net-next,1/3] mptcp: sockopt: make 'tcp_fastopen_connect' generic
13015669: [net-next,2/3] mptcp: add TCP_FASTOPEN_NO_COOKIE support
13015670: [net-next,3/3] mptcp: sockopt: use new helper for
TCP_DEFER_ACCEPT:
      - Series: mptcp: Socket option updates
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=687733&state=*&archive=both


    our repo (by: Geliang Tang, Paolo Abeni):

13017795: [mptcp-net] selftests: mptcp: gives slow test-case more time:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/680973297b6995126f49732c0828ccfce8865c72.1666628806.git.pabeni@redhat.com/

13018441: [mptcp-next,v3] mptcp: get sk from msk directly:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221025032610.17496-1-geliang.tang@suse.com/

13018442: [mptcp-next,v2] Revert "mptcp: add get_subflow wrappers" - fix
divide error in mptcp_subflow_get_send:
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/95f77f38e54f9564608e844f507701c04745475b.1666668425.git.geliang.tang@suse.com/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: /):

/

    our repo (by: Benjamin Hesmans, Geliang Tang, Jason Wang, Jiapeng
Chong, Mat Martineau, Matthieu Baerts, Menglong Dong, Paolo Abeni,
wangjianli):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
12321111: mptcp: Remove redundant assignment to remaining:
12970164: [RFC,mptcp-next,05/10] mptcp: delay mptcp data_ack calculation
12970163: [RFC,mptcp-next,06/10] mptcp: allow delayed data_ack calculation
12970165: [RFC,mptcp-next,07/10] mptcp: TFO receive: bypass mapping check
12970166: [RFC,mptcp-next,08/10] mptcp: allow data that can not be
DATA_ACKed
12970167: [RFC,mptcp-next,09/10] mptcp: force data_ready
12970168: [RFC,mptcp-next,10/10] mptcp: test TFO:
      - status is the same as last week

12922458: mptcp: Fix comment typo:
      - State: Changes requested
      - Series: mptcp: Fix comment typo
      - Submitter: Jason Wang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=661054&state=*&archive=both
      - Mat sent a new patch replacing this one → superseded

13007315: [RFC] selftests: mptcp: set test-case parameters consistently:
      - State: RFC
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/2abed554f2050c7626dede74c92a181506a92682.1665779933.git.pabeni@redhat.com/

13012120: [mptcp-net,1/4] selftests: mptcp: run mptcp_sockopt from a new
netns
13012121: [mptcp-next,2/4] selftests: mptcp: run mptcp_inq from a clean
netns
13012122: [mptcp-next,3/4] selftests: mptcp: removed defined but unused vars
13012123: [mptcp-next,4/4] selftests: mptcp: uniform 'rndh' variable:
      - State: Queued
      - Series: mptcp: run mptcp_sockopt from a new netns + cleanup
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=686816&state=*&archive=both
      - To be applied + add a new patch suggested by Geliang → Done

13015839: net/mptcp: fix repeated words in comments:
      - State: Changes requested
      - Series: net/mptcp: fix repeated words in comments
      - Submitter: wangjianli
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=687811&state=*&archive=both
      - Mat sent a new patch replacing this one → superseded

13015971: [mptcp-next] selftests: mptcp: use max_time instead of time:
      - State: Queued
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221022133528.31996-1-geliang.tang@suse.com/
      - is it linked to
https://github.com/multipath-tcp/mptcp_net-next/issues/310 ?
      - No, just a refactoring → -next → Done

13020295: [mptcp-next,v16,01/15] mptcp: refactor push_pending logic
13020296: [mptcp-next,v16,02/15] mptcp: drop last_snd and
MPTCP_RESET_SCHEDULER
13020297: [mptcp-next,v16,03/15] mptcp: add sched_data_set_contexts helper
13020298: [mptcp-next,v16,04/15] Squash to "mptcp: add struct
mptcp_sched_ops"
13020299: [mptcp-next,v16,05/15] Squash to "bpf: Add bpf_mptcp_sched_ops"
13020300: [mptcp-next,v16,06/15] Squash to "bpf: Add
bpf_mptcp_sched_kfunc_set"
13020301: [mptcp-next,v16,07/15] Squash to "selftests/bpf: Add bpf_first
scheduler"
13020308: [mptcp-next,v16,08/15] Squash to "selftests/bpf: Add bpf_bkup
scheduler"
13020309: [mptcp-next,v16,09/15] Squash to "selftests/bpf: Add bpf_rr
scheduler"
13020310: [mptcp-next,v16,10/15] mptcp: use get_send wrapper
13020311: [mptcp-next,v16,11/15] mptcp: use get_retrans wrapper
13020312: [mptcp-next,v16,12/15] mptcp: delay updating first_pending
13020313: [mptcp-next,v16,13/15] mptcp: delay updating already_sent
13020314: [mptcp-next,v16,14/15] selftests/bpf: Add bpf_red scheduler
13020315: [mptcp-next,v16,15/15] selftests/bpf: Add bpf_red test:
      - State: Changes requested
      - Series: BPF redundant scheduler
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=688956&state=*&archive=both
      - data fin handling was different in case of error in the push
pending refactoring
      - but more work needed for the redundant part (in a sequential
send → this part needs more work)

13020451: [mptcp-next,v2,1/2] mptcp: use entry->lsk directly
13020452: [mptcp-next,v2,2/2] mptcp: add pm listener events:
      - State: Changes requested
      - Series: add pm listener events
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=688998&state=*&archive=both
      - Linked to https://github.com/multipath-tcp/mptcp_net-next/issues/313
      - To help a userspace PM to create additional listening ports
based on ports an app is listening to
      - commit message of 1/2 needs to be updated
      - + selftest: see next patch ↓

13020538: [mptcp-next] selftests: mptcp: update userspace pm tests:
      - State: Changes requested
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221026124114.24816-1-geliang.tang@suse.com/
      - part of the previous series (add pm listener events)

13027471: [mptcp-next] mptcp: Fix grammar in a comment:
      - State: New
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221101205538.13892-1-mathew.j.martineau@linux.intel.com/
      - Can be applied

13029900: [mptcp-next,v6,1/4] mptcp: introduce 'sk' to replace
'sock->sk' in mptcp_listen()
13029901: [mptcp-next,v6,2/4] mptcp: add statistics for mptcp socket in use
13029902: [mptcp-next,v6,3/4] selftest: mptcp: exit from
copyfd_io_poll() when receive SIGUSR1
13029903: [mptcp-next,v6,4/4] selftest: mptcp: add test for mptcp socket
in use:
      - State: New
      - Series: mptcp: add statistics for mptcp socket in use
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=691610&state=*&archive=both
      - v6 fixes some issues with the selftests
      - but the CI still has issues with it: we probably need to wait
for the previous processes to be killed, see comments on v5.



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from last week: 312):

  313  Add netlink events for listening socket create/close
[enhancement] @geliangtang:
      - See "add pm listener events" series above


    Bugs (opened, flagged as "bug" and assigned)

  312  packetdrill: `add_addr` test is regularly failing: packets
arriving before the expected time [bug] [packetdrill] @matttbe:
        - https://github.com/multipath-tcp/packetdrill/pull/98


    Bugs (opened and flagged as "bug" and not assigned)

  310  selftests: `simult_flows`: transfer slower than expected! [bug]
[selftests]

  299  several kernel warnings about mptcp [bug]:
      - reminder sent, we can close if we don't get feedback before the
next meeting

  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  313  Add netlink events for listening socket create/close
[enhancement] @geliangtang:
      - see patches above

  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - see patches above

   74  BPF: path manager [enhancement] @geliangtang

   59  (MP)TFO support [enhancement] @dmytroshytyi:
       - Dmytro is working on selftests
       - first call to sendto() is OK (but no TFO? → we shoud force no
cookie)
       - Dmytro will send patches with the current and the issue he has
in the commit message to better understand what's the problem


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe:
      - any feedback?


    Open questions (opened, questions and not assigned)



    For later (opened and not assigned assigned)

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


    Recently closed (since last meeting)

  314  [syzkaller] Divide by 0 in mptcp_subflow_get_send() @geliangtang
  309  selftests: `mptcp_join`: test 33: `remove addresses` failing
occasionally  [bug] [selftests]
  294  Clear way for userspace to know if the connection fell back to
TCP [enhancement] @matttbe
  248  packetdrill: more tests failing due to packets arriving later
than expected [bug] [packetdrill]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.2):
https://github.com/multipath-tcp/mptcp_net-next/projects/17
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [004ddd2ae4b9] selftests: mptcp: gives slow test-case more
time (Paolo Abeni):
            - not urgent: can be sent
            - we can wait to sent 2 others that are pending


    - Fixes for net-next: /

    - Features for net-next:

        - [2e44efc04db0] mptcp: use msk instead of mptcp_sk (Geliang Tang)
        - [946bd7c018ee] mptcp: change 'first' as a parameter (Geliang Tang)
        - [e564872ae095] mptcp: get sk from msk directly (Geliang Tang):
            - can be sent but not urgent: we can wait for more patches
that are pending

    - Features for net-next (next): /

    - Features for other trees:

        - [40b60735d5e4] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [a5069dd2c4cd] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [5562b2cc1aef] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [072f9bcec34e] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [e110e6b9f320] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [9aa128bf67a6] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [004a320db6bf] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [5510fe89d9db] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [ba2677fe0a97] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [8f517758d7b7] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [5a6399912e03] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [619cd818e0d8] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [29c381730b23] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - pending patches, we wait



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - an issue with "bhash2", discussions are ongoing on netdev
        -
https://lore.kernel.org/netdev/20221029001249.86337-1-kuniyu@amazon.com/
        - but not related to MPTCP

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - last couple of weeks were OK
        - (didn't run yesterday but maybe normal)

    - packetdrill (Davide):
        - one PR: https://github.com/multipath-tcp/packetdrill/pull/98

    - Patchew (Davide):
        - /

    - CI (Matth):
        - better timeout to stop before the hard limit from the CI
        - most debug builds are now OK but we still need to investigate
why there are timeout



- Go:
    - FYI, I created an issue in GO to add support for MPTCP in the
'net' package, feel free to +1: https://github.com/golang/go/issues/56539



- Glibc:
    - add MPTCP socket option support in GLibc?
    - https://sourceware.org/pipermail/libc-alpha/2022-October/142586.html
    - https://sourceware.org/pipermail/libc-alpha/2022-October/142869.html



Next meeting:
    - Next one on Thursday, the 10th of November.
    - 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20221110



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
