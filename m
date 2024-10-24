Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C62F1FE109
	for <mptcp@lists.linux.dev>; Thu, 24 Oct 2024 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790544; cv=none; b=SqC4uDX6iN5Lx6ohgUIQiv3dNeYbLOScgAV2ShAub6z2/jC9aUj7t80C4q0NxAall7LPErPH7T0xO+RR7YwZGqTDC3bVZww0srw8Gv3Jr6vYZnPzKJBRKE1qLQaHrYCW3pBdqW9QFuAt8+/xyEWHgvCOjqVXhL1D7T3Gje0sShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790544; c=relaxed/simple;
	bh=V8n8b9v7j8eMIL3dxev21l3R4jUTH1XgYC16xv4+Tio=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=INSIjPELRnJTWeMwUyZZif4YyngJcPt5HszDXZ4ynC+AKuAT/X80iSH4MnwW1zeLr+Yk1yMPnuINUmqJZSOn/GuzlPTNSRX3fiu2mOEm+nLiedTMvdM1pflQTWQhNp1ftDgAlo575jFaqHQIUMG7Zhj9GWvnQ/p+bZVIz24HZ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwKi4DWe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwKi4DWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C304C4CEE5
	for <mptcp@lists.linux.dev>; Thu, 24 Oct 2024 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729790544;
	bh=V8n8b9v7j8eMIL3dxev21l3R4jUTH1XgYC16xv4+Tio=;
	h=Date:From:Subject:To:From;
	b=JwKi4DWeVPBPDxOsUjEjRZp+sz2HI3372Io7KujqP8c9jcIwRkJnw9nlizLeNgNmz
	 8VKXZ5ZctNXBzuvcDMFR4kDF4XPSW08g12BLj3Hx7ZBa0AKs4px1dBjRB9XJszA+7Z
	 Oc2M24Bjzm/q9QqvFAd9K1mvz5bjWISnLbh2w70J2qzeSfnwIQNAuGBI1eO/uPwDBX
	 vgS0/TFeZZpnDXj2Y/IgJ5pSBGKi+h/w2tBzQ8T7mVUSyOp4o0hsUYPF5NsHb1RjuE
	 6abCsLyEHp6EQP1Gs8xiALaXl5rU4tLybnHGSW1LYw2rLrmWbMY3ZffoabaGEBMByH
	 56MVcx+JWYhJg==
Message-ID: <00a07d91-4187-4eb1-a65c-4d8d428f0219@kernel.org>
Date: Thu, 24 Oct 2024 19:22:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 23rd of October 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Linux <mptcp@lists.linux.dev>
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


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13826239: [net,1/4] mptcp: handle consistently DSS corruption
13826240: [net,2/4] tcp: fix mptcp DSS corruption due to large pmtu xmit
13826241: [net,3/4] mptcp: fallback when MPTCP opts are dropped after
1st data
13826242: [net,4/4] mptcp: pm: do not remove closing subflows:
    - Series: mptcp: misc. fixes involving fallback to TCP
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=896666&state=*&archive=both

13835092: [net,v2,1/2] mptcp: prevent MPC handshake on port-based signal
endpoints
13835093: [net,v2,2/2] selftests: mptcp: join: test for prohibited MPC
to port-based endp:
    - Series: mptcp: prevent MPC handshake on port-based signal endpoints
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=898914&state=*&archive=both

13835861: [net] mptcp: pm: fix UaF read in mptcp_pm_nl_rm_addr_or_subflow:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241015-net-mptcp-uaf-pm-rm-v1-1-c4ee5d987a64@kernel.org/

13840124: [6.11.y] tcp: fix mptcp DSS corruption due to large pmtu xmit:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241017143218.1428691-2-matttbe@kernel.org/

13841563: [6.11.y] mptcp: prevent MPC handshake on port-based signal
endpoints:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241018103356.2167155-2-matttbe@kernel.org/

13841997: [6.6.y,1/4] tcp: fix mptcp DSS corruption due to large pmtu xmit
13841998: [6.6.y,2/4] selftests: mptcp: join: change capture/checksum as
bool
13841999: [6.6.y,3/4] selftests: mptcp: join: test for prohibited MPC to
port-based endp
13842000: [6.6.y,4/4] selftests: mptcp: remove duplicated variables:
    - Series: mptcp: fix recent failed backports
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=900797&state=*&archive=both

13842096: [6.1.y,1/2] tcp: fix mptcp DSS corruption due to large pmtu xmit
13842097: [6.1.y,2/2] mptcp: prevent MPC handshake on port-based signal
endpoints:
    - Series: mptcp: fix recent failed backports
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=900840&state=*&archive=both

13842643: [5.15.y,1/6] mptcp: track and update contiguous data status
13842644: [5.15.y,2/6] mptcp: handle consistently DSS corruption
13842645: [5.15.y,3/6] tcp: fix mptcp DSS corruption due to large pmtu xmit
13842647: [5.15.y,5/6] mptcp: pm: fix UaF read in
mptcp_pm_nl_rm_addr_or_subflow
13842648: [5.15.y,6/6] mptcp: prevent MPC handshake on port-based signal
endpoints:
    - Series: mptcp: fix recent failed backports
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=900986&state=*&archive=both

13842663: [5.10.y,1/3] mptcp: track and update contiguous data status
13842664: [5.10.y,2/3] mptcp: handle consistently DSS corruption
13842665: [5.10.y,3/3] tcp: fix mptcp DSS corruption due to large pmtu xmit:
    - Series: mptcp: fix recent failed backports
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=900990&state=*&archive=both

13839735: [net-next,v2] tools: ynl-gen: use big-endian netlink attribute
types:
    - Submitter: Asbjørn Sloth Tønnesen
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241017094704.3222173-1-ast@fiberby.net/


    our repo (by: Davide Caratti, Geliang Tang, Matthieu Baerts):

13826745: [mptcp-next] mptcp: use "middlebox interference" for MP_TCPRST
in case map_valid is false:
    - Submitter: Davide Caratti
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/4b2cee91613e597a172b46bb0d9d3143053c52da.1728408247.git.dcaratti@redhat.com/

13838779: [mptcp-net,1/2] mptcp: init: protect sched with rcu_read_lock
13838780: [mptcp-net,2/2] Squash to "bpf: Add bpf_mptcp_sched_ops":
    - Series: mptcp: "fix suspicious RCU usage" warnings
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=899900&state=*&archive=both

13839796: [mptcp-net,1/2] mptcp: remove unneeded lock when listing scheds
13839797: [mptcp-net,2/2] selftests: mptcp: list sysctl data:
    - Series: mptcp: remove unneeded lock when listing scheds
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=900176&state=*&archive=both

13842002: [mptcp-next,v12,1/8] bpf: Register mptcp common kfunc set
13842004: [mptcp-next,v12,3/8] bpf: Acquire and release mptcp socket
13842005: [mptcp-next,v12,4/8] selftests/bpf: More endpoints for
endpoint_init
13842006: [mptcp-next,v12,5/8] selftests/bpf: Add mptcp_subflow bpf_iter
subtest
13842007: [mptcp-next,v12,6/8] Squash to "selftests/bpf: Add bpf
scheduler test"
13842008: [mptcp-next,v12,7/8] Revert "bpf: Export more bpf_burst
related functions"
13842009: [mptcp-next,v12,8/8] Squash to "bpf: Add
bpf_mptcp_sched_kfunc_set":
    - Series: add mptcp_subflow bpf_iter
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=900798&state=*&archive=both

13845971: [mptcp-net] mptcp: no admin perm to list endpoints:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241022-mptcp-pm-dump-addr-admin-v1-1-9ad328d01817@kernel.org/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Asbjørn Sloth Tønnesen, Matthieu
Baerts, Yunsheng Lin):

13841633: [net-next,v22,12/14] net: replace page_frag with page_frag_cache:
    - This series will probably be split, no hurry

13843828: [net,1/3] mptcp: init: protect sched with rcu_read_lock
13843829: [net,2/3] mptcp: remove unneeded lock when listing scheds
13843830: [net,3/3] selftests: mptcp: list sysctl data:
    - Series: mptcp: sched: fix some lock issues
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=901302&state=*&archive=both
    - Sent recently

13844310: [net-next,1/4] mptcp: pm: send ACK on non-stale subflows
13844311: [net-next,2/4] mptcp: annotate data-races around
subflow->fully_established
13844312: [net-next,3/4] mptcp: implement mptcp_pm_connection_closed
13844313: [net-next,4/4] mptcp: use "middlebox interference" RST when no
DSS:
    - Series: mptcp: various small improvements
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=901451&state=*&archive=both
    - Sent recently


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

13829435: [mptcp-next,v3,1/1] selftests/bpf: Use make/remove netns
helpers in mptcp:
    - State: Changes requested
    - Series: add netns helpers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=897427&state=*&archive=both
    - reviewed, can be sent directly

13845248: [mptcp-next,v2,1/5] selftests/bpf: Add mptcp pm_nl_ctl link
13845249: [mptcp-next,v2,2/5] selftests/bpf: Use pm_nl_ctl if ip mptcp
not supported
13845250: [mptcp-next,v2,3/5] bpf: Add mptcp_address bpf_iter
13845251: [mptcp-next,v2,4/5] bpf: Export more helpers used by
mptcp_address test
13845252: [mptcp-next,v2,5/5] selftests/bpf: Add mptcp_address bpf_iter
subtest:
    - State: New
    - Series: add mptcp_address bpf_iter
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=901713&state=*&archive=both

13845374: [mptcp-next,v2,01/36] mptcp: drop else in
mptcp_pm_addr_families_match
13845375: [mptcp-next,v2,02/36] mptcp: use __lookup_addr in pm_netlink
13845376: [mptcp-next,v2,03/36] mptcp: add mptcp_for_each_address macros
13845377: [mptcp-next,v2,04/36] mptcp: use sock_kfree_s instead of kfree
13845378: [mptcp-next,v2,05/36] mptcp: add lookup_addr for userspace pm
13845379: [mptcp-next,v2,06/36] mptcp: add mptcp_userspace_pm_get_sock
helper
13845380: [mptcp-next,v2,07/36] mptcp: make three pm wrappers static
13845381: [mptcp-next,v2,08/36] mptcp: drop skb parameter of get_addr
13845382: [mptcp-next,v2,09/36] mptcp: add id parameter for get_addr
13845383: [mptcp-next,v2,10/36] mptcp: add addr parameter for get_addr
13845384: [mptcp-next,v2,11/36] mptcp: reuse sending nlmsg code in get_addr
13845385: [mptcp-next,v2,12/36] mptcp: change info of get_addr as const
13845386: [mptcp-next,v2,13/36] mptcp: add struct mptcp_id_bitmap
13845387: [mptcp-next,v2,14/36] mptcp: refactor dump_addr with id bitmap
13845388: [mptcp-next,v2,15/36] mptcp: refactor dump_addr with get_addr
13845389: [mptcp-next,v2,16/36] mptcp: reuse sending nlmsg code in dump_addr
13845390: [mptcp-next,v2,17/36] mptcp: update local address flags when
setting it
13845391: [mptcp-next,v2,18/36] mptcp: change rem type of set_flags
13845392: [mptcp-next,v2,19/36] mptcp: drop skb parameter of set_flags
13845393: [mptcp-next,v2,20/36] mptcp: add loc and rem for set_flags
13845394: [mptcp-next,v2,21/36] mptcp: update address type of get_local_id
13845395: [mptcp-next,v2,22/36] mptcp: change is_backup interfaces as
get_flags
13845396: [mptcp-next,v2,23/36] mptcp: drop struct mptcp_pm_local
13845397: [mptcp-next,v2,24/36] mptcp: drop struct mptcp_pm_add_entry
13845398: [mptcp-next,v2,25/36] mptcp: change local type of subflow_destroy
13845399: [mptcp-next,v2,26/36] mptcp: hold pm lock when deleting entry
13845400: [mptcp-next,v2,27/36] mptcp: rename mptcp_pm_remove_addrs
13845401: [mptcp-next,v2,28/36] mptcp: drop free_list for deleting entries
13845402: [mptcp-next,v2,29/36] mptcp: define struct mptcp_pm_ops
13845403: [mptcp-next,v2,30/36] mptcp: implement userspace pm interfaces
13845404: [mptcp-next,v2,31/36] mptcp: register default userspace pm
13845405: [mptcp-next,v2,32/36] bpf: Add mptcp path manager struct_ops
13845406: [mptcp-next,v2,33/36] bpf: Register mptcp struct_ops kfunc set
13845407: [mptcp-next,v2,34/36] Squash to "bpf: Export mptcp packet
scheduler helpers"
13845408: [mptcp-next,v2,35/36] selftests/bpf: Add mptcp userspace pm
subtest
13845409: [mptcp-next,v2,36/36] selftests/bpf: Add mptcp bpf path
manager subtest:
    - State: Under review
    - Series: BPF path manager
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=901761&state=*&archive=both

13846161: [mptcp-net] mptcp: pm: use _rcu variant under rcu_read_lock:
    - State: New
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20241022-mptcp-pm-lookup_addr_rcu-v1-1-19d45f26c872@kernel.org/
    - even if we modify an entry, we don't modify the list itself
    - we should then use rcu_read_lock() instead of taking the spinlock,
and probably use READ_ONCE/WRITE_ONCE on the flag (if thread safe)
    - TODO: Matth

13846824: [mptcp-next,v8,01/13] mptcp: check sk_stream_memory_free in loop
13846825: [mptcp-next,v8,02/13] mptcp: make mptcp_subflow_set_scheduled
inline
13846826: [mptcp-next,v8,03/13] mptcp: add mptcp_validate_scheduler helper
13846827: [mptcp-next,v8,04/13] Squash to "bpf: Add bpf_mptcp_sched_ops"
13846828: [mptcp-next,v8,05/13] Squash to "selftests/bpf: Add bpf
scheduler test"
13846829: [mptcp-next,v8,06/13] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13846830: [mptcp-next,v8,07/13] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13846831: [mptcp-next,v8,08/13] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13846832: [mptcp-next,v8,09/13] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13846833: [mptcp-next,v8,10/13] Squash to "selftests/bpf: Add bpf_burst
scheduler & test"
13846834: [mptcp-next,v8,11/13] Squash to "bpf: Export mptcp packet
scheduler helpers"
13846835: [mptcp-next,v8,12/13] Revert "mptcp: add sched_data helpers"
13846836: [mptcp-next,v8,13/13] mptcp: drop subflow contexts in
mptcp_sched_data:
    - State: New
    - Series: use bpf_iter in bpf schedulers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=902168&state=*&archive=both
    - it is likely possible we will have to iterate more in the BPF case



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 520):


  526  Question: MPTCP subflows are reconnected every now and then
[question]:
      - Old kernel, maybe a bug that has been fixed
      - Subflows are removed during the connection on the client side:
should be due to a modification of the MPTCP endpoints. No other causes?

  525  tests: cover more MPTCP socket options [enhancement]
[packetdrill] [selftests]:
      - To improve: https://ci-results.mptcp.dev/lcov/export/index.html

  524  tests: cover more Diag-related code [selftests]:
      - To improve: https://ci-results.mptcp.dev/lcov/export/index.html

  521  Implement psock_update_sk_prot, for eBPF SOCKMAP support
[enhancement]:
      - Would be interesting to have to get good performances when using
a proxy in BPF with sockmap.


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

  526  Question: MPTCP subflows are reconnected every now and then
[question]
  520  Question about proper MPTCP configuration over VPN. [question]
  502  Question for ip-mptcp command [question]
  489  IPv6 Rejoin Subflow [question]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

  525  tests: cover more MPTCP socket options [enhancement]
[packetdrill] [selftests]
  524  tests: cover more Diag-related code [selftests]
  521  Implement psock_update_sk_prot, for eBPF SOCKMAP support
[enhancement]
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


    Recently closed (since 2024-10-09)

  523  Suspicious RCU usage in `mptcp_sched_find` [bug] @matttbe
  522  Test and Add MPTCP Schedulers [question]


    Packetdrill PRs

  52  3 years ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs: /

    mptcpd PRs

  307  1 day ago    matttbe  scripts: debug: also print system info
  306  14 days ago  matttbe  lib: switch to v4.0.1: only added items
  305  14 days ago  matttbe  Some clean-ups
  304  5 days ago   matttbe  Support listener events:
      - Matth: TODO: check to update the Debian version with just the
patch to be compatible with newer ELL versions
      - Matth: TODO: modify the CI to run daily the test checking it
still compiles with the last version of ELL (+ tests?) → Done


FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.13):
https://github.com/orgs/multipath-tcp/projects/11
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /

    - Fixes for -net:

        - [b8b8f6796065] mptcp: init: protect sched with rcu_read_lock
(Matthieu Baerts (NGI0))
        - [b4844683facd] mptcp: remove unneeded lock when listing scheds
(Matthieu Baerts (NGI0))
        - [598a075d877b] selftests: mptcp: list sysctl data (Matthieu
Baerts (NGI0)):
            - sent, not applied yet

        - [023ee64ef5a3] mptcp: no admin perm to list endpoints
(Matthieu Baerts (NGI0)):
            - TODO: send at some points → will check on Monday

    - Fixes for net-next: /

    - Features for net-next:

        - [f6d8fc67d62a] mptcp: pm: send ACK on non stale subflows
(Matthieu Baerts (NGI0))
        - [d855df01337a] mptcp: annotate data-races around
subflow->fully_established (Gang Yan)
        - [8c3ca3bdf38b] mptcp: implement mptcp_pm_connection_closed
(Geliang Tang)
        - [408519e69724] mptcp: use "middlebox interference" RST when no
DSS (Davide Caratti):
            - sent, not applied yet

    - Features for net-next (next): /

    - Features for other trees:

        - [6add433f2563] bpf: Register mptcp common kfunc set (Geliang Tang)
        - [b2248cf6bbe1] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [457ab85b18d1] bpf: Acquire and release mptcp socket (Geliang
Tang)
        - [7b374224a3a8] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [bf51ed0274b3] selftests/bpf: Add mptcp_subflow bpf_iter
subtest (Geliang Tang):
            - probably best to wait: checking if it fits well with the
BPF packet scheduler and PM
            - but we can certainly send that this cycle, maybe in 1 or 2
weeks?

        - [20e533bfcbc4] mptcp: add sched_data helpers (Geliang Tang)
        - [559d78357044] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [98b44e897166] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [2c1edd35d248] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [7f8ec946b5fb] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [42bbafeb98be] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [c8a885cf978a] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [485d37231de9] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [083a2dc08499] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)



Extra tests:
    - news about Syzkaller? (Christoph):
        -

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - There is a new mode: validating the MPTCP BPF tests with a
debug kernel:
            - but it is flaky
            - there is a real known issue to fix there
            - TODO: Matth: find a solution → mark as flaky? fix the issue?



Next meeting:
    - Next one on Wednesday, *in two weeks*, the 6th of November.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20241106



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

