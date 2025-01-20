Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF9C2FB
	for <mptcp@lists.linux.dev>; Mon, 20 Jan 2025 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395644; cv=none; b=m0Ikp4lYlfs7lsMzet6jPCoIgi6UqznjRf0QCW3Fsp0htkRIS5XGHVtKFMET7a5C05pCsABK2kSuBWxw4MfSpvSLLvA5AyW0rApGdmJDEe0ln+VEk657bttHOHaiIN8WaYGsFZHjFIttfk5zfyjzs+LBHVmOojRN1Q7f7jj+Xoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395644; c=relaxed/simple;
	bh=2Y4DLNsG6yGXhb5scCKlM9td3uILC6MKBhlMPpQKSDw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=aINjuZKyd/IGxQgU94aNYs3DVaVUKcI0FoWxnzV8pNdlMKwjBhaoc+UYeIvMfGoh500qPM7Xe4iR50Hx2Zjs7bp2EXpa/recsMSbFdDNRfaI/g+py557vcaV3aLbQ75AzZNIcL6Uvo9LgoJEVQ2gwrIFpK7b9EVatvAV9be7ito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDQfTwCb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDQfTwCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D9EC4CEDD
	for <mptcp@lists.linux.dev>; Mon, 20 Jan 2025 17:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737395644;
	bh=2Y4DLNsG6yGXhb5scCKlM9td3uILC6MKBhlMPpQKSDw=;
	h=Date:From:Subject:To:From;
	b=sDQfTwCbQVLu2aKWm7I+COu4pWbvkOxgn08a23ft93XlLvrooHUPpW2UEonNfQoDo
	 dCu85or/KjniOLgUYmW10Y1pCQC87G8lDKuActB17PlXwuN99ExKC6Yab4AdiagupG
	 Wgpo0PkmIbKlLIaFUstVUfj3tSwMxhuf1IzD45jYufAzrhec8uO7NUvIuW3g3/TsgB
	 DQaum8Qsn7O4ZzL6oCgKiYP9MGZWqPvpmfvlY0Qe5kiowWtng/5UnTt14gh1TYehZc
	 tlZDQofVwYjk3qAWBXrGDqrArCm2kUXZ1qW3ZlkmS6Tzv77N/GATOc943EjrotB6JT
	 uO7BpxxOypHow==
Message-ID: <d3b5c040-d677-42ed-984a-d9d4e5daceae@kernel.org>
Date: Mon, 20 Jan 2025 18:54:01 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 15th of January 2025
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our new meeting with Mat (Cruise), and myself (NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    netdev (if mptcp ML is in cc) (by: Matthieu Baerts):

13917791: [net,v2,1/3] netlink: specs: mptcp: add missing 'server-side' attr
13917792: [net,v2,2/3] netlink: specs: mptcp: clearly mention attributes
13917793: [net,v2,3/3] netlink: specs: mptcp: fix missing doc:
    - Series: netlink: specs: mptcp: fixes for some descriptions
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=920130&state=*&archive=both

13923406: [net,1/3] mptcp: fix recvbuffer adjust on sleeping rcvmsg
13923407: [net,2/3] mptcp: don't always assume copied data in
mptcp_cleanup_rbuf()
13923408: [net,3/3] mptcp: prevent excessive coalescing on receive:
    - Series: mptcp: rx path fixes
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=921453&state=*&archive=both

13931162: [net,1/9] mptcp: sysctl: avail sched: remove write access
13931163: [net,2/9] mptcp: sysctl: sched: avoid using current->nsproxy
13931164: [net,3/9] mptcp: sysctl: blackhole timeout: avoid using
current->nsproxy
13931165: [net,4/9] sctp: sysctl: cookie_hmac_alg: avoid using
current->nsproxy
13931166: [net,5/9] sctp: sysctl: rto_min/max: avoid using current->nsproxy
13931167: [net,6/9] sctp: sysctl: auth_enable: avoid using current->nsproxy
13931168: [net,7/9] sctp: sysctl: udp_port: avoid using current->nsproxy
13931169: [net,8/9] sctp: sysctl: plpmtud_probe_interval: avoid using
current->nsproxy
13931170: [net,9/9] rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using
current->nsproxy:
    - Series: net: sysctl: avoid using current->nsproxy
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=923435&state=*&archive=both

13937691: [net,1/3] mptcp: be sure to send ack when mptcp-level window
re-opens
13937692: [net,2/3] mptcp: fix spurious wake-up on under memory pressure
13937693: [net,3/3] selftests: mptcp: avoid spurious errors on disconnect:
    - Series: mptcp: fixes for connect selftest flakes
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=924940&state=*&archive=both

13936626: [net-next,v2,1/2] net: remove init_dummy_netdev():
    - Reviewed


    our repo (by: Geliang Tang, Matthieu Baerts, Paolo Abeni):

13897106: [mptcp-next,v2,1/7] mptcp: prevent excessive coalescing on receive
13897107: [mptcp-next,v2,2/7] tcp: fix recvbuffer adjust on sleeping rcvmsg
13897108: [mptcp-next,v2,3/7] mptcp: don't always assume copied data in
mptcp_cleanup_rbuf()
13897109: [mptcp-next,v2,4/7] mptcp: consolidate subflow cleanup
13897110: [mptcp-next,v2,5/7] mptcp: move the whole rx path under msk
socket lock protection
13897111: [mptcp-next,v2,6/7] mptcp: cleanup mem accounting.
13897112: [mptcp-next,v2,7/7] net: dismiss sk_forward_alloc_get():
    - Series: mptcp: rx path refactor
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=915337&state=*&archive=both

13905650: [mptcp-next,1/2] mptcp: dismiss __mptcp_rmem()
13905651: [mptcp-next,2/2] mptcp: micro-optimize __mptcp_move_skb():
    - Series: mptcp: rx refactor follow-ups
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=917303&state=*&archive=both

13909518: [mptcp-net,v2,1/3] netlink: specs: mptcp: add missing
'server-side' attr
13909519: [mptcp-net,v2,2/3] netlink: specs: mptcp: clearly mention
attributes
13909520: [mptcp-net,v2,3/3] netlink: specs: mptcp: fix missing doc:
    - Series: netlink: specs: mptcp: events: missing and clearer attr
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=918161&state=*&archive=both

13917711: [net] mptcp: fix TCP options overflow.:
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/025d9df8cde3c9a557befc47e9bc08fbbe3476e5.1734771049.git.pabeni@redhat.com/

13921186: [mptcp-net] mptcp: fix for setting remote ipv4mapped address:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/35436a387650236cce065f198b89bb5afb23f708.1735205514.git.tanggeliang@kylinos.cn/

13929422: [mptcp-net,1/9] mptcp: sysctl: avail sched: remove write access
13929423: [mptcp-net,2/9] mptcp: sysctl: sched: avoid using current->nsproxy
13929424: [mptcp-net,3/9] mptcp: sysctl: blackhole timeout: avoid using
current->nsproxy
13929425: [mptcp-net,4/9] sctp: sysctl: cookie_hmac_alg: avoid using
current->nsproxy
13929426: [mptcp-net,5/9] sctp: sysctl: rto_min/max: avoid using
current->nsproxy
13929427: [mptcp-net,6/9] sctp: sysctl: auth_enable: avoid using
current->nsproxy
13929428: [mptcp-net,7/9] sctp: sysctl: udp_port: avoid using
current->nsproxy
13929429: [mptcp-net,8/9] sctp: sysctl: plpmtud_probe_interval: avoid
using current->nsproxy
13929430: [mptcp-net,9/9] rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using
current->nsproxy:
    - Series: net: sysctl: avoid using current->nsproxy
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=923074&state=*&archive=both

13931486: [mptcp-next,1/5] selftests: mptcp: simult_flows: unify errors msgs
13931487: [mptcp-next,2/5] selftests: mptcp: move stats info in case of
errors to lib.sh
13931488: [mptcp-next,3/5] selftests: mptcp: add -m with ss in case of
errors
13931489: [mptcp-next,4/5] selftests: mptcp: connect: remove unused variable
13931490: [mptcp-next,5/5] selftests: mptcp: connect: better display the
files size:
    - Series: selftests: mptcp: more info in case of errors
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=923491&state=*&archive=both

13933548: [mptcp-next] selftests: mptcp: sockopt: save nstat infos:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/5ff48cd1eed9a8b4c51a9ba5d7f9e0d0e8b0389b.1736477880.git.tanggeliang@kylinos.cn/

13933877: [mptcp-next,v9,1/8] mptcp: drop info of
userspace_pm_remove_id_zero_address
13933878: [mptcp-next,v9,2/8] mptcp: pm: userspace: flags: clearer msg
if no remote addr
13933879: [mptcp-next,v9,3/8] mptcp: pm: more precise error messages
13933880: [mptcp-next,v9,4/8] mptcp: pm: improve error messages
13933881: [mptcp-next,v9,5/8] mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK
13933882: [mptcp-next,v9,6/8] mptcp: pm: remove duplicated error messages
13933883: [mptcp-next,v9,7/8] mptcp: pm: mark missing address attributes
13933884: [mptcp-next,v9,8/8] mptcp: pm: use NL_SET_ERR_MSG_ATTR when
possible:
    - Series: use GENL_REQ_ATTR_CHECK in userspace pm
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=924037&state=*&archive=both

13933894: [mptcp-next,v4,1/7] mptcp: make three pm wrappers static
13933896: [mptcp-next,v4,2/7] mptcp: drop skb parameter of get_addr
13933897: [mptcp-next,v4,3/7] mptcp: add id parameter for get_addr
13933898: [mptcp-next,v4,4/7] mptcp: reuse sending nlmsg code in get_addr
13933899: [mptcp-next,v4,5/7] mptcp: drop skb parameter of set_flags
13933900: [mptcp-next,v4,6/7] mptcp: change rem type of set_flags
13933901: [mptcp-next,v4,7/7] mptcp: add local parameter for set_flags:
    - Series: BPF path manager, part 2
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=924040&state=*&archive=both

13935148: [mptcp-net,1/3] mptcp: be sure to send ack when mptcp-level
window re-opens
13935146: [mptcp-net,2/3] mptcp: fix spurious wake-up on under memory
pressure.
13935147: [mptcp-net,3/3] selftests: mptcp: avoid spurious errors on
disconnect:
    - Series: mptcp: a bunch of fixes for ST flakes
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=924334&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts, Yunsheng Lin):

13897129: [net-next,v2,09/10] net: replace page_frag with page_frag_cache
13915179: [bpf-next/net,v2,1/7] bpf: Extend bpf_skc_to_mptcp_sock to
MPTCP sock
13915180: [bpf-next/net,v2,2/7] bpf: Allow use of skc_to_mptcp_sock in
cg_sockopt
13915181: [bpf-next/net,v2,3/7] bpf: Register mptcp common kfunc set
13915182: [bpf-next/net,v2,4/7] bpf: Add mptcp_subflow bpf_iter
13915183: [bpf-next/net,v2,5/7] bpf: Acquire and release mptcp socket
13915184: [bpf-next/net,v2,6/7] selftests/bpf: More endpoints for
endpoint_init
13915185: [bpf-next/net,v2,7/7] selftests/bpf: Add mptcp_subflow
bpf_iter subtest:
    - Series: bpf: Add mptcp_subflow bpf_iter support
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=919529&state=*&archive=both

13939236: [net-next,1/6] selftests: mptcp: simult_flows: unify errors msgs
13939237: [net-next,2/6] selftests: mptcp: sockopt: save nstat infos
13939238: [net-next,3/6] selftests: mptcp: move stats info in case of
errors to lib.sh
13939239: [net-next,4/6] selftests: mptcp: add -m with ss in case of errors
13939240: [net-next,5/6] selftests: mptcp: connect: remove unused variable
13939241: [net-next,6/6] selftests: mptcp: connect: better display the
files size:
    - Series: mptcp: selftests: more debug in case of errors
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=925368&state=*&archive=both

13939308: [net-next] mptcp: fix for setting remote ipv4mapped address:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250114-net-next-mptcp-fix-remote-addr-v1-1-debcd84ea86f@kernel.org/


    our repo (by: Cong Liu, Gang Yan, Geliang Tang, Gregory Detal, Jakub
Kicinski, Matthieu Baerts):

12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
    - State: Changes requested
    - Series: BPF redundant scheduler, part 3
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
    - Status: same

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
    - Status: same

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
    - Status: same

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
    - Status: same

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
    - Status: same

13909382: [mptcp-next,v3] mptcp: use GENL_REQ_ATTR_CHECK for token:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/d9c76c6c008c770046f665a4a4e93735fd121399.1734337790.git.tanggeliang@kylinos.cn/
    - Status: same

13918597: [mptcp-next,v2,1/9] mptcp: split get_subflow interface into two
13918598: [mptcp-next,v2,2/9] Squash to "bpf: Add bpf_mptcp_sched_ops"
13918599: [mptcp-next,v2,3/9] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13918600: [mptcp-next,v2,4/9] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13918601: [mptcp-next,v2,5/9] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13918602: [mptcp-next,v2,6/9] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13918603: [mptcp-next,v2,7/9] Squash to "selftests/bpf: Add bpf_burst
scheduler & test"
13918604: [mptcp-next,v2,8/9] Squash to "bpf: Export mptcp packet
scheduler helpers"
13918605: [mptcp-next,v2,9/9] Squash to "selftests/bpf: Add bpf_burst
scheduler & test":
    - State: New
    - Series: split get_subflow interface into two
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=920351&state=*&archive=both
    - Status: same

13918732: [mptcp-next,v12,01/10] bpf: Add bpf_mptcp_send_info_to_ssk
13918733: [mptcp-next,v12,02/10] Revert "mptcp: add sched_data helpers"
13918734: [mptcp-next,v12,03/10] mptcp: drop struct mptcp_sched_data
13918735: [mptcp-next,v12,04/10] Squash to "bpf: Add bpf_mptcp_sched_ops"
13918736: [mptcp-next,v12,05/10] Squash to "bpf: Export mptcp packet
scheduler helpers"
13918737: [mptcp-next,v12,06/10] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13918738: [mptcp-next,v12,07/10] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13918739: [mptcp-next,v12,08/10] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13918740: [mptcp-next,v12,09/10] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13918741: [mptcp-next,v12,10/10] Squash to "selftests/bpf: Add bpf_burst
scheduler & test":
    - State: New
    - Series: use bpf_iter in bpf schedulers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=920379&state=*&archive=both
    - Status: same

13930286: [mptcp-next,v4,1/5] selftests/bpf: Add mptcp pm_nl_ctl link
13930287: [mptcp-next,v4,2/5] selftests/bpf: Use pm_nl_ctl if ip mptcp
not supported
13930288: [mptcp-next,v4,3/5] bpf: Add mptcp_userspace_pm_addr bpf_iter
13930289: [mptcp-next,v4,4/5] bpf: Export more helpers for
mptcp_userspace_pm_addr test
13930290: [mptcp-next,v4,5/5] selftests/bpf: Add mptcp_userspace_pm_addr
bpf_iter subtest:
    - State: New
    - Series: add mptcp_address bpf_iter
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=923265&state=*&archive=both
    - Status: same

13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX validation
13932546: [3/3] selftests: mptcp: add a testcase for invalid addr timeout:
    - State: Changes requested
    - Series: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both
    - some modifications to be done

13933549: [mptcp-next] Squash to "selftests: mptcp: move stats info in
case of errors to lib.sh":
    - State: Rejected
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/ff9a10bb4359ec77fc0b7499f44b388d737abe0f.1736477907.git.tanggeliang@kylinos.cn/
    - not needed

13936935: [1/3] selftests: mptcp: Fix incorrect file descriptor check in
main_loop
13936934: [2/3] selftests: mptcp: Fix input fd lifecycle in reconnection
loop
13936936: [3/3] selftests: mptcp: Clean up resources properly in main_loop:
    - State: Changes requested
    - Series: selftests: mptcp: Fix various issues in main_loop
    - Submitter: Cong Liu
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=924794&state=*&archive=both
    - some modifications to be done

13939024: [mptcp-next,1/3] doc: mptcp: sysctl: blackhole_timeout is
per-netns
13939025: [mptcp-next,2/3] mptcp: sysctl: add
syn_retrans_before_tcp_fallback
13939026: [mptcp-next,3/3] mptcp: blackhole only if 1st SYN retrans w/o
MPC is accepted:
    - State: New
    - Series: mptcp: blackhole: sysctl SYN retrans + fix conditions
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=925349&state=*&archive=both
    - might be good to send the 2nd patch this week, new sysctl, should
be fine → done

13939983: [mptcp-next] selftests/bpf: Drop cgroup_fd of run_mptcpify:
    - State: New
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/38e34a835050f35b7f14f7938b20f86a97ac0836.1736926065.git.tanggeliang@kylinos.cn/
    - can be applied, TODO Matth → Done

13940188: [mptcp-next,v3,1/6] mptcp: add mptcp_pm_genl_fill_addr helper
13940189: [mptcp-next,v3,2/6] mptcp: add struct mptcp_pm_addr_id_bitmap
13940190: [mptcp-next,v3,3/6] mptcp: drop inet6_sk in mptcp_nl_find_ssk
13940191: [mptcp-next,v3,4/6] mptcp: drop match in
userspace_pm_append_new_local_addr
13940192: [mptcp-next,v3,5/6] mptcp: hold msk lock before removing id 0
address
13940193: [mptcp-next,v3,6/6] mptcp: change is_backup interfaces as
get_flags:
    - State: New
    - Series: BPF path manager, part 3
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=925637&state=*&archive=both
    - Matth will look at it

13940200: [mptcp-next,v2,1/3] mptcp: define struct mptcp_pm_ops
13940201: [mptcp-next,v2,2/3] mptcp: register default userspace pm
13940202: [mptcp-next,v2,3/3] mptcp: init and release mptcp_pm_ops:
    - State: New
    - Series: BPF path manager, part 4
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=925640&state=*&archive=both



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 536):

  539  WARN in `__mptcp_fastopen_gen_msk_ackseq()`: sock owned by user
[bug]:
      - Linked to recent modifications: optimisations in the rx path

  537  [syzkaller] WARNING in `__mptcp_clean_una` (2) [bug] [syzkaller]
[reproducer] [bisected] @pabeni:
      - hard/no longer able to reproduce?
      - Paolo will share more info later

TODO: Matth: create a ticket for each new syzbot report → Done


    Bugs (opened, flagged as "bug" and assigned)

  537  [syzkaller] WARNING in `__mptcp_clean_una` (2) [bug] [syzkaller]
[reproducer] [bisected] @pabeni
  529  BUG: sleeping function called from invalid context in BPF sched
selftests [bug] [selftests] [sched] [bpf] @geliangtang
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm] @geliangtang
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

  539  WARN in `__mptcp_fastopen_gen_msk_ackseq()`: sock owned by user [bug]
  508  Divide error on device removal [bug] [feedback-needed]
  505  Subflows won't be used when the interface for the main flow is a
subinterface [bug] [feedback-needed]
  501  Why do endpoint tcp connections close? [bug] [feedback-needed]
  499  selftests: `mptcp_connect.sh`: disconnect test timed out [bug]
[selftests]
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

  514  Add MIB counters for fallback to TCP [enhancement] @geliangtang
  480  MPTCP and KTLS support [enhancement] @geliangtang
  434  in-kernel PM: increase subflows limit [enhancement] [pm] @matttbe
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  530  about mptcp subflow creation question [question]
[feedback-needed] [triage]
  520  Question about proper MPTCP configuration over VPN. [question]
[feedback-needed]
  502  Question for ip-mptcp command [question]
  489  IPv6 Rejoin Subflow [question]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

  536  PM: new subflow: avoid selecting initial endpoint upon `ADD_ADDR`
reception if servers deny MPJ to initial address [enhancement] [pm]
  535  TCPDump: display `MP_CAPABLE` C flag [enhancement]
  532  Userspace PM doesn't have access to `allow_join_id0` /
`allow_join_initial_addr_port` bit from the SYN-ACK [enhancement]
  525  tests: cover more MPTCP socket options [enhancement]
[packetdrill] [selftests]
  521  Implement psock_update_sk_prot, for eBPF SOCKMAP support
[enhancement]
  519  Reset the connection once "MPTCP has been verified" instead of a
fallback [enhancement]
  515  Add `TCP_MAXSEG` socket option support [enhancement]
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
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill]
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


    Recently closed (since 20241218)

  538  [syzkaller] general protection fault in `put_page` (4) [bug]
[syzkaller] [reproducer]


    Packetdrill PRs

  159  22 hours ago  matttbe   mptcp: mpc: no blackhole if not 1st TCP
accepted:
      - linked to a new series:

https://lore.kernel.org/20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org

  52   3 years ago   dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs

/

    mptcpd PRs

  316  1 month ago  matttbe  mptcpize: set `GODEBUG=multipathtcp=1` env var
  315  1 month ago  matttbe  mptcpize: do not override existing
LD_PRELOAD value
  314  1 month ago  matttbe  musl compat



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.14):
https://github.com/orgs/multipath-tcp/projects/12
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /


    - Fixes for -net: /


    - Fixes for net-next:

        - [7b0c2304fedc] mptcp: fix for setting remote ipv4mapped
address (Geliang Tang):
            - already sent, waiting to be applied

    - Features for net-next:

        - [e70022ed4d3f] mptcp: consolidate subflow cleanup (Paolo Abeni)
        - [4c0ce82b9494] mptcp: move the whole rx path under msk socket
lock protection (Paolo Abeni)
        - [5b9e6642e94a] mptcp: cleanup mem accounting (Paolo Abeni)
        - [b705d6cbb114] net: dismiss sk_forward_alloc_get() (Paolo Abeni)
        - [2cd7fda1d5c2] mptcp: dismiss __mptcp_rmem() (Paolo Abeni)
        - [9b3a9bbb6db1] mptcp: micro-optimize __mptcp_move_skb() (Paolo
Abeni):
            - There is an issue, see #539
            - Wait a bit

        - [99255b5e8c02] selftests: mptcp: simult_flows: unify errors
msgs (Matthieu Baerts (NGI0))
        - [360f17ac2125] selftests: mptcp: sockopt: save nstat infos
(Geliang Tang)
        - [bd910050c277] selftests: mptcp: move stats info in case of
errors to lib.sh (Matthieu Baerts (NGI0))
        - [bc470a34c17c] selftests: mptcp: add -m with ss in case of
errors (Matthieu Baerts (NGI0))
        - [755ceff1fc7a] selftests: mptcp: connect: remove unused
variable (Matthieu Baerts (NGI0))
        - [12f833f8c07f] selftests: mptcp: connect: better display the
files size (Matthieu Baerts (NGI0)):
            - already sent, waiting to be applied

        - [adb3a23766bd] mptcp: drop info of
userspace_pm_remove_id_zero_address (Geliang Tang)
        - [2b509e53613b] mptcp: pm: userspace: flags: clearer msg if no
remote addr (Matthieu Baerts (NGI0))
        - [f4c266e109a7] mptcp: pm: more precise error messages
(Matthieu Baerts (NGI0))
        - [a4d55b205b91] mptcp: pm: improve error messages (Matthieu
Baerts (NGI0))
        - [89c9a227231e] mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK
(Geliang Tang)
        - [90749ef4780e] mptcp: pm: remove duplicated error messages
(Matthieu Baerts (NGI0))
        - [de56c255395c] mptcp: pm: mark missing address attributes
(Matthieu Baerts (NGI0))
        - [b56e6c8a213f] mptcp: pm: use NL_SET_ERR_MSG_ATTR when
possible (Matthieu Baerts (NGI0))
        - [7d584023fa34] mptcp: make three pm wrappers static (Geliang Tang)
        - [63b93ec49631] mptcp: drop skb parameter of get_addr (Geliang
Tang)
        - [dbe21e990583] mptcp: add id parameter for get_addr (Geliang Tang)
        - [56d3ea8eee37] mptcp: reuse sending nlmsg code in get_addr
(Geliang Tang)
        - [7e0aa8feb4ba] mptcp: drop skb parameter of set_flags (Geliang
Tang)
        - [d9a4d755eaaa] mptcp: change rem type of set_flags (Geliang Tang)
        - [6e816ef94fc4] mptcp: add local parameter for set_flags
(Geliang Tang):
            - will be sent next, this week

    - Features for net-next (next): /

    - Features for other trees:

        - [95e4fbab5e30] bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock
(Geliang Tang)
        - [1271445ac1a5] bpf: Allow use of skc_to_mptcp_sock in
cg_sockopt (Geliang Tang)
        - [b5b54ef467bb] bpf: Register mptcp common kfunc set (Geliang Tang)
        - [29276daa1a2a] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [dc3fb05de27a] bpf: Acquire and release mptcp socket (Geliang
Tang)
        - [cc1061f7854a] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [03853f3ce760] selftests/bpf: Add mptcp_subflow bpf_iter
subtest (Geliang Tang):
            - sent ~one month ago, waiting for reviews
            - Matth sent a message

        - [9885cf356bbc] mptcp: add sched_data helpers (Geliang Tang)
        - [a6062e1ce23a] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [54c4267c4dc9] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [c383d3708560] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [e8db7814bcab] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [7901637e6d6b] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [c49f5dd45315] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [0f064417f9ec] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [b84aedec42e3] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - "mptcp_join: fastclose test" is now always failing, probably
linked to a patch modifying the selftests. Matth: investigate that



Patches for stable:
    - When to send "mptcp: prevent excessive coalescing on receive" to
stable?
    - Check at the next meeting



Next meeting:
    - Next one on Wednesday, the 29th of January.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20250129



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

