Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8814B968
	for <mptcp@lists.linux.dev>; Mon,  5 Aug 2024 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861477; cv=none; b=g3i2jQ64Fb7ScSxlPkJPXIZOAE00XeKAr4ouuHUJ3SHhEFTcXOG3ANR8P7pvKV5JUJZ9MG5IgbTyE68ACWGnyBPsNAiknlzarQA24EAFo7UQn0H2zBrklRZ6F7GVkhO5NMCMLAri/HJGhaX8acF23G3EWFV86HK6FiWHGU4P5/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861477; c=relaxed/simple;
	bh=8oLBzT3McCOWz0cCPKhKdS2yJM6fUvZ+h4Wtua7csUE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=aozt8KExXpBX27/mcDWl3e84HKX9WUw8sLjT8f42GbJWmHg+z3fk+kAuJWEf53w4QQIY/iBOZ/iQMAvRur46LSHXrjJo/n/119sqeX968PTxeJnbjuebcyp5X7h/gVKLhRF9hmS5Ja5ofwrQBCrHcM9lL3Cr/kw9ajWR7qlnQfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh7bwhZW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh7bwhZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81505C32782
	for <mptcp@lists.linux.dev>; Mon,  5 Aug 2024 12:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722861477;
	bh=8oLBzT3McCOWz0cCPKhKdS2yJM6fUvZ+h4Wtua7csUE=;
	h=Date:To:From:Subject:From;
	b=Qh7bwhZW6UqHGZC6JP09m0IwfiR2oD4F9CxDHIIetVcHlrmjP4BKLbMz74ptJV/Z4
	 1yKNxZpQ/94Pz7o95XhslZJLXfolo1gyJSPsPqSUMU7T0Nu1TkUgFZ9dWSP6Qxf2dF
	 4cYzlOD/4NlBm/3hEWY0IhIp7YTS335uqqdulbsXUwCcbvl8JWa8Pp5619QAA7fdAS
	 4J4Y7Ox4jyvdIwysEYKdcipSJcLkHzC1UI7Mue33i32juHoQVpnCCDdr05tkrGqB9d
	 sxTAMuuFOBZwKg7y7MPG9qhtCYk4VaRV+yYS2jaxSEyt+1vp/mO+SONDVRr9EiqgiT
	 x/f4zmNUNmhKA==
Message-ID: <f97b458b-6e78-4c84-a15c-ff682b6074eb@kernel.org>
Date: Mon, 5 Aug 2024 14:37:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 31st of July 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last week, we had our new meeting with Mat (Cruise), Christoph (Apple),
Davide (Redhat) and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Joel Granados, Matthieu Baerts):

13740840: [net,v3] tcp: process the 3rd ACK with sk_socket for TFO/MPTCP:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240724-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v3-1-d48339764ce9@kernel.org/

13741350: [GIT,PULL] sysctl constification changes for v6.11-rc1:
    - Submitter: Joel Granados
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240724210014.mc6nima6cekgiukx@joelS2.panther.com/

13743653: [net,1/5] mptcp: fix user-space PM announced address accounting
13743654: [net,2/5] mptcp: fix NL PM announced address accounting
13743655: [net,3/5] selftests: mptcp: add explicit test case for
remove/readd
13743656: [net,4/5] selftests: mptcp: fix error path
13743657: [net,5/5] selftests: mptcp: always close input's FD if opened:
    - Series: mptcp: fix signal endpoint readd
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=874228&state=*&archive=both

13743678: [net,1/7] mptcp: sched: check both directions for backup
13743679: [net,2/7] mptcp: distinguish rcv vs sent backup flag in requests
13743680: [net,3/7] mptcp: pm: only set request_bkup flag when sending
MP_PRIO
13743681: [net,4/7] mptcp: mib: count MPJ with backup flag
13743682: [net,5/7] selftests: mptcp: join: validate backup in MPJ
13743683: [net,6/7] mptcp: pm: fix backup support in signal endpoints
13743684: [net,7/7] selftests: mptcp: join: check backup support in
signal endp:
    - Series: mptcp: fix inconsistent backup usage
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=874234&state=*&archive=both


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

13739048: [mptcp-net,v4,01/23] mptcp: fully established after ADD_ADDR
echo on MPJ
13739049: [mptcp-net,v4,02/23] mptcp: pm: deny endp with signal +
subflow + port
13739050: [mptcp-net,v4,03/23] mptcp: pm: reduce indentation blocks
13739051: [mptcp-net,v4,04/23] mptcp: pm: don't try to create sf if
alloc failed
13739052: [mptcp-net,v4,05/23] mptcp: pm: do not ignore 'subflow' if
'signal' flag is also set
13739053: [mptcp-net,v4,06/23] selftests: mptcp: join: ability to invert
ADD_ADDR check
13739054: [mptcp-net,v4,07/23] selftests: mptcp: join: test both signal
& subflow
13739055: [mptcp-net,v4,08/23] mptcp: pm: re-using ID of unused removed
ADD_ADDR
13739056: [mptcp-net,v4,09/23] selftests: mptcp: join: check re-using ID
of unused ADD_ADDR
13739057: [mptcp-net,v4,10/23] mptcp: pm: re-using ID of unused removed
subflows
13739058: [mptcp-net,v4,11/23] selftests: mptcp: join: check re-using ID
of closed subflow:
    - Series: mptcp: fix endpoints with 'signal' and 'subflow' flags
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=874103&state=*&archive=both

13742046: [mptcp-net,1/2] mptcp: fix bad RCVPRUNED mib accounting
13742047: [mptcp-net,2/2] mptcp: fix duplicate data handling:
    - Series: [mptcp-net,1/2] mptcp: fix bad RCVPRUNED mib accounting
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=873877&state=*&archive=both

13742841: [mptcp-net,v5,01/13] mptcp: pm: re-using ID of unused flushed
subflows
13742842: [mptcp-net,v5,02/13] selftests: mptcp: join: test for
flush/re-add endpoints
13742843: [mptcp-net,v5,03/13] mptcp: pm: remove mptcp_pm_remove_subflow()
13742844: [mptcp-net,v5,04/13] mptcp: pm: only mark 'subflow' endp as
available
13742845: [mptcp-net,v5,05/13] mptcp: pm: only decrement
add_addr_accepted for MPJ req
13742846: [mptcp-net,v5,06/13] mptcp: pm: check add_addr_accept_max
before accepting new ADD_ADDR
13742847: [mptcp-net,v5,07/13] mptcp: pm: only in-kernel cannot have
entries with ID 0
13742848: [mptcp-net,v5,08/13] mptcp: pm: fullmesh: select the right ID
later
13742849: [mptcp-net,v5,09/13] selftests: mptcp: join: validate fullmesh
endp on 1st sf
13742850: [mptcp-net,v5,10/13] mptcp: pm: avoid possible UaF when
selecting endp
13742851: [mptcp-net,v5,11/13] mptcp: pm: reuse ID 0 after delete and re-add
13742852: [mptcp-net,v5,12/13] mptcp: pm: rename helpers linked to 'flush'
13742853: [mptcp-net,v5,13/13] mptcp: pm: reduce entries iterations on
connect:
    - Series: mptcp: fix endpoints with 'signal' and 'subflow' flags
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=874103&state=*&archive=both
    - More to come: → Done
        - rm and re-add 'subflow' endpoint linked to the init subflow:
no RM_ADDR sent, only subflow closed but:
            - subflow not closed when receiving TCP+FIN without DATA_FIN
        - re-adding init sf with != id
        - send ACK on an active subflow, not just the first one in the
list, e.g. init sf is closing

13743837: [RESEND,mptcp-next] selftests: mptcp: join: simplify
checksum_tests:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/b61be1bd6c70121fee3c6e183fb224b41d9dac90.1722138514.git.tanggeliang@kylinos.cn/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts,
Yunsheng Lin):

13665648: [bpf-next,v2,1/8] selftests/bpf: Add unshare_netns helper
13665649: [bpf-next,v2,2/8] selftests/bpf: Use unshare_netns helper
13665650: [bpf-next,v2,3/8] selftests/bpf: Drop duplicate create_netns
13665651: [bpf-next,v2,4/8] selftests/bpf: Export create_netns helper
13665652: [bpf-next,v2,5/8] selftests/bpf: Use create_netns helper
13665653: [bpf-next,v2,6/8] selftests/bpf: Export cleanup_netns helper
13665654: [bpf-next,v2,7/8] selftests/bpf: Use cleanup_netns helper
13665655: [bpf-next,v2,8/8] selftests/bpf: Use netns helpers in lwt tests:
    - Series: add netns helpers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853539&state=*&archive=both
    - status is the same as last week

13689188: [RESEND,v2] checkpatch: skip warnings for symbol links:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/dc502b1b45cb27fda48d72d73e3267a32db023d8.1717722648.git.tanggeliang@kylinos.cn/
    - status is the same as last week

13722725: [bpf-next,v3,1/3] selftests/bpf: Add mptcp subflow example
13722726: [bpf-next,v3,2/3] selftests/bpf: Add mptcp pm_nl_ctl link
13722727: [bpf-next,v3,3/3] selftests/bpf: Add mptcp subflow subtest:
    - Series: selftests/bpf: new MPTCP subflow subtest
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=868164&state=*&archive=both
    - status is the same as last week
    - TODO: Matth: check what to do here → Done

13736352: [net,v2,2/2] tcp: limit wake-up for crossed SYN cases to SYN-ACK:
    - Series: tcp: restrict crossed SYN specific actions to SYN-ACK
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=872226&state=*&archive=both
    - TODO: Matth: re-send it to net-next → Done

13743697: [iproute2-net,1/7] man: mptcp: document 'dev IFNAME'
13743698: [iproute2-net,2/7] man: mptcp: clarify 'signal' and 'subflow'
flags
13743699: [iproute2-net,3/7] man: mptcp: 'port' has to be used with 'signal'
13743700: [iproute2-net,4/7] man: mptcp: 'backup' flag also affects
outgoing data
13743701: [iproute2-net,5/7] man: mptcp: 'fullmesh' has to be used with
'subflow'
13743702: [iproute2-net,6/7] man: mptcp: clarify the 'ID' parameter
13743703: [iproute2-net,7/7] ip: mptcp: 'id 0' is only for 'del':
    - Series: mptcp: improve man pages to avoid confusions
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=874238&state=*&archive=both

13748430: [net,1/2] mptcp: fix bad RCVPRUNED mib accounting
13748431: [net,2/2] mptcp: fix duplicate data handling:
    - Series: mptcp: fix duplicate data handling
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=875404&state=*&archive=both

13748531: [net,1/7] mptcp: fully established after ADD_ADDR echo on MPJ
13748532: [net,2/7] mptcp: pm: deny endp with signal + subflow + port
13748533: [net,3/7] mptcp: pm: reduce indentation blocks
13748534: [net,4/7] mptcp: pm: don't try to create sf if alloc failed
13748535: [net,5/7] mptcp: pm: do not ignore 'subflow' if 'signal' flag
is also set
13748536: [net,6/7] selftests: mptcp: join: ability to invert ADD_ADDR check
13748537: [net,7/7] selftests: mptcp: join: test both signal & subflow:
    - Series: mptcp: fix endpoints with 'signal' and 'subflow' flags
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=875429&state=*&archive=both

13748763: [net-next,v12,12/14] net: replace page_frag with page_frag_cache


    our repo (by: Geliang Tang, Gregory Detal, Matthieu Baerts):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:
13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
    - State: Changes requested
    - Series: BPF redundant scheduler, part 3
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
    - status is the same as last week

13305089: [mptcp-next,1/6] mptcp: sockopt: move tcp_inq code to a
dedicated function
13305091: [mptcp-next,2/6] mptcp: sockopt: update supported list
13305093: [mptcp-next,3/6] mptcp: sockopt: get val in a generic way
13305090: [mptcp-next,4/6] mptcp: sockopt: add missing getsockopt() options
13305094: [mptcp-next,5/6] mptcp: sockopt: set val in a generic way
13305092: [mptcp-next,6/6] mptcp: sockopt: support IP_TTL &
IPV6_UNICAST_HOPS:
    - State: Changes requested
    - Series: mptcp: sockopt: uniform code to get/set values
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=763505&state=*&archive=both
    - status is the same as last week

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
    - status is the same as last week

13656189: [mptcp-net,v2] mptcp: fix the default value of scaling_ratio:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/
    - status is the same as last week

13665855: [mptcp-next,v3,1/2] Squash to "selftests/bpf: Add mptcp
subflow subtest"
13665856: [mptcp-next,v3,2/2] Squash to "selftests/bpf: Add bpf
scheduler test":
    - State: Changes requested
    - Series: fixes for create_netns
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853620&state=*&archive=both
    - status is the same as last week

13675217: [mptcp-next,RFC,1/4] mptcp: add push sched callback
13675218: [mptcp-next,RFC,2/4] mptcp: use new push callback to schedule
chunks
13675219: [mptcp-next,RFC,3/4] mptcp: bpf: allow to write to
mptcp_sched_chunk
13675220: [mptcp-next,RFC,4/4] selftests/bpf: mptcp RR: send 1 MSS on
each subflow:
    - State: RFC
    - Series: mptcp: update scheduler API
    - Submitter: Gregory Detal
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=856158&state=*&archive=both
    - status is the same as last week

13729347: [mptcp-next,1/3] mptcp: add mptcp_snd_nxt helper
13729348: [mptcp-next,2/3] Squash to "bpf: Export more bpf_burst related
functions"
13729349: [mptcp-next,3/3] Squash to "selftests/bpf: Add bpf_burst
scheduler":
    - State: Changes requested
    - Series: get msk->snd_nxt with READ_ONCE
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=870130&state=*&archive=both
    - status is the same as last week

13741513: [mptcp-next] Squash to "selftests/bpf: Add mptcp subflow subtest":
    - State: Under review
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/fccaccd2e7a1ce8518782c85965a6e26d37a87f9.1721872694.git.tanggeliang@kylinos.cn/
    - TODO: Matth: maybe easier to take this patch → Done (v2)

13744694: [mptcp-next,v2,1/2] mptcp: MIB counters for sent MP_JOIN
13744695: [mptcp-next,v2,2/2] selftests: mptcp: join: validate MPJ SYN
TX MIB counters:
    - State: Under review
    - Series: mptcp: MIB counters for sent MP_JOIN
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=874506&state=*&archive=both
    - one remaining question:
        - do we keep the counter linked to the non fully established mode?

13746957: [mptcp-next] Squash to "selftests/bpf: Add mptcp subflow
subtest" - set limits:
    - State: Rejected
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/9dafce3091d30a8446897813d2a9d302625c09d0.1722327628.git.tanggeliang@kylinos.cn/



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 510):

  512  Primary flow re-establishes as a subflow but immediately closes
[bug]:
      - Might be fixed by the patches Matth was working on, not properly
sent yet (but suggested in the bug report)
      - To be validated

  511  Add MIB counters for sent `MPTCP_RST_EMPTCP` [enhancement]:
      - Would help to debug issues where unexpected RST are seen, likely
due to internal issues


    Bugs (opened, flagged as "bug" and assigned)

  487  `send()` fails with `EAGAIN` in blocking IO mode [bug]
[selftests] [sched] @geliangtang
  477  Client: fallback to TCP after X MPC [bug] @matttbe
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  512  Primary flow re-establishes as a subflow but immediately closes [bug]
  508  Divide error on device removal [bug]
  505  Subflows won't be used when the interface for the main flow is a
subinterface [bug]
  501  Why do endpoint tcp connections close? [bug]
  500  cleanup rbuf bug [bug]
  499  selftests: `mptcp_connect.sh`: disconnect test timed out [bug]
[selftests]
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm]
  495  [syzkaller] KASAN: slab-use-after-free Read in
`__inet6_lookup_established` [bug] [syzkaller]
  494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]
  493  [syzkaller] WARNING in `__mptcp_clean_una` [bug] [syzkaller]
  492  userspace pm: subflows counter: not updated when a subflows is
removed from the other end [bug]
  491  selftests: `mptcp_join`: tests `Infinite map` & `MP_FAIL MP_RST`
are unstable [bug] [selftests]
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf]
  483  [6.1] selftests: `mptcp_connect.sh` failures with
`copyfd_io_poll: poll timed out` errors [bug] [selftests]
  476  packetdrill: coalescing feature doesn't take into account MPTCP
options [bug] [packetdrill]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug]
[selftests]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  416  No new subflow when removing an endpoint and adding a new one [bug]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  480  MPTCP and KTLS support [enhancement] @geliangtang
  434  in-kernel PM: increase subflows limit [enhancement] [pm] @matttbe
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  506  [Question] Cannot create backup subflows to remote endpoints?
[question]
  502  Question for ip-mptcp command [question]
  489  IPv6 Rejoin Subflow [question]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

  511  Add MIB counters for sent `MPTCP_RST_EMPTCP` [enhancement]
  509  Add MIB counters for sent MPJ [enhancement]
  503  in-kernel PM: use endpoints only to create subflows with received
`ADD_ADDR` [enhancement] [pm]
  497  in-kernel PM: check to create new subflows when some are
destroyed [enhancement] [pm]
   496  in-kernel PM: store received `ADD_ADDR` [enhancement] [pm]
  481  remove refcount on TCP sockets for the timers [enhancement]
  469  CI: add code coverage support [enhancement] [CI]
  467  Scheduler: add redundant scheduler support in BPF [enhancement]
[sched]
  462  selftests: print (and set?) random seed [enhancement] [selftests]
  461  Protocol: extend Data-Level Length field [enhancement] [protocol]
  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps
are enabled [enhancement]
  441  optimize established options generation [enhancement]
  440  in-kernel PM: re-establish subflows after "network" errors
[enhancement] [pm]
  426  selftests: validate listener sockets with multiple accepts
[enhancement] [selftests]
  397  Doc and guidance for users [enhancement] [documentation]
  396  ci: periodically run selftests from the export branch on stable
kernels [enhancement] [selftests]
  389  packetdrill: increase coverage for "early `close()`" cases
[enhancement] [packetdrill]
  350  scheduler: API changes (tasks) [enhancement] [sched]
  348  scheduler: frequently probe "stale" subflow with reinjected data
[enhancement] [sched]
  345  scheduler: "penalise" some subflows by sending less than their
cwnd [enhancement] [sched]
  344  scheduler: new callback to initiate optimisations [enhancement]
[sched]
  337  in-kernel PM: listen socket: support "behind a NAT" use case
[enhancement] [pm]
  335  Server to Client subflows: option to allow joining the initial
address and port [enhancement] [pm]
  334  in-kernel PM: send >1 ADD_ADDR before the establishment of a new
subflow [enhancement] [pm]
  333  New MIBs to help understanding issues when PM cannot create new
subflows [enhancement] [pm]
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
   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2024-07-24)

None.


    Packetdrill PRs

  # 52  2 years ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs

  # /



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.12):
https://github.com/orgs/multipath-tcp/projects/10
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees:

        - [efcd3572877c] selftests/bpf: Filter out _GNU_SOURCE when
compiling test_cpp (Stanislav Fomichev)

    - Fixes for -net:

        - [c89694bba94d] tcp: limit wake-up for crossed SYN cases to
SYN-ACK (Matthieu Baerts (NGI0)):
            - To be sent to net-next: TODO: Matth → Done

        - [b61261346726] mptcp: fix bad RCVPRUNED mib accounting (Paolo
Abeni)
        - [e4ba6d8f54c2] mptcp: fix duplicate data handling (Paolo Abeni):
            - They have been sent today

        - [20a731236dc4] mptcp: fully established after ADD_ADDR echo on
MPJ (Matthieu Baerts (NGI0))
        - [eeb63fa4acce] mptcp: pm: deny endp with signal + subflow +
port (Matthieu Baerts (NGI0))
        - [331451306067] mptcp: pm: reduce indentation blocks (Matthieu
Baerts (NGI0))
        - [0ca6e4074810] mptcp: pm: don't try to create sf if alloc
failed (Matthieu Baerts (NGI0))
        - [c6b7d0067c4a] mptcp: pm: do not ignore 'subflow' if 'signal'
flag is also set (Matthieu Baerts (NGI0))
        - [06d385527cdd] selftests: mptcp: join: ability to invert
ADD_ADDR check (Matthieu Baerts (NGI0))
        - [b1e087983abf] selftests: mptcp: join: test both signal &
subflow (Matthieu Baerts (NGI0))
            - They have been sent today

        - [13619b2cc492] mptcp: pm: re-using ID of unused removed
ADD_ADDR (Matthieu Baerts (NGI0))
        - [af295388cccd] selftests: mptcp: join: check re-using ID of
unused ADD_ADDR (Matthieu Baerts (NGI0))
        - [0c8f40d24cf4] mptcp: pm: re-using ID of unused removed
subflows (Matthieu Baerts (NGI0))
        - [dcc083223a81] selftests: mptcp: join: check re-using ID of
closed subflow (Matthieu Baerts (NGI0))
        - [c4349b276130] mptcp: pm: re-using ID of unused flushed
subflows (Matthieu Baerts (NGI0))
        - [f9fb44ebf272] selftests: mptcp: join: test for flush/re-add
endpoints (Matthieu Baerts (NGI0))
        - [4f87a31fbd7f] mptcp: pm: remove mptcp_pm_remove_subflow()
(Matthieu Baerts (NGI0))
        - [8976a730b80c] mptcp: pm: only mark 'subflow' endp as
available (Matthieu Baerts (NGI0))
        - [b89be9a708d5] mptcp: pm: only decrement add_addr_accepted for
MPJ req (Matthieu Baerts (NGI0))
        - [22cb1de930e4] mptcp: pm: check add_addr_accept_max before
accepting new ADD_ADDR (Matthieu Baerts (NGI0))
        - [d37c1733b045] mptcp: pm: only in-kernel cannot have entries
with ID 0 (Matthieu Baerts (NGI0))
        - [7dc6c84b4c30] mptcp: pm: fullmesh: select the right ID later
(Matthieu Baerts (NGI0))
        - [7526c87a7aa7] selftests: mptcp: join: validate fullmesh endp
on 1st sf (Matthieu Baerts (NGI0))
        - [1bd6e348e55c] mptcp: pm: avoid possible UaF when selecting
endp (Matthieu Baerts (NGI0))
        - [24e5377984d0] mptcp: pm: reuse ID 0 after delete and re-add
(Matthieu Baerts (NGI0)):
            - applied today, can wait a bit

    - Fixes for net-next: /

    - Features for net-next:

        - [68917c5633e5] selftests: mptcp: join: simplify checksum_tests
(Geliang Tang)
        - [7d2982f194c0] mptcp: pm: rename helpers linked to 'flush'
(Matthieu Baerts (NGI0))
        - [744c8b345086] mptcp: pm: reduce entries iterations on connect
(Matthieu Baerts (NGI0)):
            - can wait a bit, applied today, there are patches for -net
anyway

    - Features for net-next (next): /

    - Features for other trees:

        - [24bf72f51a04] mptcp: add sched_data helpers (Geliang Tang)
        - [48bc5bb518f9] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [d6f4f0bf918c] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)

        - [5b338a450a4b] selftests/bpf: Add mptcp subflow example
(Nicolas Rybowski)
        - [14d995778228] selftests/bpf: Add mptcp pm_nl_ctl link
(Geliang Tang)
        - [c5bc14af8ed3] selftests/bpf: Add mptcp subflow subtest
(Geliang Tang):
            - re-sent these 3 with Geliang's patches

        - [20c240b69d16] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [94e911efb35d] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [6c257ed634ec] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [3e076ad694b2] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [67c4a27e751d] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [e6e91a9dcb9c] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [6766887c5669] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang):
            - status: same: waiting for the sched API refact



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        -
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/10174787351:
            - one issue with packetdrill, but linked to timers, to be
monitored, doesn't seem problematic
            - another issue with connect, similar to what was seen on
Netdev CI:
                https://github.com/multipath-tcp/mptcp_net-next/issues/499
            - one issue with EAGAIN on a blocking connection, to be checked:

https://github.com/multipath-tcp/mptcp_net-next/actions/runs/10174787351



Next meeting:
    - Next one on Wednesday, the 7th of August.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20240807



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.
