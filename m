Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769AA3D6B
	for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 14:37:16 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id x2so16556537edd.2
        for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 06:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDSx0uUXnSXodyDB8HDN6Nq7Qh3C2XDwAcUxBFkAtiI=;
        b=vaEwEXHWqK1/YTGqWj9GKUL47XzuxFNZJYFTHckoQ9qcmwy4TCLbZnCO+fXT1YJciD
         RqZn6OxP3pQlvqEPPyUu7McJVqOmLoMpJWtwfpGA5g2Y+3ZPgsFN9BywTCsWm2PSk3E+
         FGXeP8guAATocv6ZfYOmWZnRprhjg8YMFzeM/LBXTjf2WVUuLKVKADeuLlEckHKy1kcC
         FothIOiEhaJBQBDCwohVd6C7kA496A1tv1tjUesU1tp08Bw+apsTyNs4GXBhZxTmbuSy
         Tn1CjqYII9RqsNPm01xWbAeqz93UC9hHXRQxA1i/TGVQ0uENYHvC5KM6nft/mohOGpwO
         5yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pDSx0uUXnSXodyDB8HDN6Nq7Qh3C2XDwAcUxBFkAtiI=;
        b=0dmj4sVRMnoh66Zy0Fo/Vb5d7+OLfGOk8SNiYUFY3r2MMIaMvSP2fu83NXgooYaFBN
         yxT5RH3evE3lYdWBf5xBcZGC7dUTePjZj1zwKbZBmYMjNSINynllk8FgcNNp/ZtCvoSL
         PKTzpneCrNDBdjyrplEJebNh1T8Czf5jIhgVztGwb8ZIwss6B1LR5afMLgSJYmEduVcB
         cjmqyqAb7eMusaFAxKRof+/RpVMHYF+8DB0n4iTZAaUA7blFWAcKyDZ8T/CMR0r7ty95
         v3ExNExiDedvubmLbNTcoH2y/fd3tIoeyvXmF+WW/1/6Rkwo3X3SmLo6QASGNDcRG+x9
         9JGw==
X-Gm-Message-State: ANoB5pkOlynFf3cB3ZLwX7pzWBY9+pkXveNYpK0Mkv6PNai0WOWloL0p
	tTx4UxFjxljQ2c18/YlzFQryIn4mof415A==
X-Google-Smtp-Source: AA0mqf5mJK/RWdRJOCJnGDR/AjsodWu0DyKeDeSeVXScozn8iulMvRxcymJXvVnZSPtVMLQmZ7NMCQ==
X-Received: by 2002:a50:fd0d:0:b0:469:c73c:e29a with SMTP id i13-20020a50fd0d000000b00469c73ce29amr1714216eds.423.1669041433805;
        Mon, 21 Nov 2022 06:37:13 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id dk1-20020a170906f0c100b0078d22b0bcf2sm4995659ejb.168.2022.11.21.06.37.13
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 06:37:13 -0800 (PST)
Message-ID: <7f28700a-3401-5189-b9a0-88a44695f698@tessares.net>
Date: Mon, 21 Nov 2022 15:37:12 +0100
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
Subject: [Weekly meetings] MoM - 17th of November 2022
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 217th meeting with Mat, Ossama (Intel), Paolo
(Redhat), Dmytro () and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

13039424: [net-next,1/5] mptcp: use msk instead of mptcp_sk
13039425: [net-next,2/5] mptcp: change 'first' as a parameter
13039426: [net-next,3/5] mptcp: get sk from msk directly
13039428: [net-next,4/5] selftests: mptcp: use max_time instead of time
13039427: [net-next,5/5] mptcp: Fix grammar in a comment:
      - Series: mptcp: Miscellaneous refactoring and small fixes
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=694259&state=*&archive=both


    our repo (by: Dmytro Shytyi, Matthieu Baerts, Paolo Abeni):

13012120: [mptcp-net,1/4] selftests: mptcp: run mptcp_sockopt from a new
netns
13012121: [mptcp-next,2/4] selftests: mptcp: run mptcp_inq from a clean
netns
13012122: [mptcp-next,3/4] selftests: mptcp: removed defined but unused vars
13012123: [mptcp-next,4/4] selftests: mptcp: uniform 'rndh' variable:
      - Series: mptcp: run mptcp_sockopt from a new netns + cleanup
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=686816&state=*&archive=both

13032474: [mptcp-next,1/2] mptcp: deduplicate error paths on endpoint
creation
13032475: [mptcp-next,2/2] mptcp: more detailed error reporting on
endpoint creation:
      - Series: [mptcp-next,1/2] mptcp: deduplicate error paths on
endpoint creation
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=692242&state=*&archive=both

13033434: [RFC,mptcp-next,v15,1/5] mptcp: introduce MSG_FASTOPEN flag
13033432: [RFC,mptcp-next,v15,2/5] mptcp: implement delayed seq
generation for passive fastopen
13033433: [RFC,mptcp-next,v15,3/5] mptcp: add subflow_v(4,6)_send_synack()
13033431: [RFC,mptcp-next,v15,4/5] mptcp: add TCP_FASTOPEN sock option
13037633: [mptcp-next,1.5/5] mptcp: track accuratelly the incoming MPC
suboption type.:
      - Series: [net-next] Squash-to: "mptcp: implement delayed seq
generation for passive fastopen"
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=693684&state=*&archive=both

13037631: [net-next] Squash-to: "mptcp: implement delayed seq generation
for passive fastopen":
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/0c2a587290902feb0c3c0a2f5c7f04e788d63751.1667993471.git.pabeni@redhat.com/

13037632: [net-next] Squash-to: "selftests: mptcp: mptfo
Initiator/Listener":
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/41b40e837c47147ce713ae0d35a916471d36f82d.1667993466.git.pabeni@redhat.com/

13038959: [mptcp-net] selftests: mptcp: fix mibit vs mbit mix up:
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221110160017.3641527-1-matthieu.baerts@tessares.net/

13039073: [mptcp-next,1/2] selftests: mptcp: clearly declare global ns vars
13039074: [mptcp-next,2/2] selftests: mptcp: declare var as local:
      - Series: mptcp: more cleanup in mptcp_sockopt.sh
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=694188&state=*&archive=both

13040102: [mptcp-next] Squash-to: "selftests: mptcp: mptfo
Initiator/Listener":
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/508587c12b02e0f33388aa2fe30add27eb8c13c8.1668161791.git.pabeni@redhat.com/

13040167: [mptcp-next,1/2] Squash-to: "mptcp: implement delayed seq
generation for passive fastopen"
13040168: [mptcp-next,2/2] Squash-to: "mptcp: add
subflow_v(4,6)_send_synack()":
      - Series: [mptcp-next,1/2] Squash-to: "mptcp: implement delayed
seq generation for passive fastopen"
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=694478&state=*&archive=both

13040592: [mptcp-next] Squash-to: "selftests: mptcp: mptfo
Initiator/Listener": fix mmap failure:
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/81db127b6a12947e39a6715d567e22c0bfd3d9b8.1668184713.git.pabeni@redhat.com/

13042195: [mptcp-next,1/3] Squash-to: "mptcp: implement delayed seq
generation for passive fastopen"
13042196: [mptcp-next,2/3] Squash-to: "mptcp: implement delayed seq
generation for passive fastopen"
13042194: [mptcp-next,3/3] Squash-to: "selftests: mptcp: mptfo
Initiator/Listener":
      - Series: mptcp: fix checkpatch splats
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=695060&state=*&archive=both

13042599: [mptcp-next,1/5] Squash-to: "mptcp: implement delayed seq
generation for passive fastopen"
13042600: [mptcp-next,2/5] Squash-to (part 1): "mptcp: add
subflow_v(4,6)_send_synack()"
13042602: [mptcp-next,3/5] Squash-to (part 2): "mptcp: add
subflow_v(4,6)_send_synack()"
13042601: [mptcp-next,4/5] Squash-to (part 3): "mptcp: add
subflow_v(4,6)_send_synack()"
13042603: [mptcp-next,5/5] Squash-to: "selftests: mptcp: mptfo
Initiator/Listener":
      - Series: mptcp: uniform code style and fix checkpatch splats
      - Submitter: Matthieu Baerts
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=695171&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

13044249: [net,1/3] selftests: mptcp: gives slow test-case more time
13044250: [net,2/3] selftests: mptcp: run mptcp_sockopt from a new netns
13044251: [net,3/3] selftests: mptcp: fix mibit vs mbit mix up:
      - Series: mptcp: selftests: Fix timeouts and test isolation
      - Submitter: Mat Martineau
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=695716&state=*&archive=both


    our repo (by: Benjamin Hesmans, Geliang Tang, Jiapeng Chong,
Matthieu Baerts, Menglong Dong, Paolo Abeni):

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
12970168: [RFC,mptcp-next,10/10] mptcp: test TFO
13007315: [RFC] selftests: mptcp: set test-case parameters consistently:
      - State: RFC
      - Status: same as last week

13029900: [mptcp-next,v6,1/4] mptcp: introduce 'sk' to replace
'sock->sk' in mptcp_listen()
13029901: [mptcp-next,v6,2/4] mptcp: add statistics for mptcp socket in use
13029902: [mptcp-next,v6,3/4] selftest: mptcp: exit from
copyfd_io_poll() when receive SIGUSR1
13029903: [mptcp-next,v6,4/4] selftest: mptcp: add test for mptcp socket
in use:
      - State: Changes requested
      - Series: mptcp: add statistics for mptcp socket in use
      - Submitter: Menglong Dong
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=691610&state=*&archive=both
      - Status: same as last week

13039803: [mptcp-next,v19,1/9] mptcp: refactor push_pending logic
13039804: [mptcp-next,v19,2/9] mptcp: drop last_snd and
MPTCP_RESET_SCHEDULER
13039805: [mptcp-next,v19,3/9] mptcp: add sched_data_set_contexts helper
13039806: [mptcp-next,v19,4/9] Squash to "mptcp: add struct mptcp_sched_ops"
13039807: [mptcp-next,v19,5/9] Squash to "bpf: Add bpf_mptcp_sched_ops"
13039808: [mptcp-next,v19,6/9] Squash to "bpf: Add
bpf_mptcp_sched_kfunc_set"
13039809: [mptcp-next,v19,7/9] Squash to "selftests/bpf: Add bpf_first
scheduler"
13039810: [mptcp-next,v19,8/9] Squash to "selftests/bpf: Add bpf_bkup
scheduler"
13039811: [mptcp-next,v19,9/9] Squash to "selftests/bpf: Add bpf_rr
scheduler":
      - State: Queued
      - Series: BPF redundant scheduler, part 1
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=694383&state=*&archive=both
      - TODO: Matth: To be applied in the last section (new features for
other trees (bpf)) with the others → done

13040964: [mptcp-next] Squash to "mptcp: refactor push_pending logic" v19:
      - State: Queued
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221112003133.27153-1-geliang.tang@suse.com/
      - TODO: Matth: See above: to be applied → done

13041839: [mptcp-next] mptcp: don't fallback when dss validating fails:
      - State: Rejected
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/patch/20221114024005.26661-1-geliang.tang@suse.com/

13044027: [mptcp-next,1/2] mptcp: consolidate initial ack seq generation
13044028: [mptcp-next,2/2] Squash-to "mptcp: implement delayed seq
generation for passive fastopen":
      - State: Queued
      - Series: mptcp: more fastopen follow-up
      - Submitter: Paolo Abeni
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=695647&state=*&archive=both
      - TODO: Matth: To be applied → done

13045005: [mptcp-next,v20,1/7] mptcp: add scheduler wrappers
13045006: [mptcp-next,v20,2/7] mptcp: use get_send wrapper
13045007: [mptcp-next,v20,3/7] mptcp: use get_retrans wrapper
13045008: [mptcp-next,v20,4/7] mptcp: delay updating first_pending
13045009: [mptcp-next,v20,5/7] mptcp: delay updating already_sent
13045010: [mptcp-next,v20,6/7] selftests/bpf: Add bpf_red scheduler
13045011: [mptcp-next,v20,7/7] selftests/bpf: Add bpf_red test:
      - State: Under review
      - Series: BPF redundant scheduler, part 2
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=695953&state=*&archive=both
      - Mat is going to look at it
      - Complicated to support the redundant part
      - the first 3 patches add capabilities for the kernel to support
the same chunk on multiple subflows to help for the redundant scheduler

13046149: [mptcp-next,v5,1/4] mptcp: add pm listener events
13046150: [mptcp-next,v5,2/4] selftests: mptcp: enhance userspace pm tests
13046151: [mptcp-next,v5,3/4] selftests: mptcp: listener test for
userspace PM
13046152: [mptcp-next,v5,4/4] selftests: mptcp: listener test for
in-kernel PM:
      - State: New
      - Series: add pm listener events
      - Submitter: Geliang Tang
      - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=696257&state=*&archive=both
      - small modifications needed compared to v4, should be OK, Mat
will look at that



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 314):

  315  Issues with backup flow:
      - probably linked to backup bit ignored on signal endpoints: not
supported by the protocol
      - (and this kernel doesn't send MP_PRIO after)


    Bugs (opened, flagged as "bug" and assigned)

None.


    Bugs (opened and flagged as "bug" and not assigned)

  315  Issues with backup flow
  290  Not possible to `connect()` after a disconnect for a passive
socket [bug]


    In Progress (opened, new feature and assigned)

  313  Add netlink events for listening socket create/close
[enhancement] @geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti

   75  BPF: packet scheduler [enhancement] @geliangtang:
       - See patches above

   74  BPF: path manager [enhancement] @geliangtang

   59  (MP)TFO support [enhancement] @dmytroshytyi:
       - Patches have been merged
       - Remaining stuffs:
           - Packetdrill: client side (TODO Matth: check that → done)
           - Packetdrill: server side (we don't have any)
           - socketoption? (set key + packetdrill)


    Assigned Questions (opened, questions and assigned)

  307  TCP performance better than MPTCP [question] @matttbe


    Open questions (opened, questions and not assigned)

/

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


    Recently closed (since last week)

  310  selftests: `simult_flows`: transfer slower than expected! [bug]
[selftests] @matttbe
  299  several kernel warnings about mptcp [bug]



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (6.2):
https://github.com/multipath-tcp/mptcp_net-next/projects/17
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [473bfa2bd6b0] selftests: mptcp: gives slow test-case more
time (Paolo Abeni)
        - [7a8925011f45] selftests: mptcp: run mptcp_sockopt from a new
netns (Matthieu Baerts)
        - [14fa699a873b] selftests: mptcp: fix mibit vs mbit mix up
(Matthieu Baerts):
            - Sent by Mat, pending on netdev → Done

    - Fixes for net-next:

        - [62e785366aae] tcp: Fix tcp_syn_flood_action() if
CONFIG_IPV6=n (Geert Uytterhoeven)

    - Features for net-next:

        - [5dc475c51346] mptcp: deduplicate error paths on endpoint
creation (Paolo Abeni)
        - [64400bbdec4c] mptcp: more detailed error reporting on
endpoint creation (Paolo Abeni):
            - Can be sent → Done

        - [883032041349] selftests: mptcp: run mptcp_inq from a clean
netns (Matthieu Baerts)
        - [ad1e59de5f53] selftests: mptcp: removed defined but unused
vars (Matthieu Baerts)
        - [dd49f6582b97] selftests: mptcp: uniform 'rndh' variable
(Matthieu Baerts)
        - [e970f74eb973] selftests: mptcp: clearly declare global ns
vars (Matthieu Baerts)
        - [873d96466389] selftests: mptcp: declare var as local
(Matthieu Baerts):
            - can wait
            - we should have an rc7 so we have time to have the other
selftests fixes in net to be applied + sync with net-next

    - Features for net-next (next):

        - [2fdb10e80dcd] mptcp: add MSG_FASTOPEN sendmsg flag support
(Dmytro Shytyi)
        - [16ba533e0f13] mptcp: track accurately the incoming MPC
suboption type (Paolo Abeni)
        - [6646f09c903c] mptcp: implement delayed seq generation for
passive fastopen (Dmytro Shytyi)
        - [ce6ca7f0fc35] mptcp: add subflow_v(4,6)_send_synack() (Dmytro
Shytyi)
        - [0d8888194e7a] mptcp: add TCP_FASTOPEN sock option (Dmytro Shytyi)
        - [c4e6ca8c393d] selftests: mptcp: mptfo Initiator/Listener
(Dmytro Shytyi):
            - some patches for this are pending, we can wait

    - Features for other trees:

        - [c6ab9780932c] mptcp: add struct mptcp_sched_ops (Geliang Tang)
        - [2663d24bad22] mptcp: add a new sysctl scheduler (Geliang Tang)
        - [d61f5f2f9763] mptcp: add sched in mptcp_sock (Geliang Tang)
        - [b9073ee3cd6d] mptcp: add scheduled in mptcp_subflow_context
(Geliang Tang)
        - [dced721c0b29] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [0bc4260eaa8d] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)
        - [d70b4bd1439a] selftests/bpf: Add mptcp sched structs (Geliang
Tang)
        - [d9973d8c187a] selftests/bpf: Add bpf_first scheduler (Geliang
Tang)
        - [9a1aec180fa4] selftests/bpf: Add bpf_first test (Geliang Tang)
        - [91ce0ffc8e2e] selftests/bpf: Add bpf_bkup scheduler (Geliang
Tang)
        - [4b583820d256] selftests/bpf: Add bpf_bkup test (Geliang Tang)
        - [451038503610] selftests/bpf: Add bpf_rr scheduler (Geliang Tang)
        - [d1c7fe91874e] selftests/bpf: Add bpf_rr test (Geliang Tang):
            - status: same as last week: we can wait



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - No new MPTCP issues

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - issues with the automation but not linked to MPTCP: no news

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - situation is better
        - some instabilities with:
            - packetdrill add-addr: because it is the first one and
processing/crafting ADD_ADDR echo is quite slow?
            - mptcp join: with the last one? (111: delete and re-add)



Next meeting:
    - Next one on Thursday, the 24th of November.
    - 16:00 UTC (8am PST, 5pm CET, 12am CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20221124



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
