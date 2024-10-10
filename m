Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C02D29AF
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557811; cv=none; b=Gu8eX5b7/53ob6I7kidhzN0L4isFxfXvIRcV7Wmd/0DF1USUbKlPXAunrQtkpJ5MJ23UYoJzqP3y5PO0g47LzjTveqtJ+TDz1YLTcCBE52Q4uGppd2m2pN9Hyp/P0c7KMg4xTX9pQQicTGkRFmDpMV5v74BytXrUBy508OHp/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557811; c=relaxed/simple;
	bh=GZBT3dYrlwCWlRYuVpGCc2ZJVoJqZe9vmKt7PBDZYFY=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=ic5gq2+ACYr1Q6QALdz6/jPojKrCQzk46uC38icFW0FiWEW5qoSaPvir60dBwnpwLmxnZC4gVL1TYvQqgNzyTg1j2pXA0pws9DMnr1DACiHM1qaMjpAkCEAqD2lPjPY0CnfP+L6/iQsECvwE6h8SORwC7xWX1LtwkHearaeu7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGnbPAHn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGnbPAHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1162AC4CEC5
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 10:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728557810;
	bh=GZBT3dYrlwCWlRYuVpGCc2ZJVoJqZe9vmKt7PBDZYFY=;
	h=Date:From:To:Subject:From;
	b=aGnbPAHn2nnT9KC00Dm/8tJ3b/TNV+k9bvNZlTPlyUfmhXIOYnhtSkFqTFH14CtYP
	 ZaUeXpLkUPr59UnofSn/xrAKhr8VWiN7t6aUt/WcGNgSBLPeT4Zc74abbGbisMZ7wy
	 OZvPqxYdfVbR2/kSRe9SHztP32E6AS4z5suIHzhG40cOCRHNsuS83zQrEEU0nZpiOx
	 ytkARsD8cAVC+KMYZ4Lf+rlRMzCa8KoYEljcJRpVrlzKtzSPaZFlRyMhpgDDozpqyt
	 zQ0SJHYmk8kNW/xHWWH1kK9aOTlRxzDWehuplsXJfV13gAzgQkuJzI+2cHeAWO4eAz
	 SCMMLtzmyTFLA==
Message-ID: <fcd23360-5fb7-4510-8b9d-3bcc97222860@kernel.org>
Date: Thu, 10 Oct 2024 12:56:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Linux <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 9th of October 2024
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our new meeting with Christoph (Apple), Mat (Cruise),
and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Matthieu Baerts (NGI0)):

13821410: [mptcp-net] mptcp: fallback if MPTCP opts are dropped after
1st data:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241003-mptcp-gh-518-v1-1-e79e1f6434ad@kernel.org/

13826643: [mptcp-net,v3,1/2] mptcp: prevent MPC handshake on port-based
signal endpoints
13826644: [mptcp-net,v3,2/2] selftests: mptcp: join: add test-case for
MPC attempt towards signl ep:
    - Series: mptcp: prevent MPC handshake on port-based signal endpoints
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=896784&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts
(NGI0), Yunsheng Lin):

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
    - @Geliang: what should we do with them?
        - The commit 1e115a58be0ff ("selftests/bpf: netns_new() and
netns_free() helpers.") now in bpf-next makes this set useless. I'll
send a patch as v3 of this set to use these new helpers in mptcp
selftests too recently.

13689188: [RESEND,v2] checkpatch: skip warnings for symbol links:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/dc502b1b45cb27fda48d72d73e3267a32db023d8.1717722648.git.tanggeliang@kylinos.cn/
    - reminder sent by Matth, will see
    - Let's drop this patch from patchwork → Done

13826239: [net,1/4] mptcp: handle consistently DSS corruption
13826240: [net,2/4] tcp: fix mptcp DSS corruption due to large pmtu xmit
13826241: [net,3/4] mptcp: fallback when MPTCP opts are dropped after
1st data
13826242: [net,4/4] mptcp: pm: do not remove closing subflows:
    - Series: mptcp: misc. fixes involving fallback to TCP
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=896666&state=*&archive=both

13826295: [net-next,v20,12/14] net: replace page_frag with page_frag_cache:
    - Mat's Acked tag has been dropped in v14
    - Reason:
https://lore.kernel.org/all/6b9503fe-566c-49bb-97b9-941090f9cf7e@huawei.com/


    our repo (by: Asbjørn Sloth Tønnesen, Davide Caratti, Geliang Tang,
Gregory Detal, Matthieu Baerts):

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
    - Status is the same

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
    - Status is the same

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
    - Status is the same

13656189: [mptcp-net,v2] mptcp: fix the default value of scaling_ratio:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/
    - Status is the same

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
    - Status is the same

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
    - Status is the same
    - Let's drop this series from patchwork → Done

13750069: [mptcp-next,1/4] selftests: mptcp: add cfg_timeo for mptcp_connect
13750070: [mptcp-next,2/4] selftests: mptcp: add io thread mode for
mptcp_connect
13750071: [mptcp-next,3/4] selftests: mptcp: enable io thread mode
13750072: [mptcp-next,4/4] selftests: mptcp: join: add io thread tests:
    - State: Changes requested
    - Series: add io thread mode tests
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=875830&state=*&archive=both
    - Status is the same

13795803: [mptcp-next,2/2] mptcp: add back mptcp_pm_subflow_closed:
    - State: Changes requested
    - Series: update PM event CLOSED handlers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=888215&state=*&archive=both
    - Status is the same
    - Let's drop this patch from patchwork → Done

13803165: [net-next] tools: ynl-gen: use big-endian netlink attribute types:
    - State: Changes requested
    - Submitter: Asbjørn Sloth Tønnesen
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240913085555.134788-1-ast@fiberby.net/
    - Status is the same
    - Let's drop this patch from patchwork → Done

13824435: [mptcp-next,v3,01/10] mptcp: add struct mptcp_id_bitmap
13824436: [mptcp-next,v3,02/10] mptcp: add mptcp_userspace_pm_get_sock
helper
13824437: [mptcp-next,v3,03/10] mptcp: use __lookup_addr in pm_netlink
13824438: [mptcp-next,v3,04/10] mptcp: use sock_kfree_s instead of kfree
13824439: [mptcp-next,v3,05/10] mptcp: add lookup_addr for userspace pm
13824440: [mptcp-next,v3,06/10] mptcp: change remote as mptcp_addr_info
13824441: [mptcp-next,v3,07/10] mptcp: change local as mptcp_pm_addr_entry
13824442: [mptcp-next,v3,08/10] mptcp: make pm wrappers static
13824443: [mptcp-next,v3,09/10] mptcp: drop skb parameter of get_addr
13824444: [mptcp-next,v3,10/10] mptcp: drop skb parameter of set_flags:
    - State: New
    - Series: cleanups for PM interfaces
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=896160&state=*&archive=both
    - Matth will look at that

13826150: [mptcp-next,v2,01/13] mptcp: add id parameter for get_addr
13826151: [mptcp-next,v2,02/13] mptcp: add addr parameter for get_addr
13826152: [mptcp-next,v2,03/13] mptcp: reuse sending nlmsg code in get_addr
13826153: [mptcp-next,v2,04/13] mptcp: change info of get_addr as const
13826154: [mptcp-next,v2,05/13] mptcp: refactor dump_addr with id bitmap
13826155: [mptcp-next,v2,06/13] mptcp: refactor dump_addr with get_addr
13826156: [mptcp-next,v2,07/13] mptcp: reuse sending nlmsg code in dump_addr
13826157: [mptcp-next,v2,08/13] mptcp: add loc and rem for set_flags
13826158: [mptcp-next,v2,09/13] mptcp: update address type of get_local_id
13826159: [mptcp-next,v2,10/13] mptcp: change is_backup interfaces as
get_flags
13826160: [mptcp-next,v2,11/13] mptcp: hold pm lock when deleting entry
13826161: [mptcp-next,v2,12/13] mptcp: rename mptcp_pm_remove_addrs
13826162: [mptcp-next,v2,13/13] mptcp: drop free_list for deleting entries:
    - State: New
    - Series: refactor PM interfaces
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=896645&state=*&archive=both
    - depends on "cleanups for PM interfaces"

13826745: [mptcp-next] mptcp: use "middlebox interference" for MP_TCPRST
in case map_valid is false:
    - State: New
    - Submitter: Davide Caratti
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/4b2cee91613e597a172b46bb0d9d3143053c52da.1728408247.git.dcaratti@redhat.com/
    - To be reviewed
    - Matth will look at that: TODO → Done

13828018: [mptcp-next,v9,1/7] bpf: Register mptcp common kfunc set
13828019: [mptcp-next,v9,2/7] bpf: Add mptcp_subflow bpf_iter
13828020: [mptcp-next,v9,3/7] bpf: Add mptcp_sock acquire and release
helpers
13828021: [mptcp-next,v9,4/7] selftests/bpf: Add mptcp_subflow bpf_iter
test prog
13828022: [mptcp-next,v9,5/7] selftests/bpf: More endpoints for
endpoint_init
13828023: [mptcp-next,v9,6/7] Squash to "selftests/bpf: Add bpf
scheduler test"
13828024: [mptcp-next,v9,7/7] selftests/bpf: Add mptcp_subflow bpf_iter
subtest:
    - State: New
    - Series: add mptcp_subflow bpf_iter
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=897104&state=*&archive=both
    - Mat will look at that

13828126: [mptcp-next,v3,01/10] Squash to "bpf: Add
bpf_mptcp_sched_kfunc_set"
13828127: [mptcp-next,v3,02/10] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13828128: [mptcp-next,v3,03/10] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13828129: [mptcp-next,v3,04/10] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13828130: [mptcp-next,v3,05/10] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13828131: [mptcp-next,v3,06/10] Squash to "bpf: Export more bpf_burst
related functions"
13828132: [mptcp-next,v3,07/10] Squash to "selftests/bpf: Add bpf_burst
scheduler & test"
13828133: [mptcp-next,v3,08/10] Revert "mptcp: add sched_data helpers"
13828134: [mptcp-next,v3,09/10] mptcp: drop subflow contexts in
mptcp_sched_data
13828135: [mptcp-next,v3,10/10] Squash to "selftests/bpf: Add bpf
scheduler test" - drop has_bytes_sent:
    - State: New
    - Series: use bpf_iter in bpf schedulers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=897127&state=*&archive=both
    - depends on "add mptcp_subflow bpf_iter"




Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 518):

  520  Question about proper MPTCP configuration over VPN.:
      - More info needed here
      - Probably we should add a template including what people should
share in a new ticket: TODO

  519  Reset the connection once "MPTCP has been verified" instead of a
fallback [enhancement]:
      - to be compliant with the RFC's recommendations
      - probably best not to change the behaviour of when we send
ADD_ADDR, etc.
      - see the idea suggested in the ticket


    Bugs (opened, flagged as "bug" and assigned)

  487  `send()` fails with `EAGAIN` in blocking IO mode [bug]
[selftests] [sched] @geliangtang
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf]
@geliangtang
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  508  Divide error on device removal [bug] [feedback-needed]
  505  Subflows won't be used when the interface for the main flow is a
subinterface [bug] [feedback-needed]
  501  Why do endpoint tcp connections close? [bug] [feedback-needed]
  499  selftests: `mptcp_connect.sh`: disconnect test timed out [bug]
[selftests]
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm]
  495  [syzkaller] KASAN: slab-use-after-free Read in
`__inet6_lookup_established` [bug] [syzkaller]
  494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]
  492  userspace pm: subflows counter: not updated when a subflows is
removed from the other end [bug]
  491  selftests: `mptcp_join`: tests `Infinite map` & `MP_FAIL MP_RST`
are unstable [bug] [selftests]
  483  [6.1] selftests: `mptcp_connect.sh` failures with
`copyfd_io_poll: poll timed out` errors [bug] [selftests]
  476  packetdrill: coalescing feature doesn't take into account MPTCP
options [bug] [packetdrill]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug]
[selftests]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  416  No new subflow when removing an endpoint and adding a new one
[bug] [feedback-needed]
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

  502  Question for ip-mptcp command [question]
  489  IPv6 Rejoin Subflow [question]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

  520  Question about proper MPTCP configuration over VPN.
  519  Reset the connection once "MPTCP has been verified" instead of a
fallback [enhancement]
  515  Add `TCP_MAXSEG` socket option support [enhancement]
  514  Add MIB counters for fallback to TCP [enhancement]
  511  Add MIB counters for sent `MPTCP_RST_EMPTCP` [enhancement]
  503  in-kernel PM: use endpoints only to create subflows with received
`ADD_ADDR` [enhancement] [pm]
  497  in-kernel PM: check to create new subflows when some are
destroyed [enhancement] [pm]
  496  in-kernel PM: store received `ADD_ADDR` [enhancement] [pm]
  481  remove refcount on TCP sockets for the timers [enhancement]
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
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2024-10-02)

  518  Connection is RST if data (< init window) with MPTCP options
received, then MPTCP options are dropped [bug]


    Packetdrill PRs

  52  3 years ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs:
        - recently added: HAProxy, Apache (httpd), pTCPDump, DAE


    mptcpd PRs

  306  5 hours ago   matttbe  lib: switch to v4.0.1: only added items
  305  21 hours ago  matttbe  Some clean-ups
  304  5 hours ago   matttbe  Support listener events:
      - Hopefully Ossame can have a look?



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.13):
https://github.com/orgs/multipath-tcp/projects/11
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /


    - Fixes for -net:

        - [241257a07365] mptcp: handle consistently DSS corruption
(Paolo Abeni)
        - [f82989f76970] tcp: fix mptcp DSS corruption due to large pmtu
xmit (Paolo Abeni)
        - [94c1b64650e8] mptcp: pm: do not remove closing subflows
(Matthieu Baerts (NGI0))
        - [2c69e317aceb] mptcp: fallback when MPTCP opts are dropped
after 1st data (Matthieu Baerts (NGI0)):
            - already sent

        - [1bc6b383da6a] mptcp: prevent MPC handshake on port-based
signal endpoints (Paolo Abeni)
        - [3e6b0fb14dcf] selftests: mptcp: join: test for prohibited MPC
to port-based endp (Paolo Abeni):
            - probably best to wait a bit before sending them, applied today
            - TODO send next week, Matth → scheduled

    - Fixes for net-next: /

    - Features for net-next:

        - [424bbb61eeb7] mptcp: pm: send ACK on non stale subflows
(Matthieu Baerts (NGI0))
        - [5f432006308d] mptcp: annotate data-races around
subflow->fully_established (Gang Yan):
            - conflicting with "mptcp: fallback when MPTCP opts are
dropped after 1st data"
            - and "mptcp: prevent MPC handshake on port-based signal
endpoints"
            - can wait one more week → scheduled for later
        - [95cffe9d16f9] mptcp: implement mptcp_pm_connection_closed
(Geliang Tang)

    - Features for net-next (next): /

    - Features for other trees:

        - [21ff914394fd] mptcp: add sched_data helpers (Geliang Tang)
        - [6ff012c019b8] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [4a3553c9be60] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)

        - [93924e84d8c8] selftests/bpf: Add mptcp subflow example
(Nicolas Rybowski)
        - [ba3918b82b9e] selftests/bpf: Add getsockopt to inspect mptcp
subflow (Geliang Tang)
        - [04b5459ffca7] selftests/bpf: Add mptcp subflow subtest
(Geliang Tang):
            - have been applied in bpf-next/net, waiting for a sync with
net-next

        - [458e6ef99137] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [7404819c5dfc] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [d82efac21d32] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [b61436ea5a02] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [1fd1e62ff424] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [16d127b66eea] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [7fdbf8224a6b] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)



Extra tests:
    - news about Syzkaller? (Christoph):
        - broken on Christoph side, he will look at fixing that

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - quite good, but still some recurring issues, e.g.
          https://github.com/multipath-tcp/mptcp_net-next/issues/499



Meetings:
    - less "urgencies" these days, and we are better organised using GH
issues, patchworks, who is doing reviews, looking at issues, etc.
    - we suggest switching to one meeting every 2 weeks:
        - A "fortnightly" meeting, as in "occurring every two weeks",
because biweekly means "every two weeks", or "twice a week" apparently :)
        - https://www.merriam-webster.com/grammar/on-biweekly-and-bimonthly



Next meeting:
    - Next one on Wednesday, *in two weeks*, the 23rd of October.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20241023



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

