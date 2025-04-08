Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C80266EFC
	for <mptcp@lists.linux.dev>; Tue,  8 Apr 2025 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110937; cv=none; b=SnZrZ9CRv/pAI/mCqkR+x5e17U0o1wNw6tx9WNVzpYQKfSrvwI94VYU04dBbZq3MC5NSTMEnnp3grZP/Ew3Y4j0gnMhbD19lqAbsbz4PvxuOrsTyENIATdEVdXs0cspcqJhg52fe/AzRq5HmEvU3IsAvRT5e86UD1K76bfD2MOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110937; c=relaxed/simple;
	bh=W8FBQx0fGLQ41PK8ar5S5jDFeIhluhD0DUFds6lDrNM=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=NtbfKDM4o3DKla+HXaHsNCcb6gnL7dvmJlcWTaomKOS3/g4BOanJLe/dRAjPM3Jvhbxtv8KpewWztA6qK9IVJzTUq9cOgLS+0opf4h/8tc8YfvR/UJkJcZtXoY8SeI5tLsqFez+mDwQOwhbrh2EES1b+NuOlsH0fyKHyHZwyxYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqczMYe9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqczMYe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB15C4CEE7
	for <mptcp@lists.linux.dev>; Tue,  8 Apr 2025 11:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744110937;
	bh=W8FBQx0fGLQ41PK8ar5S5jDFeIhluhD0DUFds6lDrNM=;
	h=Date:From:To:Subject:From;
	b=kqczMYe9tme/6XnR8d5qigHP2r3gRwmtbftEaK6jwlbyO91DPqfAyOh3MOOAeQd+X
	 o+Gl2Le05rEcxq7OWKcBFRe8xuUtQSx7PQwzLpc0cUxLAOj12izNksDM85S6hFaGLP
	 Wjqc/NkbdB+ENPDTd2rQtru9V1N7yHL7BJvPr4/EHL9vs3dA/+1ohxS83gTwmsTOyb
	 RFDoO+Kwr9+E+r3lripoZAJPxBAI9owk2fT7aECwSMC9Bd0Wiv919qHIzWfXtEDP1x
	 8OhA4ILnI+9ZjnWT/RQooo/vaqzsHwV57MDcFuUEIai7fq5UzNVOiAdT4CKLZm+VcB
	 4nxxPmD4IbvAg==
Message-ID: <bdec920a-885b-4df1-beb6-8358312ec48e@kernel.org>
Date: Tue, 8 Apr 2025 13:15:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
To: MPTCP Linux <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 26th of March 2025
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everyone,

Two weeks ago, we had our new meeting with Mat (Cruise) and myself (NGI0
Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:


Accepted patches:

    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts,
Yue Haibing):

13996023: [net-next] mptcp: Remove unused declaration mptcp_set_owner_r():
    - Submitter: Yue Haibing
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250228095148.4003065-1-yuehaibing@huawei.com/

13996126: [net-next,v2,1/3] sock: add sock_kmemdup helper
13996127: [net-next,v2,2/3] net: use sock_kmemdup for ip_options
13996128: [net-next,v2,3/3] mptcp: use sock_kmemdup for address entry:
    - Series: add sock_kmemdup helper
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=938919&state=*&archive=both

13996530: [net-next,1/5] selftests: mptcp: Add a tool to get specific
msk_info
13996531: [net-next,2/5] selftests: mptcp: add a test for
mptcp_diag_dump_one
13996532: [net-next,3/5] mptcp: pm: in-kernel: avoid access entry
without lock
13996533: [net-next,4/5] mptcp: pm: in-kernel: reduce parameters of
set_flags
13996534: [net-next,5/5] mptcp: pm: exit early with ADD_ADDR echo if
possible:
    - Series: mptcp: improve code coverage and small optimisations
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=939014&state=*&archive=both

13999276: [net] mptcp: fix 'scheduling while atomic' in
mptcp_pm_nl_append_new_local_addr:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250303-net-mptcp-fix-sched-while-atomic-v1-1-f6a216c5a74c@kernel.org/

14004256: [net-next,1/2] tcp: ulp: diag: always print the name if any
14004257: [net-next,2/2] tcp: ulp: diag: more info without CAP_NET_ADMIN:
    - Series: tcp: ulp: diag: expose more to non net admin users
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=940975&state=*&archive=both

14006273: [net-next,01/15] mptcp: pm: use addr entry for get_local_id
14006274: [net-next,02/15] mptcp: pm: remove '_nl' from
mptcp_pm_nl_addr_send_ack
14006275: [net-next,03/15] mptcp: pm: remove '_nl' from
mptcp_pm_nl_mp_prio_send_ack
14006276: [net-next,04/15] mptcp: pm: remove '_nl' from mptcp_pm_nl_work
14006277: [net-next,05/15] mptcp: pm: remove '_nl' from
mptcp_pm_nl_rm_addr_received
14006278: [net-next,06/15] mptcp: pm: remove '_nl' from
mptcp_pm_nl_subflow_chk_stale()
14006279: [net-next,07/15] mptcp: pm: remove '_nl' from
mptcp_pm_nl_is_init_remote_addr
14006280: [net-next,08/15] mptcp: pm: kernel: add '_pm' to
mptcp_nl_set_flags
14006281: [net-next,09/15] mptcp: pm: avoid calling PM specific code
from core
14006282: [net-next,10/15] mptcp: pm: worker: split in-kernel and common
tasks
14006283: [net-next,11/15] mptcp: pm: export mptcp_remote_address
14006284: [net-next,12/15] mptcp: pm: move generic helper at the top
14006285: [net-next,13/15] mptcp: pm: move generic PM helpers to pm.c
14006286: [net-next,14/15] mptcp: pm: split in-kernel PM specific code
14006287: [net-next,15/15] mptcp: pm: move Netlink PM helpers to
pm_netlink.c:
    - Series: mptcp: pm: code reorganisation
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=941476&state=*&archive=both

14014655: [net-next,01/12] mptcp: pm: split netlink and in-kernel init
14014656: [net-next,02/12] mptcp: pm: in-kernel: use kmemdup helper
14014657: [net-next,03/12] mptcp: pm: use pm variable instead of msk->pm
14014658: [net-next,04/12] mptcp: pm: only fill id_avail_bitmap for
in-kernel pm
14014659: [net-next,05/12] mptcp: pm: add struct_group in mptcp_pm_data
14014660: [net-next,06/12] mptcp: pm: define struct mptcp_pm_ops
14014661: [net-next,07/12] mptcp: pm: register in-kernel and userspace PM
14014662: [net-next,08/12] mptcp: sysctl: set path manager by name
14014663: [net-next,09/12] mptcp: sysctl: map path_manager to pm_type
14014664: [net-next,10/12] mptcp: sysctl: map pm_type to path_manager
14014665: [net-next,11/12] mptcp: sysctl: add available_path_managers
14014666: [net-next,12/12] selftests: mptcp: add pm sysctl mapping tests:
    - Series: mptcp: pm: prep work for new ops and sysctl knobs
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=943469&state=*&archive=both

14016435: [net-next] selftests: drv-net: fix merge conflicts resolution:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250314-net-next-drv-net-ping-fix-merge-v1-1-0d5c19daf707@kernel.org/

13992062: [iproute2-net] ss: mptcp: subflow: display seq counters as
decimal:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250226-iproute2-net-ss-ulp-mptcp-dec-v1-1-4f4177cff217@kernel.org/

14002857: [net-next] tcp: clamp window like before the cleanup:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org/

14017381: [net,1/3] mptcp: Fix data stream corruption in the address
announcement
14017382: [net,2/3] mptcp: sockopt: fix getting IPV6_V6ONLY
14017383: [net,3/3] mptcp: sockopt: fix getting freebind & transparent:
    - Series: mptcp: fix data stream corruption and missing sockopts
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=944157&state=*&archive=both


    our repo (by: Arthur Mongodin, Gang Yan, Geliang Tang, Matthieu
Baerts, Thorsten Blum):

13977532: [mptcp-next,v15,1/8] Squash to "mptcp: add sched_data helpers"
13977533: [mptcp-next,v15,2/8] Squash to "bpf: Export mptcp packet
scheduler helpers"
13977534: [mptcp-next,v15,3/8] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13977535: [mptcp-next,v15,4/8] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13977536: [mptcp-next,v15,5/8] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13977537: [mptcp-next,v15,6/8] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13977538: [mptcp-next,v15,7/8] Squash to "selftests/bpf: Add bpf_burst
scheduler & test"
13987388: [mptcp-next,v4,1/5] Revert "bpf: Extend bpf_skc_to_mptcp_sock
to MPTCP sock"
13987389: [mptcp-next,v4,2/5] Revert "bpf: Allow use of
skc_to_mptcp_sock in cg_sockopt"
13987390: [mptcp-next,v4,3/5] Squash to "bpf: Add mptcp_subflow bpf_iter"
13987391: [mptcp-next,v4,4/5] Revert "bpf: Acquire and release mptcp socket"
13987392: [mptcp-next,v4,5/5] Squash to "selftests/bpf: Add
mptcp_subflow bpf_iter subtest":
    - Series: Squash to "Add mptcp_subflow bpf_iter support"
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=936873&state=*&archive=both

13992569: [mptcp-next,v2] mptcp: pm: exit early with ADD_ADDR echo if
possible:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250226-mptcp-userspace-avoid-worker-v2-1-4b144f314353@kernel.org/

13992904: [mptcp-next] Squash to "bpf: Add mptcp_subflow bpf_iter":
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250226180727.2499531-2-matttbe@kernel.org/

13996430: [mptcp-next,v2,01/14] mptcp: pm: remove '_nl' from
mptcp_pm_nl_addr_send_ack
13996431: [mptcp-next,v2,02/14] mptcp: pm: remove '_nl' from
mptcp_pm_nl_mp_prio_send_ack
13996432: [mptcp-next,v2,03/14] mptcp: pm: remove '_nl' from
mptcp_pm_nl_work
13996433: [mptcp-next,v2,04/14] mptcp: pm: remove '_nl' from
mptcp_pm_nl_rm_addr_received
13996434: [mptcp-next,v2,05/14] mptcp: pm: remove '_nl' from
mptcp_pm_nl_subflow_chk_stale()
13996435: [mptcp-next,v2,06/14] mptcp: pm: remove '_nl' from
mptcp_pm_nl_is_init_remote_addr
13996436: [mptcp-next,v2,07/14] mptcp: pm: kernel: add '_pm' to
mptcp_nl_set_flags
13996437: [mptcp-next,v2,08/14] mptcp: pm: avoid calling PM specific
code from core
13996438: [mptcp-next,v2,09/14] mptcp: pm: worker: split in-kernel and
common tasks
13996439: [mptcp-next,v2,10/14] mptcp: pm: export mptcp_remote_address
13996440: [mptcp-next,v2,11/14] mptcp: pm: move generic helper at the top
13996441: [mptcp-next,v2,12/14] mptcp: pm: move generic PM helpers to pm.c
13996442: [mptcp-next,v2,13/14] mptcp: pm: split in-kernel PM specific code
13996443: [mptcp-next,v2,14/14] mptcp: pm: move Netlink PM helpers to
pm_netlink.c:
    - Series: mptcp: pm: code reorganisation
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=938995&state=*&archive=both

13998925: [mptcp-next] mptcp: pm: split netlink and in-kernel init:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250303-mptcp-pm-split-init-nl-kernel-v1-1-533c1575b5c2@kernel.org/

14000077: [mptcp-next,v1,1/2] mptcp: pm: in-kernel: use kmemdup helper
14000078: [mptcp-next,v1,2/2] mptcp: pm: use pm variable instead of msk->pm:
    - Series: pm misc cleanups
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=939900&state=*&archive=both

14000524: [mptcp-net,1/2] mptcp: sockopt: fix getting IPV6_V6ONLY
14000525: [mptcp-net,2/2] mptcp: sockopt: fix getting freebind &
transparent:
    - Series: mptcp: sockopt: fix missing get options
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=940005&state=*&archive=both

14003152: [mptcp-next,v2,1/2] tcp: ulp: diag: always print the name if any
14003153: [mptcp-next,v2,2/2] tcp: ulp: diag: more info without
CAP_NET_ADMIN:
    - Series: tcp: ulp: diag: remove net admin restriction
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=940679&state=*&archive=both

14003753: [mptcp-next,v1,1/8] mptcp: add mptcp_validate_scheduler helper
14003754: [mptcp-next,v1,2/8] Squash to "bpf: Add bpf_mptcp_sched_ops"
14003755: [mptcp-next,v1,3/8] Squash to "selftests/bpf: Add bpf
scheduler test"
14003756: [mptcp-next,v1,4/8] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
14003757: [mptcp-next,v1,5/8] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
14003758: [mptcp-next,v1,6/8] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
14003759: [mptcp-next,v1,7/8] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
14003760: [mptcp-next,v1,8/8] Squash to "selftests/bpf: Add bpf_burst
scheduler & test":
    - Series: cleanups for bpf schedulers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=940810&state=*&archive=both

14011189: [mptcp-next,v2,1/2] mptcp: pm: only fill id_avail_bitmap for
in-kernel pm
14011190: [mptcp-next,v2,2/2] mptcp: pm: add struct_group in mptcp_pm_data:
    - Series: add struct_group in mptcp_pm_data
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=942573&state=*&archive=both

14011208: [mptcp-next,v11,01/10] mptcp: pm: define struct mptcp_pm_ops
14011209: [mptcp-next,v11,02/10] mptcp: pm: register in-kernel and
userspace PM
14011210: [mptcp-next,v11,03/10] mptcp: sysctl: set path manager by name
14011211: [mptcp-next,v11,04/10] mptcp: pm: init and release mptcp_pm_ops
14011212: [mptcp-next,v11,05/10] mptcp: pm: add get_local_id() interface
14011213: [mptcp-next,v11,06/10] mptcp: pm: add get_priority() interface
14011215: [mptcp-next,v11,08/10] mptcp: sysctl: map pm_type to path_manager
14011216: [mptcp-next,v11,09/10] mptcp: sysctl: add available_path_managers
14011217: [mptcp-next,v11,10/10] selftests: mptcp: add pm sysctl mapping
tests:
    - Series: BPF path manager, part 5
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=942579&state=*&archive=both

14015411: [net] mptcp: Fix data stream corruption in the address
announcement:
    - Submitter: Arthur Mongodin
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/81b2a80e-2a25-4a5f-b235-07a68662aa98@randorisec.fr/

14019697: [mptcp-next] selftests: mptcp: ignore mptcp_diag binary:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250317-mptcp-sft-diag-ignore-v1-1-d1e7ec9ff89a@kernel.org/

14020795: [mptcp-next,v3] selftests: mptcp: fix incorrect fd checks in
main_loop:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/59caf78b9d67a0a61a19a46f7820456f6ced3d6e.1742296236.git.tanggeliang@kylinos.cn/

14021958: [mptcp-net,v2] mptcp: fix a NULL pointer result in panic:
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250319022733.51444-1-yangang@kylinos.cn/

14022085: [mptcp-next,v3,1/1] selftests: mptcp: close fd_in before
returning in main_loop:
    - Series: cleanups for main_loop
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=945438&state=*&archive=both

14026903: [mptcp-next,v4,1/9] Squash to "mptcp: pm: add get_local_id()
interface"
14029282: [v2] mptcp: pm: Return local variable instead of freed pointer:
    - Submitter: Thorsten Blum
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250325163251.135510-2-thorsten.blum@linux.dev/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts, Sebastian
Andrzej Siewior, Yunsheng Lin):

13897129: [net-next,v2,09/10] net: replace page_frag with page_frag_cache

14024259: [bpf-next/net,v3,1/5] bpf: Register mptcp common kfunc set
14024260: [bpf-next/net,v3,2/5] bpf: Add mptcp_subflow bpf_iter
14024261: [bpf-next/net,v3,3/5] selftests/bpf: More endpoints for
endpoint_init
14024262: [bpf-next/net,v3,4/5] selftests/bpf: Add mptcp_subflow
bpf_iter subtest
14024263: [bpf-next/net,v3,5/5] selftests/bpf: Drop cgroup_fd of
run_mptcpify:
    - State: New
    - Series: bpf: Add mptcp_subflow bpf_iter support
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=946008&state=*&archive=both

14008559: [net-next,15/18] mptcp: Use nested-BH locking for hmac_storage:
    - discussions are on-going on other patches from the series:

https://lore.kernel.org/all/99214ac9-cff7-4a5c-b439-ed9ec2c6877c@redhat.com/


    our repo (by: Cong Liu, Gang Yan, Geliang Tang, Gregory Detal,
Matthieu Baerts):

12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
    - State: Changes requested
    - Series: BPF redundant scheduler, part 3
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
    - status: same

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
    - status: same

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
    - status: same

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
    - status: same

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
    - status: same

13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX validation
13932546: [3/3] selftests: mptcp: add a testcase for invalid addr timeout:
    - State: Changes requested
    - Series: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both
    - status: same

14006331: [mptcp-next,v2,01/11] Revert "mptcp: sched: remove
mptcp_sched_data"
14006332: [mptcp-next,v2,02/11] Squash to "bpf: Add bpf_mptcp_sched_ops"
14006333: [mptcp-next,v2,03/11] mptcp: add bpf_iter_task for
mptcp_sched_data
14006334: [mptcp-next,v2,04/11] mptcp: set and clear bpf_iter_task
14006335: [mptcp-next,v2,05/11] mptcp: add mptcp_subflow_sched bpf_iter
14006336: [mptcp-next,v2,06/11] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
14006337: [mptcp-next,v2,07/11] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
14006338: [mptcp-next,v2,08/11] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
14006339: [mptcp-next,v2,09/11] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
14006340: [mptcp-next,v2,10/11] Squash to "selftests/bpf: Add bpf_burst
scheduler & test"
14006341: [mptcp-next,v2,11/11] mptcp: drop subflow contexts in
mptcp_sched_data:
    - State: Rejected
    - Series: add bpf_iter_task
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=941486&state=*&archive=both
    - We will not add a new item in msk for BPF context, nor
re-introducing mptcp_sched_data

14009184: [mptcp-next,v3,1/2] mptcp: add bpf_iter_task for mptcp_sock
14009185: [mptcp-next,v3,2/2] bpf: Customize mptcp's own sock lock:
    - State: Rejected
    - Series: add bpf_iter_task
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=942077&state=*&archive=both

14024767: [mptcp-next,v1,1/4] bpf: Add mptcp path manager struct_ops
14024768: [mptcp-next,v1,2/4] bpf: Export mptcp path manager kfuncs
14024769: [mptcp-next,v1,3/4] selftests/bpf: Add mptcp netlink pm subtest
14024770: [mptcp-next,v1,4/4] selftests/bpf: Add mptcp bpf_netlink pm
subtest:
    - State: Changes requested
    - Series: BPF path manager, part 7
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=946095&state=*&archive=both

14026904: [mptcp-next,v4,2/9] mptcp: pm: add established interfaces
14026905: [mptcp-next,v4,3/9] mptcp: pm: drop is_userspace in
subflow_check_next
14026906: [mptcp-next,v4,4/9] mptcp: pm: drop redundant
MPTCP_MIB_ADDADDRDROP
14026907: [mptcp-next,v4,5/9] mptcp: pm: add add_addr_received() interface
14026908: [mptcp-next,v4,6/9] mptcp: pm: add rm_addr_received() interface
14026909: [mptcp-next,v4,7/9] mptcp: pm: add add_addr_echo() interface
14026910: [mptcp-next,v4,8/9] mptcp: pm: add accept_new_subflow() interface
14026911: [mptcp-next,v4,9/9] mptcp: pm: add allow_new_subflow() interface:
    - State: Changes requested
    - Series: BPF path manager, part 6
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=946713&state=*&archive=both
    - regarding the PM lock taken from the PM worker:
        - PM lock and callback: should be called without them and reduce
the locks, but then spin_lock will be taken and released more instead of
less for a longer period.
        - more unlock/lock == more costly, but should be OK: from worker
and let more time to do more things in //
        - but we should not read pm->status without the lock, then
modify it with the lock: either get a copy + reset with the lock or
READ_ONCE
        - can we have mptcp_pm_worker() called multiple times for the
same msk in //?:
            Geliang understood what Mat meant here and will update it in
v5 of this set.

14028311: [mptcp-next,v1] mptcp: fix cast type of is_fully_established:
    - State: Rejected
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/27b15c2de6fe36088ef95c4823d9e4a6d7bc9ec6.1742898970.git.tanggeliang@kylinos.cn/



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 549):

  555  [syzbot] WARNING in `mptcp_do_fallback` [bug] [syzkaller]
  553  MPTCP backup subflow compatibility [question] [feedback-needed]
@matttbe
  552  pm: in-kernel: delay before creating new subflows [enhancement]

Recently discussed:

  549  pm: in-kernel: set `msk->pm.work_pending` back to `true` [bug]
  548  disable mptcp for an interface [question] @matttbe
  530  about mptcp subflow creation question [question] [feedback-needed]
  524  tests: cover more Diag-related code [selftests] @geliangtang
  416  No new subflow when removing an endpoint and adding a new one
[bug] [feedback-needed]


    Bugs (opened, flagged as "bug" and assigned)

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

  555  [syzbot] WARNING in `mptcp_do_fallback` [bug] [syzkaller]
  549  pm: in-kernel: set `msk->pm.work_pending` back to `true` [bug]
  508  Divide error on device removal [bug] [feedback-needed]
  505  Subflows won't be used when the interface for the main flow is a
subinterface [bug] [feedback-needed]
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

  553  MPTCP backup subflow compatibility [question] [feedback-needed]
@matttbe
  548  disable mptcp for an interface [question] @matttbe


    Open questions (opened, questions and not assigned)

  530  about mptcp subflow creation question [question] [feedback-needed]
  520  Question about proper MPTCP configuration over VPN. [question]
[feedback-needed]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question] [feedback-needed]


    For later (opened and not assigned)

  552  pm: in-kernel: delay before creating new subflows [enhancement]
  545  Deal with multiple pure TCP ACK without MPTCP options [enhancement]
  543  TCPDump: display `MP_TCPRST` info [enhancement]
  542  in-kernel PM: limit to one subflow per network interface for each
connection [enhancement] [pm]
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


    Recently closed (since 20250226)

  554  Observing significant delays (>30 seconds) on "handover" to
subflow [bug] [pm]
  551  selftests: `mptcp_connect.sh`: disconnect test reset [bug]
[selftests] @matttbe
  550  `getsockopt(IPPROTO_IPV6, IPV6_V6ONLY)` returns `-EOPNOTSUPP`
[bug] @matttbe
  499  selftests: `mptcp_connect.sh`: disconnect test timed out [bug]
[selftests]


    Packetdrill PRs

  52  2 months ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs

  51  4 days ago  matttbe  pm: subflow: specify the destination IP


    mptcpd PRs

  314  1 month ago  matttbe  musl compat



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.15):
https://github.com/orgs/multipath-tcp/projects/13
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:
    Net-next is closed.



Extra tests:
    - news about Syzkaller? (Christoph):
        - Matth will look at set some up.

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp



Next meeting:
    - Next one on Wednesday, the 9th of April.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20250409



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

